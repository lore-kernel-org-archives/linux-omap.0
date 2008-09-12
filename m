From: Felipe Balbi <me@felipebalbi.com>
Subject: [rfc] [patch] clean up to ehci-omap (Was: Re: [patch] omap: usb:
	ehci: fix use of hcd->regs)
Date: Fri, 12 Sep 2008 21:38:20 +0300
Message-ID: <20080912183819.GE7132@frodo>
References: <20080912121024.GG759@gandalf.research.nokia.com> <200809120932.57016.david-b@pacbell.net> <20080912175033.GB7132@frodo> <20080912182255.GD7132@frodo>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:49349 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbYILSio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 14:38:44 -0400
Content-Disposition: inline
In-Reply-To: <20080912182255.GD7132@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

This one is RFC since I need someone to test it for me. I'm home now
without any hw so if anyone could validate if it works I'd be really
glad otherwise I'll test it tomorrow at work on my sdp.

===== cut here =====

>From 194d26cae0e9093c4b1da4de531f6e5c16495678 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Fri, 12 Sep 2008 21:36:42 +0300
Subject: [RFC][PATCH] omap: usb: ehci: clean up to ehci-omap.c

This patch fixes a few mistakes on the ehci-omap driver and cleans up a
few style issues. It should be broken into smaller pieces but for now I
just wanna get the feeling about the patch from the other guys, so here
it goes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/host/ehci-omap.c |  152 ++++++++++++++++++++++--------------------
 1 files changed, 81 insertions(+), 71 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index fff4195..4f823c5 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -5,7 +5,7 @@
  * Tested on OMAP3430 ES2.0 SDP
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * 	Author: Vikram Pandita <vikram.pandita@ti.com>
+ *	Author: Vikram Pandita <vikram.pandita@ti.com>
  *
  * Based on "ehci-fsl.c" and "ehci-au1xxx.c" ehci glue layers
  *
@@ -31,7 +31,6 @@
 
 #include "ehci-omap.h"
 
-
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 /* EHCI connected to External PHY */
 
@@ -42,10 +41,10 @@
 
 /* ISSUE1:
  *      ISP1504 for input clocking mode needs special reset handling
- * 	Hold the PHY in reset by asserting RESET_N signal
- * 	Then start the 60Mhz clock input to PHY
- * 	Release the reset after a delay -
- * 		to get the PHY state machine in working state
+ *	Hold the PHY in reset by asserting RESET_N signal
+ *	Then start the 60Mhz clock input to PHY
+ *	Release the reset after a delay -
+ *		to get the PHY state machine in working state
  */
 #define EXTERNAL_PHY_RESET
 #define	EXT_PHY_RESET_GPIO_PORT1	(57)
@@ -89,10 +88,10 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 
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
 	while (!(omap_readl(OMAP_UHH_HOSTCONFIG) &
@@ -106,15 +105,15 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 
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
@@ -130,11 +129,11 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
 
 		/* Enable only the channel that is needed */
-		if (!(tll_channel_mask & 1<<i))
+		if (!(tll_channel_mask & 1 << i))
 			continue;
 
 		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) |
-			    (1<<OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
+			    (1 << OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
 			    OMAP_TLL_CHANNEL_CONF(i));
 
 		omap_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
@@ -262,7 +261,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 
 	dev_dbg(hcd->self.controller, "\n TLL RESET DONE\n");
 
-	/* (1<<3) = no idle mode only for initial debugging */
+	/* (1 << 3) = no idle mode only for initial debugging */
 	omap_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT) |
 			(1 << OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT) |
 			(1 << OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT),
@@ -280,10 +279,10 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
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
 	while (omap_readl(OMAP_UHH_HOSTCONFIG) &
@@ -313,7 +312,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	/* Refer ISSUE2: LINK assumes external charge pump */
 
 	/* use Port1 VBUS to charge externally Port2:
-	 * 	So for PHY mode operation use Port2 only
+	 *	So for PHY mode operation use Port2 only
 	 */
 	omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
 			(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
@@ -323,7 +322,7 @@ static int omap_start_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 			EHCI_INSNREG05_ULPI);
 
 	while (!(omap_readl(EHCI_INSNREG05_ULPI) &
-		(1<<EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
+		(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT)));
 
 #endif
 
@@ -342,16 +341,16 @@ static void omap_stop_ehc(struct platform_device *dev, struct usb_hcd *hcd)
 	dev_dbg(hcd->self.controller, ": stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
-	omap_writel((1<<1), OMAP_UHH_SYSCONFIG);
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<0)));
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<1)));
-	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1<<2)));
+	omap_writel((1 << 1), OMAP_UHH_SYSCONFIG);
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 0)));
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 1)));
+	while (!(omap_readl(OMAP_UHH_SYSSTATUS) & (1 << 2)));
 	dev_dbg(hcd->self.controller,
 		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
 			omap_readl(OMAP_UHH_SYSSTATUS));
 
