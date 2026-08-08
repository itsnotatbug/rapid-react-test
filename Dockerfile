# ---- Build stage ----
# Node version used to compile the app. 24 is the current Active LTS line
# (your Mac is on v26, which is "Current" but won't become LTS until Oct
# 2026) — bump to node:26-alpine later if you want exact local/prod parity.
FROM node:24-alpine AS build
WORKDIR /app

# Install deps first so this layer is cached unless package*.json changes
COPY package.json package-lock.json ./
RUN npm ci

# Copy the rest of the source and build the static bundle
COPY . .
RUN npm run build

# ---- Serve stage ----
FROM nginx:alpine AS serve

# SPA-friendly config: falls back to index.html for client-side routes,
# adds long-lived caching for hashed static assets
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
