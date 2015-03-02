From: Adam YH Lee <adam.yh.lee@gmail.com>
Subject: [PATCH] rtc-twl: add DT support for RTC battery recharge
Date: Mon,  2 Mar 2015 13:32:15 -0800
Message-ID: <1425331935-8849-1-git-send-email-adam.yh.lee@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:41189 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbbCBVdG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Mar 2015 16:33:06 -0500
Received: by pablj1 with SMTP id lj1so11467739pab.8
        for <linux-omap@vger.kernel.org>; Mon, 02 Mar 2015 13:33:06 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: ash@gumstix.com, arun@gumstix.com, Adam YH Lee <adam.yh.lee@gmail.com>

This patch introduces device tree binding for the RTC backup battery charger
on TWL4030.

Tested on Gumstix Overo (OMAP3) Tobi.

Signed-off-by: Adam YH Lee <adam.yh.lee@gmail.com>
---
 Documentation/devicetree/bindings/rtc/twl-rtc.txt | 20 ++++++++++++
 drivers/rtc/rtc-twl.c                             | 39 +++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/twl-rtc.txt b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
index 596e0c9..fcb0c4d 100644
--- a/Documentation/devicetree/bindings/rtc/twl-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
@@ -5,8 +5,28 @@ The TWL family (twl4030/6030) contains a RTC.
 Required properties:
 - compatible : Should be twl4030-rtc
 
+Optional properties:
+- enable-battery-charge: Boolean, enable RTC battery charge
+
+- charge-rate : should contain trickle charge rate:
+
+     25uA - <0x0>
+    150uA - <0x1>
+    500uA - <0x2>
+      1mA - <0x3>
+
+- charge-voltage : should contain charge voltage:
+
+     2.5v - <0x0>
+     3.0v - <0x4>
+     3.1v - <0x8>
+     3.2v - <0xc>
+
 Examples:
 
 rtc@0 {
     compatible = "ti,twl4030-rtc";
+    enable-battery-charge;
+    charge-rate = <0x1>;
+    charge-voltage = <0x8>;
 };
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 1915464..0c3e855 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -31,6 +31,13 @@
 
 #include <linux/i2c/twl.h>
 
+/*
+ * PM_RECEIVER block register offsets (use TWL4030_MODULE_PM_RECEIVER)
+ */
+#define REG_BB_CFG	0x12
+
+/* PM_RECEIVER  BB_CFG bitfield */
+#define BIT_PM_RECEIVER_BB_CFG_BBCHEN           0x10
 
 /*
  * RTC block register offsets (use TWL_MODULE_RTC)
@@ -474,8 +481,11 @@ static struct rtc_class_ops twl_rtc_ops = {
 static int twl_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
+	struct device_node *node = pdev->dev.of_node;
 	int ret = -EINVAL;
 	int irq = platform_get_irq(pdev, 0);
+	const __be32 *charge_volt = NULL;
+	const __be32 *charge_rate = NULL;
 	u8 rd_reg;
 
 	if (irq <= 0)
@@ -543,6 +553,35 @@ static int twl_rtc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+#ifdef CONFIG_OF
+	if (of_property_read_bool(node, "enable-battery-charge")  == true) {
+		charge_rate = of_get_property(node, "charge-rate", NULL);
+		if (charge_rate == NULL) {
+			dev_err(&pdev->dev, "Backup battery charge rate is missing\n");
+			return ret;
+		}
+		charge_volt = of_get_property(node, "charge-voltage", NULL);
+		if (charge_volt == NULL) {
+			dev_err(&pdev->dev, "Backup battery charge voltage is missing\n");
+			return ret;
+		}
+		ret = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
+				BIT_PM_RECEIVER_BB_CFG_BBCHEN |
+				be32_to_cpup(charge_volt) |
+				be32_to_cpup(charge_rate),
+				REG_BB_CFG);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to enable backup battery charging\n");
+			return ret;
+		}
+
+		dev_info(&pdev->dev, "RTC backup charge enabled\n");
+	} else {
+		twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER, 0x0, REG_BB_CFG);
+		dev_info(&pdev->dev, "RTC backup charge disabled\n");
+	}
+#endif
+
 	platform_set_drvdata(pdev, rtc);
 	return 0;
 }
-- 
1.9.1

