import flixel.util.FlxTimer;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.keyboard.FlxKey;

class WaitForKeypress {
    private var action:FlxActionDigital;
    private var func:Void->Void;

    public function new(keys:Array<FlxKey>, func:Void->Void) {
        action = new FlxActionDigital();
        this.func = func;
        for (i in 0...keys.length) {
            action.addKey(keys[i], PRESSED);
        }
    }

    public function start(updateFrequency:Float = 0.01) {
        function timerFunc(tmr: FlxTimer) {
            // Check if the action is triggered
            if (action.check()) {
                // Call the function we were given
                func();

                // Then kill the update timer
                tmr.cancel();
            }
        }
        new FlxTimer().start(updateFrequency, timerFunc, 0);
    }
}
