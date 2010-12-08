From: Hema HK <hemahk@ti.com>
Subject: [PATCH 3/7] usb: otg: Kconfig: Add Kconfig option for TWL6030 transceiver.
Date: Tue,  7 Dec 2010 19:11:18 -0500
Message-ID: <1291767078-10144-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34840 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962Ab0LGNj2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 08:39:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb-owner@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, David Brownell <dbrownell@users.sourceforge.net>

Added the TWL6030-usb transceiver option in the Kconfig

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/otg/Kconfig |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6/drivers/usb/otg/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/otg/Kconfig
+++ linux-2.6/drivers/usb/otg/Kconfig
@@ -59,6 +59,18 @@ config TWL4030_USB
 	  This transceiver supports high and full speed devices plus,
 	  in host mode, low speed.
 
+config TWL6030_USB
+	tristate "TWL6030 USB Transceiver Driver"
+	depends on TWL4030_CORE
+	select USB_OTG_UTILS
+	help
+	  Enable this to support the USB OTG transceiver on TWL6030
+	  family chips. This TWL6030 transceiver has the VBUS and ID GND
+	  and OTG SRP events capabilities. For all other transceiver functionality
+	  UTMI PHY is embedded in OMAP4430.The internal PHY configurations APIs
+	  are hooked to this driver through platform_data structure.
+	  The definition of internal PHY APIs are in the mach-omap2 layer.
+
 config NOP_USB_XCEIV
 	tristate "NOP USB Transceiver Driver"
 	select USB_OTG_UTILS
