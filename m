From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH 4/4] OMAP: MUSB: Enable Mentor USB options in 4430 defconfig
Date: Thu, 25 Feb 2010 12:07:53 +0530
Message-ID: <1267079873-14768-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33174 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753454Ab0BYGiE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 01:38:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>

This patch enables Mentor USB peripheral mode
options for OMAP4 SDP defconfig.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
Index: mainline/arch/arm/configs/omap_4430sdp_defconfig
===================================================================
--- mainline.orig/arch/arm/configs/omap_4430sdp_defconfig
+++ mainline/arch/arm/configs/omap_4430sdp_defconfig
@@ -531,7 +531,76 @@ CONFIG_SSB_POSSIBLE=y
 CONFIG_DUMMY_CONSOLE=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+# CONFIG_USB is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_SOC=y
+
+#
+# OMAP 44xx high speed USB support
+#
+# CONFIG_USB_MUSB_HOST is not set
+CONFIG_USB_MUSB_PERIPHERAL=y
+# CONFIG_USB_MUSB_OTG is not set
+CONFIG_USB_GADGET_MUSB_HDRC=y
+# CONFIG_MUSB_PIO_ONLY is not set
+CONFIG_USB_INVENTRA_DMA=y
+# CONFIG_USB_TI_CPPI_DMA is not set
+# CONFIG_USB_MUSB_DEBUG is not set
+
+#
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
+#
+CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG is not set
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_VBUS_DRAW=2
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_ATMEL_USBA is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_PXA25X is not set
+# CONFIG_USB_GADGET_R8A66597 is not set
+# CONFIG_USB_GADGET_PXA27X is not set
+# CONFIG_USB_GADGET_S3C_HSOTG is not set
+# CONFIG_USB_GADGET_IMX is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_M66592 is not set
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_FSL_QE is not set
+# CONFIG_USB_GADGET_CI13XXX is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LANGWELL is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+CONFIG_USB_GADGET_DUALSPEED=y
+CONFIG_USB_ZERO=m
+# CONFIG_USB_AUDIO is not set
+# CONFIG_USB_ETH is not set
+# CONFIG_USB_GADGETFS is not set
+CONFIG_USB_FILE_STORAGE=m
+# CONFIG_USB_FILE_STORAGE_TEST is not set
+# CONFIG_USB_MASS_STORAGE is not set
+CONFIG_USB_G_SERIAL=m
+# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_USB_G_PRINTER is not set
+# CONFIG_USB_CDC_COMPOSITE is not set
+# CONFIG_USB_G_MULTI is not set
+
+#
+# OTG and related infrastructure
+#
+CONFIG_USB_OTG_UTILS=y
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_USB_ULPI is not set
+CONFIG_NOP_USB_XCEIV=y
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
