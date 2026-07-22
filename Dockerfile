FROM nginx:latest

COPY src/main/webapp/index.html /usr/share/nginx/html/index.html

EXPOSE 80