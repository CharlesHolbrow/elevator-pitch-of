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
        auto p = *itr;
        float r = 128 + 127 * cos(t * 0.1 + i * 0.1);
        float g = 128 + 127 * cos(t * 0.2);
        float b = 128 + 127 * cos(t * 0.3);
        ofSetColor(r, g, b);
        ofDrawCircle(x + p.pos.x, y + p.pos.y, p.radius);
        i++;
    }
}

void Trail::setup() {
    for (unsigned int i = 0; i < 40; i++){
        Particle p;
        p.pos.x = float(i * 15);
        p.pos.y = float(i * 15);
        p.radius = float(i * 3);
        p.vel.x = 10 * sin(i * 0.1);
        p.vel.y = -15 * sin(i * 0.1);
        all.push_back(p);
    }
}

void Trail::update(float deltaT) {
    float localDeltaT = deltaT * s;
    t += localDeltaT;

    unsigned int i = 0;
    for (auto itr = all.begin(); itr != all.end(); itr++) {
//        all[i].vel.y = 30 * sin(t + i * 0.1);
//        all[i].vel.x = 30 * sin(t + i * 0.2);
        
        // update position based on velocity;
        itr->radius *= 1 - (localDeltaT * 0.01);
        itr->pos.x += localDeltaT * itr->vel.x;
        itr->pos.y += localDeltaT * itr->vel.y;
        i++;
    };

    // begin()/end() return iterators -- pass this erase()
    // front()/back() return elements
    
    if (all.size() > 0) {
        if (all.back().radius < 0.1) {
            all.pop_back();
        }
    }
}
