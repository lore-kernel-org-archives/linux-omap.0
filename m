From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/3 v5] usb: musb: enable support for am335x
Date: Wed, 8 Feb 2012 13:11:12 +0530
Message-ID: <1328686872-22924-3-git-send-email-ajay.gupta@ti.com>
References: <1328686872-22924-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40438 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754123Ab2BHHlZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 02:41:25 -0500
In-Reply-To: <1328686872-22924-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Enabled the flag so that musb_dsps glue file can be used for am335x

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/musb/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 126c220..ef0c3f9 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -8,7 +8,7 @@ config USB_MUSB_HDRC
 	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
 	depends on USB && USB_GADGET
 	select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
-	select NOP_USB_XCEIV if SOC_OMAPTI81XX
+	select NOP_USB_XCEIV if (SOC_OMAPTI81XX || SOC_OMAPAM33XX)
 	select TWL4030_USB if MACH_OMAP_3430SDP
 	select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA
 	select USB_OTG_UTILS
@@ -57,7 +57,7 @@ config USB_MUSB_AM35X
 
 config USB_MUSB_DSPS
 	tristate "TI DSPS platforms"
-	depends on SOC_OMAPTI81XX
+	depends on SOC_OMAPTI81XX || SOC_OMAPAM33XX
 
 config USB_MUSB_BLACKFIN
 	tristate "Blackfin"
-- 
1.7.0.4

