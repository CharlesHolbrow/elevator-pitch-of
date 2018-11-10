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
    ofVec2f pos = { 0, 0 };
    float speed = 1;
    void render();
    void update(float deltaT);
    void setup();
    void add();
    void add(float x, float y);
private:
    float time = 0;
    float tickResolution = 1.f / 60.f;
    float currentTickTime = 0.0f;
    float previousTickTime = 0.0f;
    long int ticksElapsed = 0;
    std::list <Particle> all;
};

#endif /* trail_h */
