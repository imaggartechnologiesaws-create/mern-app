# Stage 1: build React frontend
FROM node:18 AS build

WORKDIR /app
COPY client/package*.json ./client/
COPY client/ ./client/
RUN cd client && npm install && npm run build

# Stage 2: setup backend + serve frontend
FROM node:18

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY server.js ./
COPY --from=build /app/client/build ./client/build

EXPOSE 3000
CMD ["node", "server.js"]
