FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
# Add execute permissions to node_modules/.bin/astro
RUN chmod +x node_modules/.bin/astro && npm run build

# Production stage
FROM node:18-alpine AS production
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
RUN npm install --only=production

EXPOSE 3000
CMD ["npm", "start"]
