#include "ofApp.h"
#include "trail.h"


//--------------------------------------------------------------
void ofApp::setup(){
    ofSetCircleResolution(40);
    coreMotion.setupAccelerometer();
    

    // add a trail to the screen;
    Trail t;
    t.pos.y += 400;
    t.setup();
    renderables.push_back(t);
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
    v.z += 1;
    ofBackground(v.length() * 200);
    ofLog() << v.x << "   " << v.y << "   " << v.z;
//    ofLog() << coreMotion.getGravity();
    for (unsigned int i = 0; i < renderables.size(); i++) {
        renderables[i].render();
    };
    line.draw();
}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
    ofLog() << "touch down " << touch.id << " | " << touch.x << ", " << touch.y;
    line.clear();
    line.addVertex(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
    line.curveTo(touch.x, touch.y);
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
    ofLog() << "touch up " << touch.id << " | " << touch.x << ", " << touch.y;
    line.simplify();
    line.close();
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

