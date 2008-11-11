From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 41/59] omap: namespace cleanup to drivers/usb/host/ehci-omap.c
Date: Wed, 12 Nov 2008 00:57:00 +0200
Message-ID: <1226444238-14614-42-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
 <1226444238-14614-30-git-send-email-me@felipebalbi.com>
 <1226444238-14614-31-git-send-email-me@felipebalbi.com>
 <1226444238-14614-32-git-send-email-me@felipebalbi.com>
 <1226444238-14614-33-git-send-email-me@felipebalbi.com>
 <1226444238-14614-34-git-send-email-me@felipebalbi.com>
 <1226444238-14614-35-git-send-email-me@felipebalbi.com>
 <1226444238-14614-36-git-send-email-me@felipebalbi.com>
 <1226444238-14614-37-git-send-email-me@felipebalbi.com>
 <1226444238-14614-38-git-send-email-me@felipebalbi.com>
 <1226444238-14614-39-git-send-email-me@felipebalbi.com>
 <1226444238-14614-40-git-send-email-me@felipebalbi.com>
 <1226444238-14614-41-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43302 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbYKKXP7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:15:59 -0500
In-Reply-To: <1226444238-14614-41-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |   48 +++++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 419e70a..fa772aa 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -88,14 +88,14 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 	int i;
 
 	/* Use UTMI Ports of TLL */
-	omap_writel((1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
+	__raw_writel((1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
 			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
 			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
 			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
 			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
 	/* Enusre bit is set */
-	while (!(omap_readl(OMAP_UHH_HOSTCONFIG)
+	while (!(__raw_readl(OMAP_UHH_HOSTCONFIG)
 			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)))
 		cpu_relax();
 
@@ -106,22 +106,22 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
 
 		/* Disable AutoIdle */
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
+		__raw_writel(__raw_readl(OMAP_TLL_CHANNEL_CONF(i)) &
 			    ~(1<<OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 		/* Disable BitStuffing */
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
+		__raw_writel(__raw_readl(OMAP_TLL_CHANNEL_CONF(i)) &
 			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 		/* SDR Mode */
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
+		__raw_writel(__raw_readl(OMAP_TLL_CHANNEL_CONF(i)) &
 			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 
 	}
 
 	/* Program Common TLL register */
-	omap_writel((1 << OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT) |
+	__raw_writel((1 << OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT) |
 			(1 << OMAP_TLL_SHARED_CONF_USB_DIVRATION_SHIFT) |
 			(0 << OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN_SHIFT) |
 			(0 << OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN_SHFT),
@@ -134,14 +134,14 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 		if (!(tll_channel_mask & 1<<i))
 			continue;
 
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) |
+		__raw_writel(__raw_readl(OMAP_TLL_CHANNEL_CONF(i)) |
 			    (1<<OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 
-		omap_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
+		__raw_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
 		dev_dbg(hcd->self.controller, "\nULPI_SCRATCH_REG[ch=%d]"
 			"= 0x%02x\n",
-			i+1, omap_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
+			i+1, __raw_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
 	}
 }
 
@@ -256,24 +256,24 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 		cpu_relax();
 
 	/* perform TLL soft reset, and wait until reset is complete */
-	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
+	__raw_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
 			OMAP_USBTLL_SYSCONFIG);
 	/* Wait for TLL reset to complete */
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS)
+	while (!(__raw_readl(OMAP_USBTLL_SYSSTATUS)
 			& (1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT)))
 		cpu_relax();
 
 	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
 	/* (1<<3) = no idle mode only for initial debugging */
-	omap_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT) |
+	__raw_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT) |
 			(1 << OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT) |
 			(1 << OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT),
 			OMAP_USBTLL_SYSCONFIG);
 
 
 	/* Put UHH in NoIdle/NoStandby mode */
-	omap_writel((0 << OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT) |
+	__raw_writel((0 << OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT) |
 			(1 << OMAP_UHH_SYSCONFIG_ENAWAKEUP_SHIFT) |
 			(1 << OMAP_UHH_SYSCONFIG_SIDLEMODE_SHIFT) |
 			(1 << OMAP_UHH_SYSCONFIG_CACTIVITY_SHIFT) |
@@ -282,14 +282,14 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 	/* Bypass the TLL module for PHY mode operation */
-	omap_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
+	__raw_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
 			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
 			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
 			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
 			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
 	/* Ensure that BYPASS is set */
-	while (omap_readl(OMAP_UHH_HOSTCONFIG)
+	while (__raw_readl(OMAP_UHH_HOSTCONFIG)
 			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT))
 		cpu_relax();
 
@@ -319,14 +319,14 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	/* use Port1 VBUS to charge externally Port2:
 	 *	So for PHY mode operation use Port2 only
 	 */
-	omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
+	__raw_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
 			(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
 			(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
 			(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
 			(0x26),
 			EHCI_INSNREG05_ULPI);
 
-	while (!(omap_readl(EHCI_INSNREG05_ULPI)
+	while (!(__raw_readl(EHCI_INSNREG05_ULPI)
 			& (1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)))
 		cpu_relax();
 
@@ -347,19 +347,19 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	dev_dbg(hcd->self.controller, "stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
-	omap_writel((1<<1), OMAP_UHH_SYSCONFIG);
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<0)))
+	__raw_writel((1<<1), OMAP_UHH_SYSCONFIG);
+	while (!(__raw_readl(OMAP_UHH_SYSSTATUS) & (1<<0)))
 		cpu_relax();
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<1)))
+	while (!(__raw_readl(OMAP_UHH_SYSSTATUS) & (1<<1)))
 		cpu_relax();
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<2)))
+	while (!(__raw_readl(OMAP_UHH_SYSSTATUS) & (1<<2)))
 		cpu_relax();
 	dev_dbg(hcd->self.controller,
 		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
-			omap_readl(OMAP_UHH_SYSSTATUS));
+			__raw_readl(OMAP_UHH_SYSSTATUS));
 
-	omap_writel((1<<1), OMAP_USBTLL_SYSCONFIG);
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)))
+	__raw_writel((1<<1), OMAP_USBTLL_SYSCONFIG);
+	while (!(__raw_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)))
 		cpu_relax();
 	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
-- 
1.6.0.2.307.gc427

