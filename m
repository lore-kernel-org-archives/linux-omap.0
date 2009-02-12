From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] musb_hdrc: Set musb_resources dynamically
Date: Thu, 12 Feb 2009 11:16:55 -0800
Message-ID: <20090212191655.19766.8429.stgit@localhost>
References: <20090212191408.19766.62874.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59635 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811AbZBLTRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 14:17:02 -0500
In-Reply-To: <20090212191408.19766.62874.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

The cpu_is_omap34xx() may not be static.

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/usb-musb.c |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 5d79f89..897c07d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -35,13 +35,7 @@
 
 #ifdef CONFIG_USB_MUSB_SOC
 static struct resource musb_resources[] = {
-	[0] = {
-		.start	= cpu_is_omap34xx()
-			? OMAP34XX_HSUSB_OTG_BASE
-			: OMAP243X_HS_BASE,
-		.end	= cpu_is_omap34xx()
-			? OMAP34XX_HSUSB_OTG_BASE + SZ_8K - 1
-			: OMAP243X_HS_BASE + SZ_8K - 1,
+	[0] = { /* start and end set dynamically */
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {	/* general IRQ */
@@ -128,9 +122,7 @@ static struct musb_hdrc_platform_data musb_plat = {
 #elif defined(CONFIG_USB_GADGET_MUSB_HDRC)
 	.mode		= MUSB_PERIPHERAL,
 #endif
-	.clock		= cpu_is_omap34xx()
-			? "hsotgusb_ick"
-			: "usbhs_ick",
+	/* .clock is set dynamically */
 	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
 
@@ -160,6 +152,17 @@ static struct platform_device musb_device = {
 void __init usb_musb_init(void)
 {
 #ifdef CONFIG_USB_MUSB_SOC
+
+	if (cpu_is_omap243x()) {
+		musb_resources[0].start = OMAP243X_HS_BASE;
+		musb_plat.clock = "usbhs_ick";
+	} else {
+		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
+		musb_plat.clock = "hsotgusb_ick";
+	}
+
+	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
+
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;

