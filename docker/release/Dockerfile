# ----------------------------------------
# 	Build stage
# ----------------------------------------
FROM swift:5.7.3-amazonlinux2 as build

WORKDIR /build
COPY ./Package.* ./
RUN swift package resolve
COPY . .
RUN swift build -c release
WORKDIR /artifacts
RUN cp "$(swift build --package-path /build -c release --show-bin-path)/App" ./

# ----------------------------------------
# 	Serve stage
# ----------------------------------------
FROM swift:5.7.3-amazonlinux2-slim

WORKDIR /app
COPY --from=build /artifacts /app
EXPOSE 8080
ENV LOG_LEVEL=notice
ENTRYPOINT ["./App"]
CMD ["--hostname", "0.0.0.0", "--port", "8080"]
