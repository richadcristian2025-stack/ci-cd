# Stage build
FROM node:18 AS builder

# Set working directory
WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies sesuai lockfile
RUN npm ci

# Copy seluruh source code
COPY . .

# Build Astro
ENV NODE_ENV=production

RUN npm run build


# Stage serve dengan Nginx (lebih ringan & cepat)
FROM nginx:alpine

# Copy hasil build dari builder
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]