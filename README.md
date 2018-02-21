# Brick Breaker: Kinect Edition
Author: Ali Shazal

## Project Call

Blackberry aims to revolutionize the gaming industry yet again and, I, the Lead Game Design Architect of the company, was tasked with reviving our most popular game *The Brick Breaker*. Combining Machine Learning algorithms using Wekinator and input from a Kinect, I have finally succeeded in creating an interactive version of everyone's favourite childhood mobile game.

## Components

**1. Kinect**
![](https://github.com/artintelclass/interactive-project-alishazal/blob/master/20180221_023622.jpg)

**2. Machine Learning using Wekinator**
![](https://github.com/artintelclass/interactive-project-alishazal/blob/master/Screen%20Shot%202018-02-21%20at%203.32.32%20AM.png)

**3. Brick Breaker Processing Game**

![ ](https://github.com/artintelclass/interactive-project-alishazal/blob/master/Screen%20Shot%202018-02-21%20at%203.29.31%20AM.png)

## History

   **Original Idea**
   
My intial idea for the interactive project was a sign language translator. The concept was that the Leap Motion would be used to detect the hand gestures and then wekinator would be trained to understand these gestures. A text output would display the translation of the gesture in Enlgish. 

  **Second Idea**

Due to the enormity of my intial idea, and understanding the fact that it needed a lot more effort than I would have been able to put in, I decided to use the Kinect and do something interactive with it. I didn't think about the output initially but soon enough I saw myself experimenting with a crystal orb. I made its prototype and asked my peers to test it. Videos can be found [here](https://drive.google.com/open?id=1simyDbQQhIzrPeqGOOBa049ZzuLynVdw). All the students loved playing with the orb. I decided to make a game out of it where the user would collect coins with the orb. Professor suggested that I make something related to basketball.
 
  **Third Idea**

My search in find a working basketball game in Processing led me to discovering "Tetris" and other childhood favorites. I, then, thought of using those as my outputs for this project. While presenting this idea to a friend, he recommended that I find brick breaker and use that as my output. 

  **Final Idea**

And so, I found Raghu Vaidyanathan's brick breaker game on OpenProcessing and modified it to use it as my output. Thus, I present to you *Brick Breaker: Interactive Version*.

## Construction Steps

* The first step towards designing this project was getting the KinectOSC from Gene Kogan's *OSC-Modules* Git repository. With professor's help, I compiled it using Project Generator.
* The next step was to set up Wekinator. At first, I thought of using continuous input from the kinect but after receiving professor's feedback that "there is little use of Machine Learning" in this idea, I went on to use DTW. I intialized it to recieve 2 inputs from Wekinator and give out three gestures using Dynamic Time Warping (DTW). Following are the trained gestures:
  1. Left horizontal movement of right hand at shoulder height translates to paddle moving left
  2. Right horizontal movement of right hand at shoulder height translates to paddle moving right.
  3. Upwards movement of right hand from shoulder height translates to game resetting.

* The last step was to modify the brick breaker processing code. After running the original game, I discovered that it was extremely hard to play with gestures. Thus, I removed missiles from it and slowed the ball down. And so, the final version of my output was ready.

## Setting Up For Yourself

Download the "BrickBreakerMODIFIED" and "FinalWekinator" folders from the repo. Then, download the KinectOSC zip folder from this [link](https://drive.google.com/open?id=1Tvas_k5h0yfCzNLFH-BT6Cms6ejQKpgL). These are the only three things that you need. First, run KinectOSC and see if Kinect detects your skeleton. *(Note: The code in this is made to get data just from the right hand.)* If your skeleton does not show up, try changing your distance from the Kinect or restart the program; the program isn't perfect at this stage. After this, open the Wekinator file; it has already been trained for the three gestures mentioned above. Make it run and test your gestures on it. You can adjust the match threshold as per your liking. The last step is starting the processing game. 

## User Testing

I had my friends do some user testing on the final piece. 
For some it worked well:

![For some it worked well](https://github.com/artintelclass/interactive-project-alishazal/blob/master/giphy-downsized-large.gif)

While others got too emotional playing

![](https://github.com/artintelclass/interactive-project-alishazal/blob/master/giphy%20(1).gif)

More videos can be found on this [link](https://drive.google.com/drive/folders/1cFT5IC7AXcZaHea45VFD7pHzXHX7j0-T).


## Hurdles

There were some hiccups throughout the projects. All the hurdles that I encountered were related to the KinectOSC:
* Sometimes, it fails to run or fails to detect the skeleton after its on.
* At times, it just crashes while running.

## For Future Work

In the future, I want to implement an opposing "force" on the pedal to make it slide naturally instead of discrete movements, which was something that the professor suggested. I couldn't implement it right now because I would have had to change hundreds of "x" and "y" variables because the implementation of the force required position PVector.

## Final Thoughts

This project is a culmination of everything that we've learned in the last 4 weeks. It has been very fulfilling to be able to use the small things we learned in class and make something big and truly interactive from it. Moreover, this project has made Machine Learning seem more "human" to me in the sense that I can see it learns like a human does, by "seeing". I'm now looking forward to the next 10 weeks even more.
