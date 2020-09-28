package utils;

import haxe.ds.Map;
import haxe.Timer;

typedef TimeFunc = {
	var func:Void->Void;
	var keep:Bool;
	var delay:Int;
	var dt:Int;
}

class TimerOne {
	private static var _instance:TimerOne;

	private var timer:Timer;
	var map:Map<Int, TimeFunc> = [];
	var t:Int = 1000; // 不能再快了。2019-12-2 这里改了、
	var totoal:UInt = 0;

	public static function getInstance():TimerOne {
		if (_instance == null) {
			_instance = new TimerOne();
		}

		return _instance;
	}

	public function new() {
		if (_instance != null) {
			throw "webinstance eror!";
		}
		// dispatchEvent(new Event

		timer = new Timer(t);

		timer.run = run;
	}

	function run() {
		// 这里注册。

		for (key => v in map) {
			if (v == null) {
				map.remove(key);
			} else {
				v.dt += t;
				if (v.dt >= v.delay) {
					v.func();
					if (!v.keep) {
						map.remove(key);
					}
					v.dt = 0;
				}
			}
		}
	}

	/**
	 * 注册
	 * @param func
	 * @param delay  毫秒，
	 * @param keep
	 */
	public function reg(func:Void->Void, delay:Int, keep:Bool = true):Int {
		var tc:TimeFunc = {
			func: func,
			delay: delay,
			keep: keep,
			dt: 0
		};
		totoal += 2;
		map[totoal] = tc;
		if (totoal > 1000000000) {
			totoal = 1000;
		}
		return totoal;
	}

	public function unReg(func:Void->Void) {
		for (key => e in map) {
			if (e.func == func) {
				map.remove(key);
			}
		}
	}

	public function remove(key:Int) {
		if (map.exists(key)) {
			trace('warning  删除key=$key');
			map.remove(key);
		}
	}

	/**
	 * [Description]
	 * @param func
	 * @param delay 毫秒
	 * @return Int
	 */
	public function delay(func:Void->Void, delay:Int):Int {
		totoal += 1;
		return reg(func, delay, false);
	}

	public function hashKey(key:Int) {
		return map.exists(key);
	}
}
