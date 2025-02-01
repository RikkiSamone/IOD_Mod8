const { MongoClient, ObjectId } = require('mongodb');

const uri = "mongodb://localhost:27017"; // Update if using MongoDB Atlas
const client = new MongoClient(uri);

async function seedDatabase() {
  try {
    await client.connect();
    console.log("Connected to MongoDB");

    const db = client.db("blogApp"); // Create or switch to 'blogApp' database

    // Insert Users
    const usersCollection = db.collection("users");
    const user = await usersCollection.insertOne({
      username: "john_doe",
      email: "johndoe@example.com",
      passwordHash: "hashedpassword123",
      createdAt: new Date(),
      bio: "Tech enthusiast and blogger.",
      profilePic: "profilePic.jpg",
    });

    // Insert Post (linked to User)
    const postsCollection = db.collection("posts");
    const post = await postsCollection.insertOne({
      title: "My First Blog Post",
      content: "This is an amazing day!",
      authorId: user.insertedId, // Reference user _id
      createdAt: new Date(),
      likes: 0
    });

    // Insert Comment (linked to Post)
    const commentsCollection = db.collection("comments");
    await commentsCollection.insertOne({
      postId: post.insertedId, // Reference post _id
      authorId: user.insertedId, // Reference user _id
      content: "Great post!",
      createdAt: new Date()
    });
      
    //Likes (linked to Post and User)
      const likesCollection = db.collection("likes");
      await likesCollection.insertOne({
          postId: post.insertedId, //reference post_Id
          userId: user.insertedId, //references user_id
          createdAt: new Date()
      });


    console.log("Data seeded successfully!");
  } catch (error) {
    console.error("Error seeding database:", error);
  } finally {
    await client.close();
  }
}

seedDatabase();