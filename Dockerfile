FROM golang:1.22 as go-builder
WORKDIR /app
COPY a.go ./
COPY go.sum ./
COPY go.mod ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -x -o go_server

FROM node:21-alpine as build
WORKDIR /app
COPY package*.json tailwind.config.js vite.config.ts postcss.config.js svelte.config.js tsconfig.json ./
RUN npm install


RUN apk add --no-cache python3 py3-pip
COPY src/ ./src/
COPY static/ ./static/
COPY --from=go-builder /app/go_server /app/go_server
COPY django/ ./django/
COPY entrypoint.sh /app/

RUN pip3 install daff==1.3.46 --break-system-packages --no-cache-dir -r django/requirements.txt
RUN 
RUN chmod +x /app/entrypoint.sh

EXPOSE 5173 4696 8000

ENTRYPOINT ["/app/entrypoint.sh"]