FROM node:alpine as builder

WORKDIR /app

COPY Admin .

RUN npm install &&\
    npm run build-prod

FROM nginx:alpine

COPY --from=builder /app/dist/Admin/* /app/wwwroot/admin/
COPY nginx.conf /etc/nginx/nginx.conf