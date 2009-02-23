From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 17/23] usb: host: ehci: fix register definitions
Date: Mon, 23 Feb 2009 20:55:29 +0200
Message-ID: <1235415335-17408-18-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42654 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677AbZBWS51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:57:27 -0500
In-Reply-To: <1235415335-17408-17-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Make the register definitions in ehci-omap.c more sane.
Also change the parameter passed omap_start/stop_ehc().

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |  219 +++++++++++++++++++++---------------------
 1 files changed, 111 insertions(+), 108 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index cd891cc..c9305a3 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -49,30 +49,30 @@
 #define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
 #define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
 #define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
-	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT	8
-	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT	3
-	#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT	2
-	#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT	1
-	#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE_SHIFT	0
+	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY		(1 << 8)
+	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE		(1 << 3)
+	#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP		(1 << 2)
+	#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET		(1 << 1)
+	#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE		(1 << 0)
 #define	OMAP_USBTLL_SYSSTATUS	(OMAP_USBHOST_TLL_BASE + 0x14)
-	#define	OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT	0
+	#define	OMAP_USBTLL_SYSSTATUS_RESETDONE		(1 << 0)
 #define	OMAP_USBTLL_IRQSTATUS	(OMAP_USBHOST_TLL_BASE + 0x18)
 #define	OMAP_USBTLL_IRQENABLE	(OMAP_USBHOST_TLL_BASE + 0x1C)
 
 #define	OMAP_TLL_SHARED_CONF	(OMAP_USBHOST_TLL_BASE + 0x30)
-	#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN_SHFT	6
-	#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN_SHIFT	5
-	#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION_SHIFT	2
-	#define	OMAP_TLL_SHARED_CONF_FCLK_REQ_SHIFT		1
-	#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT		0
+	#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN		(1 << 6)
+	#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN		(1 << 5)
+	#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION		(1 << 2)
+	#define	OMAP_TLL_SHARED_CONF_FCLK_REQ			(1 << 1)
+	#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON			(1 << 0)
 
 #define	OMAP_TLL_CHANNEL_CONF(num)\
 			(OMAP_USBHOST_TLL_BASE + (0x040 + 0x004 * num))
-	#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT	11
-	#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE_SHIFT	10
-	#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT	9
-	#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT		8
-	#define	OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT		0
+	#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
+	#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
+	#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
+	#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
+	#define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
 
 #define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)\
 			(OMAP_USBHOST_TLL_BASE + (0x804 + 0x100 * num))
@@ -94,28 +94,28 @@
 			(OMAP_USBHOST_TLL_BASE + (0x816 + 0x100 * num))
 
 #define OMAP_TLL_CHANNEL_COUNT		3
-	#define OMAP_TLL_CHANNEL_1_EN_MASK	1
-	#define OMAP_TLL_CHANNEL_2_EN_MASK	2
-	#define OMAP_TLL_CHANNEL_3_EN_MASK	4
+	#define OMAP_TLL_CHANNEL_1_EN_MASK	(1 << 1)
+	#define OMAP_TLL_CHANNEL_2_EN_MASK	(1 << 2)
+	#define OMAP_TLL_CHANNEL_3_EN_MASK	(1 << 4)
 
 /* UHH Register Set */
 #define	OMAP_USBHOST_UHH_BASE	(OMAP_USBHOST_BASE + 0x4000)
 #define	OMAP_UHH_REVISION	(OMAP_USBHOST_UHH_BASE + 0x00)
 #define	OMAP_UHH_SYSCONFIG	(OMAP_USBHOST_UHH_BASE + 0x10)
-	#define	OMAP_UHH_SYSCONFIG_MIDLEMODE_SHIFT	12
-	#define	OMAP_UHH_SYSCONFIG_CACTIVITY_SHIFT	8
-	#define	OMAP_UHH_SYSCONFIG_SIDLEMODE_SHIFT	3
-	#define	OMAP_UHH_SYSCONFIG_ENAWAKEUP_SHIFT	2
-	#define	OMAP_UHH_SYSCONFIG_SOFTRESET_SHIFT	1
-	#define	OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT	0
+	#define	OMAP_UHH_SYSCONFIG_MIDLEMODE	(1 << 12)
+	#define	OMAP_UHH_SYSCONFIG_CACTIVITY	(1 << 8)
+	#define	OMAP_UHH_SYSCONFIG_SIDLEMODE	(1 << 3)
+	#define	OMAP_UHH_SYSCONFIG_ENAWAKEUP	(1 << 2)
+	#define	OMAP_UHH_SYSCONFIG_SOFTRESET	(1 << 1)
+	#define	OMAP_UHH_SYSCONFIG_AUTOIDLE	(1 << 0)
 
 #define	OMAP_UHH_SYSSTATUS	(OMAP_USBHOST_UHH_BASE + 0x14)
 #define	OMAP_UHH_HOSTCONFIG	(OMAP_USBHOST_UHH_BASE + 0x40)
