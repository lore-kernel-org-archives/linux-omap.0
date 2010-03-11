From: Maulik Mankad <x0082077@ti.com>
Subject: [PATCH v2 2/3] USB: MUSB: Build MUSB driver for OMAP4
Date: Thu, 11 Mar 2010 17:28:30 +0530
Message-ID: <1268308710-21832-1-git-send-email-x0082077@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35842 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757638Ab0CKL6m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Mar 2010 06:58:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Maulik Mankad <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <david-b@pacbell.net>, Sergei Shtylyov <sshtylyov@mvista.com>, Olof Johansson <olof@lixom.net>

This patch updates the Makefile to build the
MUSB driver for OMAP4. It also sets the Kconfig
options for OMAP4.

Signed-off-by: Maulik Mankad <x0082077@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <david-b@pacbell.net>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Olof Johansson <olof@lixom.net>

Index: mainline/drivers/usb/musb/Kconfig
===================================================================
--- mainline.orig/drivers/usb/musb/Kconfig
+++ mainline/drivers/usb/musb/Kconfig
@@ -38,6 +38,7 @@ config USB_MUSB_SOC
 	default y if ARCH_DAVINCI
 	default y if ARCH_OMAP2430
 	default y if ARCH_OMAP3
+	default y if ARCH_OMAP4
 	default y if (BF54x && !BF544)
 	default y if (BF52x && !BF522 && !BF523)
 
@@ -50,6 +51,9 @@ comment "OMAP 243x high speed USB suppor
 comment "OMAP 343x high speed USB support"
 	depends on USB_MUSB_HDRC && ARCH_OMAP3
 
+comment "OMAP 44xx high speed USB support"
+	depends on USB_MUSB_HDRC && ARCH_OMAP4
+
 comment "Blackfin high speed USB Support"
 	depends on USB_MUSB_HDRC && ((BF54x && !BF544) || (BF52x && !BF522 && !BF523))
 
@@ -153,7 +157,7 @@ config MUSB_PIO_ONLY
 config USB_INVENTRA_DMA
 	bool
 	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default ARCH_OMAP2430 || ARCH_OMAP3 || BLACKFIN
+	default ARCH_OMAP2430 || ARCH_OMAP3 || BLACKFIN || ARCH_OMAP4
 	help
 	  Enable DMA transfers using Mentor's engine.
 
Index: mainline/drivers/usb/musb/Makefile
===================================================================
--- mainline.orig/drivers/usb/musb/Makefile
+++ mainline/drivers/usb/musb/Makefile
@@ -22,6 +22,10 @@ ifeq ($(CONFIG_ARCH_OMAP3430),y)
 	musb_hdrc-objs	+= omap2430.o
 endif
 
+ifeq ($(CONFIG_ARCH_OMAP4),y)
+	musb_hdrc-objs  += omap2430.o
+endif
+
 ifeq ($(CONFIG_BF54x),y)
 	musb_hdrc-objs	+= blackfin.o
 endif
