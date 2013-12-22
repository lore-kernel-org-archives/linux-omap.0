From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2] usb: musb: Rework USB and USB_GADGET dependency
Date: Sun, 22 Dec 2013 00:08:33 -0300
Message-ID: <1387681713-2791-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44807 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751204Ab3LVDIZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Dec 2013 22:08:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

This USB controller can work in as host-only, gadget-only or dual-role
modes. Rework the dependency on the USB and USB_GADGET configs in order
to allow building the driver when !USB or !USG_GADGET.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
Changes from v1:

 * Rework the dependency, as per Felipe's suggestion, to allow
   building the driver in either !USB or !USB_GADGET. This has been
   done following dwc3, which seems to be doing the Right Thing.

 drivers/usb/Kconfig      | 4 ++--
 drivers/usb/musb/Kconfig | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 2642b8a..a34fb98 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -94,8 +94,6 @@ source "drivers/usb/wusbcore/Kconfig"
 
 source "drivers/usb/host/Kconfig"
 
-source "drivers/usb/musb/Kconfig"
-
 source "drivers/usb/renesas_usbhs/Kconfig"
 
 source "drivers/usb/class/Kconfig"
@@ -106,6 +104,8 @@ source "drivers/usb/image/Kconfig"
 
 endif
 
+source "drivers/usb/musb/Kconfig"
+
 source "drivers/usb/dwc3/Kconfig"
 
 source "drivers/usb/chipidea/Kconfig"
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 57dfc0c..a1d805f 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -6,7 +6,7 @@
 # (M)HDRC = (Multipoint) Highspeed Dual-Role Controller
 config USB_MUSB_HDRC
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
-	depends on USB_GADGET
+	depends on (USB || USB_GADGET)
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on the Mentor Graphics silicon IP.  Then
@@ -35,21 +35,21 @@ choice
 
 config USB_MUSB_HOST
 	bool "Host only mode"
-	depends on USB
+	depends on USB=y || USB=USB_MUSB_HDRC
 	help
 	  Select this when you want to use MUSB in host mode only,
 	  thereby the gadget feature will be regressed.
 
 config USB_MUSB_GADGET
 	bool "Gadget only mode"
-	depends on USB_GADGET
+	depends on USB_GADGET=y || USB_GADGET=USB_MUSB_HDRC
 	help
 	  Select this when you want to use MUSB in gadget mode only,
 	  thereby the host feature will be regressed.
 
 config USB_MUSB_DUAL_ROLE
 	bool "Dual Role mode"
-	depends on (USB && USB_GADGET)
+	depends on ((USB=y || USB=USB_MUSB_HDRC) && (USB_GADGET=y || USB_GADGET=USB_MUSB_HDRC))
 	help
 	  This is the default mode of working of MUSB controller where
 	  both host and gadget features are enabled.
-- 
1.8.1.5

