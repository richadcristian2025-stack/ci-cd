# Stage build
FROM node:18 AS builder
WORKDIR /app

# Copy package.json dan lockfile
COPY package*.json ./

# Install semua dependencies, termasuk devDependencies
RUN npm ci --include=dev

# Copy seluruh source code
COPY . .

# Build Astro
RUN npm run build

# Stage serve pakai Node.js
FROM node:18-alpine
WORKDIR /app

# Install serve untuk hosting hasil build
RUN npm install -g serve

COPY --from=builder /app/dist ./dist

EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
