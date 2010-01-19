From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 15/16] usb: host: ehci: adding regulator framework in ehci-omap.c driver.
Date: Tue, 19 Jan 2010 15:14:14 +0200
Message-ID: <1263906855-28341-16-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54514 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729Ab0ASNPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:15:01 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

OMAP3 has three HS USB ports so it can have three different regulator
for each PHY connected to each port.

Currently these regulators are assumed to be optional and driver doesn't
fail but continue with the initialization if it doesn't get any regulators.

Regulator supply names has to be mapped in board files as 'hsusbN' where
'N' is port number and can be {0, 1 ,2}.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/host/ehci-omap.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 2460f0d..17e4ceb 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -37,6 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/regulator/consumer.h>
 #include <plat/usb.h>
 
 /*
@@ -178,6 +179,11 @@ struct ehci_hcd_omap {
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
@@ -546,6 +552,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	int irq = platform_get_irq(pdev, 0);
 	int ret = -ENODEV;
+	int i;
+	char supply[7];
 
 	if (!pdata) {
 		dev_dbg(&pdev->dev, "missing platform_data\n");
@@ -613,6 +621,21 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
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
@@ -641,6 +664,12 @@ err_add_hcd:
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
@@ -674,10 +703,17 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
 	struct ehci_hcd_omap *omap = platform_get_drvdata(pdev);
 	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
+	int i;
 
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
1.6.6.rc0

