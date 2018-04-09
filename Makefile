build:
	# generate gRPC interface
	#protoc -I. --go_out=plugins=grpc:$(GOPATH)/src/github.com/rafaelbartolome/micro-test/consignment-service \
	  proto/consignment/consignment.proto
	
	# generate go-micro interfac
	#protoc -I. --go_out=plugins=micro:$(GOPATH)/src/github.com/rafaelbartolome/micro-test/consignment-service \
		--micro_out=plugins=micro:$(GOPATH)/src/github.com/rafaelbartolome/micro-test/consignment-service \
		proto/consignment/consignment.proto
	protoc -I. --go_out=plugins=micro:$(GOPATH)/src/github.com/rafaelbartolome/micro-test/consignment-service \
		proto/consignment/consignment.proto

	# generate docker image
	docker build -t consignment-service .

run: 
	docker run -p 50051:50051 \
		-e MICRO_SERVER_ADDRESS=:50051 \
		-e MICRO_REGISTRY=mdns consignment-service