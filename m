From: Vignesh R <vigneshr@ti.com>
Subject: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute encoder
Date: Thu, 19 May 2016 14:34:00 +0530
Message-ID: <1463648641-6931-2-git-send-email-vigneshr@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Johan Hovold <johan@kernel.org>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Vignesh R <vigneshr@ti.com>, Masanari Iida <standby24x7@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, S Twiss <stwiss.opensource@diasemi.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Moritz Fischer <moritz.fischer@ettus.com>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Timo Teras <timo.teras@iki.fi>, Guido Martinez <guido@vanguardiasur.com.ar>, Clifton Barnes <clifton.a.barnes@gmail.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

There are rotary-encoders where GPIO lines reflect the actual position
of the rotary encoder dial. For example, if dial points to 9, then four
GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
Add support for such rotary-encoder.
The driver relies on rotary-encoder,absolute-encoder DT property to
detect such encoders.
Since, GPIO IRQs are not necessary to work with
such encoders, optional polling mode support is added using
input_poll_dev skeleton. This is can be used by enabling
CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 .../devicetree/bindings/input/rotary-encoder.txt   |   4 +
 Documentation/input/rotary-encoder.txt             |   9 ++
 drivers/input/misc/Kconfig                         |  11 ++
 drivers/input/misc/rotary_encoder.c                | 165 ++++++++++++++++-----
 4 files changed, 155 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index 6c9f0c8a846c..9c928dbd1500 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -12,6 +12,10 @@ Optional properties:
 - rotary-encoder,relative-axis: register a relative axis rather than an
   absolute one. Relative axis will only generate +1/-1 events on the input
   device, hence no steps need to be passed.
+- rotary-encoder,absolute-encoder: support encoders where GPIO lines
+  reflect the actual position of the rotary encoder dial. For example,
+  if dial points to 9, then four GPIO lines read HLLH(1001b = 9).
+  In this case, rotary-encoder,steps-per-period needed not be defined.
 - rotary-encoder,rollover: Automatic rollove when the rotary value becomes
   greater than the specified steps or smaller than 0. For absolute axis only.
 - rotary-encoder,steps-per-period: Number of steps (stable states) per period.
diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
index 46a74f0c551a..dc76092f5618 100644
--- a/Documentation/input/rotary-encoder.txt
+++ b/Documentation/input/rotary-encoder.txt
@@ -36,6 +36,15 @@ The phase diagram of these two outputs look like this:
                 |<>|
 	          one step (quarter-period mode)
 
+
+In some encoders, the value pointed by rotary encoders switch is directly
+reflected by status of the GPIOs connecting rotary encoder to CPU. For
+example, if rotary encoder dial points to 9, then the four GPIOs
+conncting rotary encoder will read HLLH(1001b = 9). Such encoders are
+supported by defining devictree binding "rotary-encoder,absolute-encoder".
+These encoders are also supported without need for event(IRQ) generation
+using Input subsytem's polling mode support.
+
 For more information, please see
 	https://en.wikipedia.org/wiki/Rotary_encoder
 
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 1f2337abcf2f..81805f9a534c 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -566,6 +566,17 @@ config INPUT_GPIO_ROTARY_ENCODER
 	  To compile this driver as a module, choose M here: the
 	  module will be called rotary_encoder.
 
+config INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT
+	bool "Polling mode support for rotary encoder"
+	depends on INPUT_GPIO_ROTARY_ENCODER
+	select INPUT_POLLDEV
+	help
+	  Say Y here to enable polling mode support for rotary encoders
+	  connected to GPIO lines that do have interrupt capability and
+	  report rotary encoder position as absolute value over GPIO
+	  lines. Check file: Documentation/input/rotary-encoder.txt for
+	  more information.
+
 config INPUT_RB532_BUTTON
 	tristate "Mikrotik Routerboard 532 button interface"
 	depends on MIKROTIK_RB532
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index c7fc8d4fb080..8f60289fb6cd 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -25,24 +25,29 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/property.h>
+#include <linux/input-polldev.h>
 
 #define DRV_NAME "rotary-encoder"
 
 struct rotary_encoder {
 	struct input_dev *input;
-
+#ifdef CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT
+	struct input_polled_dev *poll_dev;
+#endif
 	struct mutex access_mutex;
 
 	u32 steps;
 	u32 axis;
 	bool relative_axis;
 	bool rollover;
+	bool absolute_encoder;
 
 	unsigned int pos;
 
 	struct gpio_descs *gpios;
+	struct device *dev;
 
-	unsigned int *irq;
+	int *irq;
 
 	bool armed;
 	signed char dir;	/* 1 - clockwise, -1 - CCW */
@@ -67,6 +72,21 @@ static unsigned int rotary_encoder_get_state(struct rotary_encoder *encoder)
 	return ret & 3;
 }
 
