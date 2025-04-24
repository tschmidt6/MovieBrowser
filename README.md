# iOS Sample Project

## Finished Simulator

<img src="https://github.com/tschmidt6/MovieBrowser/blob/main/Simulator.gif" width=50% height=50%>

## Context

You'll be building a small app to demonstrate some basic coding skills in Swift and the iOS SDK. This app is meant to represent some common challenges you will encounter in normal day-to-day development work.

---

## Ground Rules

Please follow these basic guidelines while building out the app:

- ✅ Use **Swift** as your core coding language.
- ✅ The app should **compile without any errors or warnings**.
- ✅ You should **not have any Auto Layout warnings**.
- ✅ Use **UIKit** for the **search screen**, and **SwiftUI** for the **details screen**.
- 🚫 Do **not use any 3rd party libraries**. The requirements have been built in a way that only uses the **iOS SDK** and **Xcode**.
- ✅ Use the **latest version of Xcode** and iOS tooling.

---

## Requirements

You will be building an app based on the [MovieDB API](https://developer.themoviedb.org/reference/search-movie).  
The app will allow you to:

- Search for movies
- List the search results
- Browse to a detail view for each movie

---

## Details

- The **API key is embedded** in the project. You do not need to create an account or set up a new API key.
- The user should be able to:
  - Search for a movie
  - Scroll through the results
  - Tap a result to view the movie’s details
- Follow the **attached screenshots** as visual design specs for how screens should look and what data to include from the API.
- Transform API data as necessary to match the UI requirements.

---

## API Endpoints

You will need the following 2 endpoints:

1. **Search movies**  
   [https://developer.themoviedb.org/reference/search-movie](https://developer.themoviedb.org/reference/search-movie)

2. **Poster images**  
   [https://developer.themoviedb.org/docs/image-basics](https://developer.themoviedb.org/docs/image-basics)

---

## UI Guidelines

- The **Search screen** should:
  - Include a search bar
  - Load and display results directly below the search bar

- The **Detail screen** should:
  - Load a **placeholder image** (included in the project) until the movie poster has finished downloading

- Use **Storyboard** to create your initial UI and lay out the screen.
- Add code as needed to wire up the UI to the logic.

## Followup Questions During Interview
- What are the differences between classes and structs in the case of UIKit Viewcontrollers and SwuiftUI views
- How does a SwiftUI view know to update?
  - What do all the SwiftUI types do? @State, @Binding, etc.
  - If Structs are immutable, how does @State change?
- How would you implement pagination to your table and API?
  - What is prefetching?
- If a user clicks the same cell over and over, how do you handle duplicate API calls?
  - What cache would you use? Would there ever be memory issues if someone is on the app for a long time?
- If the API session token expires how would you handle that?
  - Where would you store the session token securly?
  - Have you used Keychain?
- What is deep linking?
- What are the access levels of Swift? Internal, private, fileprivate, open
- What is NSManagedContext in Coredata?
  - What does the unique ID do?
- What are the different types of DispatchQueues?
  - What does priority do?
- If and API returns a string or a double how would you deal with that? init decoder, decoding keys
- In code reviews what do you look for?
- How would you unit test API calls without making a real network request? Dependecy Injection