-	omap_writel((1<<1), OMAP_USBTLL_SYSCONFIG);
-	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1<<0)));
+	omap_writel((1 << 1), OMAP_USBTLL_SYSCONFIG);
+	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS) & (1 << 0)));
 	dev_dbg(hcd->self.controller, ":TLL RESEET DONE");
 
 	if (ehci_clocks->usbtll_fck_clk != NULL) {
@@ -412,36 +411,42 @@ static const struct hc_driver ehci_omap_hc_driver;
 static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
 {
 	int retval = 0;
+	int irq = platform_get_irq(dev, 0);
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
+	struct resource *res;
 
 	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_probe()");
 
-	if (usb_disabled())
-		return -ENODEV;
+	if (usb_disabled()) {
+		retval = -ENODEV;
+		goto err_disabled;
+	}
 
-	if (dev->resource[1].flags != IORESOURCE_IRQ) {
-		dev_dbg(&dev->dev, "resource[1] is not IORESOURCE_IRQ");
+	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev, dev->dev.bus_id);
+	if (!hcd) {
 		retval = -ENOMEM;
+		goto err_hcd;
 	}
 
-	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev, dev->dev.bus_id);
-	if (!hcd)
-		return -ENOMEM;
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res || irq == 0) {
+		retval = -EINVAL;
+		goto err_resource;
+	}
 
 	retval = omap_start_ehc(dev, hcd);
 	if (retval)
-		return retval;
+		goto err_start;
 
-	hcd->rsrc_start = 0;
-	hcd->rsrc_len = 0;
-	hcd->rsrc_start = dev->resource[0].start;
-	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = res->end - res->start + 1;
 
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
 		dev_err(&dev->dev, "ioremap failed\n");
-		return -ENOMEM;
+		retval = -ENOMEM;
+		goto err_ioremap;
 	}
 
 	ehci = hcd_to_ehci(hcd);
@@ -452,18 +457,36 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
 	ehci->hcs_params = readl(&ehci->caps->hcs_params);
 
 	/* SET 1 micro-frame Interrupt interval */
-	writel(readl(&ehci->regs->command) | (1<<16), &ehci->regs->command);
+	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start,
-				IRQF_DISABLED | IRQF_SHARED);
-	if (retval == 0)
-		return retval;
+	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (retval) {
+		dev_err(&dev->dev, "failed to add hcd\n");
+		goto err_add_hcd;
+	}
 
-	dev_dbg(hcd->self.controller, "ERR: add_hcd");
-	omap_stop_ehc(dev, hcd);
+	return 0;
+
+err_add_hcd:
+	ehci->hcs_params = 0;
+	ehci->regs = NULL;
+	ehci->caps = NULL;
+	ehci = NULL;
 	iounmap(hcd->regs);
+	omap_stop_ehc(dev, hcd);
+
+err_ioremap:
+	hcd->rsrc_start = 0;
+	hcd->rsrc_len = 0;
+
+err_start:
+	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
+err_hcd:
+err_resource:
+err_disabled:
+	dev_dbg(&dev->dev, "failed to initialized host controller\n");
 	return retval;
 }
 
@@ -497,18 +520,6 @@ static int ehci_hcd_omap_drv_remove(struct platform_device *dev)
 }
 
 /*-------------------------------------------------------------------------*/
-#ifdef CONFIG_PM
-static int omap_ehci_bus_suspend(struct usb_hcd *hcd)
-{
-	return ehci_bus_suspend(hcd);
-}
-
-static int omap_ehci_bus_resume(struct usb_hcd *hcd)
-{
-	return ehci_bus_resume(hcd);
-}
-#endif
-/*-------------------------------------------------------------------------*/
 
 static const struct hc_driver ehci_omap_hc_driver = {
 	.description = hcd_name,
@@ -548,21 +559,20 @@ static const struct hc_driver ehci_omap_hc_driver = {
 	.hub_status_data = ehci_hub_status_data,
 	.hub_control = ehci_hub_control,
 #ifdef	CONFIG_PM
-	.bus_suspend = omap_ehci_bus_suspend,
-	.bus_resume = omap_ehci_bus_resume,
+	.bus_suspend = ehci_bus_suspend,
+	.bus_resume = ehci_bus_resume,
 #endif
 };
 
 /*-------------------------------------------------------------------------*/
-MODULE_ALIAS("omap-ehci");
+MODULE_ALIAS("plaform:omap-ehci");
 static struct platform_driver ehci_hcd_omap_driver = {
-	.probe = ehci_hcd_omap_drv_probe,
-	.remove = ehci_hcd_omap_drv_remove,
-	.shutdown = usb_hcd_platform_shutdown,
-	/*.suspend      = ehci_hcd_omap_drv_suspend, */
-	/*.resume       = ehci_hcd_omap_drv_resume, */
-	.driver = {
-		.name = "ehci-omap",
-		.bus = &platform_bus_type
+	.probe		= ehci_hcd_omap_drv_probe,
+	.remove		= ehci_hcd_omap_drv_remove,
+	.shutdown	= usb_hcd_platform_shutdown,
+	/*.suspend	= ehci_hcd_omap_drv_suspend, */
+	/*.resume	= ehci_hcd_omap_drv_resume, */
+	.driver		= {
+		.name	= "ehci-omap",
 	}
 };
-- 
1.6.0.1.196.g01914

-- 
balbi
