#include "ofApp.h"
#include "trail.h"


//--------------------------------------------------------------
void ofApp::setup(){
    ofSetCircleResolution(40);

    coreMotion.setupAccelerometer();
    coreMotion.setupGyroscope();
    coreMotion.setupAttitude(CMAttitudeReferenceFrameXMagneticNorthZVertical);

    // add a trail to the screen;
    Trail t1;
    t1.pos.x = ofGetWidth() / 2;
    t1.pos.y = ofGetHeight() / 2;
    t1.pos.y += 400;
    t1.setup();
    renderables.push_back(t1);

    Trail t2;
    t2.setup();
    renderables.push_back(t2);

    ticker.tickResolution = 1.f / 120.f;
}

//--------------------------------------------------------------
void ofApp::update(){
    coreMotion.update();
    ticker.setTime(ofGetElapsedTimef());

    // Tickle me
    while (float tickDelta = ticker.tickIfPossible()) {
        for (unsigned int i = 0; i < renderables.size(); i++) {
            renderables[i].update(tickDelta);
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
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0);
    auto v = coreMotion.getAccelerometerData() - coreMotion.getGravity();

    ofBackground(v.length() * 400);
    for (unsigned int i = 0; i < renderables.size(); i++) {
        renderables[i].render();
    };
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
    gesture.append(touch.x, touch.y, ofGetElapsedTimef());

    l1.curveTo(touch.x, touch.y);
    l2.addVertex(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    isDown = false;
    gesture.append(touch.x, touch.y, ofGetElapsedTimef());
    l1.close();
    l2.close();
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

