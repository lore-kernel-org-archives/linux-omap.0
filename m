From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] input: twl4030-pwrbutton: avoid merge conflicts
Date: Thu,  5 Mar 2009 21:27:11 +0200
Message-ID: <1236281231-625-1-git-send-email-felipe.balbi@nokia.com>
References: <20090227200034.GK16801@frodo>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42485 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbZCET1T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2009 14:27:19 -0500
In-Reply-To: <20090227200034.GK16801@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

sync up with the version going upstream.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
This patch is syncing with the fixed up version accepted in
mainline. Should be applied to avoid merge conflicts
on the next merge window.

 drivers/input/misc/Kconfig             |    6 ++
 drivers/input/misc/twl4030-pwrbutton.c |   87 ++++++++++++++++----------------
 2 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9667b50..6fa9e38 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -196,6 +196,12 @@ config INPUT_CM109
 config INPUT_TWL4030_PWRBUTTON
 	tristate "TWL4030 Power button Driver"
 	depends on TWL4030_CORE
+	help
+	  Say Y here if you want to enable power key reporting via the
+	  TWL4030 family of chips.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called twl4030_pwrbutton.
 
 config INPUT_UINPUT
 	tristate "User level driver support"
diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl4030-pwrbutton.c
index b0a9c9f..7150830 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -1,11 +1,10 @@
 /**
- * drivers/i2c/chips/twl4030-pwrbutton.c
+ * twl4030-pwrbutton.c - TWL4030 Power Button Input Driver
  *
- * Driver for sending triton2 power button event to input-layer
- *
- * Copyright (C) 2008 Nokia Corporation
+ * Copyright (C) 2008-2009 Nokia Corporation
  *
  * Written by Peter De Schrijver <peter.de-schrijver@nokia.com>
+ * Several fixes by Felipe Balbi <felipe.balbi@nokia.com>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License. See the file "COPYING" in the main directory of this
@@ -34,18 +33,18 @@
 
 #define STS_HW_CONDITIONS 0xf
 
-static struct input_dev *powerbutton_dev;
-static struct device *dbg_dev;
-
-static irqreturn_t powerbutton_irq(int irq, void *dev_id)
+static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 {
+	struct input_dev *pwr = _pwr;
 	int err;
 	u8 value;
 
 #ifdef CONFIG_LOCKDEP
 	/* WORKAROUND for lockdep forcing IRQF_DISABLED on us, which
-	 * we don't want and can't tolerate.  Although it might be
-	 * friendlier not to borrow this thread context...
+	 * we don't want and can't tolerate since this is a threaded
+	 * IRQ and can sleep due to the i2c reads it has to issue.
+	 * Although it might be friendlier not to borrow this thread
+	 * context...
 	 */
 	local_irq_enable();
 #endif
@@ -53,11 +52,11 @@ static irqreturn_t powerbutton_irq(int irq, void *dev_id)
 	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &value,
 				  STS_HW_CONDITIONS);
 	if (!err)  {
-		input_report_key(powerbutton_dev, KEY_POWER,
-				 value & PWR_PWRON_IRQ);
+		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
+		input_sync(pwr);
 	} else {
-		dev_err(dbg_dev, "twl4030: i2c error %d while reading TWL4030"
-			" PM_MASTER STS_HW_CONDITIONS register\n", err);
+		dev_err(pwr->dev.parent, "twl4030: i2c error %d while reading"
+			" TWL4030 PM_MASTER STS_HW_CONDITIONS register\n", err);
 	}
 
 	return IRQ_HANDLED;
@@ -65,66 +64,64 @@ static irqreturn_t powerbutton_irq(int irq, void *dev_id)
 
 static int __devinit twl4030_pwrbutton_probe(struct platform_device *pdev)
 {
-	int err = 0;
+	struct input_dev *pwr;
 	int irq = platform_get_irq(pdev, 0);
+	int err;
 
-	dbg_dev = &pdev->dev;
+	pwr = input_allocate_device();
+	if (!pwr) {
+		dev_dbg(&pdev->dev, "Can't allocate power button\n");
+		err = -ENOMEM;
+		goto out;
+	}
 
-	/* PWRBTN == PWRON */
 	err = request_irq(irq, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-			"twl4030-pwrbutton", NULL);
+			"twl4030_pwrbutton", pwr);
 	if (err < 0) {
-		dev_dbg(&pdev->dev, "Can't get IRQ for power button: %d\n", err);
-		goto out;
-	}
-
-	powerbutton_dev = input_allocate_device();
-	if (!powerbutton_dev) {
-		dev_dbg(&pdev->dev, "Can't allocate power button\n");
-		err = -ENOMEM;
-		goto free_irq_and_out;
+		dev_dbg(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
+		goto free_input_dev;
 	}
 
-	powerbutton_dev->evbit[0] = BIT_MASK(EV_KEY);
-	powerbutton_dev->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
-	powerbutton_dev->name = "triton2-pwrbutton";
+	pwr->evbit[0] = BIT_MASK(EV_KEY);
+	pwr->keybit[BIT_WORD(KEY_POWER)] = BIT_MASK(KEY_POWER);
+	pwr->name = "twl4030_pwrbutton";
+	pwr->phys = "twl4030_pwrbutton/input0";
+	pwr->dev.parent = &pdev->dev;
+	platform_set_drvdata(pdev, pwr);
 
-	err = input_register_device(powerbutton_dev);
+	err = input_register_device(pwr);
 	if (err) {
 		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
-		goto free_input_dev;
+		goto free_irq_and_out;
 	}
 
-	dev_info(&pdev->dev, "triton2 power button driver initialized\n");
-
 	return 0;
 
-
-free_input_dev:
-	input_free_device(powerbutton_dev);
 free_irq_and_out:
-	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
+	free_irq(irq, NULL);
+free_input_dev:
+	input_free_device(pwr);
 out:
 	return err;
 }
 
 static int __devexit twl4030_pwrbutton_remove(struct platform_device *pdev)
 {
+	struct input_dev *pwr = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
 
-	free_irq(irq, NULL);
-	input_unregister_device(powerbutton_dev);
-	input_free_device(powerbutton_dev);
+	free_irq(irq, pwr);
+	input_unregister_device(pwr);
 
 	return 0;
 }
 
 struct platform_driver twl4030_pwrbutton_driver = {
 	.probe		= twl4030_pwrbutton_probe,
-	.remove		= twl4030_pwrbutton_remove,
+	.remove		= __devexit_p(twl4030_pwrbutton_remove),
 	.driver		= {
-		.name	= "twl4030-pwrbutton",
+		.name	= "twl4030_pwrbutton",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -141,7 +138,9 @@ static void __exit twl4030_pwrbutton_exit(void)
 }
 module_exit(twl4030_pwrbutton_exit);
 
+MODULE_ALIAS("platform:twl4030_pwrbutton");
 MODULE_DESCRIPTION("Triton2 Power Button");
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Peter De Schrijver");
+MODULE_AUTHOR("Peter De Schrijver <peter.de-schrijver@nokia.com>");
+MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
 
-- 
1.6.2.rc0.61.g5cd12

