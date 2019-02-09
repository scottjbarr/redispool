# the base "go" command to use
GO ?= go

# build and run on the local OS, whatever that is
GO_BUILD = go build

GO_DIST_BASE = GOOS=linux GOARCH=amd64 $(GO_BUILD) -a -tags netgo -ldflags '-w'

# go build that should produce a "scratch" Docker image friendly binary
GO_DIST = CGO_ENABLED=0 $(GO_DIST_BASE)

# go "dist" command with CGO enabled
GO_DIST_CGO = CGO_ENABLED=1 $(GO_DIST_BASE)

.PHONY: dist

ci: clean tools prepare deps test

# Install dependencies.
deps:
	go get -t ./...

tools:
	go get github.com/golang/lint/golint
	go get github.com/golang/dep/cmd/dep
	go get github.com/mattn/goreman

prepare:
	mkdir -p tmp

test: prepare
	@# $(GO) test -coverprofile=tmp/coverage.out
	go test ./...

test-coverage: test
	go tool cover -html=tmp/coverage.out

clean:
