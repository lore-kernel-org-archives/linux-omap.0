From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH 2/4] USB: MUSB: Enable MUSB for OMAP4 in Kconfig
Date: Thu, 25 Feb 2010 12:05:58 +0530
Message-ID: <1267079758-14480-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44010 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753712Ab0BYGgK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Feb 2010 01:36:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <david-b@pacbell.net>

This patch adds the OMAP4 Kconfig options for MUSB.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <david-b@pacbell.net
---
Index: mainline/drivers/usb/musb/Kconfig
===================================================================
--- mainline.orig/drivers/usb/musb/Kconfig
+++ mainline/drivers/usb/musb/Kconfig
@@ -38,6 +38,7 @@ config USB_MUSB_SOC
 	default y if ARCH_DAVINCI
 	default y if ARCH_OMAP2430
 	default y if ARCH_OMAP34XX
+	default y if ARCH_OMAP4
 	default y if (BF54x && !BF544)
 	default y if (BF52x && !BF522 && !BF523)
 
@@ -50,6 +51,9 @@ comment "OMAP 243x high speed USB suppor
 comment "OMAP 343x high speed USB support"
 	depends on USB_MUSB_HDRC && ARCH_OMAP34XX
 
+comment "OMAP 44xx high speed USB support"
+	depends on USB_MUSB_HDRC && ARCH_OMAP4
+
 comment "Blackfin high speed USB Support"
 	depends on USB_MUSB_HDRC && ((BF54x && !BF544) || (BF52x && !BF522 && !BF523))
 
@@ -153,7 +157,7 @@ config MUSB_PIO_ONLY
 config USB_INVENTRA_DMA
 	bool
 	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default ARCH_OMAP2430 || ARCH_OMAP34XX || BLACKFIN
+	default ARCH_OMAP2430 || ARCH_OMAP34XX || BLACKFIN || ARCH_OMAP4
 	help
 	  Enable DMA transfers using Mentor's engine.
 
