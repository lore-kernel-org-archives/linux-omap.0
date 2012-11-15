From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 14/16] mfd: omap-usb-host: Support an auxiliary clock per port
Date: Thu, 15 Nov 2012 16:34:12 +0200
Message-ID: <1352990054-14680-15-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54706 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768043Ab2KOOeh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 09:34:37 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com

Boards like Panda require an auxiliary clock to clock the PHY
that is connected to one of the USB ports. This patch enables
board support code to  provide the name and the rate of such
a clock for each of the USB ports. omap-usb-host driver can
then manage the clock.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/usb-host.c        |    2 ++
 arch/arm/plat-omap/include/plat/usb.h |    6 ++++++
 drivers/mfd/omap-usb-host.c           |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index eb85528..bfab301 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -494,6 +494,8 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 
 	for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
 		usbhs_data.port_mode[i] = pdata->port_mode[i];
+		usbhs_data.clk[i] = pdata->clk[i];
+		usbhs_data.clkrate[i] = pdata->clkrate[i];
 		usbtll_data.port_mode[i] = pdata->port_mode[i];
 		ohci_data.port_mode[i] = pdata->port_mode[i];
 		ehci_data.port_mode[i] = pdata->port_mode[i];
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 6b618a1..0f89890 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -43,6 +43,9 @@ struct usbhs_omap_board_data {
 	 * Each PHY can have a separate regulator.
 	 */
 	struct regulator		*regulator[OMAP3_HS_USB_PORTS];
+
+	const char			*clk[OMAP3_HS_USB_PORTS];
+	unsigned long int		clkrate[OMAP3_HS_USB_PORTS];
 };
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -65,6 +68,9 @@ struct usbhs_omap_platform_data {
 
 	struct ehci_hcd_omap_platform_data	*ehci_data;
 	struct ohci_hcd_omap_platform_data	*ohci_data;
+
+	const char			*clk[OMAP3_HS_USB_PORTS];
+	unsigned long int		clkrate[OMAP3_HS_USB_PORTS];
 };
 
 struct usbtll_omap_platform_data {
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4289847..a1ea8e6 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -89,6 +89,7 @@ struct usbhs_port {
 	struct clk	*utmi_clk;
 	struct clk	*hsic60m_clk;
 	struct clk	*hsic480m_clk;
+	struct clk	*aux_clk;	/* board dependent clock */
 };
 
 struct usbhs_hcd_omap {
@@ -288,6 +289,15 @@ static int usbhs_runtime_resume(struct device *dev)
 		clk_enable(omap->ehci_logic_fck);
 
 	for (i = 0; i < omap->nports; i++) {
+		if (omap->port[i].aux_clk) {
+			r = clk_enable(omap->port[i].aux_clk);
+			if (r) {
+				dev_err(dev,
+				 "%s: Can't enable port %d aux clk %d\n",
+				 __func__, i, r);
+			}
+		}
+
 		if (is_ehci_tll_mode(pdata->port_mode[i])) {
 			if (omap->port[i].utmi_clk) {
 				r = clk_enable(omap->port[i].utmi_clk);
@@ -344,6 +354,9 @@ static int usbhs_runtime_suspend(struct device *dev)
 			if (omap->port[i].hsic480m_clk)
 				clk_disable(omap->port[i].hsic480m_clk);
 		}
+
+		if (omap->port[i].aux_clk)
+			clk_disable(omap->port[i].aux_clk);
 	}
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
@@ -620,6 +633,24 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 				hsic_clk, PTR_ERR(pclk));
 		else
 			omap->port[i].hsic60m_clk = pclk;
+
+		/* get the auxiliary clock if required and set its rate */
+		if (pdata->clk[i] && pdata->clkrate[i]) {
+			pclk = clk_get(dev, pdata->clk[i]);
+			if (IS_ERR(pclk)) {
+				dev_err(dev,
+				 "Failed to get clock %s\n", pdata->clk[i]);
+			} else {
+				omap->port[i].aux_clk = pclk;
+
+				ret = clk_set_rate(pclk, pdata->clkrate[i]);
+				if (ret) {
+					dev_err(dev,
+					 "Failed to set clock %s to %luHz\n",
+					 pdata->clk[i], pdata->clkrate[i]);
+				}
+			}
+		}
 	}
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
@@ -671,6 +702,7 @@ err_alloc:
 		clk_put(omap->port[i].utmi_clk);
 		clk_put(omap->port[i].hsic60m_clk);
 		clk_put(omap->port[i].hsic480m_clk);
+		clk_put(omap->port[i].aux_clk);
 	}
 
 	clk_put(omap->init_60m_fclk);
@@ -710,6 +742,7 @@ static int __devexit usbhs_omap_remove(struct platform_device *pdev)
 		clk_put(omap->port[i].utmi_clk);
 		clk_put(omap->port[i].hsic60m_clk);
 		clk_put(omap->port[i].hsic480m_clk);
+		clk_put(omap->port[i].aux_clk);
 	}
 
 	clk_put(omap->init_60m_fclk);
-- 
1.7.4.1

