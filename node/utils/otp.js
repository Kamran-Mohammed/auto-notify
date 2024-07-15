const fast2sms = require("fast-two-sms");
const dotenv = require("dotenv");

dotenv.config({ path: "../config.env" });

// const { FAST2SMS } = require("../config");

// exports.generateOTP = (otp_length) => {
//   // Declare a digits variable
//   // which stores all digits
//   var digits = "0123456789";
//   let OTP = "";
//   for (let i = 0; i < otp_length; i++) {
//     OTP += digits[Math.floor(Math.random() * 10)];
//   }
//   return OTP;
// };

// exports.fast2sms = async ({ message, contactNumber }, next) => {
//   try {
//     const res = await fast2sms.sendMessage({
//       authorization: FAST2SMS,
//       message,
//       numbers: [contactNumber],
//     });
//     console.log(res);
//   } catch (error) {
//     next(error);
//   }
// };

// console.log(process.env.FAST2SMS_AUTH);
// console.log(process.env.DATABASE_PASSWORD);

const messageBhejo = async () => {
  try {
    var options = {
      authorization: process.env.FAST2SMS_AUTH,
      message: "Hello",
      numbers: ["9959728604"],
    };
    await fast2sms.sendMessage(options);
  } catch (err) {
    console.log(err);
  }
};
