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

    // update position based on velocity;
    void update(float deltaT) {
        pos += deltaT *  vel;
    };
};

class Trail {
public:
    ofVec2f pos = { ofGetWidth() / 2.f, ofGetHeight() / 2.f };
    float speed = 1;
    float lastUpdate = 0; // the local time of the last call to update
    void render();
    void update(float deltaT);
    void setup();
    void add();
private:
    float time = 0; // time
    std::list <Particle> all;
};

#endif /* trail_h */
