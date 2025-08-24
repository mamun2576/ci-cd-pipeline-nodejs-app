#!/bin/bash
npm install --omit=dev
if [ -f package.json ]; then
  npm run build || echo "No build step"
fi

if ! command -v pm2 &> /dev/null
then
  sudo npm install -g pm2
fi

if pm2 list | grep -q ostad-app; then
  pm2 restart ostad-app
else
  pm2 start npm --name ostad-app -- run start
fi
