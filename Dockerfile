	
FROM	nginx:latest
LABEL	org.opencontainers.image.authors="Toni Tauro <eye@eyenx.ch>"
RUN	apt-get update -y
RUN	apt-get install -y \
	python-pip
RUN	pip install j2cli
COPY	start	/start
RUN	chmod +x /start
COPY	nginx.tmpl	/nginx.tmpl
CMD	["/start"]
EXPOSE	80	443
