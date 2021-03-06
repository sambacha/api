FROM node:lts-alpine3.12
RUN apk add --update --no-cache nodejs
RUN npm i -g yarn

RUN npm install -g serverless && \
    npm install -g serverless-offline

ADD package.json yarn.lock /tmp/
ADD .yarn-cache.tgz /

RUN cd /tmp && yarn
RUN mkdir -p /service && cd /service && ln -s /tmp/node_modules

COPY . /service
WORKDIR /service

ENV FORCE_COLOR=1

ENTRYPOINT ["npm"]

EXPOSE 3000

CMD [ "sls", "offline", "--host", "0.0.0.0" ]