# base image
FROM node:9.6.1

RUN mkdir app
WORKDIR /app

COPY package.json /usr/src/app/package.json

RUN npm install --silent
RUN npm install react-scripts@1.1.1 -g --silent
