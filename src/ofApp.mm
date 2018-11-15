#include "ofApp.h"
#include "trail.h"


//--------------------------------------------------------------
void ofApp::setup(){
    ofSetCircleResolution(40);

    coreMotion.setupAccelerometer();
    coreMotion.setupGyroscope();
    coreMotion.setupAttitude(CMAttitudeReferenceFrameXMagneticNorthZVertical);
    oscRebecca.setup("rebeccas-mbp.media.mit.edu", 7400);
    oscPat.setup("pats-mbp.media.mit.edu", 7400);


    Trail t1; // currently unused
    t1.pos.x = ofGetWidth() / 2;
    t1.pos.y = ofGetHeight() / 2;
    t1.pos.y += 400;
    t1.setup();
    renderables.push_back(t1);

    Trail t2;
    t2.setup();
    renderables.push_back(t2);

    ticker.tickResolution = 1.f / 240.f;
}

//--------------------------------------------------------------
void ofApp::update(){
    coreMotion.update();
    gravity = coreMotion.getGravity();
    ofVec3f newAcceleration = coreMotion.getAccelerometerData() - gravity;
    accelerationChange = newAcceleration - acceleration;
    acceleration = newAcceleration;

    float absoluteTime = ofGetElapsedTimef();
    ticker.setTime(absoluteTime);

    // some book keeping
    float globalDeltaTime = absoluteTime - lastTime;
    lastTime = absoluteTime;

    int ticksThisFrame = 0;

    // Tickle
    while (float tickDelta = ticker.tickIfPossible()) {
        ticksThisFrame++;
        // Run our physics engine on all the renderables
        for (unsigned int i = 0; i < renderables.size(); i++) {
            renderables[i].update(tickDelta, ofVec2f(gravity.x * -50, gravity.y * 50));
        }

        if (isDown && renderables.size()) {
            // There is a touch, and a renderable
            float tickTime = ticker.tickTime();
            if (gesture.isValidAtTime(tickTime)) {
                // If the gesture includes this time;
                ofVec2f gPos = gesture.positionAtTime(tickTime);
                renderables.back().add(gPos.x, gPos.y);
            }
        }
    } // ticks

    if (ticksThisFrame != 4) {
        ofLog() << globalDeltaTime << " uneven frame " << ticksThisFrame << " | " << renderables.back().size();
    }

    // Seond OSC!!
    // Create, send message
    ofxOscMessage length;
    length.setAddress("/acceleration/length");
    length.addFloatArg(acceleration.length());
    ofxOscMessage xyz;
    xyz.setAddress("/acceleration/xyz");
    xyz.addFloatArg(acceleration.x);
    xyz.addFloatArg(acceleration.y);
    xyz.addFloatArg(acceleration.z);
    oscRebecca.sendMessage(length);
    oscPat.sendMessage(length);
    oscRebecca.sendMessage(xyz);
    oscPat.sendMessage(xyz);
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0);
    // Verify that accelerometer is working
    //auto v = coreMotion.getAccelerometerData() - coreMotion.getGravity();
    //ofBackground(v.length() * 400);

    for (unsigned int i = 0; i < renderables.size(); i++) {
        renderables[i].render();
    };

    // Debug stuff
//    ofSetColor(255);
//    auto vertices = l2.getVertices();
//    for (unsigned int i = 0; i < vertices.size(); i++) {
//        auto v = vertices[i];
//        ofDrawCircle(v.x, v.y, 3);
//    }
//    ofSetColor(127);
//    l1.draw();
//    l2.draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    isDown = true;
    l1.clear();
    l1.addVertex(touch.x, touch.y);
    l2.clear();
    l2.addVertex(touch.x, touch.y);

    // update gesture
    gesture.clear();
    gesture.append(touch.x, touch.y, ofGetElapsedTimef());
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    // Question: Ideally, touch.time would be the exact time that the event was received.
    // - Why is touch.time always == 0?
    // It appears basically all touch properties allways == 0
    // - touch.angle
    // - touch.width/height
    // - touch.xaccel/yaccel/xspeed/yspeed
    // Is it not possible to get these values?
    gesture.append(touch.x, touch.y, ofGetElapsedTimef());

    // This is really for debug information
    l1.curveTo(touch.x, touch.y);
    l2.addVertex(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    isDown = false;
    gesture.append(touch.x, touch.y, ofGetElapsedTimef());
    l1.curveTo(touch.x, touch.y);
    l2.addVertex(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    ofLog() << "touch double " << touch.id << " | " << touch.x << ", " << touch.y;
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    ofLog() << "touch cancel " << touch.id << " | " << touch.x << ", " << touch.y;
    isDown = false;
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

