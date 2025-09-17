# Stage build
FROM node:18 AS builder
WORKDIR /app

# Copy package.json dan lockfile
COPY package*.json ./
RUN npm ci --include=dev

# Copy seluruh source
COPY . .

# Build Astro
RUN npm run build

# Stage run
FROM node:18-alpine
WORKDIR /app

# Install serve untuk static hosting
RUN npm install -g serve

# Copy hasil build
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
