From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] omap3: ehci: remove chargepump hack
Date: Thu, 24 Sep 2009 17:36:57 +0530
Message-ID: <1253794017-25552-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54087 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067AbZIXMG5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Sep 2009 08:06:57 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8OC6xmV015713
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 07:07:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

omap3: ehci: remove chargepump hack

This hack was for a very early development board that is no longer
in use. Remove it. No board should require it.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5f913c3..5571f44 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -486,7 +486,6 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
-	.chargepump = true,
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = 57,
 	.reset_gpio_port[1]  = 61,
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index aa403e6..f81141f 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -406,7 +406,6 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
-	.chargepump = false,
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
 	.reset_gpio_port[1]  = 147,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 62a6f32..a2fcd06 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -299,7 +299,6 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
-	.chargepump = false,
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
 	.reset_gpio_port[1]  = 135,
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 9f115dc..fd4a951 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -389,7 +389,6 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
-	.chargepump = false,
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = 16,
 	.reset_gpio_port[1]  = -EINVAL,
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index d16172d..46e376f 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -389,7 +389,6 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
-	.chargepump = false,
 	.phy_reset  = true,
 	.reset_gpio_port[0]  = -EINVAL,
 	.reset_gpio_port[1]  = OVERO_GPIO_USBH_NRESET,
diff --git a/arch/arm/plat-omap/include/mach/usb.h b/arch/arm/plat-omap/include/mach/usb.h
index d1b14cc..a4068a4 100644
--- a/arch/arm/plat-omap/include/mach/usb.h
+++ b/arch/arm/plat-omap/include/mach/usb.h
@@ -14,7 +14,6 @@ enum ehci_hcd_omap_mode {
 
 struct ehci_hcd_omap_platform_data {
 	enum ehci_hcd_omap_mode		port_mode[OMAP3_HS_USB_PORTS];
-	unsigned			chargepump:1;
 	unsigned			phy_reset:1;
 
 	/* have to be valid if phy_reset is true and portx is in phy mode */
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 36fb183..f2771cf 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -169,9 +169,6 @@ struct ehci_hcd_omap {
 	/* phy reset workaround */
 	int			phy_reset;
 
-	/* vbus internal chargepump workaround */
-	int			chargepump;
-
 	/* desired phy_mode: TLL, PHY */
 	enum ehci_hcd_omap_mode	port_mode[OMAP3_HS_USB_PORTS];
 
@@ -423,25 +420,6 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 			gpio_set_value(omap->reset_gpio_port[1], 1);
 	}
 
-	if (omap->chargepump) {
-
-		/* Refer ISSUE2: LINK assumes external charge pump */
-
-		/* use Port1 VBUS to charge externally Port2:
-		 *	So for PHY mode operation use Port2 only
-		 */
-		ehci_omap_writel(omap->ehci_base, EHCI_INSNREG05_ULPI,
-				/* OTG ctrl reg*/
-				(0xa << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |
-				/*   Write */
-				(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |
-				/* Port1 */
-				(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |
-				/* Start */
-				(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |
-				(0x26));
-	}
-
 	return 0;
 
 err_sys_status:
