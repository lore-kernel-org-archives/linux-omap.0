From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 02/10 v1] usb: host: omap: switch to platform_get_resource_byname
Date: Mon, 28 Feb 2011 22:01:44 +0530
Message-ID: <1298910712-2051-3-git-send-email-keshava_mgowda@ti.com>
References: <1298910712-2051-1-git-send-email-keshava_mgowda@ti.com>
 <1298910712-2051-2-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298910712-2051-2-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

now that we have names on all memory bases, we can
switch to use platform_get_resource_byname() which
will make it simpler when we move to a setup where
OHCI and EHCI on OMAP play well together.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
