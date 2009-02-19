From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 1/2] i2c: move twl4030-pwrbutton to child registration style
Date: Thu, 19 Feb 2009 15:29:56 +0200
Message-ID: <1235050197-26818-2-git-send-email-me@felipebalbi.com>
References: <1235050197-26818-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48178 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbZBSNaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Feb 2009 08:30:06 -0500
In-Reply-To: <1235050197-26818-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, David Brownell <dbrownell@users.sourceforge.net>, Samuel Ortiz <sameo@openedhand.com>

This patch is *compile tested only*. It moves twl4030-pwrbutton
to a platform_driver so it can be registered as a child of
twl4030-core.c.

Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Samuel Ortiz <sameo@openedhand.com>
Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/i2c/chips/twl4030-pwrbutton.c |   59 ++++++++++++++++++++++----------
 drivers/mfd/twl4030-core.c            |   12 +++++++
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-pwrbutton.c b/drivers/i2c/chips/twl4030-pwrbutton.c
index 1d9cb90..b0a9c9f 100644
--- a/drivers/i2c/chips/twl4030-pwrbutton.c
+++ b/drivers/i2c/chips/twl4030-pwrbutton.c
@@ -27,20 +27,15 @@
 #include <linux/errno.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <linux/i2c/twl4030.h>
 
-
-#define PWR_PWRON_IRQ (1<<0)
+#define PWR_PWRON_IRQ (1 << 0)
 
 #define STS_HW_CONDITIONS 0xf
 
-
-/* FIXME have this constant delivered to us as part of the
- * twl4030-core setup ...
- */
-#define TWL4030_PWRIRQ_PWRBTN	(TWL4030_PWR_IRQ_BASE + 0)
-
 static struct input_dev *powerbutton_dev;
+static struct device *dbg_dev;
 
 static irqreturn_t powerbutton_irq(int irq, void *dev_id)
 {
@@ -61,29 +56,32 @@ static irqreturn_t powerbutton_irq(int irq, void *dev_id)
 		input_report_key(powerbutton_dev, KEY_POWER,
 				 value & PWR_PWRON_IRQ);
 	} else {
-		pr_err("twl4030: i2c error %d while reading TWL4030"
+		dev_err(dbg_dev, "twl4030: i2c error %d while reading TWL4030"
 			" PM_MASTER STS_HW_CONDITIONS register\n", err);
 	}
 
 	return IRQ_HANDLED;
 }
 
-static int __init twl4030_pwrbutton_init(void)
+static int __devinit twl4030_pwrbutton_probe(struct platform_device *pdev)
 {
 	int err = 0;
+	int irq = platform_get_irq(pdev, 0);
+
+	dbg_dev = &pdev->dev;
 
 	/* PWRBTN == PWRON */
-	err = request_irq(TWL4030_PWRIRQ_PWRBTN, powerbutton_irq,
+	err = request_irq(irq, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
-			"PwrButton", NULL);
+			"twl4030-pwrbutton", NULL);
 	if (err < 0) {
-		pr_debug("Can't get IRQ for power button: %d\n", err);
+		dev_dbg(&pdev->dev, "Can't get IRQ for power button: %d\n", err);
 		goto out;
 	}
 
 	powerbutton_dev = input_allocate_device();
 	if (!powerbutton_dev) {
-		pr_debug("Can't allocate power button\n");
+		dev_dbg(&pdev->dev, "Can't allocate power button\n");
 		err = -ENOMEM;
 		goto free_irq_and_out;
 	}
@@ -94,11 +92,11 @@ static int __init twl4030_pwrbutton_init(void)
 
 	err = input_register_device(powerbutton_dev);
 	if (err) {
-		pr_debug("Can't register power button: %d\n", err);
+		dev_dbg(&pdev->dev, "Can't register power button: %d\n", err);
 		goto free_input_dev;
 	}
 
-	printk(KERN_INFO "triton2 power button driver initialized\n");
+	dev_info(&pdev->dev, "triton2 power button driver initialized\n");
 
 	return 0;
 
@@ -110,13 +108,36 @@ free_irq_and_out:
 out:
 	return err;
 }
-module_init(twl4030_pwrbutton_init);
 
-static void __exit twl4030_pwrbutton_exit(void)
+static int __devexit twl4030_pwrbutton_remove(struct platform_device *pdev)
 {
-	free_irq(TWL4030_PWRIRQ_PWRBTN, NULL);
+	int irq = platform_get_irq(pdev, 0);
+
+	free_irq(irq, NULL);
 	input_unregister_device(powerbutton_dev);
 	input_free_device(powerbutton_dev);
+
+	return 0;
+}
+
+struct platform_driver twl4030_pwrbutton_driver = {
+	.probe		= twl4030_pwrbutton_probe,
+	.remove		= twl4030_pwrbutton_remove,
+	.driver		= {
+		.name	= "twl4030-pwrbutton",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init twl4030_pwrbutton_init(void)
+{
+	return platform_driver_register(&twl4030_pwrbutton_driver);
+}
+module_init(twl4030_pwrbutton_init);
+
+static void __exit twl4030_pwrbutton_exit(void)
+{
+	platform_driver_unregister(&twl4030_pwrbutton_driver);
 }
 module_exit(twl4030_pwrbutton_exit);
 
diff --git a/drivers/mfd/twl4030-core.c b/drivers/mfd/twl4030-core.c
index 19ee29b..1552296 100644
--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -107,6 +107,11 @@
 #define twl_has_usb()	false
 #endif
 
+#if defined(CONFIG_TWL4030_PWRBUTTON) || defined(CONFIG_TWL4030_PWBUTTON_MODULE)
+#define twl_has_pwrbutton()	true
+#else
+#define twl_has_pwrbutton()	false
+#endif
 
 /* Triton Core internal information (BEGIN) */
 
@@ -534,6 +539,13 @@ add_children(struct twl4030_platform_data *pdata, unsigned long features)
 		usb_transceiver = child;
 	}
 
+	if (twl_has_pwrbutton()) {
+		child = add_child(1, "twl4030_pwrbutton",
+				NULL, 0, true, pdata->irq_base + 8 + 0, 0);
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+	}
+
 	if (twl_has_regulator()) {
 		/*
 		child = add_regulator(TWL4030_REG_VPLL1, pdata->vpll1);
-- 
1.6.1.3

