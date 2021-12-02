# StackOverflowAPIDemo
Sample iOS app that demonstrates how to responsibly download images and display them into reused Table View or Collection View cells 

The app connects to one of StackOverflow's public REST API endpoints to download a list of available public user profiles. This list is delivered into a Table View where each cell contains the user's gravatar image, their badge count, and a link to view their full profile in a Safari web link. 

There are several considerations I take in this app to accommodate for different image download scenarios. 

1. Asynchronously download images onto a background thread to avoid chocking the UI thread while the  table view cells are loading onto the screen.

2. Cache already-download images to prevent the same image from being downloaded more than once

3. Prevent any simultaneous downloads of the same image from happening triggered by a cell being recycled/reused on the screen

4. Show a loading/activity indicator when an image hasn't been downloaded yet

Example Apple Implementation on a UICollectionView-based app:

https://developer.apple.com/documentation/uikit/views_and_controls/table_views/asynchronously_loading_images_into_table_and_collection_views	


To test the responsiveness of the UI it's ability to handle LTE network slowness/latency, I attached my laptop to my iPhone's mobile hotspot, placed my phone in a metal box I had nearby, and then launched the app. I then removed the app from the simulator and repeated the deploy and launch several times to confirm that any images that didn't load instantly loaded as I scrolled the table view.

3rd-Party Libraries Used:
PKHUD - A simple library for displaying a pretty HUD progress indicator if user data takes more than a second to download
