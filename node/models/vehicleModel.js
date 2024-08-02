const mongoose = require("mongoose");

const vehicleSchema = mongoose.Schema({
  name: {
    type: String,
    required: [true, "Please enter a name for your vehicle"],
  },
  numberPlate: {
    type: String,
    requred: [true, "Please enter the number plate"],
    unique: false,
  },
  ownedBy: {
    type: mongoose.Types.ObjectId,
    ref: "User",
    required: [true, "please provide user"],
  },
});

const Vehicle = mongoose.model("Vehicle", vehicleSchema);

module.exports = Vehicle;
