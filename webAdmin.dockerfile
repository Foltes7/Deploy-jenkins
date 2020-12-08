FROM node:alpine as builder

WORKDIR /app

COPY Admin .

RUN npm install &&\
    npm run build-prod

FROM nginx:alpine

COPY --from=builder /app/dist/Admin/* /usr/share/nginx/html/admin/
COPY --from=builder /app/nginx.conf /etc/nginx/nginx.conf