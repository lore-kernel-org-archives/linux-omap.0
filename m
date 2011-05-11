From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/3] usb: musb: allow musb and glue layers to be modules
Date: Wed, 11 May 2011 13:06:54 +0300
Message-ID: <1305108415-27206-3-git-send-email-balbi@ti.com>
References: <1305108415-27206-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:60552 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754294Ab1EKPrn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 May 2011 11:47:43 -0400
In-Reply-To: <1305108415-27206-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

This in part reverts commit 7a180e70cfc56e131bfe4796773df2acfc7d4180.
(usb: musb: temporarily make it bool) and while
at that we also allow glue layers to be compiled
as modules.

There are still some other changes needed
until we can have a fully functional build
with this setup, but we're getting there.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/Kconfig |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index f90123f..dbb13bd 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -14,7 +14,7 @@ config USB_MUSB_HDRC
 	select TWL4030_USB if MACH_OMAP_3430SDP
 	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
 	select USB_OTG_UTILS
-	bool 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
+	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
 	help
 	  Say Y here if your system has a dual role high speed USB
 	  controller based on the Mentor Graphics silicon IP.  Then
@@ -30,39 +30,39 @@ config USB_MUSB_HDRC
 
 	  If you do not know what this is, please say N.
 
-#	  To compile this driver as a module, choose M here; the
-#	  module will be called "musb-hdrc".
+	  To compile this driver as a module, choose M here; the
+	  module will be called "musb-hdrc".
 
 choice
 	prompt "Platform Glue Layer"
 	depends on USB_MUSB_HDRC
 
 config USB_MUSB_DAVINCI
-	bool "DaVinci"
+	tristate "DaVinci"
 	depends on ARCH_DAVINCI_DMx
 
 config USB_MUSB_DA8XX
-	bool "DA8xx/OMAP-L1x"
+	tristate "DA8xx/OMAP-L1x"
 	depends on ARCH_DAVINCI_DA8XX
 
 config USB_MUSB_TUSB6010
-	bool "TUSB6010"
+	tristate "TUSB6010"
 	depends on ARCH_OMAP
 
 config USB_MUSB_OMAP2PLUS
-	bool "OMAP2430 and onwards"
+	tristate "OMAP2430 and onwards"
 	depends on ARCH_OMAP2PLUS
 
 config USB_MUSB_AM35X
-	bool "AM35x"
+	tristate "AM35x"
 	depends on ARCH_OMAP
 
 config USB_MUSB_BLACKFIN
-	bool "Blackfin"
+	tristate "Blackfin"
 	depends on (BF54x && !BF544) || (BF52x && ! BF522 && !BF523)
 
 config USB_MUSB_UX500
-	bool "U8500 and U5500"
+	tristate "U8500 and U5500"
 	depends on (ARCH_U8500 && AB8500_USB) || (ARCH_U5500)
 
 endchoice
-- 
1.7.4.1.343.ga91df

