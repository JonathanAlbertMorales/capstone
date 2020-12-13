FROM node:10-alpine as builder

COPY package.json ./

RUN npm install && mkdir /app-ui && mv ./node_modules ./app-ui

WORKDIR /app-ui

COPY . .

RUN npm run build


FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*


COPY --from=builder /app-ui/dist /usr/share/nginx/html