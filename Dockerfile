# Node image
FROM node:18

# app directory
WORKDIR /app

# package copy
COPY package*.json ./

# install dependencies
RUN npm install

# source code copy
COPY . .

# build project
RUN npm run build

# expose port
EXPOSE 3000

# run app
CMD ["npm","run","start:prod"]