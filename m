From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 12/22] mfd: omap-usb-host: know about number of ports from revision register
Date: Wed, 28 Nov 2012 16:49:00 +0200
Message-ID: <1354114150-11941-13-git-send-email-rogerq@ti.com>
References: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38161 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932260Ab2K1Ot3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 09:49:29 -0500
In-Reply-To: <1354114150-11941-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

The revision register should tell us how many ports are present.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index afa0ff6..87b574b 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -89,6 +89,8 @@
 
 
 struct usbhs_hcd_omap {
+	int				nports;
+
 	struct clk			*xclk60mhsp1_ck;
 	struct clk			*xclk60mhsp2_ck;
 	struct clk			*utmi_p1_fck;
@@ -351,8 +353,6 @@ static void omap_usbhs_init(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&omap->lock, flags);
-	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
-	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
 
 	reg = usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 	/* setup ULPI bypass and burst configurations */
@@ -485,8 +485,32 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	platform_set_drvdata(pdev, omap);
+	pm_runtime_get_sync(dev);
 
-	for (i = 0; i < OMAP3_HS_USB_PORTS; i++)
+	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
+
+	/* we need to call runtime suspend before we update omap->nports
+	 * to prevent unbalanced clk_disable()
+	 */
+	pm_runtime_put_sync(dev);
+
+	switch (omap->usbhs_rev) {
+	case OMAP_USBHS_REV1:
+		omap->nports = 3;
+		break;
+	case OMAP_USBHS_REV2:
+		omap->nports = 2;
+		break;
+	default:
+		omap->nports = OMAP3_HS_USB_PORTS;
+		dev_dbg(dev,
+		  "USB HOST Rev : 0x%d not recognized, assuming %d ports\n",
+		   omap->usbhs_rev, omap->nports);
+		break;
+	}
+
+	for (i = 0; i < omap->nports; i++)
 		if (is_ehci_phy_mode(i) || is_ehci_tll_mode(i) ||
 			is_ehci_hsic_mode(i)) {
 			omap->ehci_logic_fck = clk_get(dev, "ehci_logic_fck");
@@ -576,8 +600,6 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 				"failed error:%d\n", ret);
 	}
 
-	platform_set_drvdata(pdev, omap);
-
 	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
 	if (ret) {
-- 
1.7.4.1

