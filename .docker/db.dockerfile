# Image name in Docker
FROM mongo

# Make sure necessary packages are installed
RUN apt-get update && apt-get install -y cron netcat-traditional netcat-openbsd

