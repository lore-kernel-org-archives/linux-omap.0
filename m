From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH 2/2] usb: ehci: Allow EHCI to be built on OMAP3
Date: Sat,  7 Nov 2009 01:16:32 +0530
Message-ID: <1257536793-15291-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50257 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759655AbZKFTqb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 14:46:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Vikram Pandita <vikram.pandita@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>

usb: ehci: Allow EHCI to be built on OMAP3

OMAP3 chips have a built-in EHCI controller.
The recently introduced omap ehci-hcd driver missed
out on selecting USB_ARCH_HAS_EHCI in Kconfig.

Without this, the driver cannot be built.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
---
I've based this on current Linus' tree plus your usb
patch queue (gregkh-07-usb-2.6.32-rc6.patch).

 drivers/usb/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/usb/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/Kconfig	2009-11-06 04:03:39.000000000 -0800
+++ linux-2.6/drivers/usb/Kconfig	2009-11-06 04:04:08.000000000 -0800
@@ -61,6 +61,7 @@ config USB_ARCH_HAS_EHCI
 	default y if ARCH_W90X900
 	default y if ARCH_AT91SAM9G45
 	default y if ARCH_MXC
+	default y if ARCH_OMAP34XX
 	default PCI
 
 # ARM SA1111 chips have a non-PCI based "OHCI-compatible" USB host interface.
