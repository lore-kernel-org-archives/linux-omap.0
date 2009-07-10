From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 8/8] ehci: Support for ES3.x
Date: Fri, 10 Jul 2009 14:47:14 +0530
Message-ID: <1247217434-6309-8-git-send-email-ajay.gupta@ti.com>
References: <1247217434-6309-1-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-2-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-3-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-4-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-5-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-6-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-7-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47208 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbZGJJRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 05:17:33 -0400
In-Reply-To: <1247217434-6309-7-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

OMAP ES3.x supports portwise PHY or TLL mode of operation whereas
in ES2.x all the three ports can either be in PHY mode or in TLL
mode.Port3 can not be configured in PHY mode.

Port mode must be defined either PHY, TLL or UNKNOWN in platform
files.Be careful of the scenario where one port is set as PHY and
other in TLL but the OMAP silicon version is 2.x or earlier where
this scenario is *not* supported.

Changes are :
        - Setup all the bypass configuration in omap_start_ehc()
          based on ES version.
        - Remove UHH_HOSTCONFIG programming for bypass settings
          in omap_usb_utmi_init()

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |   90 ++++++++++++++++++++++++------------------
 1 files changed, 52 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e64ba9f..c0f9a19 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -32,7 +32,6 @@
  *	- move DPLL5 programming to clock fw
  *	- add suspend/resume
  *	- move workarounds to board-files
- *	- differentiate between ES2.x and ES3.x
  *	- make it enumerate devices
  */
 
@@ -103,6 +102,9 @@
 #define	OMAP_UHH_SYSSTATUS				(0x14)
 #define	OMAP_UHH_HOSTCONFIG				(0x40)
 #define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS			(1 << 0)
+#define	OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS		(1 << 0)
+#define	OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS		(1 << 11)
+#define	OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS		(1 << 12)
 #define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN		(1 << 2)
 #define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN		(1 << 3)
 #define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN		(1 << 4)
@@ -186,16 +188,6 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
 	unsigned reg;
 	int i;
 
-	reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
-	reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS
-		| OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
-		| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
-		| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN;
-	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
-
-	/* Use UTMI Ports of TLL */
-	ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
-
 	/* Program the 3 TLL channels upfront */
 	for (i = 0; i < OMAP_TLL_CHANNEL_COUNT; i++) {
 		reg = ehci_omap_readl(omap->tll_base, OMAP_TLL_CHANNEL_CONF(i));
@@ -244,7 +236,9 @@ static void omap_usb_utmi_init(struct ehci_hcd_omap *omap, u8 tll_channel_mask)
  */
 static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 {
+	struct omap_chip_id oci = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3);
 	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	u8 tll_ch_mask = 0;
 	unsigned reg = 0;
 	int ret = 0;
 
@@ -363,37 +357,58 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 	ehci_omap_writel(omap->uhh_base, OMAP_UHH_SYSCONFIG, reg);
 
-	if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
-		(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
-		(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY)) {
+	reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 
-		reg = ehci_omap_readl(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
+	/* setup ULPI bypass and burst configurations */
+	reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
+			| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
+			| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
+	reg &= ~OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN;
 
-		reg |= (OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN
-				| OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN
-				| OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN);
-		reg &= ~(OMAP_UHH_HOSTCONFIG_ULPI_BYPASS
-				| OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN);
+	/* Bypass the TLL module for PHY mode operation */
+	if (omap_chip_is(oci)) {
+		dev_dbg(omap->dev, "OMAP3 ES version > ES3\n");
+		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY)
+			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
+		else if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P1_BYPASS;
 
-		/* Bypass the TLL module for PHY mode operation */
-		ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
-		dev_dbg(omap->dev, "Entered ULPI PHY MODE: success\n");
+		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY)
+			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
+		else if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P2_BYPASS;
+
+		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY)
+			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
+		else if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
+			reg |= OMAP_UHH_HOSTCONFIG_ULPI_P3_BYPASS;
 
-	} else if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
-		(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL) ||
-		(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)) {
-
-		/* Enable UTMI mode for all 3 TLL channels */
-		omap_usb_utmi_init(omap,
-			OMAP_TLL_CHANNEL_1_EN_MASK |
-			OMAP_TLL_CHANNEL_2_EN_MASK |
-			OMAP_TLL_CHANNEL_3_EN_MASK
-			);
 	} else {
-		dev_err(hcd->self.controller,
-				"UNKOWN mode requested\n");
-		ret = -EINVAL;
-		goto err_unknown_mode;
+		dev_dbg(omap->dev, "OMAP3 ES version < ES3\n");
+		if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
+			(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
+				(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY))
+			reg &= ~OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
+		else
+			reg |= OMAP_UHH_HOSTCONFIG_ULPI_BYPASS;
+	}
+	ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
+	dev_dbg(omap->dev, "UHH setup done, uhh_base=%x\n", reg);
+
+
+	if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
+		(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL) ||
+			(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)) {
+
+		if (omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL)
+			tll_ch_mask |= OMAP_TLL_CHANNEL_1_EN_MASK;
+		if (omap->port_mode[1] == EHCI_HCD_OMAP_MODE_TLL)
+			tll_ch_mask |= OMAP_TLL_CHANNEL_2_EN_MASK;
+		if (omap->port_mode[2] == EHCI_HCD_OMAP_MODE_TLL)
+			tll_ch_mask |= OMAP_TLL_CHANNEL_3_EN_MASK;
+
+		/* Enable UTMI mode for required TLL channels */
+		omap_usb_utmi_init(omap, tll_ch_mask);
 	}
 
 	if (omap->phy_reset) {
@@ -431,7 +446,6 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 	return 0;
 
-err_unknown_mode:
 err_sys_status:
 	clk_disable(omap->usbtll_ick);
 	clk_put(omap->usbtll_ick);
-- 
1.6.2.4

