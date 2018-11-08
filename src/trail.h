//
//  trail.hpp
//  emptyExample
//
//  Created by Charles Holbrow on 11/5/18.
//

#ifndef trail_h
#define trail_h

#include <array>
#include "ofxiOS.h"
struct Particle {
    ofVec2f pos;   // pixels
    ofVec2f vel;   // pixels / second
    float radius;  // pixels
};

class Trail {
public:
    float x = ofGetWidth() / 2.;
    float y = ofGetHeight() / 2.;
    float s = 4; // speed
    void render();
    void update(float deltaT);
    void setup();
private:
    float t = 0; // time
    std::list <Particle> all;
};

#endif /* trail_h */
