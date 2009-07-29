From: <gregkh@suse.de>
Subject: patch usb-musb-fix-the-nop-registration-for-omap3evm.patch added to gregkh-2.6 tree
Date: Wed, 29 Jul 2009 07:02:25 -0700
Message-ID: <1248876145550@kroah.org>
References: <19F8576C6E063C45BE387C64729E73940432A6E035@dbde02.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58991 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbZG2ODh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jul 2009 10:03:37 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E73940432A6E035@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ajay.gupta@ti.com, david-b@pacbell.net, dbrownell@users.sourceforge.net, felipe.balbi@nokia.com, gregkh@suse.de, linux-omap@vger.kernel.org, talvala@stanford.edu, tony@atomide.com


This is a note to let you know that I've just added the patch titled

    Subject: USB: musb: fix the nop registration for OMAP3EVM

to my gregkh-2.6 tree.  Its filename is

    usb-musb-fix-the-nop-registration-for-omap3evm.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From ajay.gupta@ti.com  Wed Jul 29 06:50:48 2009
From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Date: Wed, 29 Jul 2009 11:58:57 +0530
Subject: USB: musb: fix the nop registration for OMAP3EVM
To: "gregkh@suse.de" <gregkh@suse.de>, David Brownell <david-b@pacbell.net>
Cc: <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "talvala@stanford.edu" <talvala@stanford.edu>
Message-ID: <19F8576C6E063C45BE387C64729E73940432A6E035@dbde02.ent.ti.com>

OMAP3EVM uses ISP1504 phy which doesn't require any programming and
thus has to use NOP otg transceiver.

Cleanups being done:
	- Remove unwanted code in usb-musb.c file
	- Register NOP in OMAP3EVM board file using
	  usb_nop_xceiv_register().
	- Select NOP_USB_XCEIV for OMAP3EVM boards.
	- Don't enable TWL4030_USB in omap3_evm_defconfig

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Eino-Ville Talvala <talvala@stanford.edu>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/arm/configs/omap3_evm_defconfig |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c |    5 +++++
 arch/arm/mach-omap2/usb-musb.c       |   21 ---------------------
 drivers/usb/musb/Kconfig             |    1 +
 4 files changed, 7 insertions(+), 22 deletions(-)

--- a/arch/arm/configs/omap3_evm_defconfig
+++ b/arch/arm/configs/omap3_evm_defconfig
@@ -1107,7 +1107,7 @@ CONFIG_USB_ZERO=m
 CONFIG_USB_OTG_UTILS=y
 # CONFIG_USB_GPIO_VBUS is not set
 # CONFIG_ISP1301_OMAP is not set
-CONFIG_TWL4030_USB=y
+# CONFIG_TWL4030_USB is not set
 # CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -25,6 +25,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/usb/otg.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -307,6 +308,10 @@ static void __init omap3_evm_init(void)
 				ARRAY_SIZE(omap3evm_spi_board_info));
 
 	omap_serial_init();
+#ifdef CONFIG_NOP_USB_XCEIV
+	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
+	usb_nop_xceiv_register();
+#endif
 	usb_musb_init();
 	ads7846_dev_init();
 }
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -155,20 +155,6 @@ static struct platform_device musb_devic
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
-
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -12,6 +12,7 @@ config USB_MUSB_HDRC
 	depends on !SUPERH
 	select NOP_USB_XCEIV if ARCH_DAVINCI
 	select TWL4030_USB if MACH_OMAP_3430SDP
+	select NOP_USB_XCEIV if MACH_OMAP3EVM
 	select USB_OTG_UTILS
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
 	help

