import express from "express";
import mongodb, { Db } from "mongodb";

const app = express();
const uri = process.env.URI!;
const client = new mongodb.MongoClient(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
let db: Db;

app.listen(3000, async () => {
  console.log("API running");
  console.log(`Connecting to: ${uri}`);
  await client.connect();
  db = client.db("phonebook");
  console.log("Connected");
});
