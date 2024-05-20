const express = require("express");

const app = express();

app.get('/health', (req, res) => {
  res.header({ "System-Health": true })
  res.sendStatus(204)
})


app.listen(3000, () => {
  console.log("listening on 3000");
});
