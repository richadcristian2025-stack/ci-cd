FROM node:18

WORKDIR /app

# install system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++

# install dependencies
COPY package*.json ./
RUN npm install

# copy source code
COPY . .

# expose port
EXPOSE 4321

# start astro dev server
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0", "--port", "4321"]