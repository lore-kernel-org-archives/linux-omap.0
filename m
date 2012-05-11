From: joseph daniel <josephdanielwalter@gmail.com>
Subject: [PATCH v2] usb/dwc3: Fix the dwc3 dependency
Date: Fri, 11 May 2012 15:53:40 +0530
Message-ID: <1336731820-29083-1-git-send-email-josephdanielwalter@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55363 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887Ab2EKKXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 06:23:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: joseph daniel <josephdanielwalter@gmail.com>

The warning shown up when ran with randconfig,

warning: (USB_DWC3) selects USB_XHCI_PLATFORM which has unmet direct dependencies (USB_SUPPORT && USB_XHCI_HCD)

Signed-off-by: joseph daniel <josephdanielwalter@gmail.com>
---
 drivers/usb/dwc3/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index d8f741f..d13c60f 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -4,7 +4,7 @@ config USB_DWC3
 	select USB_OTG_UTILS
 	select USB_GADGET_DUALSPEED
 	select USB_GADGET_SUPERSPEED
-	select USB_XHCI_PLATFORM
+	select USB_XHCI_PLATFORM if USB_SUPPORT && USB_XHCI_HCD
 	help
 	  Say Y or M here if your system has a Dual Role SuperSpeed
 	  USB controller based on the DesignWare USB3 IP Core.
-- 
1.7.9.5

