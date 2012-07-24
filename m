From: Ruslan Bilovol <ruslan.bilovol@ti.com>
Subject: [PATCH] omap: usb: host: remove deprecated flag 'es2_compatibility'
Date: Tue, 24 Jul 2012 21:08:40 +0300
Message-ID: <1343153320-4628-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51619 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933171Ab2GXSIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jul 2012 14:08:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, tony@atomide.com, ajay.gupta@ti.com, gadiyar@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

Currently this flag is not used anywhere and may be safely removed.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@ti.com>
---
 arch/arm/mach-omap2/usb-host.c        |    1 -
 arch/arm/plat-omap/include/plat/usb.h |    4 ----
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index dde8a11..5e1cb53 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -500,7 +500,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 		ehci_data.regulator[i] = pdata->regulator[i];
 	}
 	ehci_data.phy_reset = pdata->phy_reset;
-	ohci_data.es2_compatibility = pdata->es2_compatibility;
 	usbhs_data.ehci_data = &ehci_data;
 	usbhs_data.ohci_data = &ohci_data;
 
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 762eeb0..f8c1eb8 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -32,9 +32,6 @@ struct usbhs_omap_board_data {
 	/* have to be valid if phy_reset is true and portx is in phy mode */
 	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
 
-	/* Set this to true for ES2.x silicon */
-	unsigned			es2_compatibility:1;
-
 	unsigned			phy_reset:1;
 
 	/*
@@ -53,7 +50,6 @@ struct ehci_hcd_omap_platform_data {
 
 struct ohci_hcd_omap_platform_data {
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
-	unsigned			es2_compatibility:1;
 };
 
 struct usbhs_omap_platform_data {
-- 
1.7.1