-	#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT	0
-	#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT	2
-	#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT	3
-	#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT	4
-	#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT	5
+	#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS		(1 << 0)
+	#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN	(1 << 2)
+	#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN	(1 << 3)
+	#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN	(1 << 4)
+	#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN	(1 << 5)
 
 #define	OMAP_UHH_DEBUG_CSR	(OMAP_USBHOST_UHH_BASE + 0x44)
 
@@ -167,71 +167,75 @@ struct ehci_hcd_omap {
 
 /*-------------------------------------------------------------------------*/
 
-static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
+static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	unsigned reg;
 	int i;
 
+	reg = omap_readl(OMAP_UHH_HOSTCONFIG);
+	reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS
+		| OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
+		| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
+		| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN;
+	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
+
 	/* Use UTMI Ports of TLL */
-	omap_writel((1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
-			(1 << OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
-			(1 << OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
-			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
-			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
-						OMAP_UHH_HOSTCONFIG);
-	/* Enusre bit is set */
+	omap_writel(reg, OMAP_UHH_HOSTCONFIG);
+
+	/* Ensure bit is set */
 	while (!(omap_readl(OMAP_UHH_HOSTCONFIG)
-			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT))) {
+			& OMAP_UHH_HOSTCONFIG_ULPI_BYPASS)) {
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			return;
 		}
 	}
 
-	dev_dbg(hcd->self.controller, "Entered UTMI MODE: success\n");
+	dev_dbg(omap->dev, "Entered UTMI MODE: success\n");
 
 	/* Program the 3 TLL channels upfront */
 
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+		reg = omap_readl(OMAP_TLL_CHANNEL_CONF(i));
 
 		/* Disable AutoIdle */
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			~(1 << OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT),
-			OMAP_TLL_CHANNEL_CONF(i));
+		reg &= ~OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE;
+		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
+
 		/* Disable BitStuffing */
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-			~(1 << OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT),
-			OMAP_TLL_CHANNEL_CONF(i));
-		/* SDR Mode */
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) &
-				~(1 << OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT),
-				OMAP_TLL_CHANNEL_CONF(i));
+		reg &= ~OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF;
+		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
 
+		/* SDR Mode */
+		reg &= ~OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE;
+		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
 	}
 
 	/* Program Common TLL register */
-	omap_writel((1 << OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT) |
-			(1 << OMAP_TLL_SHARED_CONF_USB_DIVRATION_SHIFT) |
-			(0 << OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN_SHIFT) |
-			(0 << OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN_SHFT),
-				OMAP_TLL_SHARED_CONF);
+	reg = omap_readl(OMAP_TLL_SHARED_CONF);
+	reg |= (OMAP_TLL_SHARED_CONF_FCLK_IS_ON
+			| OMAP_TLL_SHARED_CONF_USB_DIVRATION
+			| OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN);
+	reg &= ~OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN;
+
+	omap_writel(reg, OMAP_TLL_SHARED_CONF);
 
 	/* Enable channels now */
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
+		reg = omap_readl(OMAP_TLL_CHANNEL_CONF(i));
 
-		/* Enable only the channel that is needed */
+		/* Enable only the reg that is needed */
 		if (!(tll_channel_mask & 1<<i))
 			continue;
 
-		omap_writel(omap_readl(OMAP_TLL_CHANNEL_CONF(i)) |
-				(1 << OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT),
-				OMAP_TLL_CHANNEL_CONF(i));
+		reg |= OMAP_TLL_CHANNEL_CONF_CHANEN;
+		omap_writel(reg, OMAP_TLL_CHANNEL_CONF(i));
 
-		omap_writeb(0xBE, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
-		dev_dbg(hcd->self.controller, "ULPI_SCRATCH_REG[ch=%d]"
-			"= 0x%02x\n",
+		omap_writeb(0xbe, OMAP_TLL_ULPI_SCRATCH_REGISTER(i));
+		dev_dbg(omap->dev, "ULPI_SCRATCH_REG[ch=%d]= 0x%02x\n",
 			i+1, omap_readb(OMAP_TLL_ULPI_SCRATCH_REGISTER(i)));
 	}
 }
