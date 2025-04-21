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