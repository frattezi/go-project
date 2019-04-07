FROM node:10-alpine

ENV  NODE_ENV=development 
ENV REACT_APP_BACKEND_WS=ws://localhost:8080
ENV REACT_APP_BACKEND_URL=http://localhost:8080

RUN mkdir app
WORKDIR /app

COPY . /app

RUN yarn

CMD ["yarn", "start"]