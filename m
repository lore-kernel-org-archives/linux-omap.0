From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] omap3: ehci: Add regulator framework
Date: Sun, 15 Nov 2009 14:15:48 +0530
Message-ID: <1258274748-28053-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34019 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161AbZKOIpz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 15 Nov 2009 03:45:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, broonie@opensource.wolfsonmicro.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Adding regulator framework in EHCI driver.

OMAP3 has three HS USB ports so it can have three different regulator
for each PHY connected to each port.

Currently these regulators are assumed to be optional and driver doesn't
fail but continue with the initialization if it doesn't get any regulators.

Regulator supply names has to be mapped in board files as 'hsusbN' where
'N' is port number and can be {0, 1 ,2}.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 97ce7d5..91ab9da 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -37,6 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
 #include <plat/usb.h>
 
 struct usb_hcd *ghcd;
@@ -191,6 +192,11 @@ struct ehci_hcd_omap {
 	void __iomem		*uhh_base;
 	void __iomem		*tll_base;
 	void __iomem		*ehci_base;
+
+	/* Regulators for USB PHYs.
+	 * Each PHY can have a seperate regulator.
+	 */
+	struct regulator        *regulator[OMAP3_HS_USB_PORTS];
 };
 
 /*-------------------------------------------------------------------------*/
@@ -839,6 +845,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	int irq = platform_get_irq(pdev, 0);
 	int ret = -ENODEV;
+	int i;
+	char supply[7];
 
 	if (!pdata) {
 		dev_dbg(&pdev->dev, "missing platform_data\n");
@@ -918,6 +926,21 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_tll_ioremap;
 	}
 
+	/* get ehci regulator and enable */
+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+		if (omap->port_mode[i] != EHCI_HCD_OMAP_MODE_PHY) {
+			omap->regulator[i] = NULL;
+			continue;
+		}
+		snprintf(supply, sizeof(supply), "hsusb%d", i);
+		omap->regulator[i] = regulator_get(omap->dev, supply);
+		if (IS_ERR(omap->regulator[i]))
+			dev_dbg(&pdev->dev,
+			"failed to get ehci port%d regulator\n", i);
+		else
+			regulator_enable(omap->regulator[i]);
+	}
+
 	ret = omap_start_ehc(omap, hcd);
 	if (ret) {
 		dev_dbg(&pdev->dev, "failed to start ehci\n");
@@ -949,6 +972,12 @@ err_add_hcd:
 	omap_stop_ehc(omap, hcd);
 
 err_start:
+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+		if (omap->regulator[i]) {
+			regulator_disable(omap->regulator[i]);
+			regulator_put(omap->regulator[i]);
+		}
+	}
 	iounmap(omap->tll_base);
 
 err_tll_ioremap:
@@ -981,6 +1010,7 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
 	struct ehci_hcd_omap *omap = platform_get_drvdata(pdev);
 	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
+	int i;
 
 	if (omap->port_mode[0] != EHCI_HCD_OMAP_MODE_UNKNOWN)
 		device_remove_file(&pdev->dev, &dev_attr_port1);
@@ -992,6 +1022,12 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	omap_stop_ehc(omap, hcd);
 	iounmap(hcd->regs);
+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+		if (omap->regulator[i]) {
+			regulator_disable(omap->regulator[i]);
+			regulator_put(omap->regulator[i]);
+		}
+	}
 	iounmap(omap->tll_base);
 	iounmap(omap->uhh_base);
 	usb_put_hcd(hcd);
-- 
1.6.2.4

