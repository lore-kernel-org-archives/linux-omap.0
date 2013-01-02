From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v5 12/22] mfd: omap-usb-host: know about number of ports from revision register
Date: Wed, 2 Jan 2013 17:00:32 +0200
Message-ID: <1357138842-28964-13-git-send-email-rogerq@ti.com>
References: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1357138842-28964-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sameo@linux.intel.com, tony@atomide.com
Cc: keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The revision register should tell us how many ports are present.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index b24a3ab..5edb828 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -91,6 +91,8 @@
 
 
 struct usbhs_hcd_omap {
+	int				nports;
+
 	struct clk			*xclk60mhsp1_ck;
 	struct clk			*xclk60mhsp2_ck;
 	struct clk			*utmi_p1_fck;
@@ -353,8 +355,6 @@ static void omap_usbhs_init(struct device *dev)
 
 	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&omap->lock, flags);
-	omap->usbhs_rev = usbhs_read(omap->uhh_base, OMAP_UHH_REVISION);
-	dev_dbg(dev, "OMAP UHH_REVISION 0x%x\n", omap->usbhs_rev);
 
 	reg = usbhs_read(omap->uhh_base, OMAP_UHH_HOSTCONFIG);
 	/* setup ULPI bypass and burst configurations */
@@ -487,8 +487,32 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 
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
@@ -578,8 +602,6 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 				"failed error:%d\n", ret);
 	}
 
-	platform_set_drvdata(pdev, omap);
-
 	omap_usbhs_init(dev);
 	ret = omap_usbhs_alloc_children(pdev);
 	if (ret) {
-- 
1.7.4.1
