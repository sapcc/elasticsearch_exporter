# Copyright 2016 The Prometheus Authors
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
DATE    = $(shell date +%Y%m%d%H%M) 
VERSION = v$(DATE) 
GOOS    ?= darwin
GOARCH  ?= amd64


LDFLAGS := -X main.Version=$(VERSION)

GOFLAGS     := -ldflags "$(LDFLAGS)"

BINARIES := elasticsearch_exporter
GOFILES  := $(*.go)

.PHONY: all clean bin/version 

all: $(BINARIES:%=bin/$(GOOS)/$(GOARCH)/%) bin/version

bin/$(GOOS)/$(GOARCH)/%: $(GOFILES) Makefile
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build $(GOFLAGS) -v -i -o bin/$(GOOS)/$(GOARCH)/$* ./cmd/$*

bin/version:
	echo elasticsearch_exporter.$(VERSION) > bin/version

clean:
	rm -rf bin/*
