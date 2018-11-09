#pragma once

#include "ofxiOS.h"
#include "ofxiOSCoreMotion.h"
#include "trail.h"

class ofApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);

    ofxiOSCoreMotion coreMotion;
    vector < Trail > renderables;
    float lastTime = 0;
    ofPolyline l1;
    ofPolyline l2;
};


