From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: cleanup the nop registration for OMAP3EVM
Date: Wed, 29 Jul 2009 11:58:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940432A6E035@dbde02.ent.ti.com>
References: <1246611626-28137-1-git-send-email-ajay.gupta@ti.com>
 <200907030830.02241.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51523 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbZG2G3P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jul 2009 02:29:15 -0400
In-Reply-To: <200907030830.02241.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "gregkh@suse.de" <gregkh@suse.de>, David Brownell <david-b@pacbell.net>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "tony@atomide.com" <tony@atomide.com>, "talvala@stanford.edu" <talvala@stanford.edu>

> On Friday 03 July 2009, Ajay Kumar Gupta wrote:
> > OMAP3EVM uses ISP1504 phy which doesn't require any
> > programming and thus has to use NOP otg transceiver.
> >
> > Cleanups being done:
> > 	- Remove unwanted code in usb-musb.c file
> > 	- Register nop in OMAP3EVM board file using
> > 	  usb_nop_xceiv_register().
> > 	- Select NOP_USB_XCEIV for OMAP3EVM boards.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> 
> Acked-by: David Brownell <dbrownell@users.sourceforge.net>
> 
> ... another for-2.6.31 bugfix.

Greg,

	Here is the refreshed version of this patch.

Thanks,
Ajay
================ cut here =================================================
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
---
Resubmitting with below changes.
	- Refreshed against linus tree
	- Combining recent patch from Eino-Ville Talvala on
	  "Removing TWL4030_USB from omap3_evm_defconfig"
	- Register nop under #ifdef to avoid compilation warning when
	  USB itself it not selected in OMAP3EVM build.

 arch/arm/configs/omap3_evm_defconfig |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c |    5 +++++
 arch/arm/mach-omap2/usb-musb.c       |   21 ---------------------
 drivers/usb/musb/Kconfig             |    1 +
 4 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
index 28be17f..d5ff477 100644
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
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index d3cc145..cf3dd77 100644
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
-
 	if (platform_device_register(&musb_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 		return;
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 70073b1..803adcb 100644
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
-- 
1.6.2.4

