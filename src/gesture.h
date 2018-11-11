//
//  gesture.h
//  Hike
//
//  Created by Charles Holbrow on 11/10/18.
//

#ifndef gesture_h
#define gesture_h

#include "ofxiOS.h"

struct GesturePoint {
    ofVec2f pos;
    float globalTime;
};

class Gesture {
public:
    std::list <GesturePoint> points;
    void clear();
    void append(float x, float y, float globalTime);
    float duration(); // how long does the gesture last for?
    bool isValidAtTime(float globalTime);
    ofVec2f positionAtTime(float globalTime);
};


#endif /* gesture_h */
