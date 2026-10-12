FROM nginx:1.27-alpine

# Our own minimal server config: listen on 8080, serve static files only.
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 8080

# Fly expects the process to run in the foreground.
CMD ["nginx", "-g", "daemon off;"]
