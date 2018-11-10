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
    t2.pos.x = 400;
    t2.pos.y = 800;
    renderables.push_back(t2);
}

//--------------------------------------------------------------
void ofApp::update(){
    coreMotion.update();
    float currentTime = ofGetElapsedTimef();
    float deltaT = currentTime - lastTime;
    lastTime = currentTime;

    for (unsigned int i = 0; i < renderables.size(); i++) {
        renderables[i].update(deltaT);
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0);
    auto v = coreMotion.getAccelerometerData() - coreMotion.getGravity();

    ofBackground(v.length() * 200);
    for (unsigned int i = 0; i < renderables.size(); i++) {
        renderables[i].render();
    };
    l1.draw();
    l2.draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    ofLog() << "touch down " << touch.id << " | " << touch.x << ", " << touch.y;
    l1.clear();
    l1.addVertex(touch.x, touch.y);
    l2.clear();
    l2.addVertex(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    l1.curveTo(touch.x, touch.y);
    l2.addVertex(touch.x, touch.y);
    renderables.back().add(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    ofLog() << "touch up " << touch.id << " | " << touch.x << ", " << touch.y;
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

