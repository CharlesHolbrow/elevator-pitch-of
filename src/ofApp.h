#pragma once

#include "ofxiOS.h"
#include "ofxiOSCoreMotion.h"
#include "ofxOsc.h"
#include "ticker.h"
#include "trail.h"
#include "gesture.h"

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

    // ofx addons
    ofxiOSCoreMotion coreMotion;
    ofxOscSender oscRebecca;
    ofxOscSender oscPat;

    // My objects
    Ticker ticker;
    vector < Trail > renderables;
    Gesture gesture;

    // misc helpers
    ofVec3f gravity;
    ofVec3f acceleration;
    ofVec3f accelerationChange;

    bool isDown = false;
    float lastTime = 0;
    ofPolyline l1;
    ofPolyline l2;
};
