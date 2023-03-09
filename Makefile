# ----------------------------------------
# 	Swift
# ----------------------------------------

run:
	swift run App

build:
	swift build

release:
	swift build -c release
	
test:
	swift test --parallel

test-with-coverage:
	swift test --parallel --enable-code-coverage

clean:
	rm -rf .build

# ----------------------------------------
# 	System
# ----------------------------------------

install: release
	install ./.build/release/App /usr/local/bin/App

uninstall:
	rm /usr/local/bin/App

# ----------------------------------------
# 	Docker
# ----------------------------------------

docker-build-debug:
	docker build \
		-t hummingbird-debug-image \
		-f ./docker/debug/Dockerfile \
		.

docker-run-debug:
	docker run \
		--name hummingbird-debug-instance \
		-v $(PWD)/:/app \
		-w /app \
		-e "PS1=\u@\w: " \
		-p 8080:8080 \
		--rm \
		-it hummingbird-debug-image

docker-clean-debug:
	docker rmi hummingbird-debug-image

docker-run:
	swift run App --hostname 0.0.0.0

docker-build-release:
	docker build \
		-t hummingbird-release-image \
		-f ./docker/release/Dockerfile \
		.

docker-run-release:
	docker run \
	--name hummingbird-release-instance \
	-p 8080:8080 \
	--rm -it hummingbird-release-image

docker-clean-release:
	docker rmi hummingbird-release-image
