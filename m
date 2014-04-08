From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH] usb: dwc3: add glue layer dependencies
Date: Tue, 8 Apr 2014 10:42:40 +0200
Message-ID: <20140408104240.30ac287c@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54730 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756037AbaDHImo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Apr 2014 04:42:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, WingMan Kwok <w-kwok2@ti.com>

Glue layers for the DWC3 driver only make sense on specific platforms.
Add dependencies so that they are not built where they aren't needed.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: WingMan Kwok <w-kwok2@ti.com>
---
 drivers/usb/dwc3/Kconfig |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-3.15-rc0.orig/drivers/usb/dwc3/Kconfig	2014-03-31 05:40:15.000000000 +0200
+++ linux-3.15-rc0/drivers/usb/dwc3/Kconfig	2014-04-08 10:36:19.218960761 +0200
@@ -44,7 +44,7 @@ comment "Platform Glue Driver Support"
 
 config USB_DWC3_OMAP
 	tristate "Texas Instruments OMAP5 and similar Platforms"
-	depends on EXTCON
+	depends on EXTCON && (ARCH_OMAP2PLUS || COMPILE_TEST)
 	default USB_DWC3
 	help
 	  Some platforms from Texas Instruments like OMAP5, DRA7xxx and
@@ -54,6 +54,7 @@ config USB_DWC3_OMAP
 
 config USB_DWC3_EXYNOS
 	tristate "Samsung Exynos Platform"
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	default USB_DWC3
 	help
 	  Recent Exynos5 SoCs ship with one DesignWare Core USB3 IP inside,
@@ -72,6 +73,7 @@ config USB_DWC3_PCI
 
 config USB_DWC3_KEYSTONE
 	tristate "Texas Instruments Keystone2 Platforms"
+	depends on ARCH_KEYSTONE || COMPILE_TEST
 	default USB_DWC3
 	help
 	  Support of USB2/3 functionality in TI Keystone2 platforms.


-- 
Jean Delvare
SUSE L3 Support
