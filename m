From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v7 6/9] drivers:input:ads7846(+tsc2046): add new common binding names, pre-calibration and flipping
Date: Fri, 11 Nov 2016 20:02:03 +0100
Message-ID: <1557925457e4157ddffd28a0ac14848f0853031c.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
In-Reply-To: <cover.1478890925.git.hns@goldelico.com>
References: <cover.1478890925.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
introduced common DT bindings for touchscreens [1] and a helper function to
parse the DT.

commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")
added another helper for parsing axis inversion and swapping
and applying them to x and y coordinates.

Both helpers have been integrated to accommodate any orientation of the
touch panel in relation to the LCD.

A new feature is to introduce scaling the min/max ADC values to the screen
size.

This makes it possible to pre-calibrate the touch so that is (almost)
exactly matches the LCD pixel coordinates it is glued onto. This allows to
well enough operate the touch before a user space calibration step can
improve the precision.

[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/input/ads7846.txt          |  9 +++-
 drivers/input/touchscreen/ads7846.c                | 60 ++++++++++++++++++----
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
index 9fc47b0..29f91ed 100644
--- a/Documentation/devicetree/bindings/input/ads7846.txt
+++ b/Documentation/devicetree/bindings/input/ads7846.txt
@@ -26,6 +26,12 @@ Additional required properties:
 
 Optional properties:
 
+You can optionally specify any of the touchscreen parameters described in
+
+	Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+
+This allows to scale, invert or swap coordinates and define the fuzz factors.
+
 	ti,vref-delay-usecs		vref supply delay in usecs, 0 for
 					external vref (u16).
 	ti,vref-mv			The VREF voltage, in millivolts (u16).
@@ -33,7 +39,7 @@ Optional properties:
 					(ADS7846).
 	ti,keep-vref-on			set to keep vref on for differential
 					measurements as well
-	ti,swap-xy			swap x and y axis
+	ti,swap-xy			deprecated name for touchscreen-swapped-x-y
 	ti,settle-delay-usec		Settling time of the analog signals;
 					a function of Vcc and the capacitance
 					on the X/Y drivers.  If set to non-zero,
@@ -82,6 +88,7 @@ Example for a TSC2046 chip connected to an McSPI controller of an OMAP SoC::
 			pendown-gpio = <&gpio1 8 0>;
 			vcc-supply = <&reg_vcc3>;
 
+			touchscreen-swapped-x-y;
 			ti,x-min = /bits/ 16 <0>;
 			ti,x-max = /bits/ 16 <8000>;
 			ti,y-min = /bits/ 16 <0>;
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1ce3ecb..400e421 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -34,6 +34,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/input/touchscreen.h>
 #include <asm/irq.h>
 
 /*
@@ -109,8 +110,13 @@ struct ads7846 {
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
 	u16			pressure_max;
+	u16			x_min;
+	u16			x_max;
+	u16			y_min;
+	u16			y_max;
+
+	struct touchscreen_properties prop;
 
-	bool			swap_xy;
 	bool			use_internal;
 
 	struct ads7846_packet	*packet;
@@ -825,22 +831,36 @@ static void ads7846_report_state(struct ads7846 *ts)
 	 */
 	if (Rt) {
 		struct input_dev *input = ts->input;
+		int sx, sy;
+
+		dev_dbg(&ts->spi->dev,
+			"Raw point(%4d,%4d), pressure (%4u)\n",
+				x, y, Rt);
+
+		/* scale ADC values to desired output range */
+		sx = (ts->prop.max_x * (x - ts->x_min))
+			/ (ts->x_max - ts->x_min);
+		sy = (ts->prop.max_y * (y - ts->y_min))
+			/ (ts->y_max - ts->y_min);
 
-		if (ts->swap_xy)
-			swap(x, y);
+		dev_dbg(&ts->spi->dev,
+			"Scaled point(%4d,%4d), pressure (%4u)\n",
+				sx, sy, Rt);
 
+		/* report event */
 		if (!ts->pendown) {
 			input_report_key(input, BTN_TOUCH, 1);
 			ts->pendown = true;
 			dev_vdbg(&ts->spi->dev, "DOWN\n");
 		}
 
-		input_report_abs(input, ABS_X, x);
-		input_report_abs(input, ABS_Y, y);
+		touchscreen_report_pos(ts->input, &ts->prop,
+				       (unsigned int) sx, (unsigned int) sy,
+				       false);
 		input_report_abs(input, ABS_PRESSURE, ts->pressure_max - Rt);
 
 		input_sync(input);
-		dev_vdbg(&ts->spi->dev, "%4d/%4d/%4d\n", x, y, Rt);
+		dev_vdbg(&ts->spi->dev, "%4d/%4d/%4d\n", sx, sy, Rt);
 	}
 }
 
@@ -1212,6 +1232,8 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
 	pdata->keep_vref_on = of_property_read_bool(node, "ti,keep-vref-on");
 
 	pdata->swap_xy = of_property_read_bool(node, "ti,swap-xy");
+	if (pdata->swap_xy)
+		dev_notice(dev, "please update device tree to use touchscreen-swapped-x-y");
 
 	of_property_read_u16(node, "ti,settle-delay-usec",
 			     &pdata->settle_delay_usecs);
@@ -1315,7 +1337,6 @@ static int ads7846_probe(struct spi_device *spi)
 	ts->pressure_max = pdata->pressure_max ? : ~0;
 
 	ts->vref_mv = pdata->vref_mv;
-	ts->swap_xy = pdata->swap_xy;
 
 	if (pdata->filter != NULL) {
 		if (pdata->filter_init != NULL) {
@@ -1355,18 +1376,35 @@ static int ads7846_probe(struct spi_device *spi)
 	input_dev->dev.parent = &spi->dev;
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) |
+				BIT_MASK(ABS_PRESSURE);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	ts->x_min = pdata->x_min ? : 0;
+	ts->x_max = pdata->x_max ? : MAX_12BIT;
+	ts->y_min = pdata->y_min ? : 0;
+	ts->y_max = pdata->y_max ? : MAX_12BIT;
+
 	input_set_abs_params(input_dev, ABS_X,
-			pdata->x_min ? : 0,
-			pdata->x_max ? : MAX_12BIT,
+			ts->x_min,
+			ts->x_max,
 			0, 0);
 	input_set_abs_params(input_dev, ABS_Y,
-			pdata->y_min ? : 0,
-			pdata->y_max ? : MAX_12BIT,
+			ts->y_min,
+			ts->y_max,
 			0, 0);
 	input_set_abs_params(input_dev, ABS_PRESSURE,
 			pdata->pressure_min, pdata->pressure_max, 0, 0);
 
+	if (spi->dev.of_node) {
+		input_abs_set_min(input_dev, ABS_X, 0);
+		input_abs_set_min(input_dev, ABS_Y, 0);
+
+		touchscreen_parse_properties(ts->input, false, &ts->prop);
+	}
+
+	ts->prop.swap_x_y |= pdata->swap_xy;
+
 	ads7846_setup_spi_msg(ts, pdata);
 
 	ts->reg = regulator_get(&spi->dev, "vcc");
-- 
2.7.3
