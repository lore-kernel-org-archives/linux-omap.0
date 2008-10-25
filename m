From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 2/3] clk: use clk_associate for musb driver
Date: Sat, 25 Oct 2008 22:55:47 +0300
Message-ID: <1224964548-31844-2-git-send-email-me@felipebalbi.com>
References: <1224964548-31844-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52385 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYJYTz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Oct 2008 15:55:58 -0400
In-Reply-To: <1224964548-31844-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Let musb use clk_associate to avoid introducing non-standard
clk functions and passing a clk name via pdata.

Also introduce txt file to track clk function names.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-n800-usb.c |   26 --------------------------
 arch/arm/mach-omap2/usb-musb.c       |   34 +++++++++-------------------------
 arch/arm/mach-omap2/usb-tusb6010.c   |    2 ++
 drivers/usb/musb/musb_core.c         |   23 +++++++----------------
 4 files changed, 18 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n800-usb.c b/arch/arm/mach-omap2/board-n800-usb.c
index fc128f2..c5abc83 100644
--- a/arch/arm/mach-omap2/board-n800-usb.c
+++ b/arch/arm/mach-omap2/board-n800-usb.c
@@ -25,7 +25,6 @@
 #define GPIO_TUSB_ENABLE	0
 
 static int tusb_set_power(int state);
-static int tusb_set_clock(struct clk *osc_ck, int state);
 
 #if	defined(CONFIG_USB_MUSB_OTG)
 #	define BOARD_MODE	MUSB_OTG
@@ -82,10 +81,8 @@ static struct musb_hdrc_config musb_config = {
 static struct musb_hdrc_platform_data tusb_data = {
 	.mode		= BOARD_MODE,
 	.set_power	= tusb_set_power,
-	.set_clock	= tusb_set_clock,
 	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
 	.power		= 100,	/* Max 100 mA VBUS for host mode */
-	.clock		= "osc_ck",
 	.config		= &musb_config,
 };
 
@@ -121,29 +118,6 @@ static int tusb_set_power(int state)
 	return retval;
 }
 
-static int		osc_ck_on;
-
-static int tusb_set_clock(struct clk *osc_ck, int state)
-{
-	if (state) {
-		if (osc_ck_on > 0)
-			return -ENODEV;
-
-		omap2_block_sleep();
-		clk_enable(osc_ck);
-		osc_ck_on = 1;
-	} else {
-		if (osc_ck_on == 0)
-			return -ENODEV;
-
-		clk_disable(osc_ck);
-		osc_ck_on = 0;
-		omap2_allow_sleep();
-	}
-
-	return 0;
-}
-
 void __init n800_usb_init(void)
 {
 	int ret = 0;
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 61c5709..99a1b4e 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -31,6 +31,7 @@
 #include <mach/pm.h>
 #include <mach/mux.h>
 #include <mach/usb.h>
+#include <mach/clock.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
 static struct resource musb_resources[] = {
@@ -53,27 +54,6 @@ static struct resource musb_resources[] = {
 	},
 };
 
-static int clk_on;
-
-static int musb_set_clock(struct clk *clk, int state)
-{
-	if (state) {
-		if (clk_on > 0)
-			return -ENODEV;
-
-		clk_enable(clk);
-		clk_on = 1;
-	} else {
-		if (clk_on == 0)
-			return -ENODEV;
-
-		clk_disable(clk);
-		clk_on = 0;
-	}
-
-	return 0;
-}
-
 static struct musb_hdrc_eps_bits musb_eps[] = {
 	{	"ep1_tx", 10,	},
 	{	"ep1_rx", 10,	},
@@ -127,10 +107,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode		= MUSB_PERIPHERAL,
 #endif
-	.clock		= cpu_is_omap34xx()
-			? "hsotgusb_ick"
-			: "usbhs_ick",
-	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
 
 	/* REVISIT charge pump on TWL4030 can supply up to
@@ -159,6 +135,14 @@ static struct platform_device musb_device = {
 void __init usb_musb_init(void)
 {
 #ifdef CONFIG_USB_MUSB_SOC
+	/* associate musb clocks with musb device */
+
+	if (cpu_is_omap34xx())
+		omap_clk_associate("hsotgusb_ick", &musb_device.dev);
+
+	if (cpu_is_omap24xx())
+		omap_clk_associate("usbhs_ick", &musb_device.dev);
+
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
diff --git a/arch/arm/mach-omap2/usb-tusb6010.c b/arch/arm/mach-omap2/usb-tusb6010.c
index 2c88207..86e1f42 100644
--- a/arch/arm/mach-omap2/usb-tusb6010.c
+++ b/arch/arm/mach-omap2/usb-tusb6010.c
@@ -18,6 +18,7 @@
 #include <mach/gpmc.h>
 #include <mach/gpio.h>
 #include <mach/mux.h>
+#include <mach/clock.h>
 
 
 static u8		async_cs, sync_cs;
@@ -250,6 +251,7 @@ tusb6010_setup_interface(struct musb_hdrc_platform_data *data,
 		printk(error, 1, status);
 		return status;
 	}
+	omap_clk_associate("osc_ck", &tusb_device.dev);
 	tusb_resources[0].end = tusb_resources[0].start + 0x9ff;
 	async_cs = async;
 	gpmc_cs_write_reg(async, GPMC_CS_CONFIG1,
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 128e949..ea9dd90 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1922,7 +1922,6 @@ bad_config:
 	spin_lock_init(&musb->lock);
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
-	musb->set_clock = plat->set_clock;
 	musb->min_power = plat->min_power;
 
 	/* Clock usage is chip-specific ... functional clock (DaVinci,
@@ -1930,13 +1929,11 @@ bad_config:
 	 * code does is make sure a clock handle is available; platform
 	 * code manages it during start/stop and suspend/resume.
 	 */
-	if (plat->clock) {
-		musb->clock = clk_get(dev, plat->clock);
-		if (IS_ERR(musb->clock)) {
-			status = PTR_ERR(musb->clock);
-			musb->clock = NULL;
-			goto fail;
-		}
+	musb->clock = clk_get(dev, "iclk");
+	if (IS_ERR(musb->clock)) {
+		status = PTR_ERR(musb->clock);
+		musb->clock = NULL;
+		goto fail;
 	}
 
 	/* assume vbus is off */
@@ -2159,10 +2156,7 @@ static int musb_suspend(struct platform_device *pdev, pm_message_t message)
 		 */
 	}
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 0);
-	else
-		clk_disable(musb->clock);
+	clk_disable(musb->clock);
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
@@ -2177,10 +2171,7 @@ static int musb_resume(struct platform_device *pdev)
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 1);
-	else
-		clk_enable(musb->clock);
+	clk_enable(musb->clock);
 
 	/* for static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down and we're
-- 
1.6.0.2.307.gc427

