FROM golang:1.22 as go-builder
WORKDIR /app
COPY a.go ./
COPY go.sum ./
COPY go.mod  ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -x -o go_server

FROM python:3.10-alpine  as python-build
WORKDIR /app/django
COPY ./django/ ./
RUN rm db.sqlite3
RUN ls
RUN pip install -r requirements.txt 
RUN python3 manage.py makemigrations
RUN python3 manage.py migrate



FROM node:21-alpine as build

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json tailwind.config.js  vite.config.ts postcss.config.js svelte.config.js  tsconfig.json ./

# Install the dependencies
RUN npm install
RUN apk add --no-cache python3
# Copy the rest of the application code to the container
COPY src/ ./src/
COPY static/ ./static/

COPY --from=go-builder /app/go_server /app/go_server
COPY --from=python-build /app/django /app/django
COPY ./entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh
# Expose the port that the app runs on
EXPOSE 5173 4696

# Command to run the app in development mode
ENTRYPOINT ["/app/entrypoint.sh"]
# docker build -t aa .; docker run -p 4696:4696 -p 80:5173 aa