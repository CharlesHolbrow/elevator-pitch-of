//
//  trail.hpp
//  emptyExample
//
//  Created by Charles Holbrow on 11/5/18.
//
// Trail is a collection of particles.

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
    
    void update(float deltaT, ofVec2f force) {
        pos += deltaT * (vel + force);
    };
};

class Trail {
private:
    float time = 0;
    long int ticksElapsed = 0.0;
    std::list <Particle> all;
    //  Particle particles[1000]; // TODO: switch to this way
public:
    ofVec2f pos = { 0, 0 };
    float speed = 1;
    void render();
    void update(float deltaT);
    void update(float deltaT, ofVec2f force);
    void setup();
    void add(float x, float y);
    int size() { return all.size(); };
};

#endif /* trail_h */
