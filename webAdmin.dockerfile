# node base image
FROM node:alpine as builder

# working directory
WORKDIR /app

# copy everything to current working directory 
COPY Admin .

# run npm install
RUN npm install &&\
    npm run build

# nginx base image
FROM nginx:alpine

# copy static contents of project to nginx html 
COPY --from=builder /app/dist/Admin /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]