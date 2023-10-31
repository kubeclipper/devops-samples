# syntax=docker/dockerfile:1

# Build the manager binary
FROM golang:1.19 as builder
ARG TARGETOS
ARG TARGETARCH

ENV GOPROXY=https://goproxy.cn


WORKDIR /workspace
# Copy the go source
COPY . /workspace
# and so that source changes don't invalidate our downloaded layer
RUN go mod download

# Build
# the GOARCH has not a default value to allow the binary be built according to the host where the command
# was called. For example, if we call make docker-build in a local env which has the Apple Silicon M1 SO
# the docker BUILDPLATFORM arg will be linux/arm64 when for Apple x86 it will be linux/amd64. Therefore,
# by leaving it empty we can ensure that the container and binary shipped on it will have the same platform.
RUN CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH} go build -a -o hello main.go

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
#FROM gcr.io/distroless/static:nonroot
FROM katanomi/distroless-static:nonroot
#FROM centos
WORKDIR /
COPY --from=builder /workspace/hello .
USER 65532:65532

ENTRYPOINT ["/hello"]