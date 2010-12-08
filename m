From: Hema HK <hemahk@ti.com>
Subject: [PATCH 5/7] usb: musb: TWL6030: Selecting TWL6030_USB transceiver
Date: Wed,  8 Dec 2010 21:32:10 +0530
Message-ID: <1291824130-7181-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47642 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab0LHFaP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Dec 2010 00:30:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Selecting the twl6030-usb for OMAP4430SDP and OMAP4 PANDA board and
adding OMAP4 internal phy code for compilation

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile |    1 +
 drivers/usb/musb/Kconfig     |    1 +
 2 files changed, 2 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/Makefile
+++ linux-2.6/arch/arm/mach-omap2/Makefile
@@ -180,6 +180,7 @@ obj-$(CONFIG_MACH_SBC3530)		+= board-oma
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
 obj-y					+= usb-musb.o
+obj-$(CONFIG_TWL6030_USB)		+= omap_phy_internal.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 obj-y					+= usb-ehci.o
 
Index: linux-2.6/drivers/usb/musb/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/musb/Kconfig
+++ linux-2.6/drivers/usb/musb/Kconfig
@@ -12,6 +12,7 @@ config USB_MUSB_HDRC
 	depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
 	select TWL4030_USB if MACH_OMAP_3430SDP
+	select TWL6030_USB if (MACH_OMAP_3430SDP || MACH_OMAP4_PANDA)
 	select USB_OTG_UTILS
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
 	help
