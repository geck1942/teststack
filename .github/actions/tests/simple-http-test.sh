#!/bin/sh

# Wait for NPM run dev to start
sleep 5
# URL of the page to check
URL="http://localhost:3000/blog/hello-world/"
CONTENT="Hello world!"

# Perform the HTTP request, capturing the HTTP status and response content separately
response=$(curl --write-out "%{http_code}" --silent --output response.txt $URL)
response_content=$(<response.txt)

# Check for HTTP status 200
if [ "$response" -eq 200 ]; then
    echo "HTTP status is 200, checking content..."

    # Check if the content contains the desired text
    if echo "$response_content" | grep -q "$CONTENT"; then
        echo "Content check passed. Page contains '$CONTENT'"
        exit 0 # Success
    else
        echo "Content check failed. Page does not contain '$CONTENT'"
		    echo "$response_content"  # Optionally, show response content for other statuses
    fi
else
    echo "HTTP status is not 200. Received status code: $response"
    echo "$response_content"  # Optionally, show response content for other statuses
fi

exit 1 # Fail

