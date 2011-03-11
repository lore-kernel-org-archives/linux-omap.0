From: Denis Karpov <ext-denis.2.karpov@nokia.com>
Subject: [PATCH 1/2] input: twl4030-pwrbutton: add support for platform data
Date: Fri, 11 Mar 2011 18:37:29 +0200
Message-ID: <078f4a01fa523a0f9e0033c52f52413d60cc5431.1299860654.git.ext-denis.2.karpov@nokia.com>
References: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.48]:25733 "EHLO mgw-sa02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390Ab1CKQhm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 11:37:42 -0500
In-Reply-To: <1299861450-19914-1-git-send-email-ext-denis.2.karpov@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Denis Karpov <ext-denis.2.karpov@nokia.com>

Adds support for TWL4030 power button platform data. Currently the only
field is the flag to optionally generate repeat input events from a button
press.

Signed-off-by: Denis Karpov <ext-denis.2.karpov@nokia.com>
---
 drivers/input/misc/twl4030-pwrbutton.c |    8 ++++++++
 drivers/mfd/twl-core.c                 |    4 +++-
 include/linux/i2c/twl.h                |    5 +++++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index f16972b..c380b83 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -54,9 +54,14 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 
 static int __init twl4030_pwrbutton_probe(struct platform_device *pdev)
 {
+	struct twl4030_pwrbutton_data *pdata = pdev->dev.platform_data;
 	struct input_dev *pwr;
 	int irq = platform_get_irq(pdev, 0);
 	int err;
+	bool repeat = false;
+
+	if (pdata)
+		repeat = pdata->rep;
 
 	pwr = input_allocate_device();
 	if (!pwr) {
@@ -70,6 +75,9 @@ static int __init twl4030_pwrbutton_probe(struct platform_device *pdev)
 	pwr->phys = "twl4030_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
 
+	if (repeat)
+		__set_bit(EV_REP, pwr->evbit);
+
 	err = request_threaded_irq(irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 			"twl4030_pwrbutton", pwr);
diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index a35fa7d..fd75ee9 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -729,7 +729,9 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 
 	if (twl_has_pwrbutton()) {
 		child = add_child(1, "twl4030_pwrbutton",
-				NULL, 0, true, pdata->irq_base + 8 + 0, 0);
+				pdata->pwrbutton,
+				sizeof(*pdata->pwrbutton),
+				true, pdata->irq_base + 8 + 0, 0);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 	}
diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 9d88b71..60e48fa 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -586,6 +586,10 @@ struct twl4030_keypad_data {
 	bool rep;
 };
 
+struct twl4030_pwrbutton_data {
+	bool rep;
+};
+
 enum twl4030_usb_mode {
 	T2_USB_MODE_ULPI = 1,
 	T2_USB_MODE_CEA2011_3PIN = 2,
@@ -667,6 +671,7 @@ struct twl4030_platform_data {
 	struct twl4030_gpio_platform_data	*gpio;
 	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
+	struct twl4030_pwrbutton_data		*pwrbutton;
 	struct twl4030_usb_data			*usb;
 	struct twl4030_power_data		*power;
 	struct twl4030_codec_data		*codec;
-- 
1.7.1

