mkdir -m 777 assets
mv ./x-dummy.css ./assets
mv ./1-booking.js ./assets
source "npm i express nodemailer body-parser multer"
node ./3-server.js