@@ -244,9 +248,10 @@ static void omap_usb_utmi_init(struct usb_hcd *hcd, u8 tll_channel_mask)
 static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	unsigned reg = 0;
 	int ret = 0;
 
-	dev_dbg(hcd->self.controller, "starting TI EHCI USB Controller\n");
+	dev_dbg(omap->dev, "starting TI EHCI USB Controller\n");
 
 	/* Start DPLL5 Programming:
 	 * Clock Framework is not doing this now:
@@ -266,19 +271,17 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 	while (!(cm_read_mod_reg(PLL_MOD, CM_IDLEST2) &
 				OMAP3430ES2_ST_PERIPH2_CLK_MASK)) {
-		dev_dbg(hcd->self.controller,
-			"idlest2 = 0x%x\n",
+		dev_dbg(omap->dev, "idlest2 = 0x%x\n",
 			cm_read_mod_reg(PLL_MOD, CM_IDLEST2));
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			ret = -EINVAL;
 			goto err_idlest2;
 		}
 	}
 	/* End DPLL5 programming */
 
-
 	/* PRCM settings for USBHOST:
 	 * Interface clk un-related to domain transition
 	 */
@@ -343,84 +346,87 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	clk_enable(omap->usbtll_ick);
 
 	/* Disable Auto Idle of USBTLL */
-	cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL_SHIFT),
+	cm_write_mod_reg((0 << OMAP3430ES2_AUTO_USBTLL),
 				CORE_MOD, CM_AUTOIDLE3);
 
 	/* Wait for TLL to be Active */
 	while ((cm_read_mod_reg(CORE_MOD, OMAP2430_CM_IDLEST3)
-			& (1 << OMAP3430ES2_ST_USBTLL_SHIFT))) {
+			& (0 << OMAP3430ES2_ST_USBTLL_SHIFT))) {
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			ret = -EINVAL;
 			goto err_idlest3;
 		}
 	}
 
 	/* perform TLL soft reset, and wait until reset is complete */
-	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT,
+	omap_writel(1 << OMAP_USBTLL_SYSCONFIG_SOFTRESET,
 			OMAP_USBTLL_SYSCONFIG);
 
 	/* Wait for TLL reset to complete */
 	while (!(omap_readl(OMAP_USBTLL_SYSSTATUS)
-			& (1 << OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT))) {
+			& (1 << OMAP_USBTLL_SYSSTATUS_RESETDONE))) {
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			ret = -EINVAL;
 			goto err_sys_status;
 		}
 	}
 
-	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
+	dev_dbg(omap->dev, "TLL RESET DONE\n");
 
 	/* (1<<3) = no idle mode only for initial debugging */
