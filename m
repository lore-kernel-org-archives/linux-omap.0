From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 0/9] twl4030 updates
Date: Fri, 26 Sep 2008 10:12:27 -0700
Message-ID: <200809261012.28007.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:21252 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753047AbYIZRMc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2008 13:12:32 -0400
In-Reply-To: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Let's apply the following patch 10/9 on top of this though.
And probably update the board files similarly (alpha order).

As an FYI, if you look at the "MFD core" you'll observe that
if some crap gets stripped away, the *useful* bit is a utility
making some of this create-a-child-node easier.  It's not worth
using now.  But a little bird told me that some of that crap
may be getting stripped away soon, so add_children() could
become simpler.  Wouldn't affect the function drivers (the
OTG transceiver, keypad, GPIO, RTC, etc) because we have, with
foresight, been using platform_device already.  ;)

- Dave

======= SNIP!
From: David Brownell <dbrownell@users.sourceforge.net>

Minor twl4030-core cleanups:  alphabetize the creation of the
new sub-function nodes; wrap an #if around the OMAP-only part
(to get more general build testing when this goes upstream);
remove reference to undocumented "twl3040" variant.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/twl4030-core.c |  115 ++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

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
@@ -668,6 +668,27 @@ static int add_children(struct twl4030_p
 	struct twl4030_client	*twl = NULL;
 	int			status = 0;
 
+	if (twl_has_keypad() && pdata->keypad) {
+		pdev = platform_device_alloc("twl4030_keypad", -1);
+		if (pdev) {
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
+			pdev->dev.parent = &twl->client->dev;
+			device_init_wakeup(&pdev->dev, 1);
+			status = platform_device_add_data(pdev, pdata->keypad,
+					sizeof(*pdata->keypad));
+			if (status < 0) {
+				platform_device_put(pdev);
+				goto err;
+			}
+			status = platform_device_add(pdev);
+			if (status < 0)
+				platform_device_put(pdev);
+		} else {
+			status = -ENOMEM;
+			goto err;
+		}
+	}
+
 	if (twl_has_gpio() && pdata->gpio) {
 		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM1];
 
@@ -706,6 +727,27 @@ static int add_children(struct twl4030_p
 		}
 	}
 
+	if (twl_has_madc() && pdata->madc) {
+		pdev = platform_device_alloc("twl4030_madc", -1);
+		if (pdev) {
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
+			pdev->dev.parent = &twl->client->dev;
+			device_init_wakeup(&pdev->dev, 1);
+			status = platform_device_add_data(pdev, pdata->madc,
+					sizeof(*pdata->madc));
+			if (status < 0) {
+				platform_device_put(pdev);
+				goto err;
+			}
+			status = platform_device_add(pdev);
+			if (status < 0)
+				platform_device_put(pdev);
+		} else {
+			status = -ENOMEM;
+			goto err;
+		}
+	}
+
 	if (twl_has_rtc()) {
 		pdev = platform_device_alloc("twl4030_rtc", -1);
 		if (pdev) {
@@ -736,27 +778,6 @@ static int add_children(struct twl4030_p
 		}
 	}
 
-	if (twl_has_keypad() && pdata->keypad) {
-		pdev = platform_device_alloc("twl4030_keypad", -1);
-		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
-			pdev->dev.parent = &twl->client->dev;
-			device_init_wakeup(&pdev->dev, 1);
-			status = platform_device_add_data(pdev, pdata->keypad,
-					sizeof(*pdata->keypad));
-			if (status < 0) {
-				platform_device_put(pdev);
-				goto err;
-			}
-			status = platform_device_add(pdev);
-			if (status < 0)
-				platform_device_put(pdev);
-		} else {
-			status = -ENOMEM;
-			goto err;
-		}
-	}
-
 	if (twl_has_usb() && pdata->usb) {
 		pdev = platform_device_alloc("twl4030_usb", -1);
 		if (pdev) {
@@ -778,27 +799,6 @@ static int add_children(struct twl4030_p
 		}
 	}
 
-	if (twl_has_madc() && pdata->madc) {
-		pdev = platform_device_alloc("twl4030_madc", -1);
-		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM2];
-			pdev->dev.parent = &twl->client->dev;
-			device_init_wakeup(&pdev->dev, 1);
-			status = platform_device_add_data(pdev, pdata->madc,
-					sizeof(*pdata->madc));
-			if (status < 0) {
-				platform_device_put(pdev);
-				goto err;
-			}
-			status = platform_device_add(pdev);
-			if (status < 0)
-				platform_device_put(pdev);
-		} else {
-			status = -ENOMEM;
-			goto err;
-		}
-	}
-
 err:
 	pr_err("failed to add twl4030's children\n");
 	return status;
@@ -844,17 +844,19 @@ static int __init unprotect_pm_master(vo
 
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
@@ -879,6 +881,7 @@ static int __init power_companion_init(v
 	/* effect->MADC+USB ck en */
 	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, ctrl, R_CFG_BOOT);
 	e |= protect_pm_master();
+#endif	/* OMAP */
 
 	return e;
 }

