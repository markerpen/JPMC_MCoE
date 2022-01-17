#  JPMC MCoE

This project, when built, will display a SwiftUI view containing a list of planets. Once loaded, the planets are persisted and do not need to be re-downloaded.

* **PlanetListView.swift**: A SwiftUI view which displays a list of planets
* **Networking.swift**: A simple method to download the planets from the external API and convert them into Swift structs
* **PlanetsAPI.swift**: the structs that are used to represent the JSON from the API

Backing up these main classes you'll also find:

* **Utility.swift**: helper methods to encode/decode JSON
* **Persistence.swift**: some helper methods running on top of UserDefaults

Please note that because this project needs to run on iOS 13, we can't use the new SwiftUI 'App' project structure. Instead we use the older UIKit AppDelegate/SceneDelegate project structure and replace the storyboard with a UIHostingController in the SceneDelegate.

Finally, two unit tests are included:

* Check that the network request is successful
* Check that the persistent layer works as intended

