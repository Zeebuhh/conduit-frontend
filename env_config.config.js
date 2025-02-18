const webpack = require("webpack");
require("dotenv").config({ path: "../.env" });

console.log("Loaded API_URL:", process.env.API_URL); // <-- Debugging-Log

module.exports = {
  plugins: [
    new webpack.DefinePlugin({
      API_URL: JSON.stringify(process.env.API_URL || "http://localhost/api"),
    }),
  ],
};