+static unsigned int rotary_encoder_get_gpios_state(struct rotary_encoder
+						   *encoder)
+{
+	int i;
+	unsigned int ret = 0;
+
+	for (i = 0; i < encoder->gpios->ndescs; ++i) {
+		int val = gpiod_get_value_cansleep(encoder->gpios->desc[i]);
+
+		ret = ret << 1 | val;
+	}
+
+	return ret;
+}
+
 static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 {
 	if (encoder->relative_axis) {
@@ -178,6 +198,72 @@ out:
 	return IRQ_HANDLED;
 }
 
+static void rotary_encoder_setup_input_params(struct rotary_encoder  *encoder)
+{
+	struct input_dev *input = encoder->input;
+	struct platform_device *pdev = to_platform_device(encoder->dev);
+
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = encoder->dev;
+
+	if (encoder->relative_axis)
+		input_set_capability(input, EV_REL, encoder->axis);
+	else
+		input_set_abs_params(input,
+				     encoder->axis, 0, encoder->steps, 0, 1);
+}
+
+static irqreturn_t rotary_absolute_encoder_irq(int irq, void *dev_id)
+{
+	struct rotary_encoder *encoder = dev_id;
+	unsigned int state;
+
+	mutex_lock(&encoder->access_mutex);
+
+	state = rotary_encoder_get_gpios_state(encoder);
+	if (state != encoder->last_stable) {
+		input_report_abs(encoder->input, encoder->axis, state);
+		input_sync(encoder->input);
+		encoder->last_stable = state;
+	}
+
+	mutex_lock(&encoder->access_mutex);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT
+static void rotary_encoder_poll_gpios(struct input_polled_dev *poll_dev)
+{
+	struct rotary_encoder *encoder = poll_dev->private;
+	unsigned int state = rotary_encoder_get_gpios_state(encoder);
+
+	if (state != encoder->last_stable) {
+		input_report_abs(encoder->input, encoder->axis, state);
+		input_sync(encoder->input);
+		encoder->last_stable = state;
+	}
+}
+
+static int rotary_encoder_register_poll_device(struct rotary_encoder
+		*encoder)
+{
+	struct input_polled_dev *poll_dev =
+		devm_input_allocate_polled_device(encoder->dev);
+
+	if (!poll_dev)
+		return -ENOMEM;
+	poll_dev->private = encoder;
+	poll_dev->poll = rotary_encoder_poll_gpios;
+	encoder->input = poll_dev->input;
+	rotary_encoder_setup_input_params(encoder);
+	encoder->poll_dev = poll_dev;
+
+	return input_register_polled_device(poll_dev);
+}
+#endif
+
 static int rotary_encoder_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -227,38 +313,32 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	input = devm_input_allocate_device(dev);
-	if (!input)
-		return -ENOMEM;
-
-	encoder->input = input;
-
-	input->name = pdev->name;
-	input->id.bustype = BUS_HOST;
-	input->dev.parent = dev;
-
-	if (encoder->relative_axis)
-		input_set_capability(input, EV_REL, encoder->axis);
-	else
-		input_set_abs_params(input,
-				     encoder->axis, 0, encoder->steps, 0, 1);
-
-	switch (steps_per_period >> (encoder->gpios->ndescs - 2)) {
-	case 4:
-		handler = &rotary_encoder_quarter_period_irq;
-		encoder->last_stable = rotary_encoder_get_state(encoder);
-		break;
-	case 2:
-		handler = &rotary_encoder_half_period_irq;
-		encoder->last_stable = rotary_encoder_get_state(encoder);
-		break;
-	case 1:
-		handler = &rotary_encoder_irq;
-		break;
-	default:
-		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
-			steps_per_period);
-		return -EINVAL;
+	encoder->dev = dev;
+	encoder->absolute_encoder =
+		device_property_read_bool(dev,
+					  "rotary-encoder,absolute-encoder");
+	if (encoder->absolute_encoder) {
+		handler = rotary_absolute_encoder_irq;
+	} else {
+		switch (steps_per_period >> (encoder->gpios->ndescs - 2)) {
+		case 4:
+			handler = &rotary_encoder_quarter_period_irq;
+			encoder->last_stable =
+				rotary_encoder_get_state(encoder);
+			break;
+		case 2:
+			handler = &rotary_encoder_half_period_irq;
+			encoder->last_stable =
+				rotary_encoder_get_state(encoder);
+			break;
+		case 1:
+			handler = &rotary_encoder_irq;
+			break;
+		default:
+			dev_err(dev, "'%d' is not a valid steps-per-period value\n",
+				steps_per_period);
+			return -EINVAL;
+		}
 	}
 
 	encoder->irq =
@@ -271,6 +351,18 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	for (i = 0; i < encoder->gpios->ndescs; ++i) {
 		encoder->irq[i] = gpiod_to_irq(encoder->gpios->desc[i]);
 
+#ifdef CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT
+		if (encoder->irq[i] < 0 && encoder->absolute_encoder) {
+			dev_info(dev, "Using poll mode\n");
+			err = rotary_encoder_register_poll_device(encoder);
+			if (err) {
+				dev_err(dev, "failed to register poll dev\n");
+				return err;
+			}
+			platform_set_drvdata(pdev, encoder);
+			return 0;
+		}
+#endif
 		err = devm_request_threaded_irq(dev, encoder->irq[i],
 				NULL, handler,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
@@ -283,6 +375,11 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		}
 	}
 
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+	encoder->input = input;
+	rotary_encoder_setup_input_params(encoder);
 	err = input_register_device(input);
 	if (err) {
 		dev_err(dev, "failed to register input device\n");
-- 
2.8.2
