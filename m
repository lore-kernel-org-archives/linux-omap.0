From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] usb: musb: adding support for registering nop xceiv
Date: Thu,  8 Jan 2009 16:23:56 +0530
Message-ID: <1231412036-7371-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41472 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752038AbZAHKyK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2009 05:54:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: david-b@pacbell.net, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Adding support for registering nop usb transceiver for musb
platforms. Tested with OMAP35xx EVM having OTG phy ISP1504
which is autonomous and doesn't require any phy programming.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 61c5709..c202256 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -155,10 +155,29 @@ static struct platform_device musb_device = {
 };
 #endif
 
+#ifdef CONFIG_NOP_USB_XCEIV
+static u64 nop_xceiv_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device nop_xceiv_device = {
+	.name		= "nop_usb_xceiv",
+	.id		= -1,
+	.dev = {
+		.dma_mask		= &nop_xceiv_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.platform_data		= NULL,
+	},
+};
+#endif
 
 void __init usb_musb_init(void)
 {
 #ifdef CONFIG_USB_MUSB_SOC
+#ifdef CONFIG_NOP_USB_XCEIV
+	if (platform_device_register(&nop_xceiv_device) < 0) {
+		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
+		return;
+	}
+#endif
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
-- 
1.5.6

