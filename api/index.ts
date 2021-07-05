import express from "express";
import mongodb, { Db } from "mongodb";
import { PBData } from "./structures/PBData";

const uri = process.env.URI!;
const port = 3000;

const app = express().use(express.json());
const client = new mongodb.MongoClient(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

console.log(`Listening to ${port}`);
await app.listen(3000);

console.log(`Connecting to: ${uri}`);
await client.connect();
const db = client.db("phonebook");
console.log("Initialized");

app.get("/api/contacts", async (req, res) => {
  console.log("GET");
  try {
    const data = await db
      ?.collection("contacts")
      .find()
      .sort({ first_name: 1, last_name: 1 })
      .toArray();
    console.log(data);
    await res.json(data ?? []);
  } catch (error) {
    console.error(error);
    await res.status(error.code ?? 400).send(String(error));
  }
});

app.post("/api/contacts", async (req, res) => {
  console.log("POST");
  try {
    const data: PBData = req.body;
    await db?.collection("contacts").updateOne(
      { first_name: data.first_name, last_name: data.last_name },
      {
        $set: {
          first_name: data.first_name,
          last_name: data.last_name,
          phone_numbers: data.phone_numbers,
        } as PBData,
      },
      { upsert: true }
    );
    console.log(data);
  } catch (error) {
    console.error(error);
    await res.status(error.code ?? 400).send(String(error));
  }
});
