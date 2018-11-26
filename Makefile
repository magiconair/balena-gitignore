docker:
	docker build -t balena-gitignore .
	docker run --rm -i -t balena-gitignore

balena:
	balena build --deviceType fincm3 --arch armv7hf --logs
