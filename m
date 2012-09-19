From: jrm.kurtz@gmail.com
Subject: [PATCH] usb: otg: Resolving a config conflict between omap4030_usb/omap6030 and usb_musb_omap2plus
Date: Wed, 19 Sep 2012 17:21:41 +0200
Message-ID: <1348068101-2346-1-git-send-email-jrm.kurtz@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42704 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab2ISP1M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 11:27:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, anisse@astier.eu, Jerome Kurtz <jrm.kurtz@gmail.com>

From: Jerome Kurtz <jrm.kurtz@gmail.com>

When I try to compile with TWL6030_USB=y, TWL4030_USB=y and
USB_MUSB_OMAP2PLUS=m, I get the following error:

drivers/built-in.o: In function `twl4030_usb_irq':
/home/xxx/kernel/linux/drivers/usb/otg/twl4030-usb.c:518: undefined
reference to `omap_musb_mailbox'
drivers/built-in.o: In function `twl6030_usb_irq':
/home/xxx/kernel/linux/drivers/usb/otg/twl6030-usb.c:272: undefined
reference to `omap_musb_mailbox'
/home/xxx/kernel/linux/drivers/usb/otg/twl6030-usb.c:277: undefined
reference to `omap_musb_mailbox'
drivers/built-in.o: In function `twl6030_usbotg_irq':
/home/xxx/kernel/linux/drivers/usb/otg/twl6030-usb.c:306: undefined
reference to `omap_musb_mailbox'
drivers/built-in.o: In function `twl4030_usb_phy_init':
/home/xxx/kernel/linux/drivers/usb/otg/twl4030-usb.c:540: undefined
reference to `omap_musb_mailbox'
make: *** [vmlinux] Error 1

To solve this we must add to depends of TWL4030_USB and TWL6030_USB
the option : USB_MUSB_OMAP2PLUS as done here.

Signed-off-by: Jerome Kurtz <jrm.kurtz@gmail.com>
---
 drivers/usb/otg/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 13fd1ddf..62ea57b 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -58,7 +58,7 @@ config USB_ULPI_VIEWPORT
 
 config TWL4030_USB
 	tristate "TWL4030 USB Transceiver Driver"
-	depends on TWL4030_CORE && REGULATOR_TWL4030
+	depends on TWL4030_CORE && REGULATOR_TWL4030 && USB_MUSB_OMAP2PLUS
 	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL4030
@@ -68,7 +68,7 @@ config TWL4030_USB
 
 config TWL6030_USB
 	tristate "TWL6030 USB Transceiver Driver"
-	depends on TWL4030_CORE
+	depends on TWL4030_CORE &&  USB_MUSB_OMAP2PLUS
 	select USB_OTG_UTILS
 	help
 	  Enable this to support the USB OTG transceiver on TWL6030
-- 
1.7.2.5

