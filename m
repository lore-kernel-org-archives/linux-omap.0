From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/1] usb: musb: MUSB_OTG should depend on PM
Date: Thu, 22 May 2008 03:47:33 +0300
Message-ID: <1211417253-24699-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34982 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbYEVAuD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2008 20:50:03 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4M0ncQC013719
	for <linux-omap@vger.kernel.org>; Thu, 22 May 2008 03:49:59 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Current musb Kconfig causes cyclic depency on x86
arch. The best fix is to depend on PM in order to
build on OTG mode.

Anyone interested in reproducing the error in your
linux-omap trees, just make ARCH=x86 menuconfig

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index a485a86..acbbd5f 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -88,10 +88,9 @@ config USB_MUSB_PERIPHERAL
 	  (With a "Mini-AB" connector, you should enable USB OTG.)
 
 config USB_MUSB_OTG
-	depends on USB && USB_GADGET && EXPERIMENTAL
+	depends on USB && USB_GADGET && PM && EXPERIMENTAL
 	bool "Both host and peripheral:  USB OTG (On The Go) Device"
 	select USB_GADGET_MUSB_HDRC
-	select USB_OTG
 	select PM
 	help
 	   The most notable feature of USB OTG is support for a
-- 
1.5.5.1.125.gc697a

