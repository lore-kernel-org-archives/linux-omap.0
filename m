From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] ARM: OMAP: OTG integration: fix compiler warning
Date: Wed, 9 May 2012 16:38:02 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205091637100.23869@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60725 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714Ab2EIWiE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 18:38:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com


Tony reported the following compile warning after commit
eeb3711b89d68e147e05e7b43a49ecc5009dc157 ("ARM: OMAP2+: clean up some
cppcheck warnings"):

arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
arch/arm/plat-omap/usb.c:40: warning: unused variable 'status'

This happens if CONFIG_ARCH_OMAP_OTG is set but
CONFIG_USB_GADGET_OMAP, CONFIG_USB_OHCI_HCD,
CONFIG_USB_OHCI_HCD_MODULE, and CONFIG_USB_OTG are all unset.

Fix by localizing the status variable to the blocks that use it.

Compile-tested only, with omap2plus_defconfig and omap2plus_defconfig
with CONFIG_USB_OHCI_HCD and CONFIG_USB_OTG enabled.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
Applies after eeb3711b89d68e147e05e7b43a49ecc5009dc157.

 arch/arm/plat-omap/usb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 5db7561..daa0327 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -37,7 +37,6 @@ void __init
 omap_otg_init(struct omap_usb_config *config)
 {
 	u32		syscon;
-	int		status;
 	int		alt_pingroup = 0;
 
 	/* NOTE:  no bus or clock setup (yet?) */
@@ -102,6 +101,7 @@ omap_otg_init(struct omap_usb_config *config)
 #ifdef	CONFIG_USB_GADGET_OMAP
 	if (config->otg || config->register_dev) {
 		struct platform_device *udc_device = config->udc_device;
+		int status;
 
 		syscon &= ~DEV_IDLE_EN;
 		udc_device->dev.platform_data = config;
@@ -114,6 +114,7 @@ omap_otg_init(struct omap_usb_config *config)
 #if	defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
 	if (config->otg || config->register_host) {
 		struct platform_device *ohci_device = config->ohci_device;
+		int status;
 
 		syscon &= ~HST_IDLE_EN;
 		ohci_device->dev.platform_data = config;
@@ -126,6 +127,7 @@ omap_otg_init(struct omap_usb_config *config)
 #ifdef	CONFIG_USB_OTG
 	if (config->otg) {
 		struct platform_device *otg_device = config->otg_device;
+		int status;
 
 		syscon &= ~OTG_IDLE_EN;
 		otg_device->dev.platform_data = config;
-- 
1.7.10

