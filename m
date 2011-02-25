From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 02/10] usb: host: omap: switch to platform_get_resource_byname
Date: Sat, 26 Feb 2011 04:36:30 +0530
Message-ID: <1298675198-14214-3-git-send-email-keshava_mgowda@ti.com>
References: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41152 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932997Ab1BYXHI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 18:07:08 -0500
In-Reply-To: <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

From: Felipe Balbi <balbi@ti.com>

now that we have names on all memory bases, we can
switch to use platform_get_resource_byname() which
will make it simpler when we move to a setup where
OHCI and EHCI on OMAP play well together.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/host/ehci-omap.c  |    6 +++---
 drivers/usb/host/ohci-omap3.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f784ceb..37cf12b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -813,7 +813,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	omap->ehci		= hcd_to_ehci(hcd);
 	omap->ehci->sbrn	= 0x20;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ehci");
 
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
@@ -829,7 +829,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	omap->ehci->caps = hcd->regs;
 	omap->ehci_base = hcd->regs;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
 	omap->uhh_base = ioremap(res->start, resource_size(res));
 	if (!omap->uhh_base) {
 		dev_err(&pdev->dev, "UHH ioremap failed\n");
@@ -837,7 +837,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 		goto err_uhh_ioremap;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tll");
 	omap->tll_base = ioremap(res->start, resource_size(res));
 	if (!omap->tll_base) {
 		dev_err(&pdev->dev, "TLL ioremap failed\n");
diff --git a/drivers/usb/host/ohci-omap3.c b/drivers/usb/host/ohci-omap3.c
index a37d599..32f56bb 100644
--- a/drivers/usb/host/ohci-omap3.c
+++ b/drivers/usb/host/ohci-omap3.c
@@ -618,7 +618,7 @@ static int __devinit ohci_hcd_omap3_probe(struct platform_device *pdev)
 	omap->es2_compatibility	= pdata->es2_compatibility;
 	omap->ohci		= hcd_to_ohci(hcd);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ohci");
 
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
@@ -630,7 +630,7 @@ static int __devinit ohci_hcd_omap3_probe(struct platform_device *pdev)
 		goto err_ioremap;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
 	omap->uhh_base = ioremap(res->start, resource_size(res));
 	if (!omap->uhh_base) {
 		dev_err(&pdev->dev, "UHH ioremap failed\n");
@@ -638,7 +638,7 @@ static int __devinit ohci_hcd_omap3_probe(struct platform_device *pdev)
 		goto err_uhh_ioremap;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "tll");
 	omap->tll_base = ioremap(res->start, resource_size(res));
 	if (!omap->tll_base) {
 		dev_err(&pdev->dev, "TLL ioremap failed\n");
-- 
1.6.0.4

