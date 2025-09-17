# Stage build
FROM node:18 AS builder
WORKDIR /app

# Copy package.json dan lockfile
COPY package*.json ./
RUN npm ci

# Copy semua source code
COPY . .

# Build Astro
RUN npm run build

# Stage run (pakai Node)
FROM node:18-alpine
WORKDIR /app

# Install serve
RUN npm install -g serve

# Copy hasil build
COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