-	omap_writel((1 << OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT) |
-			(1 << OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT) |
-			(1 << OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT),
+	omap_writel(OMAP_USBTLL_SYSCONFIG_ENAWAKEUP |
+			OMAP_USBTLL_SYSCONFIG_SIDLEMODE |
+			OMAP_USBTLL_SYSCONFIG_CACTIVITY,
 			OMAP_USBTLL_SYSCONFIG);
 
 
 	/* Put UHH in NoIdle/NoStandby mode */
-	omap_writel((0 << OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT) |
-			(1 << OMAP_UHH_SYSCONFIG_ENAWAKEUP_SHIFT) |
-			(1 << OMAP_UHH_SYSCONFIG_SIDLEMODE_SHIFT) |
-			(1 << OMAP_UHH_SYSCONFIG_CACTIVITY_SHIFT) |
-			(1 << OMAP_UHH_SYSCONFIG_MIDLEMODE_SHIFT),
-			OMAP_UHH_SYSCONFIG);
+	reg = omap_readl(OMAP_UHH_SYSCONFIG);
+	reg |= (OMAP_UHH_SYSCONFIG_ENAWAKEUP
+			| OMAP_UHH_SYSCONFIG_SIDLEMODE
+			| OMAP_UHH_SYSCONFIG_CACTIVITY
+			| OMAP_UHH_SYSCONFIG_MIDLEMODE);
+	reg &= ~OMAP_UHH_SYSCONFIG_AUTOIDLE;
+
+	omap_writel(reg, OMAP_UHH_SYSCONFIG);
 
 	if (omap->phy_mode == EHCI_HCD_OMAP_MODE_PHY) {
+		reg = omap_readl(OMAP_UHH_HOSTCONFIG);
+
+		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
+				| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
+				| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
+		reg &= ~(OMAP_UHH_HOSTCONFIG_ULPI_BYPASS
+				| OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN);
 
 		/* Bypass the TLL module for PHY mode operation */
-		omap_writel((0 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)|
-			(1 << OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT)|
-			(1 << OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT)|
-			(1 << OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT)|
-			(0 << OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT),
-			OMAP_UHH_HOSTCONFIG);
+		omap_writel(reg, OMAP_UHH_HOSTCONFIG);
 
 		/* Ensure that BYPASS is set */
 		while (omap_readl(OMAP_UHH_HOSTCONFIG)
-			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT)) {
+			& (1 << OMAP_UHH_HOSTCONFIG_ULPI_BYPASS)) {
 			cpu_relax();
 
 			if (time_after(timeout, jiffies)) {
-				dev_dbg(hcd->self.controller,
+				dev_dbg(omap->dev,
 						"operation timed out\n");
 				ret = -EINVAL;
 				goto err_ulpi_bypass;
 			}
 		}
 
-		dev_dbg(hcd->self.controller,
-				"Entered ULPI PHY MODE: success\n");
+		dev_dbg(omap->dev, "Entered ULPI PHY MODE: success\n");
 
 	} else if (omap->phy_mode == EHCI_HCD_OMAP_MODE_TLL) {
 
 		/* Enable UTMI mode for all 3 TLL channels */
-		omap_usb_utmi_init(hcd,
+		omap_usb_utmi_init(omap,
 			OMAP_TLL_CHANNEL_1_EN_MASK |
 			OMAP_TLL_CHANNEL_2_EN_MASK |
 			OMAP_TLL_CHANNEL_3_EN_MASK
@@ -449,7 +455,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		/* use Port1 VBUS to charge externally Port2:
 		 *	So for PHY mode operation use Port2 only
 		 */
-		omap_writel((0xA << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
+		omap_writel((0xa << EHCI_INSNREG05_ULPI_REGADD_SHIFT) |/* OTG ctrl reg*/
 				(2 << EHCI_INSNREG05_ULPI_OPSEL_SHIFT) |/*   Write */
 				(1 << EHCI_INSNREG05_ULPI_PORTSEL_SHIFT) |/* Port1 */
 				(1 << EHCI_INSNREG05_ULPI_CONTROL_SHIFT) |/* Start */
@@ -461,8 +467,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 			cpu_relax();
 
 			if (time_after(timeout, jiffies)) {
-				dev_dbg(hcd->self.controller,
-						"operation timed out\n");
+				dev_dbg(omap->dev, "operation timed out\n");
 				ret = -EINVAL;
 				goto err_ulpi_control;
 			}
@@ -509,7 +514,7 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(100);
 
-	dev_dbg(hcd->self.controller, "stopping TI EHCI USB Controller\n");
+	dev_dbg(omap->dev, "stopping TI EHCI USB Controller\n");
 
 	/* Reset OMAP modules for insmod/rmmod to work */
 	omap_writel((1 << 1), OMAP_UHH_SYSCONFIG);
@@ -517,7 +522,7 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			return;
 		}
 	}
@@ -526,7 +531,7 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			return;
 		}
 	}
@@ -535,12 +540,11 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			return;
 		}
 	}
-	dev_dbg(hcd->self.controller,
-		"UHH RESET DONE OMAP_UHH_SYSSTATUS %x !!\n",
+	dev_dbg(omap->dev, "UHH RESET DONE OMAP_UHH_SYSSTATUS %x\n",
 			omap_readl(OMAP_UHH_SYSSTATUS));
 
 	omap_writel((1 << 1), OMAP_USBTLL_SYSCONFIG);
@@ -548,11 +552,11 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		cpu_relax();
 
 		if (time_after(timeout, jiffies)) {
-			dev_dbg(hcd->self.controller, "operation timed out\n");
+			dev_dbg(omap->dev, "operation timed out\n");
 			return;
 		}
 	}
-	dev_dbg(hcd->self.controller, "TLL RESET DONE\n");
+	dev_dbg(omap->dev, "TLL RESET DONE\n");
 
 	if (omap->usbtll_fck != NULL) {
 		clk_disable(omap->usbtll_fck);
@@ -589,8 +593,7 @@ static void omap_stop_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		gpio_free(omap->reset_gpio_port2);
 	}
 
-	dev_dbg(hcd->self.controller,
-		"Clock to USB host has been disabled\n");
+	dev_dbg(omap->dev, "Clock to USB host has been disabled\n");
 }
 
 /*-------------------------------------------------------------------------*/
-- 
1.6.1.3

