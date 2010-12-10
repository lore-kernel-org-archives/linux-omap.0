From: Hema HK <hemahk@ti.com>
Subject: [PATCH 6/8 V3] usb: otg: TWL6030: Add twl6030_usb file for compilation
Date: Fri, 10 Dec 2010 18:10:37 +0530
Message-ID: <1291984837-26002-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40605 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762Ab0LJMkn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 07:40:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

Add the twl6030_usb transceiver file for compilation.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>

Index: usb/drivers/usb/otg/Makefile
===================================================================
--- usb.orig/drivers/usb/otg/Makefile
+++ usb/drivers/usb/otg/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_USB_OTG_UTILS)	+= otg.o
 obj-$(CONFIG_USB_GPIO_VBUS)	+= gpio_vbus.o
 obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
+obj-$(CONFIG_TWL6030_USB)	+= twl6030-usb.o
 obj-$(CONFIG_USB_LANGWELL_OTG)	+= langwell_otg.o
 obj-$(CONFIG_NOP_USB_XCEIV)	+= nop-usb-xceiv.o
 obj-$(CONFIG_USB_ULPI)		+= ulpi.o
