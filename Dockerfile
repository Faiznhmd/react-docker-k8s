FROM node:20-alpine

# Create user
RUN addgroup -S app && adduser -S -G app app

# Set workdir
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies as root to avoid permission issues
RUN npm install

# Copy source code
COPY . .

# Change ownership
RUN chown -R app:app /app

# Switch to app user
USER app

# Expose Vite port
EXPOSE 5173

# Ensure Vite listens on all interfaces
ENV HOST=0.0.0.0

# Start dev server
CMD ["npm", "run", "dev"]
