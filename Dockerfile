FROM node:12.16.2-alpine AS html-static
COPY . /app/detectface-frontend
RUN cd /app/detectface-frontend && npm install && npm run build


FROM nginx:latest

ENV STI_SCRIPTS_PATH=/usr/libexec/s2i \
    SOURCE_DIR=/usr/share/nginx/html

LABEL io.k8s.description="Builder image for compiling and testing Go applications" \
    io.k8s.display-name="detectface-frontend-builder}" \
    io.openshift.s2i.scripts-url=image://${STI_SCRIPTS_PATH}

# Copy the s2i scripts into the nginx image
# These scripts describe how to build & run the application, and extract artifacts 
# for downstream builds
COPY ./s2i/bin/ ${STI_SCRIPTS_PATH}

# The $SOURCE_DIR is dependent on the upstream golang image, based on the 
# $GOPATH, etc. variable set there
#
# Allow random UIDs to write to the $SOURCE_DIR (for OKD/OpenShift)
RUN mkdir -p $SOURCE_DIR \
    && chmod g+rwx $SOURCE_DIR

WORKDIR $SOURCE_DIR

USER 1001


COPY --from=html-static /app/detectface-frontend/build .
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

# support running as arbitrary user which belogs to the root group
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx

# users are not allowed to listen on priviliged ports
RUN sed -i.bak 's/listen\(.*\)80;/listen 8081;/' /etc/nginx/conf.d/default.conf

EXPOSE 8081

# comment user directive as master process is run as user in OpenShift anyhow
RUN sed -i.bak 's/^user/#user/' /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

# FROM node:12.16.2-alpine
# WORKDIR /app/detectface-frontend
# COPY . .
# RUN npm install && npm run build
# CMD ["node","server.js"]
