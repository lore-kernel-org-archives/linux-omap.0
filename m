From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] ARM: OMAP1: fix omap_udc registration
Date: Thu,  7 Mar 2013 00:23:25 +0200
Message-ID: <1362608605-26611-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:56277 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab3CFW0T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Mar 2013 17:26:19 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

omap_udc platform device is not registered properly anymore:
CONFIG_USB_GADGET_OMAP was deleted by 193ab2a6 (usb: gadget: allow
multiple gadgets to be built) already in v3.1.

Fix by using CONFIG_USB_OMAP instead. Tested on Nokia 770 by checking
that omap_udc is probed & working properly when built as a module.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/include/mach/usb.h |    2 +-
 arch/arm/mach-omap1/usb.c              |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index 753cd5c..8b2150e 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/arch/arm/mach-omap1/include/mach/usb.h
@@ -2,7 +2,7 @@
  * FIXME correct answer depends on hmc_mode,
  * as does (on omap1) any nonzero value for config->otg port number
  */
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if defined(CONFIG_USB_OMAP) || defined(CONFIG_USB_OMAP_MODULE)
 #define	is_usb0_device(config)	1
 #else
 #define	is_usb0_device(config)	0
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index 1a1db59..5cced13 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -123,7 +123,7 @@ omap_otg_init(struct omap_usb_config *config)
 	syscon = omap_readl(OTG_SYSCON_1);
 	syscon |= HST_IDLE_EN|DEV_IDLE_EN|OTG_IDLE_EN;
 
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if defined(CONFIG_USB_OMAP) || defined(CONFIG_USB_OMAP_MODULE)
 	if (config->otg || config->register_dev) {
 		struct platform_device *udc_device = config->udc_device;
 		int status;
@@ -169,7 +169,7 @@ omap_otg_init(struct omap_usb_config *config)
 void omap_otg_init(struct omap_usb_config *config) {}
 #endif
 
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if defined(CONFIG_USB_OMAP) || defined(CONFIG_USB_OMAP_MODULE)
 
 static struct resource udc_resources[] = {
 	/* order is significant! */
@@ -600,7 +600,7 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 	while (!(omap_readw(ULPD_DPLL_CTRL) & DPLL_LOCK))
 		cpu_relax();
 
-#ifdef	CONFIG_USB_GADGET_OMAP
+#if defined(CONFIG_USB_OMAP) || defined(CONFIG_USB_OMAP_MODULE)
 	if (config->register_dev) {
 		int status;
 
-- 
1.7.10.4

