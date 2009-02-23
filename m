From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 21/23] usb: host: ehci: don't ensure register write
Date: Mon, 23 Feb 2009 20:55:33 +0200
Message-ID: <1235415335-17408-22-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
 <1235415335-17408-18-git-send-email-me@felipebalbi.com>
 <1235415335-17408-19-git-send-email-me@felipebalbi.com>
 <1235415335-17408-20-git-send-email-me@felipebalbi.com>
 <1235415335-17408-21-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42529 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754842AbZBWS4c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:56:32 -0500
In-Reply-To: <1235415335-17408-21-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

There's no reason to think register writes would fail so remove
all unnecessary while() loops keeping only the ones checking
whether reset is done or not.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |  185 ++++++++++++------------------------------
 1 files changed, 52 insertions(+), 133 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index c2b592f..e413601 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -7,6 +7,9 @@
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
  *	Author: Vikram Pandita <vikram.pandita@ti.com>
  *
+ * Copyright (C) 2009 Nokia Corporation
+ *	Contact: Felipe Balbi <felipe.balbi@nokia.com>
+ *
  * Based on "ehci-fsl.c" and "ehci-au1xxx.c" ehci glue layers
  *
  * This program is free software; you can redistribute it and/or modify
@@ -28,15 +31,8 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
-
-/* platform_data lives here */
 #include <mach/usb.h>
 
-/* FIXME remove platform-specific code */
-#include <mach/hardware.h>
-#include "../../../arch/arm/mach-omap2/cm.h"
-#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
-
 /*
  * OMAP USBHOST Register addresses: VIRTUAL ADDRESSES
  *	Use ehci_omap_readl()/ehci_omap_writel() functions
@@ -178,7 +174,6 @@ struct ehci_hcd_omap {
 
 static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 {
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 	unsigned reg;
 	int i;
 
@@ -192,19 +187,6 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 	/* Use UTMI Ports of TLL */
 	ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
 
-	/* Ensure bit is set */
-	while (!(ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG)
-			& OMAP_UHH_HOSTCONFIG_ULPI_BYPASS)) {
-		cpu_relax();
-
-		if (time_after(timeout, jiffies)) {
-			dev_dbg(omap->dev, "operation timed out\n");
-			return;
-		}
-	}
-
-	dev_dbg(omap->dev, "Entered UTMI MODE: success\n");
-
 	/* Program the 3 TLL channels upfront */
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
 		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
@@ -246,6 +228,8 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 
 /*-------------------------------------------------------------------------*/
 
+#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
+
 /* omap_start_ehc
  *	- Start the TI USBHOST controller
  */
@@ -274,32 +258,11 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 			PLL_MOD, OMAP3430ES2_CM_CLKEN2);
 
 	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
-				OMAP3430ES2_ST_PERIPH2_CLK_MASK)) {
+				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
 		dev_dbg(omap->dev, "idlest2 = 0x%x\n",
 			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
-
-		if (time_after(timeout, jiffies)) {
-			dev_dbg(omap->dev, "operation timed out\n");
-			ret = -EINVAL;
-			goto err_idlest2;
-		}
-	}
 	/* End DPLL5 programming */
 
-	/* PRCM settings for USBHOST:
-	 * Interface clk un-related to domain transition
-	 */
-	cm_write_mod_reg(0 << OMAP3430ES2_AUTO_USBHOST_SHIFT,
-				OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
-
-	/* Disable sleep dependency with MPU and IVA */
-	cm_write_mod_reg((0 << OMAP3430ES2_EN_MPU_SHIFT) |
-				(0 << OMAP3430ES2_EN_IVA2_SHIFT),
-				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
-
-	/* Disable Automatic transition of clock */
-	cm_write_mod_reg(0 << OMAP3430ES2_CLKTRCTRL_USBHOST_SHIFT,
-				OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
 
 	/* Enable Clocks for USBHOST */
 	omap->usbhost_ick = clk_get(omap->dev, USBHOST_ICKL);
@@ -348,22 +311,6 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 	clk_enable(omap->usbtll_ick);
 
-	/* Disable Auto Idle of USBTLL */
-	cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL),
-				CORE_MOD, CM_AUTOIDLE3);
-
-	/* Wait for TLL to be Active */
-	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
-			& (0 << OMAP3430ES2_ST_USBTLL_SHIFT))) {
-		cpu_relax();
-
-		if (time_after(timeout, jiffies)) {
-			dev_dbg(omap->dev, "operation timed out\n");
-			ret = -EINVAL;
-			goto err_idlest3;
-		}
-	}
-
 	/* perform TLL soft reset, and wait until reset is complete */
 	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG,
 			OMAP_USBTLL_SYSCONFIG_SOFTRESET);
@@ -410,20 +357,6 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 		/* Bypass the TLL module for PHY mode operation */
 		ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
