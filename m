From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Tue, 18 Nov 2014 13:27:42 -0600
Message-ID: <1416338862-8240-1-git-send-email-balbi@ti.com>
References: <20141118192112.GM6179@saruman>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20141118192112.GM6179@saruman>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Because with OF we can pass more specific
compatible flags (such as edt-ft5306) instead
of generic edt-ft5x06, when i2c-core's
of_i2c_register_devices() tries to request_module(),
it'll request it with a non-existent specific module
alias.

In order to have this driver autoprobing again, we
just need to add missing MODULE_ALIAS() entries to
edt-ft5x06 driver.

Thanks to Dmitry for noticing that it actually should
autoprobe even with of_device_id.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Cc: <stable@vger.kernel.org> # v3.15+
Fixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index ee3434f..bcbf688 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1147,6 +1147,9 @@ static struct i2c_driver edt_ft5x06_ts_driver = {
 
 module_i2c_driver(edt_ft5x06_ts_driver);
 
+MODULE_ALIAS("i2c:edt-ft5206");
+MODULE_ALIAS("i2c:edt-ft5306");
+MODULE_ALIAS("i2c:edt-ft5406");
 MODULE_AUTHOR("Simon Budig <simon.budig@kernelconcepts.de>");
 MODULE_DESCRIPTION("EDT FT5x06 I2C Touchscreen Driver");
 MODULE_LICENSE("GPL");
-- 
2.1.0.GIT
