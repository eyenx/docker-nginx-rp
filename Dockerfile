	
FROM	nginx:latest
LABEL	org.opencontainers.image.authors="Toni Tauro <eye@eyenx.ch>"
COPY	start	/start
RUN	apt-get update -y && apt-get install -y python3-pip && pip install j2cli && chmod +x /start
COPY	nginx.tmpl	/nginx.tmpl
CMD	["/start"]
EXPOSE	80	443
