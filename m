From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Fri, 13 Nov 2009 09:52:14 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394043702AFF5@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F9384E@dbde02.ent.ti.com>
 <20091105093641.GA21779@rakim.wolfsonmicro.main>
 <20091105094134.GB3045@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E0F2@dbde02.ent.ti.com>
 <20091105111955.GA23505@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F94618@dbde02.ent.ti.com>
 <20091111154616.GA30354@rakim.wolfsonmicro.main>
 <19F8576C6E063C45BE387C64729E73940436F946DA@dbde02.ent.ti.com>
 <20091112121613.GB16661@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34360 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755536AbZKMEWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 23:22:18 -0500
In-Reply-To: <20091112121613.GB16661@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Hi,

> > MODE_UNKNOWN means that the port is not connected and so no need to
> check
> > the regulator availability.
> 
> Sure, currently - the point is that if you're going to check for the
> individual allocations anyway then the check doesn't buy you anything.

Now I have taken this into consideration during driver exit function.

Please review the v2 of this patch below.

Regards,
Ajay
================ cut here =======================

Adding regulator framework in EHCI driver.

OMAP3 has three HS USB ports so it can have three different regulator
for each PHY connected to each port.

Currently these regulators are assumed to be optional and driver doesn't
fail but continue with the initialization if it doesn't get any regulators.

Regulator supply names has to be mapped in board files as 'hsusbN' where
'N' is port number and can be {0, 1 ,2}.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 97ce7d5..394c0c6 100644
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
+		snprintf(supply, 7, "hsusb%d", i);
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
@@ -981,6 +1004,7 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
 	struct ehci_hcd_omap *omap = platform_get_drvdata(pdev);
 	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
+	int i;
 
 	if (omap->port_mode[0] != EHCI_HCD_OMAP_MODE_UNKNOWN)
 		device_remove_file(&pdev->dev, &dev_attr_port1);
@@ -992,6 +1016,13 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	omap_stop_ehc(omap, hcd);
 	iounmap(hcd->regs);
+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+		if (omap->regulator[i]) {
+			if (regulator_is_enabled(omap->regulator[i]))
+				regulator_disable(omap->regulator[i]);
+			regulator_put(omap->regulator[i]);
+		}
+	}
 	iounmap(omap->tll_base);
 	iounmap(omap->uhh_base);
 	usb_put_hcd(hcd);
-- 
1.6.2.4


==================================================
