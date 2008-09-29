From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 10/22] minor twl4030-core cleanups
Date: Mon, 29 Sep 2008 16:14:27 +0300
Message-ID: <1222694079-16289-11-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-4-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-5-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-6-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-7-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-8-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-9-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29705 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbYI2NPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:36 -0400
In-Reply-To: <1222694079-16289-10-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Minor twl4030-core cleanups:  alphabetize the creation of the
new sub-function nodes; wrap an #if around the OMAP-only part
(to get more general build testing when this goes upstream);
remove reference to undocumented "twl3040" variant.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Moved gpio before keypad driver due to alphabetic order.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |  103 +++++++++++++++++++------------------
 1 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 79d4d82..22850a8 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -45,24 +45,12 @@
 
 #define DRIVER_NAME			"twl4030"
 
-#if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
-#define twl_has_rtc()	true
-#else
-#define twl_has_rtc()	false
-#endif
-
 #if defined(CONFIG_KEYBOARD_TWL4030) || defined(CONFIG_KEYBOARD_TWL4030_MODULE)
 #define twl_has_keypad()	true
 #else
 #define twl_has_keypad()	false
 #endif
 
-#if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
-#define twl_has_usb()	true
-#else
-#define twl_has_usb()	false
-#endif
-
 #ifdef CONFIG_TWL4030_GPIO
 #define twl_has_gpio()	true
 #else
@@ -75,6 +63,18 @@
 #define twl_has_madc()	false
 #endif
 
+#if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
+#define twl_has_rtc()	true
+#else
+#define twl_has_rtc()	false
+#endif
+
+#if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
+#define twl_has_usb()	true
+#else
+#define twl_has_usb()	false
+#endif
+
 /* Primary Interrupt Handler on TWL4030 Registers */
 
 /* Register Definitions */
@@ -706,27 +706,18 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
-	if (twl_has_rtc()) {
-		pdev = platform_device_alloc("twl4030_rtc", -1);
+	if (twl_has_keypad() && pdata->keypad) {
+		pdev = platform_device_alloc("twl4030_keypad", -1);
 		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
-
-			/*
-			 * FIXME add the relevant IRQ resource, and make the
-			 * rtc driver use it instead of hard-wiring ...
-			 *
-			 * REVISIT platform_data here currently only supports
-			 * setting up the "msecure" line ... which actually
-			 * violates the "princple of least privilege", since
-			 * it's effectively always in "high trust" mode.
-			 *
-			 * For now, expect equivalent treatment at board init:
-			 * setting msecure high.  Eventually, Linux might
-			 * become more aware of those HW security concerns.
-			 */
-
+			status = platform_device_add_data(pdev, pdata->keypad,
+					sizeof(*pdata->keypad));
+			if (status < 0) {
+				platform_device_put(pdev);
+				goto err;
+			}
 			status = platform_device_add(pdev);
 			if (status < 0)
 				platform_device_put(pdev);
@@ -736,14 +727,14 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
-	if (twl_has_keypad() && pdata->keypad) {
-		pdev = platform_device_alloc("twl4030_keypad", -1);
+	if (twl_has_madc() && pdata->madc) {
+		pdev = platform_device_alloc("twl4030_madc", -1);
 		if (pdev) {
 			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
-			status = platform_device_add_data(pdev, pdata->keypad,
-					sizeof(*pdata->keypad));
+			status = platform_device_add_data(pdev, pdata->madc,
+					sizeof(*pdata->madc));
 			if (status < 0) {
 				platform_device_put(pdev);
 				goto err;
@@ -757,18 +748,27 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
-	if (twl_has_usb() && pdata->usb) {
-		pdev = platform_device_alloc("twl4030_usb", -1);
+	if (twl_has_rtc()) {
+		pdev = platform_device_alloc("twl4030_rtc", -1);
 		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM0];
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
-			status = platform_device_add_data(pdev, pdata->usb,
-					sizeof(*pdata->usb));
-			if (status < 0) {
-				platform_device_put(pdev);
-				goto err;
-			}
+
+			/*
+			 * FIXME add the relevant IRQ resource, and make the
+			 * rtc driver use it instead of hard-wiring ...
+			 *
+			 * REVISIT platform_data here currently only supports
+			 * setting up the "msecure" line ... which actually
+			 * violates the "princple of least privilege", since
+			 * it's effectively always in "high trust" mode.
+			 *
+			 * For now, expect equivalent treatment at board init:
+			 * setting msecure high.  Eventually, Linux might
+			 * become more aware of those HW security concerns.
+			 */
+
 			status = platform_device_add(pdev);
 			if (status < 0)
 				platform_device_put(pdev);
@@ -778,14 +778,14 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
-	if (twl_has_madc() && pdata->madc) {
-		pdev = platform_device_alloc("twl4030_madc", -1);
+	if (twl_has_usb() && pdata->usb) {
+		pdev = platform_device_alloc("twl4030_usb", -1);
 		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM0];
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
-			status = platform_device_add_data(pdev, pdata->madc,
-					sizeof(*pdata->madc));
+			status = platform_device_add_data(pdev, pdata->usb,
+					sizeof(*pdata->usb));
 			if (status < 0) {
 				platform_device_put(pdev);
 				goto err;
@@ -844,17 +844,19 @@ static int __init unprotect_pm_master(void)
 
 static int __init power_companion_init(void)
 {
+	int e = 0;
+
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 	struct clk *osc;
 	u32 rate;
 	u8 ctrl = HFCLK_FREQ_26_MHZ;
-	int e = 0;
 
 	if (cpu_is_omap2430())
 		osc = clk_get(NULL, "osc_ck");
 	else
 		osc = clk_get(NULL, "osc_sys_ck");
 	if (IS_ERR(osc)) {
-		printk(KERN_WARNING "Skipping twl3040 internal clock init and "
+		printk(KERN_WARNING "Skipping twl4030 internal clock init and "
 				"using bootloader value (unknown osc rate)\n");
 		return 0;
 	}
@@ -879,6 +881,7 @@ static int __init power_companion_init(void)
 	/* effect->MADC+USB ck en */
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
+#endif	/* OMAP */
 
 	return e;
 }
-- 
1.6.0.2.307.gc427

