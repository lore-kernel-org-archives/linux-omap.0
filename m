From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] musb: refresh nop transceiver support for musb
Date: Mon,  6 Apr 2009 19:04:49 +0530
Message-ID: <1239024889-28597-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34404 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053AbZDFNfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Apr 2009 09:35:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, david-b@pacbell.net, felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

As the parent patch for NOP transceiver got modified which now does the
NOP device registration also so removing registration part from 
usb-musb.c file.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Against latest linux-omap tree as on 6th April.

 arch/arm/mach-omap2/usb-musb.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 927c2d9..e932b8c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -25,6 +25,7 @@
 #include <linux/io.h>
 
 #include <linux/usb/musb.h>
+#include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -145,20 +146,6 @@ static struct platform_device musb_device = {
 	.resource	= musb_resources,
 };
 
-#ifdef CONFIG_NOP_USB_XCEIV
-static u64 nop_xceiv_dmamask = DMA_32BIT_MASK;
-
-static struct platform_device nop_xceiv_device = {
-	.name		= "nop_usb_xceiv",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &nop_xceiv_dmamask,
-		.coherent_dma_mask	= DMA_32BIT_MASK,
-		.platform_data		= NULL,
-	},
-};
-#endif
-
 void __init usb_musb_init(void)
 {
 	if (cpu_is_omap243x()) {
@@ -172,10 +159,7 @@ void __init usb_musb_init(void)
 	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
 
 #ifdef CONFIG_NOP_USB_XCEIV
-	if (platform_device_register(&nop_xceiv_device) < 0) {
-		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
-		return;
-	}
+	usb_nop_xceiv_register();
 #endif
 
 	if (platform_device_register(&musb_device) < 0) {
-- 
1.6.0.3

