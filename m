From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 06/23] usb: host: ehci: sanitize error path
Date: Mon, 23 Feb 2009 20:55:18 +0200
Message-ID: <1235415335-17408-7-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42441 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754793AbZBWSz5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:55:57 -0500
In-Reply-To: <1235415335-17408-6-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

This patch:
	- sanitizes error path in ehci_hcd_omap_drv_probe();
	- removes two unnecessary debugging messages, we only need
	  debugging in the failing case generally;
	- fix a memory leak when omap_start_ehc() fails: the recently
	  created hcd was never put in that case;

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   53 +++++++++++++++++++++++++----------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index d994392..db4576d 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -418,21 +418,24 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
 	struct usb_hcd *hcd;
 
 	int irq = platform_get_irq(pdev, 0);
-	int retval = 0;
-
-	dev_dbg(&pdev->dev, "ehci_hcd_omap_drv_probe()\n");
+	int ret = -ENODEV;
 
 	if (usb_disabled())
-		return -ENODEV;
+		goto err_disabled;
 
 	hcd = usb_create_hcd(&ehci_omap_hc_driver, &pdev->dev,
 			dev_name(&pdev->dev));
-	if (!hcd)
-		return -ENOMEM;
+	if (!hcd) {
+		dev_dbg(&pdev->dev, "failed to create hcd with err %d\n", ret);
+		ret = -ENOMEM;
+		goto err_create_hcd;
+	}
 
-	retval = omap_start_ehc(pdev, hcd);
-	if (retval)
-		return retval;
+	ret = omap_start_ehc(pdev, hcd);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to start ehci\n");
+		goto err_start;
+	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
@@ -444,12 +447,12 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 	if (!hcd->regs) {
 		dev_err(&pdev->dev, "ioremap failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_ioremap;
 	}
 
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = hcd->regs;
-
 	ehci->sbrn = 0x20;
 
 	ehci->regs = hcd->regs + HC_LENGTH(readl(&ehci->caps->hc_capbase));
@@ -459,16 +462,26 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
 	/* SET 1 micro-frame Interrupt interval */
 	writel(readl(&ehci->regs->command) | (1 << 16), &ehci->regs->command);
 
-	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
-	if (retval == 0)
-		return retval;
+	ret = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
+	if (ret) {
+		dev_dbg(&pdev->dev, "failed to add hcd with err %d\n", ret);
+		goto err_add_hcd;
+	}
 
-	dev_dbg(&pdev->dev, "ERR: add_hcd\n");
-	omap_stop_ehc(pdev, hcd);
+	return 0;
+
+err_add_hcd:
 	iounmap(hcd->regs);
+
+err_ioremap:
+	omap_stop_ehc(pdev, hcd);
+
+err_start:
 	usb_put_hcd(hcd);
 
-	return retval;
+err_create_hcd:
+err_disabled:
+	return ret;
 }
 
 /*-------------------------------------------------------------------------*/
@@ -490,12 +503,10 @@ static int ehci_hcd_omap_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
-	dev_dbg(&pdev->dev, "ehci_hcd_omap_drv_remove()\n");
-
-	iounmap(hcd->regs);
 	usb_remove_hcd(hcd);
-	usb_put_hcd(hcd);
+	iounmap(hcd->regs);
 	omap_stop_ehc(pdev, hcd);
+	usb_put_hcd(hcd);
 
 	return 0;
 }
-- 
1.6.1.3

