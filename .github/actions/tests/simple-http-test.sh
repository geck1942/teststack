#!/bin/sh

# URL of the page to check
URL="http://localhost:3000/blog/hello-world/"

# Perform the HTTP request and store response
response=$(curl --write-out "%{http_code}" --silent --output /dev/null $URL)

# Check for HTTP status 200
if [ "$response" -eq 200 ]; then
    echo "HTTP status is 200, checking content..."

    # Fetch page content and check for the desired text
    if curl --silent $URL | grep -q "Hello world!"; then
        echo "Content check passed. Page contains 'Hello world!'"
        exit 0 # Success
    else
        echo "Content check failed. Page does not contain 'Hello world!'"
        exit 1 # Fail
    fi
else
    echo "HTTP status is not 200. Received status code: $response"
    exit 1 # Fail
fi
