From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 03/23] usb: host: ehci: standardize variables
Date: Mon, 23 Feb 2009 20:52:31 +0200
Message-ID: <1235415171-17376-4-git-send-email-me@felipebalbi.com>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
 <1235415171-17376-2-git-send-email-me@felipebalbi.com>
 <1235415171-17376-3-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46627 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474AbZBWSxV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:53:21 -0500
In-Reply-To: <1235415171-17376-3-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Felipe Balbi <me@felipebalbi.com>

Style only, normally we use pdev as the platform_device's
pointer name.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 3dd4a68..a4f5f16 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -412,39 +412,39 @@ static const struct hc_driver ehci_omap_hc_driver;
  * through the hotplug entry's driver_data.
  *
  */
-static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
+static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
 {
 	int retval = 0;
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
 
-	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_probe()\n");
+	dev_dbg(&pdev->dev, "ehci_hcd_omap_drv_probe()\n");
 
 	if (usb_disabled())
 		return -ENODEV;
 
-	if (dev->resource[1].flags != IORESOURCE_IRQ) {
-		dev_dbg(&dev->dev, "resource[1] is not IORESOURCE_IRQ\n");
+	if (pdev->resource[1].flags != IORESOURCE_IRQ) {
+		dev_dbg(&pdev->dev, "resource[1] is not IORESOURCE_IRQ\n");
 		retval = -ENOMEM;
 	}
 
-	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev,
-			dev_name(&dev->dev));
+	hcd = usb_create_hcd(&ehci_omap_hc_driver, &pdev->dev,
+			dev_name(&pdev->dev));
 	if (!hcd)
 		return -ENOMEM;
 
-	retval = omap_start_ehc(dev, hcd);
+	retval = omap_start_ehc(pdev, hcd);
 	if (retval)
 		return retval;
 
 	hcd->rsrc_start = 0;
 	hcd->rsrc_len = 0;
-	hcd->rsrc_start = dev->resource[0].start;
-	hcd->rsrc_len = dev->resource[0].end - dev->resource[0].start + 1;
+	hcd->rsrc_start = pdev->resource[0].start;
+	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
 
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
-		dev_err(&dev->dev, "ioremap failed\n");
+		dev_err(&pdev->dev, "ioremap failed\n");
 		return -ENOMEM;
 	}
 
@@ -460,13 +460,13 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
 	/* SET 1 micro-frame Interrupt interval */
 	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start,
+	retval = usb_add_hcd(hcd, pdev->resource[1].start,
 				IRQF_DISABLED | IRQF_SHARED);
 	if (retval == 0)
 		return retval;
 
-	dev_dbg(hcd->self.controller, "ERR: add_hcd\n");
-	omap_stop_ehc(dev, hcd);
+	dev_dbg(&pdev->dev, "ERR: add_hcd\n");
+	omap_stop_ehc(pdev, hcd);
 	iounmap(hcd->regs);
 	usb_put_hcd(hcd);
 
@@ -480,7 +480,7 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
 
 /**
  * ehci_hcd_omap_drv_remove - shutdown processing for EHCI HCDs
- * @dev: USB Host Controller being removed
+ * @pdev: USB Host Controller being removed
  * Context: !in_interrupt()
  *
  * Reverses the effect of usb_ehci_hcd_omap_probe(), first invoking
@@ -488,16 +488,16 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
  * context, normally "rmmod", "apmd", or something similar.
  *
  */
-static int ehci_hcd_omap_drv_remove(struct platform_device *dev)
+static int ehci_hcd_omap_drv_remove(struct platform_device *pdev)
 {
-	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
-	dev_dbg(&dev->dev, "ehci_hcd_omap_drv_remove()\n");
+	dev_dbg(&pdev->dev, "ehci_hcd_omap_drv_remove()\n");
 
 	iounmap(hcd->regs);
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
-	omap_stop_ehc(dev, hcd);
+	omap_stop_ehc(pdev, hcd);
 
 	return 0;
 }
-- 
1.6.1.3

