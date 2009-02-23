From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 05/23] usb: host: ehci: use resource helpers
Date: Mon, 23 Feb 2009 20:55:17 +0200
Message-ID: <1235415335-17408-6-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42436 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbZBWSzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:55:55 -0500
In-Reply-To: <1235415335-17408-5-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Don't access pdev->resource[n].start directly, we
can use the resource helpers for that, makes the
code more readable.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   22 ++++++++++------------
 1 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e050795..d994392 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -410,24 +410,21 @@ static const struct hc_driver ehci_omap_hc_driver;
  * Allocates basic resources for this USB host controller, and
  * then invokes the start() method for the HCD associated with it
  * through the hotplug entry's driver_data.
- *
  */
 static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
 {
-	int retval = 0;
-	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
+	struct resource *res;
+	struct usb_hcd *hcd;
+
+	int irq = platform_get_irq(pdev, 0);
+	int retval = 0;
 
 	dev_dbg(&pdev->dev, "ehci_hcd_omap_drv_probe()\n");
 
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
-		dev_dbg(&pdev->dev, "resource[1] is not IORESOURCE_IRQ\n");
-		retval = -ENOMEM;
-	}
-
 	hcd = usb_create_hcd(&ehci_omap_hc_driver, &pdev->dev,
 			dev_name(&pdev->dev));
 	if (!hcd)
@@ -437,10 +434,12 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
 	if (retval)
 		return retval;
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
 	hcd->rsrc_start = 0;
 	hcd->rsrc_len = 0;
-	hcd->rsrc_start = pdev->resource[0].start;
-	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
 
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
@@ -460,8 +459,7 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
 	/* SET 1 micro-frame Interrupt interval */
 	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
 
-	retval = usb_add_hcd(hcd, pdev->resource[1].start,
-				IRQF_DISABLED | IRQF_SHARED);
+	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
 	if (retval == 0)
 		return retval;
 
-- 
1.6.1.3

