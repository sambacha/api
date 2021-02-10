FROM node:14-buster

# enforce user roles, npm disallows global install under `root`
USER node

RUN npm install -g serverless \
    npm install -g serverless-offline

WORKDIR /opt/app

COPY package*.json ./

# don't install non-production deps
ENV NODE_ENV=production

RUN npm install

COPY . .

EXPOSE 3000

# ensure service uptime and port is exposed
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:3000 || exit 1

CMD [ "sls", "offline", "--host", "0.0.0.0" ]

# container inspect schema 
LABEL maintainer="maintainer@yearn.finance" \
    org.opencontainers.image.description="Yearn Finance API Lambda" \
    org.opencontainers.image.authors="Yearn Finance" \
    org.opencontainers.image.source="https://github.com/iearn-finance/api" \
    org.opencontainers.image.title="nodejs-lambda"
