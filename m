From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2] video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
Date: Mon,  9 Jul 2018 21:16:01 +0200
Message-ID: <20180709191601.18681-1-jmkrzyszt@gmail.com>
References: <20180518210954.29044-4-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518210954.29044-4-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Now as Amstrad Delta board - the only user of this driver - provides
GPIO lookup tables, switch from GPIO numbers to GPIO descriptors and
use the table to locate required GPIO pins.

Declare static variables for storing GPIO descriptors and replace
gpio_ function calls with their gpiod_ equivalents. Move GPIO lookup
to the driver probe function so device initialization can be deferred
instead of aborted if a GPIO pin is not yet available.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: Remove problematic error code conversion, no longer needed if used
    on top of commit d08605a64e67 ("ARM: OMAP1: ams-delta: move late
    devices back to init_machine") already in linux-next and commit
    8853daf3b4ac ("gpiolib: Defer on non-DT find_chip_by_name()
    failure") just applied to linux-gpio/devel.

 drivers/video/fbdev/omap/lcd_ams_delta.c | 55 +++++++++++++-------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcd_ams_delta.c b/drivers/video/fbdev/omap/lcd_ams_delta.c
index e8c748a0dfe2..cddbd00cbf9f 100644
--- a/drivers/video/fbdev/omap/lcd_ams_delta.c
+++ b/drivers/video/fbdev/omap/lcd_ams_delta.c
@@ -24,11 +24,10 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/lcd.h>
-#include <linux/gpio.h>
 
 #include <mach/hardware.h>
-#include <mach/board-ams-delta.h>
 
 #include "omapfb.h"
 
@@ -41,6 +40,8 @@
 /* LCD class device section */
 
 static int ams_delta_lcd;
+static struct gpio_desc *gpiod_vblen;
+static struct gpio_desc *gpiod_ndisp;
 
 static int ams_delta_lcd_set_power(struct lcd_device *dev, int power)
 {
@@ -99,41 +100,17 @@ static struct lcd_ops ams_delta_lcd_ops = {
 
 /* omapfb panel section */
 
-static const struct gpio _gpios[] = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_LCD_VBLEN,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "lcd_vblen",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_LCD_NDISP,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "lcd_ndisp",
-	},
-};
-
-static int ams_delta_panel_init(struct lcd_panel *panel,
-		struct omapfb_device *fbdev)
-{
-	return gpio_request_array(_gpios, ARRAY_SIZE(_gpios));
-}
-
-static void ams_delta_panel_cleanup(struct lcd_panel *panel)
-{
-	gpio_free_array(_gpios, ARRAY_SIZE(_gpios));
-}
-
 static int ams_delta_panel_enable(struct lcd_panel *panel)
 {
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 1);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 1);
+	gpiod_set_value(gpiod_ndisp, 1);
+	gpiod_set_value(gpiod_vblen, 1);
 	return 0;
 }
 
 static void ams_delta_panel_disable(struct lcd_panel *panel)
 {
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_VBLEN, 0);
-	gpio_set_value(AMS_DELTA_GPIO_PIN_LCD_NDISP, 0);
+	gpiod_set_value(gpiod_vblen, 0);
+	gpiod_set_value(gpiod_ndisp, 0);
 }
 
 static struct lcd_panel ams_delta_panel = {
@@ -154,8 +131,6 @@ static struct lcd_panel ams_delta_panel = {
 	.pcd		= 0,
 	.acb		= 37,
 
-	.init		= ams_delta_panel_init,
-	.cleanup	= ams_delta_panel_cleanup,
 	.enable		= ams_delta_panel_enable,
 	.disable	= ams_delta_panel_disable,
 };
@@ -166,9 +141,23 @@ static struct lcd_panel ams_delta_panel = {
 static int ams_delta_panel_probe(struct platform_device *pdev)
 {
 	struct lcd_device *lcd_device = NULL;
-#ifdef CONFIG_LCD_CLASS_DEVICE
 	int ret;
 
+	gpiod_vblen = devm_gpiod_get(&pdev->dev, "vblen", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_vblen)) {
+		ret = PTR_ERR(gpiod_vblen);
+		dev_err(&pdev->dev, "VBLEN GPIO request failed (%d)\n", ret);
+		return ret;
+	}
+
+	gpiod_ndisp = devm_gpiod_get(&pdev->dev, "ndisp", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_ndisp)) {
+		ret = PTR_ERR(gpiod_ndisp);
+		dev_err(&pdev->dev, "NDISP GPIO request failed (%d)\n", ret);
+		return ret;
+	}
+
+#ifdef CONFIG_LCD_CLASS_DEVICE
 	lcd_device = lcd_device_register("omapfb", &pdev->dev, NULL,
 						&ams_delta_lcd_ops);
 
-- 
2.16.4
