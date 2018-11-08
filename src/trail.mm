//
//  trail.cpp
//  emptyExample
//
//  Created by Charles Holbrow on 11/5/18.
//

#include "ofxiOS.h"
#include "trail.h"

void Trail::render() {
    unsigned int i = 0;
    for (auto itr = all.cbegin(); itr != all.cend(); ++itr) {

        float r = 128 + 127 * cos(time * 0.4 + i * 0.01);
        float g = 128 + 127 * cos(time * 0.2);
        float b = 128 + 127 * cos(time * 0.7);
        ofSetColor(r, g, b);

        ofVec2f gPos = pos + itr->pos; // global position
        ofDrawCircle(gPos.x, gPos.y, itr->radius);
        i++;
    }
}

void Trail::setup() {

}

void Trail::update(float deltaT) {
    // total duration since last update
    float localDeltaT = deltaT * speed;
    time += localDeltaT;

    //
    for (float innerTime = previousTickTime + tickResolution; innerTime < time; innerTime += tickResolution) {
        // everything in this loop happens exactly at the same time
        currentTickTime = innerTime;

        for (auto itr = all.begin(); itr != all.end(); itr++) {
            // slowly shrink
            itr->radius *= 1 - (tickResolution * 0.2);
            // update position based on velocity
            itr->update(tickResolution);
        }

        // potentially add a dot
        if (ticksElapsed % 2000 < 1200) {
            add();
        }

        previousTickTime = innerTime;
        ticksElapsed++;
    }

    // begin()/end() return iterators -- pass this erase()
    // front()/back() return elements
    
    if (all.size() > 0) {
        if (all.back().radius < 0.5) {
            all.pop_back();
        }
    }
}

void Trail::add() {
    Particle p;
    p.vel.x = sin(currentTickTime) * 20;
    p.vel.y = -60;
    p.radius = 40 - 30 * cos(currentTickTime / 3.);
    all.push_front(p);
}
