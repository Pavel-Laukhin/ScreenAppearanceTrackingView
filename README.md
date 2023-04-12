# ScreenAppearanceTrackingView
### The way to determine when the majority of the view was displayed on the screen

![ScreenAppearanceTrackingView](https://user-images.githubusercontent.com/62621310/231671148-0b12b117-fdd7-4b97-a38f-54dbae050ba4.gif)

Have you ever wondered how to determine when a particular view was displayed on the screen? 
And what if the view is on a scroll view, which is on another scroll view, and so on?
Perhaps you would like to be able to determine when the majority of the view was displayed on the screen? 
For example, you could send a message to your analytics system (Google Analytics or something else) to keep the shopping funnel up to date and reliable. 
Now you can do this with my test application.

## How it works?

The central idea is as follows:
1. Determine the frame of a target view in a window coordinate space.
2. Determine the frame of the target view's scroll view (or just the superview in case there is no scroll view in the view hierarchy) in window coordinate space.
3. Find an intersection of these two frames.

## How to get started?

1. First, you should send a message within the 'scrollViewDidScroll' method of the UIScrollViewDelegate for all your scroll views.
In my example, there is a call to the NotificationCenter's post method, but you could choose any type of message you like.
2. Next, you should implement the 'ScreenAppearanceTrackingView' protocol (see the file of the same name), its default values for properties, its default method, and all extensions from the file. 
3. Then make the target view conform to that protocol and override 'visiblePercentThreshold' and 'onVisiblePercentReached' properties if you need. 
You can also change the completion of the 'handleScreenAppearanceUpdate' method to whatever you like. 
4. In the end, all you need to do is call the 'handleScreenAppearanceUpdate' method each time you get your message from point 1.
You can turn off the calling of this method once your visiblePercentThreshold is reached in the overridden closure property 'onVisiblePercentReached'.
