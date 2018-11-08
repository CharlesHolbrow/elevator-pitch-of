#include "ofApp.h"
#include "trail.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofSetCircleResolution(40);
    
    // add a trail to the screen;
    Trail t;
    t.pos.y += 400;
    t.setup();
    renderables.push_back(t);
}

//--------------------------------------------------------------
void ofApp::update(){
    float currentTime = ofGetElapsedTimef();
    float deltaT = currentTime - lastTime;
    lastTime = currentTime;

    for (unsigned int i = 0; i < renderables.size(); i++) {
//        renderables[i].update(1.f / 60.f);
        renderables[i].update(deltaT);
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    ofBackground(0);
    for (unsigned int i = 0; i < renderables.size(); i++) {
        renderables[i].render();
    };
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    if (renderables.size() > 0) {
        renderables.front().add();
    };
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
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

