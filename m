From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] musb: cleanup the nop registration for OMAP3EVM
Date: Fri,  3 Jul 2009 14:30:26 +0530
Message-ID: <1246611626-28137-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

OMAP3EVM uses ISP1504 phy which doesn't require any
programming and thus has to use NOP otg transceiver.

Cleanups being done:
	- Remove unwanted code in usb-musb.c file
	- Register nop in OMAP3EVM board file using
	  usb_nop_xceiv_register().
	- Select NOP_USB_XCEIV for OMAP3EVM boards.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
This patch is refreshed based on David's recommendations at
[1] and [2].

[1] http://marc.info/?l=linux-omap&m=123904265231360&w=2
[2] http://www.mail-archive.com/linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg13891.html

 arch/arm/mach-omap2/board-omap3evm.c |    3 +++
 arch/arm/mach-omap2/usb-musb.c       |   21 ---------------------
 drivers/usb/musb/Kconfig             |    1 +
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 595beac..ad3c78c 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -307,6 +308,8 @@ static void __init omap3_evm_init(void)
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
 	omap_serial_init();
+	/* OMAP3EVM uses ISP1504 phy and thus has to register nop transceiver */
+	usb_nop_xceiv_register();
 	usb_musb_init();
 	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
 	ads7846_dev_init();
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index d85296d..739e59e 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -155,20 +155,6 @@ static struct platform_device musb_device = {
 	.resource	= musb_resources,
 };
 
-#ifdef CONFIG_NOP_USB_XCEIV
-static u64 nop_xceiv_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device nop_xceiv_device = {
-	.name		= "nop_usb_xceiv",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &nop_xceiv_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= NULL,
-	},
-};
-#endif
-
 void __init usb_musb_init(void)
 {
 	if (cpu_is_omap243x())
@@ -183,13 +169,6 @@ void __init usb_musb_init(void)
 	 */
 	musb_plat.clock = "ick";
 
-#ifdef CONFIG_NOP_USB_XCEIV
-	if (platform_device_register(&nop_xceiv_device) < 0) {
-		printk(KERN_ERR "Unable to register NOP-XCEIV device\n");
-		return;
-	}
-#endif
