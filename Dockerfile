# Step 1: Build stage
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2: Production stage
FROM node:18-alpine AS runner

WORKDIR /app

# Copy hasil build dari builder
COPY --from=builder /app/dist ./dist
COPY package*.json ./

# install deps (kalau butuh preview)
RUN npm install --production

# Expose port Astro
EXPOSE 4321

# Jalankan astro preview
CMD ["npm", "run", "preview"]
