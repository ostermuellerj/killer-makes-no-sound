# killer-makes-no-sound
 Digital video feedback tesseract. Webcam is pointed at output of projector showing feed of...the webcam.

 # Major to do on the repo
- [ ] --->>>Get images to tile on the icosphere<<<---
	1. Merge mask test into main
	2. Write a function in Space to generate a mask from webcam (bonus points if this works for any video feed). This only needs to be done once per frame for the whole Icosphere, not once per space per frame (would be very expensive!)
	3. Write a function in Space to figure out where to put the mask (*not sure how to do this yet*)
	4. Write a displayMask() function in Space to draw the mask (*not sure how to do this yet*)
	5. Write a displayMasks(int n) function in Icosphere to call Space's displayMask() for a given number of spaces in spaces[] arraylist, where n=[0, spaces.size]
- [ ] Set up midi controls with MidiBus (from VISUALIZER repo)
- [ ] Add a scene brightness monitor that prevents strobing(/blinding people) when the feedback gets too intense

# Visualizer bells and whistles
- [ ] Add controls for appearance
	- Stroke color
	- Stroke weight
	- Background color/alpha
- [ ] Write a function to perform transformations on the icosphere that still preserve the masks (somehow....)
- [ ] Add an fft (from VISUALIZER repo) to make icosphere audio-reactive
- [ ] Add a controller for additional webcams and/or existing videos (and collect some sick vids if we get this working)

# To do for show
- [ ] Finish setlist
- [ ] Test projector setup in the shed
- [ ] Test audio setup in the shed
- [ ] Pimp out shed with xmas lights, etc