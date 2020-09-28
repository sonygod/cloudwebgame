const puppeteer = require('puppeteer');

// 导入设备描述库
const devices = require('puppeteer/DeviceDescriptors');

(async () => {
  const browser = await puppeteer.launch({ headless: false, devtools: true });
  const page = await browser.newPage();

  // 模拟iPhone X
  await page.emulate(devices['iPhone X']);
  await page.goto('https://www.qikegu.com');

//   await browser.close();
})();