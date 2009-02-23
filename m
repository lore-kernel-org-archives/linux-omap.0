From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 01/23] usb: host: ehci: make checkpatch.pl happy with ehci-omap
Date: Mon, 23 Feb 2009 20:52:29 +0200
Message-ID: <1235415171-17376-2-git-send-email-me@felipebalbi.com>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46615 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbZBWSxS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:53:18 -0500
In-Reply-To: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Felipe Balbi <me@felipebalbi.com>

Trivial cleanup patch, no functional changes. Just
adding a few spaces here and there.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   50 +++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 1b3266c..88ed500 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -31,7 +31,6 @@
 
 #include "ehci-omap.h"
 
-
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 /* EHCI connected to External PHY */
 
@@ -80,7 +79,6 @@ struct ehci_omap_clock_defs {
 #define USBHOST_TLL_FCLK	"usbtll_fck"
 /*-------------------------------------------------------------------------*/
 
-
 #ifndef CONFIG_OMAP_EHCI_PHY_MODE
 
 static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
@@ -89,17 +87,17 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 
 	/* Use UTMI Ports of TLL */
 	omap_writel((1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
-			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
+			(1 << OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
+			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
 	/* Enusre bit is set */
 	while (!(omap_readl(OMAP_UHH_HOSTCONFIG)
 			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)))
 		cpu_relax();
 
-	dev_dbg(hcd->self.controller, "\nEntered UTMI MODE: success\n");
+	dev_dbg(hcd->self.controller, "Entered UTMI MODE: success\n");
 
 	/* Program the 3 TLL channels upfront */
 
@@ -107,15 +105,15 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 
 		/* Disable AutoIdle */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1<<OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
+			    ~(1 << OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 		/* Disable BitStuffing */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
+			    ~(1 << OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 		/* SDR Mode */
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			    ~(1<<OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
+			    ~(1 << OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 
 	}
@@ -135,11 +133,11 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 			continue;
 
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) |
-			    (1<<OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
+			    (1 << OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 
 		omap_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
-		dev_dbg(hcd->self.controller, "\nULPI_SCRATCH_REG[ch=%d]"
+		dev_dbg(hcd->self.controller, "ULPI_SCRATCH_REG[ch=%d]"
 			"= 0x%02x\n",
 			i+1, omap_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
 	}
@@ -209,7 +207,6 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 		return PTR_ERR(ehci_clocks->usbhost_ick_clk);
 	clk_enable(ehci_clocks->usbhost_ick_clk);
 
-
 	ehci_clocks->usbhost2_120m_fck_clk = clk_get(&dev->dev,
 							USBHOST_120M_FCLK);
 	if (IS_ERR(ehci_clocks->usbhost2_120m_fck_clk))
@@ -281,10 +278,10 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 	/* Bypass the TLL module for PHY mode operation */
 	omap_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
-			(1<<OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
-			(0<<OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
+			(1 << OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
+			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
+			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
 						OMAP_UHH_HOSTCONFIG);
 	/* Ensure that BYPASS is set */
 	while (omap_readl(OMAP_UHH_HOSTCONFIG)
@@ -325,7 +322,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 			EHCI_INSNREG05_ULPI);
 
 	while (!(omap_readl(EHCI_INSNREG05_ULPI)
-			& (1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)))
+			& (1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT)))
 		cpu_relax();
 
 #endif
@@ -345,19 +342,19 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	dev_dbg(hcd->self.controller, "stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
-	omap_writel((1<<1), OMAP_UHH_SYSCONFIG);
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<0)))
+	omap_writel((1 << 1), OMAP_UHH_SYSCONFIG);
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 0)))
 		cpu_relax();
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<1)))
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 1)))
 		cpu_relax();
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<2)))
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 2)))
 		cpu_relax();
 	dev_dbg(hcd->self.controller,
 		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
 			omap_readl(OMAP_UHH_SYSSTATUS));
 
-	omap_writel((1<<1), OMAP_USBTLL_SYSCONFIG);
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)))
+	omap_writel((1 << 1), OMAP_USBTLL_SYSCONFIG);
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1 << 0)))
 		cpu_relax();
 	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
 
@@ -391,7 +388,6 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 		ehci_clocks->usbtll_ick_clk = NULL;
 	}
 
-
 #ifdef EXTERNAL_PHY_RESET
 	gpio_free(EXT_PHY_RESET_GPIO_PORT1);
 	gpio_free(EXT_PHY_RESET_GPIO_PORT2);
@@ -461,7 +457,7 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
 	ehci->hcs_params = readl(&ehci->caps->hcs_params);
 
 	/* SET 1 micro-frame Interrupt interval */
-	writel(readl(&ehci->regs->command) | (1<<16), &ehci->regs->command);
+	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
 
 	retval = usb_add_hcd(hcd, dev->resource[1].start,
 				IRQF_DISABLED | IRQF_SHARED);
@@ -562,8 +558,8 @@ static const struct hc_driver ehci_omap_hc_driver = {
 #endif
 };
 
-/*-------------------------------------------------------------------------*/
 MODULE_ALIAS("platform:omap-ehci");
+
 static struct platform_driver ehci_hcd_omap_driver = {
 	.probe = ehci_hcd_omap_drv_probe,
 	.remove = ehci_hcd_omap_drv_remove,
-- 
1.6.1.3

