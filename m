From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 5/8] drivers:input:ads7846(+tsc2046): add new common binding names, pre-calibration and flipping
Date: Fri, 13 Nov 2015 21:35:56 +0100
Message-ID: <7e66c363a6bacc33a77ca7bd577db24f603c5b1a.1447446957.git.hns@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1447446957.git.hns@goldelico.com>
In-Reply-To: <cover.1447446957.git.hns@goldelico.com>
References: <cover.1447446957.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Sebastian Reichel <sre@kernel.org>, Haibo Chen <haibo.chen@freescale.com>, Andrey Gelman <andrey.gelman@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>, Aaron Sierra <asierra@xes-inc.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, gta04-owner@goldelico.com, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
introduced common DT bindings for touchscreens [1] and a helper function to
parse the DT.

This has been integrated and interpretation of the inversion (flipping)
properties for the x and y axis has been added to accommodate any
orientation of the touch in relation to the LCD.

By scaling the min/max ADC values to the screen size it is now possible to
pre-calibrate the touch so that is (almost) exactly matches the LCD it is
glued onto. This allows to well enough operate the touch before a user
space calibration can improve the precision.

[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../devicetree/bindings/input/ads7846.txt          |  8 ++-
 drivers/input/touchscreen/ads7846.c                | 72 ++++++++++++++++++++--
 2 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/ads7846.txt b/Documentation/devicetree/bindings/input/ads7846.txt
index df8b127..ae56355 100644
--- a/Documentation/devicetree/bindings/input/ads7846.txt
+++ b/Documentation/devicetree/bindings/input/ads7846.txt
@@ -26,12 +26,17 @@ Additional required properties:
 
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
 	ti,keep-vref-on			set to keep vref on for differential
 					measurements as well
-	ti,swap-xy			swap x and y axis
 	ti,settle-delay-usec		Settling time of the analog signals;
 					a function of Vcc and the capacitance
 					on the X/Y drivers.  If set to non-zero,
@@ -79,6 +84,7 @@ Example for a TSC2046 chip connected to an McSPI controller of an OMAP SoC::
 			pendown-gpio = <&gpio1 8 0>;
 			vcc-supply = <&reg_vcc3>;
 
+			touchscreen-swapped-x-y;
 			ti,x-min = /bits/ 16 <0>;
 			ti,x-max = /bits/ 16 <8000>;
 			ti,y-min = /bits/ 16 <0>;
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 04edc8f..4525f00 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -34,6 +34,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/input/touchscreen.h>
 #include <asm/irq.h>
 
 /*
@@ -109,8 +110,14 @@ struct ads7846 {
 	u16			vref_delay_usecs;
 	u16			x_plate_ohms;
 	u16			pressure_max;
+	u16			x_min;
+	u16			x_max;
+	u16			y_min;
+	u16			y_max;
 
 	bool			swap_xy;
+	bool			invert_x;
+	bool			invert_y;
 	bool			use_internal;
 
 	struct ads7846_packet	*packet;
@@ -828,9 +835,48 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (Rt) {
 		struct input_dev *input = ts->input;
 
+		dev_dbg(&ts->spi->dev,
+			"Raw point(%4d,%4d), pressure (%4u)\n",
+				x, y, Rt);
+		/* clamp to expected ADC range */
+		if (x < ts->x_min)
+			x = ts->x_min;
+		if (x > ts->x_max)
+			x = ts->x_max;
+		if (y < ts->y_min)
+			y = ts->y_min;
+		if (y > ts->y_max)
+			y = ts->y_max;
+
+		dev_dbg(&ts->spi->dev,
+			"Clamped point(%4d,%4d), pressure (%4u)\n",
+				x, y, Rt);
+
+		/* flip */
+		if (ts->invert_x)
+			x = (ts->x_max - x) + ts->x_min;
+		if (ts->invert_y)
+			y = (ts->y_max - y) + ts->y_min;
+
+		dev_dbg(&ts->spi->dev,
+			"Flipped point(%4d,%4d), pressure (%4u)\n",
+				x, y, Rt);
+
+		/* scale to desired output range */
+		x = (input->absinfo[ABS_X].maximum * (x - ts->x_min))
+			/ (ts->x_max - ts->x_min);
+		y = (input->absinfo[ABS_Y].maximum * (y - ts->y_min))
+			/ (ts->y_max - ts->y_min);
+
+		dev_dbg(&ts->spi->dev,
+			"Scaled point(%4d,%4d), pressure (%4u)\n",
+				x, y, Rt);
+
+		/* swap x and y */
 		if (ts->swap_xy)
 			swap(x, y);
 
+		/* report event */
 		if (!ts->pendown) {
 			input_report_key(input, BTN_TOUCH, 1);
 			ts->pendown = true;
@@ -1213,7 +1259,7 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
 	of_property_read_u16(node, "ti,vref-mv", &pdata->vref_mv);
 	pdata->keep_vref_on = of_property_read_bool(node, "ti,keep-vref-on");
 
-	pdata->swap_xy = of_property_read_bool(node, "ti,swap-xy");
+	pdata->swap_xy = of_property_read_bool(node, "touchscreen-swapped-x-y");
 
 	of_property_read_u16(node, "ti,settle-delay-usec",
 			     &pdata->settle_delay_usecs);
@@ -1358,17 +1404,33 @@ static int ads7846_probe(struct spi_device *spi)
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
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
+		input_dev->absinfo[ABS_X].minimum = 0;
+		input_dev->absinfo[ABS_Y].minimum = 0;
+		ts->invert_x = of_property_read_bool(spi->dev.of_node,
+						     "touchscreen-inverted-x");
+		ts->invert_y = of_property_read_bool(spi->dev.of_node,
+						     "touchscreen-inverted-y");
+		touchscreen_parse_properties(input_dev, false);
+	}
+
 	ads7846_setup_spi_msg(ts, pdata);
 
 	ts->reg = regulator_get(&spi->dev, "vcc");
-- 
2.5.1
