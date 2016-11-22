From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v8 1/8] drivers:input:tsc2007: add new common binding names, pre-calibration, flipping and rotation
Date: Tue, 22 Nov 2016 15:02:28 +0100
Message-ID: <88a60b6d6537d500997d225bc70a28a8be2016e3.1479823354.git.hns@goldelico.com>
References: <cover.1479823354.git.hns@goldelico.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <cover.1479823354.git.hns@goldelico.com>
In-Reply-To: <cover.1479823354.git.hns@goldelico.com>
References: <cover.1479823354.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, "H. Nikolaus Schaller" <hns@goldelico.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, linux-iio@vger.kernel.org, kernel@pyra-handheld.com
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

Please note that the old ti,fuzz properties have been removed since they
are replaced by the common bindings touchscreen-fuzz-x/y/z.

Finally, calculate_pressure has been renamed to calculate_resistance
because that is what it is doing.

[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../bindings/input/touchscreen/tsc2007.txt         |  20 ++--
 drivers/input/touchscreen/tsc2007.c                | 120 +++++++++++++++++----
 include/linux/i2c/tsc2007.h                        |   8 ++
 3 files changed, 118 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
index ec365e1..6e9fd55 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2007.txt
@@ -6,6 +6,7 @@ Required properties:
 - ti,x-plate-ohms: X-plate resistance in ohms.
 
 Optional properties:
+- generic touch screen properties: see touchscreen binding [2].
 - gpios: the interrupt gpio the chip is connected to (trough the penirq pin).
   The penirq pin goes to low when the panel is touched.
   (see GPIO binding[1] for more details).
@@ -13,17 +14,20 @@ Optional properties:
   (see interrupt binding[0]).
 - interrupts: (gpio) interrupt to which the chip is connected
   (see interrupt binding[0]).
-- ti,max-rt: maximum pressure.
-- ti,fuzzx: specifies the absolute input fuzz x value.
-  If set, it will permit noise in the data up to +- the value given to the fuzz
-  parameter, that is used to filter noise from the event stream.
-- ti,fuzzy: specifies the absolute input fuzz y value.
-- ti,fuzzz: specifies the absolute input fuzz z value.
+- ti,max-rt: maximum pressure resistance above which samples are ignored
+  (default: 4095).
+- ti,report-resistance: report resistance (no pressure = max_rt) instead
+  of pressure (no pressure = 0).
+- ti,min-x: minimum value reported by X axis ADC (default 0).
+- ti,max-x: maximum value reported by X axis ADC (default 4095).
+- ti,min-y: minimum value reported by Y axis ADC (default 0).
+- ti,max-y: maximum value reported by Y axis ADC (default 4095).
 - ti,poll-period: how much time to wait (in milliseconds) before reading again the
-  values from the tsc2007.
+  values from the tsc2007 (default 1).
 
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 [1]: Documentation/devicetree/bindings/gpio/gpio.txt
+[2]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
 
 Example:
 	&i2c1 {
@@ -35,6 +39,8 @@ Example:
 			interrupts = <0x0 0x8>;
 			gpios = <&gpio4 0 0>;
 			ti,x-plate-ohms = <180>;
+			touchscreen-size-x = <640>;
+			touchscreen-size-y = <480>;
 		};
 
 		/* ... */
diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 5d0cd51..c1d9593 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -29,6 +29,7 @@
 #include <linux/of_device.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
+#include <linux/input/touchscreen.h>
 
 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
 #define TSC2007_MEASURE_AUX		(0x2 << 4)
@@ -74,6 +75,14 @@ struct tsc2007 {
 
 	u16			model;
 	u16			x_plate_ohms;
+
+	struct touchscreen_properties prop;
+
+	bool			report_resistance;
+	u16			min_x;
+	u16			min_y;
+	u16			max_x;
+	u16			max_y;
 	u16			max_rt;
 	unsigned long		poll_period; /* in jiffies */
 	int			fuzzx;
@@ -128,7 +137,8 @@ static void tsc2007_read_values(struct tsc2007 *tsc, struct ts_event *tc)
 	tsc2007_xfer(tsc, PWRDOWN);
 }
 
-static u32 tsc2007_calculate_pressure(struct tsc2007 *tsc, struct ts_event *tc)
+static u32 tsc2007_calculate_resistance(struct tsc2007 *tsc,
+					struct ts_event *tc)
 {
 	u32 rt = 0;
 
@@ -177,12 +187,13 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 	struct ts_event tc;
 	u32 rt;
 
+	dev_dbg(&ts->client->dev, "soft irq %d\n", irq);
 	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
 
 		/* pen is down, continue with the measurement */
 		tsc2007_read_values(ts, &tc);
 
-		rt = tsc2007_calculate_pressure(ts, &tc);
+		rt = tsc2007_calculate_resistance(ts, &tc);
 
 		if (!rt && !ts->get_pendown_state) {
 			/*
@@ -194,21 +205,41 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 		}
 
 		if (rt <= ts->max_rt) {
+			int sx, sy;
+
 			dev_dbg(&ts->client->dev,
 				"DOWN point(%4d,%4d), pressure (%4u)\n",
 				tc.x, tc.y, rt);
 
+			if (!ts->report_resistance)
+				rt = ts->max_rt - rt;
+
+			/* scale ADC values to desired output range */
+			sx = (ts->prop.max_x * (tc.x - ts->min_x))
+				/ (ts->max_x - ts->min_x);
+			sy = (ts->prop.max_y * (tc.y - ts->min_y))
+				/ (ts->max_y - ts->min_y);
+			rt = (input->absinfo[ABS_PRESSURE].maximum * rt) /
+				ts->max_rt;
+
+			dev_dbg(&ts->client->dev,
+				"Scaled point(%4d,%4d), pressure (%4u)\n",
+				sx, sy, rt);
+
+			/* report event */
 			input_report_key(input, BTN_TOUCH, 1);
-			input_report_abs(input, ABS_X, tc.x);
-			input_report_abs(input, ABS_Y, tc.y);
+			touchscreen_report_pos(ts->input, &ts->prop,
+						(unsigned int) sx,
+						(unsigned int) sy,
+						false);
 			input_report_abs(input, ABS_PRESSURE, rt);
 
 			input_sync(input);
 
 		} else {
 			/*
-			 * Sample found inconsistent by debouncing or pressure is
-			 * beyond the maximum. Don't report it to user space,
+			 * Sample found inconsistent by debouncing or resistance
+			 * is beyond the maximum. Don't report it to user space,
 			 * repeat at least once more the measurement.
 			 */
 			dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
@@ -233,6 +264,7 @@ static irqreturn_t tsc2007_hard_irq(int irq, void *handle)
 {
 	struct tsc2007 *ts = handle;
 
+	dev_dbg(&ts->client->dev, "hard irq %d\n", irq);
 	if (tsc2007_is_pen_down(ts))
 		return IRQ_WAKE_THREAD;
 
@@ -303,14 +335,24 @@ static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts)
 	else
 		ts->max_rt = MAX_12BIT;
 
-	if (!of_property_read_u32(np, "ti,fuzzx", &val32))
-		ts->fuzzx = val32;
+	ts->report_resistance =
+		       of_property_read_bool(np, "ti,report-resistance");
 
-	if (!of_property_read_u32(np, "ti,fuzzy", &val32))
-		ts->fuzzy = val32;
+	touchscreen_parse_properties(ts->input, false, &ts->prop);
 
-	if (!of_property_read_u32(np, "ti,fuzzz", &val32))
-		ts->fuzzz = val32;
+	if (!of_property_read_u32(np, "ti,min-x", &val32))
+		ts->min_x = val32;
+	if (!of_property_read_u32(np, "ti,max-x", &val32))
+		ts->max_x = val32;
+	else
+		ts->max_x = MAX_12BIT;
+
+	if (!of_property_read_u32(np, "ti,min-y", &val32))
+		ts->min_y = val32;
+	if (!of_property_read_u32(np, "ti,max-y", &val32))
+		ts->max_y = val32;
+	else
+		ts->max_y = MAX_12BIT;
 
 	if (!of_property_read_u64(np, "ti,poll-period", &val64))
 		ts->poll_period = msecs_to_jiffies(val64);
@@ -332,6 +374,22 @@ static int tsc2007_probe_dt(struct i2c_client *client, struct tsc2007 *ts)
 			 "GPIO not specified in DT (of_get_gpio returned %d)\n",
 			 ts->gpio);
 
+	dev_dbg(&client->dev,
+			"min/max_x (%4d,%4d)\n",
+			ts->min_x, ts->max_x);
+	dev_dbg(&client->dev,
+			"min/max_y (%4d,%4d)\n",
+			ts->min_y, ts->max_y);
+	dev_dbg(&client->dev,
+			"max_rt (%4d)\n",
+			ts->max_rt);
+	dev_dbg(&client->dev,
+			"size (%4d,%4d)\n",
+			ts->prop.max_x, ts->prop.max_y);
+	dev_dbg(&client->dev,
+			"ts-gpio: %d\n",
+			ts->gpio);
+
 	return 0;
 }
 #else
@@ -349,6 +407,14 @@ static int tsc2007_probe_pdev(struct i2c_client *client, struct tsc2007 *ts,
 	ts->model             = pdata->model;
 	ts->x_plate_ohms      = pdata->x_plate_ohms;
 	ts->max_rt            = pdata->max_rt ? : MAX_12BIT;
+	ts->prop.swap_x_y     = pdata->swap_xy;
+	ts->prop.invert_x     = pdata->invert_x;
+	ts->prop.invert_y     = pdata->invert_y;
+	ts->report_resistance = pdata->report_resistance;
+	ts->min_x             = pdata->min_x ? : 0;
+	ts->min_y             = pdata->min_y ? : 0;
+	ts->max_x             = pdata->max_x ? : MAX_12BIT;
+	ts->max_y             = pdata->max_y ? : MAX_12BIT;
 	ts->poll_period       = msecs_to_jiffies(pdata->poll_period ? : 1);
 	ts->get_pendown_state = pdata->get_pendown_state;
 	ts->clear_penirq      = pdata->clear_penirq;
@@ -388,13 +454,6 @@ static int tsc2007_probe(struct i2c_client *client,
 	if (!ts)
 		return -ENOMEM;
 
-	if (pdata)
-		err = tsc2007_probe_pdev(client, ts, pdata, id);
-	else
-		err = tsc2007_probe_dt(client, ts);
-	if (err)
-		return err;
-
 	input_dev = devm_input_allocate_device(&client->dev);
 	if (!input_dev)
 		return -ENOMEM;
@@ -419,12 +478,25 @@ static int tsc2007_probe(struct i2c_client *client,
 	input_set_drvdata(input_dev, ts);
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) |
+				BIT_MASK(ABS_PRESSURE);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
-	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, ts->fuzzx, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, ts->fuzzy, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT,
-			     ts->fuzzz, 0);
+	if (pdata) {
+		err = tsc2007_probe_pdev(client, ts, pdata, id);
+		if (err)
+			return err;
+		input_set_abs_params(input_dev, ABS_X, 0, ts->max_x-ts->min_x,
+							  ts->fuzzx, 0);
+		input_set_abs_params(input_dev, ABS_Y, 0, ts->max_y-ts->min_y,
+							  ts->fuzzy, 0);
+		input_set_abs_params(input_dev, ABS_PRESSURE, 0, ts->max_rt,
+							  ts->fuzzz, 0);
+	} else {
+		err = tsc2007_probe_dt(client, ts);
+		if (err)
+			return err;
+	}
 
 	if (pdata) {
 		if (pdata->exit_platform_hw) {
@@ -443,6 +515,8 @@ static int tsc2007_probe(struct i2c_client *client,
 			pdata->init_platform_hw();
 	}
 
+	dev_dbg(&client->dev, "request irq %d\n",
+			ts->irq);
 	err = devm_request_threaded_irq(&client->dev, ts->irq,
 					tsc2007_hard_irq, tsc2007_soft_irq,
 					IRQF_ONESHOT,
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index 4f35b6a..632db20 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -6,6 +6,14 @@
 struct tsc2007_platform_data {
 	u16	model;				/* 2007. */
 	u16	x_plate_ohms;	/* must be non-zero value */
+	bool	swap_xy;	/* swap x and y axis */
+	bool	invert_x;
+	bool	invert_y;
+	bool	report_resistance;
+	u16	min_x;	/* min and max values reported by ADC */
+	u16	min_y;
+	u16	max_x;
+	u16	max_y;
 	u16	max_rt; /* max. resistance above which samples are ignored */
 	unsigned long poll_period; /* time (in ms) between samples */
 	int	fuzzx; /* fuzz factor for X, Y and pressure axes */
-- 
2.7.3

