package;

import puppeteer.EmulateOptions;
import Puppeteer;
import puppeteer.devices.Device;
import puppeteer.Browser;

import utils.TimerOne;
using tink.CoreApi;

@await
class Main {
	public static function main() {
		DeviceList.init();

		Date.now();

		// var touchstart = new Touch({
		// 	identifier: cast Date.now().getTime(),
		// 	target: js.Browser.window,
		// 	pageX: 210,
		// 	pageY: 148,
		// 	screenX: 210,
		// 	screenY: 148,
		// 	clientX: 210,
		// 	clientY: 148
		// });

		start();
	}

	@async
	public static function start() {
		var browser:Browser = @await Puppeteer.launch({headless: false, devtools: false}).toPromise();

		var page = @await browser.newPage().toPromise();

		// var d:Device = DeviceList.map['iPhone X'];
		// @await page.emulate(d).toPromise();
    @await page.setUserAgent('Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1').toPromise();
		@await page.setViewport({
		    width: 375,
		    height: 667,
        isMobile: true,
        deviceScaleFactor: 3,
        hasTouch:true,
        isLandscape: false,
		  }).toPromise();

		@await page.goto('http://games.shidaizhu.com/public/1001/index.html').toPromise();

		//	@await page.mouse.click(Random.int(10, 375), Random.int(10, 600), {delay: 1000}).toPromise();
		page.on('touchstart', function(errorT, args) {
			trace(errorT, args);
		});
    page.on('touchend', function(errorT, args) {
			trace(errorT, args);
    });
    
    page.on('error', function(errorT, args) {
			trace(errorT, args);
		});
	

		@await  page.touchscreen.tap(200,440).toPromise();

    page.emit('error', new Error('An error within the page'));


    
    TimerOne.getInstance().reg(function(){

      if(Random.int(1,10)>6){
        @await  page.touchscreen.tap(200,440).toPromise();
      }
     
    },1000);

    
	}
}
