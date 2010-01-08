From: Francisco Alecrim <alecrim@gmail.com>
Subject: [RFC/PATCH 1/2] usb_otg: compile fix
Date: Thu,  7 Jan 2010 21:03:11 -0400
Message-ID: <1262912592-7817-1-git-send-email-alecrim@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.211.176]:60750 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab0AHBDk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 20:03:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@openbossa.org>

From: Francisco Alecrim <francisco.alecrim@openbossa.org>

include/linux/usb.h: In function 'usb_mark_last_busy':
include/linux/usb.h:561: error: 'struct usb_device' has no member named
'last_busy'

Option USB_OTG selects USB_SUSPEND but doesn't select PM(required by
USB_SUSPEND) causing this compile error. Putting USB_SUSPEND as
USB_OTG depend ensure that PM is selected.

Signed-off-by: Francisco Alecrim <francisco.alecrim@openbossa.org>
---
 drivers/usb/core/Kconfig   |    1 -
 drivers/usb/gadget/Kconfig |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index ad92594..4c7d6e8 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -109,7 +109,6 @@ config USB_SUSPEND
 config USB_OTG
 	bool
 	depends on USB && EXPERIMENTAL
-	select USB_SUSPEND
 	default n
 
 
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index ee41120..af819fe 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -211,7 +211,7 @@ config USB_OMAP
 
 config USB_OTG
 	boolean "OTG Support"
-	depends on USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD
+	depends on USB_GADGET_OMAP && ARCH_OMAP_OTG && USB_OHCI_HCD && USB_SUSPEND
 	help
 	   The most notable feature of USB OTG is support for a
 	   "Dual-Role" device, which can act as either a device
-- 
1.6.3.3

