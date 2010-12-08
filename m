From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/7] usb: otg: Kconfig: Add Kconfig option for TWL6030 transceiver.
Date: Wed,  8 Dec 2010 14:00:01 +0530
Message-ID: <1291797001-23602-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Added the TWL6030-usb transceiver option in the Kconfig

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
