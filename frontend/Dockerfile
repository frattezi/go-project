# base image
FROM node:8.15.1-alpine

RUN mkdir app
WORKDIR /app


COPY package.json /app/package.json

RUN npm install --silent
RUN npm install react-scripts@1.1.1 -g --silent


