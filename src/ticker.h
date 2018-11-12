//
//  ticker.h
//  Hike
//
//  Created by Charles Holbrow on 11/11/18.
//

#ifndef ticker_h
#define ticker_h

class Ticker {
private:
    float globalTime = 0;
    float lastTickTime = 0;
public:
    // Duration of each tick in seconds
    float tickResolution = 1.f / 60.f;

    // Increment global time by the frame amount. This will probably be called
    // on every frame of our host application. If deltaTime > tickResolution,
    // the next call to tickIfPossible() will probably return a non-zero value.
    void advanceBy(float deltaTime) { globalTime += deltaTime; };

    // set the ticker's global time
    void setTime(float absoluteTime) { globalTime = absoluteTime; };

    // Returns the amount of time the ticker advanced. 0 if the ticker could not
    // increment or decrement.
    float tickIfPossible() {
        if (globalTime > lastTickTime) {
            // we are moving forward in time
            float target = lastTickTime + tickResolution;
            if (target <= globalTime) {
                lastTickTime = target;
                return tickResolution;
            };
        } else if (globalTime < lastTickTime) {
            // we are moving backward in time
            float target = lastTickTime - tickResolution;
            if (target >= globalTime) {
                lastTickTime = target;
                return -tickResolution;
            }
        }
        return 0;
    };

    float tickTime() { return lastTickTime; };

    // How much time between the last tick and the ticker's max time?
    float remainder() { return globalTime - lastTickTime; };
};

#endif /* ticker_h */
