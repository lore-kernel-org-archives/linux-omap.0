From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 14/23] usb: host: ehci: get rid of infinite loops
Date: Mon, 23 Feb 2009 20:55:26 +0200
Message-ID: <1235415335-17408-15-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43021 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbZBWS7i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:59:38 -0500
In-Reply-To: <1235415335-17408-14-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Use time_after() to avoid looping forever.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   87 +++++++++++++++++++++++++++++++++++++-----
 1 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 2bdc978..35c645d 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -182,6 +182,7 @@ struct ehci_omap_clock_defs {
 
 static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 {
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 	int i;
 
 	/* Use UTMI Ports of TLL */
@@ -193,9 +194,15 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 						OMAP_UHH_HOSTCONFIG);
 	/* Enusre bit is set */
 	while (!(omap_readl(OMAP_UHH_HOSTCONFIG)
-			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)))
+			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT))) {
 		cpu_relax();
 
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return;
+		}
+	}
+
 	dev_dbg(hcd->self.controller, "Entered UTMI MODE: success\n");
 
 	/* Program the 3 TLL channels upfront */
@@ -254,6 +261,7 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 {
 	struct ehci_omap_clock_defs *ehci_clocks;
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 
 	dev_dbg(hcd->self.controller, "starting TI EHCI USB Controller\n");
 
@@ -278,10 +286,16 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 			PLL_MOD, OMAP3430ES2_CM_CLKEN2);
 
 	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
-				OMAP3430ES2_ST_PERIPH2_CLK_MASK))
+				OMAP3430ES2_ST_PERIPH2_CLK_MASK)) {
 		dev_dbg(hcd->self.controller,
 			"idlest2 = 0x%x\n",
 			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
+
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return -EINVAL;
+		}
+	}
 	/* End DPLL5 programming */
 
 
@@ -347,17 +361,30 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 	/* Wait for TLL to be Active */
 	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
-			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT)))
+			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT))) {
 		cpu_relax();
 
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return -EINVAL;
+		}
+	}
+
 	/* perform TLL soft reset, and wait until reset is complete */
 	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
 			OMAP_USBTLL_SYSCONFIG);
+
 	/* Wait for TLL reset to complete */
 	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS)
-			& (1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT)))
+			& (1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT))) {
 		cpu_relax();
 
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return -EINVAL;
+		}
+	}
+
 	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
 	/* (1<<3) = no idle mode only for initial debugging */
@@ -383,11 +410,18 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
 			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
+
 	/* Ensure that BYPASS is set */
 	while (omap_readl(OMAP_UHH_HOSTCONFIG)
-			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT))
+			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)) {
 		cpu_relax();
 
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return -EINVAL;
+		}
+	}
+
 	dev_dbg(hcd->self.controller, "Entered ULPI PHY MODE: success\n");
 
 #else
@@ -422,9 +456,15 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 			EHCI_INSNREG05_ULPI);
 
 	while (!(omap_readl(EHCI_INSNREG05_ULPI)
-			& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT)))
+			& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT))) {
 		cpu_relax();
 
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return -EINVAL;
+		}
+	}
+
 #endif
 
 	return 0;
@@ -433,6 +473,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 {
 	struct ehci_omap_clock_defs *ehci_clocks;
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 
 	ehci_clocks = (struct ehci_omap_clock_defs *)
 			(((char *)hcd_to_ehci(hcd)) + sizeof(struct ehci_hcd));
@@ -441,19 +482,45 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 	/* Reset OMAP modules for insmod/rmmod to work */
 	omap_writel((1 << 1), OMAP_UHH_SYSCONFIG);
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 0)))
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 0))) {
 		cpu_relax();
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 1)))
+
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return;
+		}
+	}
+
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 1))) {
 		cpu_relax();
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 2)))
+
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return;
+		}
+	}
+
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 2))) {
 		cpu_relax();
+
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return;
+		}
+	}
 	dev_dbg(hcd->self.controller,
 		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
 			omap_readl(OMAP_UHH_SYSSTATUS));
 
 	omap_writel((1 << 1), OMAP_USBTLL_SYSCONFIG);
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1 << 0)))
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1 << 0))) {
 		cpu_relax();
+
+		if (time_after(timeout, jiffies)) {
+			dev_dbg(hcd->self.controller, "operation timed out\n");
+			return;
+		}
+	}
 	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
 	if (ehci_clocks->usbtll_fck_clk != NULL) {
-- 
1.6.1.3

