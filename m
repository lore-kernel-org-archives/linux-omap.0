From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 7/7] USB: MUSB: Let board specific code handle clock initialization
Date: Thu, 27 Mar 2008 19:16:07 +0200
Message-ID: <1206638167-23951-8-git-send-email-felipe.balbi@nokia.com>
References: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-2-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-3-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-4-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-5-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-6-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-7-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29370 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759114AbYC0RR1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 13:17:27 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2RHHLxS016544
	for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 19:17:25 +0200
In-Reply-To: <1206638167-23951-7-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Instead of clk_get() in omap2430.c driver, we can let
musb_core.c do it by setting the clock id in
musb_platform_data structure.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp-usb.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-3430sdp-usb.c |   29 +++++++++++++++++++++++++++--
 drivers/usb/musb/omap2430.c             |    8 --------
 3 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp-usb.c b/arch/arm/mach-omap2/board-2430sdp-usb.c
index 908a0c0..7f4e017 100644
--- a/arch/arm/mach-omap2/board-2430sdp-usb.c
+++ b/arch/arm/mach-omap2/board-2430sdp-usb.c
@@ -13,9 +13,11 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <linux/usb/musb.h>
 
 #include <asm/arch/hardware.h>
+#include <asm/arch/pm.h>
 #include <asm/arch/usb.h>
 
 static struct resource musb_resources[] = {
@@ -34,6 +36,29 @@ static struct resource musb_resources[] = {
 	},
 };
 
+static int usbhs_ick_on;
+
+static int musb_set_clock(struct clk *clk, int state)
+{
+       if (state) {
+               if (usbhs_ick_on > 0)
+                       return -ENODEV;
+
+               omap2_block_sleep();
+               clk_enable(clk);
+               usbhs_ick_on = 1;
+       } else {
+               if (usbhs_ick_on == 0)
+                       return -ENODEV;
+
+               clk_disable(clk);
+               usbhs_ick_on = 0;
+               omap2_allow_sleep();
+       }
+
+       return 0;
+}
+
 static struct musb_hdrc_platform_data musb_plat = {
 #ifdef CONFIG_USB_MUSB_OTG
 	.mode		= MUSB_OTG,
@@ -43,6 +68,8 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	.multipoint	= 1,
+	.clock		= "usbhs_ick",
+	.set_clock	= musb_set_clock,
 };
 
 static u64 musb_dmamask = ~(u32)0;
diff --git a/arch/arm/mach-omap2/board-3430sdp-usb.c b/arch/arm/mach-omap2/board-3430sdp-usb.c
index 77088b4..81c9af7 100644
--- a/arch/arm/mach-omap2/board-3430sdp-usb.c
+++ b/arch/arm/mach-omap2/board-3430sdp-usb.c
@@ -16,11 +16,13 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
 #include <asm/io.h>
 #include <asm/arch/mux.h>
 #include <linux/usb/musb.h>
 
 #include <asm/arch/hardware.h>
+#include <asm/arch/pm.h>
 #include <asm/arch/usb.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
@@ -40,6 +42,29 @@ static struct resource musb_resources[] = {
 	},
 };
 
+static int hsotgusb_ick_on;
+
+static int musb_set_clock(struct clk *clk, int state)
+{
+	if (state) {
+		if (hsotgusb_ick_on > 0)
+			return -ENODEV;
+
+		omap2_block_sleep();
+		clk_enable(clk);
+		hsotgusb_ick_on = 1;
+	} else {
+		if (hsotgusb_ick_on == 0)
+			return -ENODEV;
+
+		clk_disable(clk);
+		hsotgusb_ick_on = 0;
+		omap2_allow_sleep();
+	}
+
+	return 0;
+}
+
 static struct musb_hdrc_platform_data musb_plat = {
 #ifdef CONFIG_USB_MUSB_OTG
 	.mode		= MUSB_OTG,
@@ -49,8 +74,8 @@ static struct musb_hdrc_platform_data musb_plat = {
 	.mode		= MUSB_PERIPHERAL,
 #endif
 	.multipoint	= 1,
-	.clock		= NULL,
-	.set_clock	= NULL,
+	.clock		= "hsotgusb_ick",
+	.set_clock	= musb_set_clock,
 };
 
 static u64 musb_dmamask = ~(u32)0;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index caae81b..364d746 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -219,13 +219,7 @@ int __init musb_platform_init(struct musb *musb)
 
 #if defined(CONFIG_ARCH_OMAP2430)
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
-	/* get the clock */
-	musb->clock = clk_get((struct device *)musb->controller, "usbhs_ick");
-#else
-	musb->clock = clk_get((struct device *)musb->controller, "hsotgusb_ick");
 #endif
-	if(IS_ERR(musb->clock))
-		return PTR_ERR(musb->clock);
 
 	musb->xceiv = *xceiv;
 	musb_platform_resume(musb);
@@ -261,13 +255,11 @@ int musb_platform_suspend(struct musb *musb)
 	OTG_SYSCONFIG_REG |= AUTOIDLE;		/* enable auto idle */
 
 	musb->xceiv.set_suspend(&musb->xceiv, 1);
-	clk_disable(musb->clock);
 	return 0;
 }
 
 int musb_platform_resume(struct musb *musb)
 {
-	clk_enable(musb->clock);
 	musb->xceiv.set_suspend(&musb->xceiv, 0);
 
 	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
-- 
1.5.5.rc1.12.g660b9