-
-		/* Ensure that BYPASS is set */
-		while (ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG)
-			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS)) {
-			cpu_relax();
-
-			if (time_after(timeout, jiffies)) {
-				dev_dbg(omap->dev,
-						"operation timed out\n");
-				ret = -EINVAL;
-				goto err_ulpi_bypass;
-			}
-		}
-
 		dev_dbg(omap->dev, "Entered ULPI PHY MODE: success\n");
 
 	} else if (omap->phy_mode == EHCI_HCD_OMAP_MODE_TLL) {
@@ -468,61 +401,8 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 				/* Start */
 				(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |
 				(0x26));
-
-		while (!(ehci_omap_readl(omap->ehci_base, EHCI_INSNREG05_ULPI)
-				& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
-			cpu_relax();
-
-			if (time_after(timeout, jiffies)) {
-				dev_dbg(omap->dev, "operation timed out\n");
-				ret = -EINVAL;
-				goto err_ulpi_control;
-			}
-		}
-	}
-
-	return 0;
-
-err_ulpi_control:
-err_unknown_mode:
-err_ulpi_bypass:
-err_sys_status:
-err_idlest3:
-	clk_disable(omap->usbtll_ick);
-	clk_put(omap->usbtll_ick);
-
-err_tll_ick:
-	clk_disable(omap->usbtll_fck);
-	clk_put(omap->usbtll_fck);
-
-err_tll_fck:
-	clk_disable(omap->usbhost1_48m_fck);
-	clk_put(omap->usbhost1_48m_fck);
-
-	if (omap->phy_reset) {
-		gpio_free(omap->reset_gpio_port1);
-		gpio_free(omap->reset_gpio_port2);
 	}
 
-err_host_48m_fck:
-	clk_disable(omap->usbhost2_120m_fck);
-	clk_put(omap->usbhost2_120m_fck);
-
-err_host_120m_fck:
-	clk_disable(omap->usbhost_ick);
-	clk_put(omap->usbhost_ick);
-
-err_host_ick:
-err_idlest2:
-	return ret;
-}
-
-static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
-
-	dev_dbg(omap->dev, "stopping TI EHCI USB Controller\n");
-
 	/* Reset OMAP modules for insmod/rmmod to work */
 	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG,
 			OMAP_UHH_SYSCONFIG_SOFTRESET);
@@ -532,7 +412,8 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(omap->dev, "operation timed out\n");
-			return;
+			ret = -ETIMEDOUT;
+			goto err_timeout;
 		}
 	}
 
@@ -542,7 +423,8 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(omap->dev, "operation timed out\n");
-			return;
+			ret = -ETIMEDOUT;
+			goto err_timeout;
 		}
 	}
 
@@ -552,11 +434,10 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(omap->dev, "operation timed out\n");
-			return;
+			ret = -ETIMEDOUT;
+			goto err_timeout;
 		}
 	}
-	dev_dbg(omap->dev, "UHH RESET DONE OMAP_UHH_SYSSTATUS %x\n",
-			ehci_omap_readl(omap->uhh_base, OMAP_UHH_SYSSTATUS));
 
 	ehci_omap_writel(omap->tll_base, OMAP_USBTLL_SYSCONFIG, (1 << 1));
 	while (!(ehci_omap_readl(omap->tll_base, OMAP_USBTLL_SYSSTATUS)
@@ -565,10 +446,47 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 		if (time_after(timeout, jiffies)) {
 			dev_dbg(omap->dev, "operation timed out\n");
-			return;
+			ret = -ETIMEDOUT;
+			goto err_timeout;
 		}
 	}
-	dev_dbg(omap->dev, "TLL RESET DONE\n");
+
+	return 0;
+
+err_timeout:
+err_unknown_mode:
+err_sys_status:
+	clk_disable(omap->usbtll_ick);
+	clk_put(omap->usbtll_ick);
+
+err_tll_ick:
+	clk_disable(omap->usbtll_fck);
+	clk_put(omap->usbtll_fck);
+
+err_tll_fck:
+	clk_disable(omap->usbhost1_48m_fck);
+	clk_put(omap->usbhost1_48m_fck);
+
+	if (omap->phy_reset) {
+		gpio_free(omap->reset_gpio_port1);
+		gpio_free(omap->reset_gpio_port2);
+	}
+
+err_host_48m_fck:
+	clk_disable(omap->usbhost2_120m_fck);
+	clk_put(omap->usbhost2_120m_fck);
+
+err_host_120m_fck:
+	clk_disable(omap->usbhost_ick);
+	clk_put(omap->usbhost_ick);
+
+err_host_ick:
+	return ret;
+}
+
+static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
+{
+	dev_dbg(omap->dev, "stopping TI EHCI USB Controller\n");
 
 	if (omap->usbtll_fck != NULL) {
 		clk_disable(omap->usbtll_fck);
@@ -821,4 +739,5 @@ static const struct hc_driver ehci_omap_hc_driver = {
 
 MODULE_ALIAS("platform:omap-ehci");
 MODULE_AUTHOR("Texas Instruments, Inc.");
+MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
 
-- 
1.6.1.3

