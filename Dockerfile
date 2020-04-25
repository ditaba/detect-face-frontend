FROM node:12.16.2-alpine AS html-static
COPY . /app/detectface-frontend
RUN cd /app/detectface-frontend && npm install && npm run build

FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY --from=html-static /app/detectface-frontend/build .
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
