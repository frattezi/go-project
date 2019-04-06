# Build
FROM node:8.15.1-alpine as build

ENV  NODE_ENV=production 
ENV REACT_APP_BACKEND_WS=ws://localhost:8080
ENV REACT_APP_BACKEND_URL=http://localhost:8080

RUN mkdir app
WORKDIR /app

COPY . .

RUN npm install --silent && npm run build

# Prod
FROM nginx:stable-alpine

EXPOSE 80

COPY ./conf/nginx-prod.conf /etc/nginx/nginx.conf
RUN nginx -t && mkdir /app

WORKDIR /app
COPY --from=build /app/build /app 

