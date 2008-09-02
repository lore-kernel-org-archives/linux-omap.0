From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc3-omap1] tweak musb_hdrc SOC init code
Date: Tue, 2 Sep 2008 12:05:00 -0700
Message-ID: <200809021205.00376.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com ([69.147.64.89]:24184 "HELO
	smtp116.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751390AbYIBTbo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 15:31:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Minor cleanups to omap 2430/34xx/35x musb_hdrc init:

 - num_eps is 16; here, each one is bidirectional
 - use DMA_32BIT_MASK to prevent confusion/errors
 - initialize root port power to reflect 100 mA limit

This still hard-wires some board-specific data, since there
are no hooks through which different boards can provide the
right data to the init code.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -21,12 +21,15 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/dma-mapping.h>
+
 #include <asm/io.h>
-#include <mach/mux.h>
+
 #include <linux/usb/musb.h>
 
 #include <mach/hardware.h>
 #include <mach/pm.h>
+#include <mach/mux.h>
 #include <mach/usb.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
@@ -109,7 +112,7 @@ static struct musb_hdrc_config musb_config = {
 	.dyn_fifo	= 1,
 	.soft_con	= 1,
 	.dma		= 1,
-	.num_eps	= 32,
+	.num_eps	= 16,
 	.dma_channels	= 7,
 	.dma_req_chan	= (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3),
 	.ram_bits	= 12,
@@ -129,16 +132,22 @@ static struct musb_hdrc_platform_data musb_plat = {
 			: "usbhs_ick",
 	.set_clock	= musb_set_clock,
 	.config		= &musb_config,
+
+	/* REVISIT charge pump on TWL4030 can supply up to
+	 * 100 mA ... but this value is board-specific, like
+	 * "mode", and should be passed to usb_musb_init().
+	 */
+	.power		= 50,			/* up to 100 mA */
 };
 
-static u64 musb_dmamask = ~(u32)0;
+static u64 musb_dmamask = DMA_32BIT_MASK;
 
 static struct platform_device musb_device = {
 	.name		= "musb_hdrc",
 	.id		= -1,
 	.dev = {
 		.dma_mask		= &musb_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
 		.platform_data		= &musb_plat,
 	},
 	.num_resources	= ARRAY_SIZE(musb_resources),
