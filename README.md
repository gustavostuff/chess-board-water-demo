## Problem to solve

**(this was a code assessment for an hiring process)**

Imagine a chess board where each square has a height, forming a topology. Water is poured over the entire board and collects in "valleys" or flows over the edges. What volume of water does a given board hold?

## About the solution

Image a randomly generated board such as:

```
3, 3, 7, 2, 7, 8, 2, 1
1, 2, 5, 1, 7, 2, 6, 5
7, 8, 3, 7, 8, 8, 2, 6
5, 2, 8, 4, 6, 3, 8, 8
5, 8, 7, 7, 3, 3, 4, 1
2, 6, 6, 1, 1, 5, 3, 3
2, 6, 8, 1, 6, 8, 7, 3
3, 7, 1, 3, 3, 3, 5, 7
```
...where each number represents the height of the square. The steps to (eventually) get the water volume would be:

* Get all the "slices" of empty space (on the X,Y plane)
* We start with level 1 (bottom)
* As you can see, there are 8 empty spaces in here, and 4 of them will flow over the edges (**magenta** squares)

  ![](https://raw.githubusercontent.com/tavuntu/chess-board-water-demo/main/assets/readme_media/empty-spaces-1.png)
* So that means level 1 can hold 4 units of water (**white** squares)
* Now let's see level 2:

  ![](https://raw.githubusercontent.com/tavuntu/chess-board-water-demo/main/assets/readme_media/empty-spaces-2.png)
* Here we have 6 units of "valid" water, so we add those to the previous ones (10 so far)
* We repeat this addition until we reach the last layer
* **Note**: Each "unit" of water = 0.5 cubic inches of water (see the notes at the bottom)

### How to distiguish white vs pink water?

Pink water can be "marked" by applying the [Flood Fill algorithm](https://en.wikipedia.org/wiki/Flood_fill), we just need to iterate over the empty spaces on the perimeter of the board. This flood fill won't reach the "valleys" where water can stay.

![](https://raw.githubusercontent.com/tavuntu/chess-board-water-demo/main/assets/readme_media/flood.gif)

## About the Demo

### Controllers

It's a typical FPS setup:

* WASD to move
* Space to go up
* Shift to go down
* Mouse to rotate camera

Plus:

* Arrow up to raise water
* Arrow down to lower water

### Some screenshots

![](https://raw.githubusercontent.com/tavuntu/chess-board-water-demo/main/assets/readme_media/1.png)

![](https://raw.githubusercontent.com/tavuntu/chess-board-water-demo/main/assets/readme_media/2.png)

![](https://raw.githubusercontent.com/tavuntu/chess-board-water-demo/main/assets/readme_media/3.png)

### Video

[![](https://i.postimg.cc/NMh4Nsb1/yt-image.png)](https://youtu.be/1Emp2AY2rUY)

## Notes

* Each square is a square inch and height increments are given every 0.5 inches (it can be observed in the 3D model). This means every individual pool (a single "box" containing water) will contain exactly 0.5 cubic inches of water

* To run this demo in you machine you need to install LÖVE (https://love2d.org/), download the .love file and double click

* See `renderer-2d.lua`, that's where the actual work is done

* My son helped me with some modeling so this was technically a fun family project!

![](https://raw.githubusercontent.com/tavuntu/chess-board-water-demo/main/assets/readme_media/clay-model.png)
