const webpack = require("webpack");
require("dotenv").config({ path: "../.env" });

module.exports = {
  plugins: [
    new webpack.DefinePlugin({
      "process.env.API_URL": JSON.stringify(
        process.env.API_URL || "http://localhost/api",
      ),
    }),
  ],
};
