From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 11/19] usb: host: omap: switch to platform_get_resource_byname
Date: Tue,  1 Mar 2011 17:15:32 +0200
Message-ID: <1298992540-5984-12-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298992540-5984-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

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
index d7e223b..1527721 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -947,7 +947,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	omap->ehci		= hcd_to_ehci(hcd);
 	omap->ehci->sbrn	= 0x20;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ehci");
 
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
@@ -963,7 +963,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	omap->ehci->caps = hcd->regs;
 	omap->ehci_base = hcd->regs;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "uhh");
 	omap->uhh_base = ioremap(res->start, resource_size(res));
 	if (!omap->uhh_base) {
 		dev_err(&pdev->dev, "UHH ioremap failed\n");
@@ -971,7 +971,7 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
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
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
