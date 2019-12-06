release-port:
	lsof -i :8888 -sTCP:LISTEN | awk '{system("kill -9 " $2)}'
	docker rm -f $$(docker ps -qf expose=8888) || true

run: release-port
	docker build . -t test:1.0
	docker run \
		-it --rm \
		--cpus ${cpus} --cpu-shares 1024 --memory ${memory} \
		-p 8888:8888 \
		-v "$(PWD)/":/app/:rw \
		test:1.0
#make run cpus=4 memory=8g

run-bash: release-port
	docker build . -t test:1.0
	docker run \
		-it --rm \
		--cpus ${cpus} --cpu-shares 1024 --memory ${memory} \
		-p 8888:8888 \
		-v "$(PWD)/":/app/:rw \
		test:1.0 \
		bash
#make run-bash cpus=4 memory=8g