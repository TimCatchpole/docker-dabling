# build image
FROM node AS build

# Arguments called using --build-arg param at build time
# Use only for Build time
# ARG VERSION = "1.18.0"

# Environment variables
# Use for persisting variables in image e.g server name ENV prio over ARG
ENV IS_PROD = "true" \
  SERVER_NAME = "tim-test"

# change working directory
WORKDIR "/etc/app"

# Dependency install and vue config separate from app build for cache stage efficiency
COPY app/package.json app/package-lock.json app/vue.config.js app/babel.config.js ./
RUN npm install

# Copy and rebuild source
COPY app/src/ /etc/app/src
# rebuild app
RUN npm run build

# Was previously nginx:alpine but wasn't working switched to node now successfully builds
FROM nginx:alpine

# COPY nginx config file "default" to nginx target on container
COPY files/default /etc/nginx/sites-available/default
# copy compiled app to server public folder
COPY --from=build /etc/app/dist/ /usr/share/nginx/html/
# Set open Port
EXPOSE 80

# Create volume binding logs to current directory
# VOLUME [${PWD},"/var/www/logs/"]

# Set nginx error and access logs to stderr and stdout, caught by Docker automatically
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log

# Launch nginx
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]