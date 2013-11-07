minipi
======
CutImageFreeHand
Cut and Drag using finger

Here we can select area using our finger to cut particular part of image, and even we can set cut image any where in image and save it.

Here 4 class is used

cutMethod.h cutMethod.m getCropImage.h getCropImage.m

Just need to send two final image

a. First Method

getCropImage

1.Image before start cuting 2.Array that contain point of selection on cutting. 3.Image after cut selection.(means in cut we have use our own finger for selection after selection we have to send image )

b. Second Method

setCutBackgroundImage

1.Image before start cuting 2.Array that contain point of selection on cutting.

Return

getCropImage

Return array which contain
Cut image without border
X- Coordinate
Y- Coordinate
Width
Height
setCutBackgroundImage

-Return backgroung image contain clear area of cut selection
