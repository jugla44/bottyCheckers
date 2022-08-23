FROM golang:alpine

# Set necessary environmet variables needed for our image
ARG bot_token="MTAxMTU3NDkyNDkxOTQ0MzUxNg.G_tPvI.Nfr5Nd8avrWTELyvuePHKOvx7ZgWOPcU62q2e0"
ENV BOT_TOKEN=$bot_token

# Move to working directory /build
WORKDIR /build

# Copy and download dependency using go mod
COPY go.mod .
COPY go.sum .
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application
RUN go build -o main .

# Move to /dist directory as the place for resulting binary folder
WORKDIR /dist

# Copy binary from build to main folder
RUN cp /build/main .

# Command to run when starting the container
CMD ["/dist/main"]
