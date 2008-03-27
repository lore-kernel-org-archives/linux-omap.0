From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 7/7] USB: MUSB: Let board specific code handle clock
	initialization
Date: Thu, 27 Mar 2008 19:42:02 +0200
Message-ID: <20080327174202.GI4652@gandalf.research.nokia.com>
References: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com> <1206638167-23951-2-git-send-email-felipe.balbi@nokia.com> <1206638167-23951-3-git-send-email-felipe.balbi@nokia.com> <1206638167-23951-4-git-send-email-felipe.balbi@nokia.com> <1206638167-23951-5-git-send-email-felipe.balbi@nokia.com> <1206638167-23951-6-git-send-email-felipe.balbi@nokia.com> <1206638167-23951-7-git-send-email-felipe.balbi@nokia.com> <1206638167-23951-8-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:42419 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYC0RnK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 13:43:10 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2RHiUKW007915
	for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 12:45:12 -0500
Content-Disposition: inline
In-Reply-To: <1206638167-23951-8-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org

On Thu, Mar 27, 2008 at 07:16:07PM +0200, Felipe Balbi wrote:
> Instead of clk_get() in omap2430.c driver, we can let
> musb_core.c do it by setting the clock id in
> musb_platform_data structure.

board-rx51-usb.c was missing,

updated below:

>From 14e0ef4901509ac229aecc561c248a96d70ac46d Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Tue, 25 Mar 2008 15:18:16 +0200
Subject: [PATCH 7/7] USB: MUSB: Let board specific code handle clock initialization

Instead of clk_get() in omap2430.c driver, we can let
musb_core.c do it by setting the clock id in
musb_platform_data structure.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp-usb.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-3430sdp-usb.c |   29 +++++++++++++++++++++++++++--
 arch/arm/mach-omap2/board-rx51-usb.c    |   26 +++++++++++++++++++++++++-
 drivers/usb/musb/omap2430.c             |    8 --------
 4 files changed, 79 insertions(+), 11 deletions(-)

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
diff --git a/arch/arm/mach-omap2/board-rx51-usb.c b/arch/arm/mach-omap2/board-rx51-usb.c
index 3c85dd0..f6e2a0b 100644
--- a/arch/arm/mach-omap2/board-rx51-usb.c
+++ b/arch/arm/mach-omap2/board-rx51-usb.c
@@ -62,10 +62,34 @@ static struct resource musb_resources[] = {
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
 	.mode		= BOARD_MODE,
-	.clock		= NULL,
 	.multipoint	= 1,
+	.clock		= "hsotgusb_ick",
+	.set_clock	= musb_set_clock,
 #ifdef CONFIG_USB_OTG_TPL
 	.otg_tpl	= tpl_table,
 #endif
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index efdb795..29927d0 100644
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
 
 	otg_set_suspend(&musb->xceiv, 1);
-	clk_disable(musb->clock);
 	return 0;
 }
 
 int musb_platform_resume(struct musb *musb)
 {
-	clk_enable(musb->clock);
 	otg_set_suspend(&musb->xceiv, 0);
 
 	OTG_FORCESTDBY_REG &= ~ENABLEFORCE; /* disable MSTANDBY */
-- 
1.5.5.rc1.12.g660b9

-- 
	- Balbi
