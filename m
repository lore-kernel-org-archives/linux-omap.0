From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 10/25] minor twl4030-core cleanups
Date: Tue, 30 Sep 2008 21:42:54 +0300
Message-ID: <1222800189-29737-11-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
 <1222800189-29737-9-git-send-email-me@felipebalbi.com>
 <1222800189-29737-10-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60464 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbYI3Ss5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:48:57 -0400
In-Reply-To: <1222800189-29737-10-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

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
1.6.0.1.196.g01914

