From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: Query: Regulator framework in EHCI driver
Date: Wed, 11 Nov 2009 20:26:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940436F94618@dbde02.ent.ti.com>
References: <20091104133922.GD25044@sirena.org.uk>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE6A@dbde02.ent.ti.com>
 <20091104144126.GA30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE7F@dbde02.ent.ti.com>
 <20091104144811.GB30644@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67DE8A@dbde02.ent.ti.com>
 <19F8576C6E063C45BE387C64729E73940436F9384E@dbde02.ent.ti.com>
 <20091105093641.GA21779@rakim.wolfsonmicro.main>
 <20091105094134.GB3045@nokia.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E0F2@dbde02.ent.ti.com>
 <20091105111955.GA23505@rakim.wolfsonmicro.main>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45905 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755903AbZKKO4M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 09:56:12 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB030A67E132@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Aggarwal, Anuj" <anuj.aggarwal@ti.com>

Hi,
> -----Original Message-----
> From: Gadiyar, Anand
> Sent: Thursday, November 05, 2009 4:56 PM
> To: Mark Brown
> Cc: felipe.balbi@nokia.com; Gupta, Ajay Kumar; linux-omap@vger.kernel.org;
> Aggarwal, Anuj
> Subject: RE: Query: Regulator framework in EHCI driver
> 
> > On Thu, Nov 05, 2009 at 04:01:24PM +0530, Gadiyar, Anand wrote:
> >
> > > How do you add a fixed voltage regulator for a board which
> > doesn't really
> > > have a controllable regulator for that voltage? (the PHY
> > supply is wired
> > > directly from the main board power-supply, no GPIO for
> > on-off control)
> >

Hi,

Please review this RFC version. It works with OMAP3EVM after adding 'ehci1' supply mapping in board file.

-Ajay

======================= RFC ============================

Adding regulator framework in EHCI driver.

OMAP3 has three HS USB ports so it can have three different regulator
for each PHY connected to each port.

Currently these regulators are assumed to be optional and driver doesn't
fail but continue with the initialization if it doesn't get any regulators.

Regulator supply names has to be mapped in board files as 'ehciX' where
'X' can be {0, 1 ,2} depending on the ports.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 97ce7d5..c4391fb 100644
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
+	char supply[5];
 
 	if (!pdata) {
 		dev_dbg(&pdev->dev, "missing platform_data\n");
@@ -918,6 +926,19 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_tll_ioremap;
 	}
 
+	/* get ehci regulator and enable */
+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+			continue;
+		sprintf(supply, "ehci%d", i);
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
@@ -981,6 +1002,7 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
 	struct ehci_hcd_omap *omap = platform_get_drvdata(pdev);
 	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
+	int i;
 
 	if (omap->port_mode[0] != EHCI_HCD_OMAP_MODE_UNKNOWN)
 		device_remove_file(&pdev->dev, &dev_attr_port1);
@@ -992,6 +1014,15 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	usb_remove_hcd(hcd);
 	omap_stop_ehc(omap, hcd);
 	iounmap(hcd->regs);
+	for (i = 0 ; i < OMAP3_HS_USB_PORTS ; i++) {
+		if (omap->port_mode[i] == EHCI_HCD_OMAP_MODE_UNKNOWN)
+			continue;
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


=========================================================
