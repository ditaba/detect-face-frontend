FROM node:12.16.2-alpine AS html-static
COPY . /app/detectface-frontend
RUN cd /app/detectface-frontend && npm install && npm run build

FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY --from=html-static /app/detectface-frontend/build .
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx
# users are not allowed to listen on priviliged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8081;/' /etc/nginx/conf.d/default.conf
EXPOSE 8081
# comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf
USER 1001
CMD ["nginx", "-g", "daemon off;"]

# FROM node:12.16.2-alpine
# WORKDIR /app/detectface-frontend
# COPY . .
# RUN npm install && npm run build
# CMD ["node","server.js"]
