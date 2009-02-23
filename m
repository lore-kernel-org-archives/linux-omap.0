From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 04/23] usb: host: ehci: tabify structures
Date: Mon, 23 Feb 2009 20:55:16 +0200
Message-ID: <1235415335-17408-5-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42422 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbZBWSzx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:55:53 -0500
In-Reply-To: <1235415335-17408-4-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Style only, no functional changes.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   46 +++++++++++++++++++++---------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index a4f5f16..e050795 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -518,57 +518,57 @@ static int omap_ehci_bus_resume(struct usb_hcd *hcd)
 
 static const struct hc_driver ehci_omap_hc_driver = {
 	.description = hcd_name,
-	.product_desc = "OMAP-EHCI Host Controller",
-	.hcd_priv_size = sizeof(struct ehci_hcd)
+	.product_desc		= "OMAP-EHCI Host Controller",
+	.hcd_priv_size		= sizeof(struct ehci_hcd)
 				+ sizeof(struct ehci_omap_clock_defs),
 
 	/*
 	 * generic hardware linkage
 	 */
-	.irq = ehci_irq,
-	.flags = HCD_MEMORY | HCD_USB2,
+	.irq			= ehci_irq,
+	.flags			= HCD_MEMORY | HCD_USB2,
 
 	/*
 	 * basic lifecycle operations
 	 */
-	.reset = ehci_init,
-	.start = ehci_run,
-	.stop = ehci_stop,
-	.shutdown = ehci_shutdown,
+	.reset			= ehci_init,
+	.start			= ehci_run,
+	.stop			= ehci_stop,
+	.shutdown		= ehci_shutdown,
 
 	/*
 	 * managing i/o requests and associated device resources
 	 */
-	.urb_enqueue = ehci_urb_enqueue,
-	.urb_dequeue = ehci_urb_dequeue,
-	.endpoint_disable = ehci_endpoint_disable,
+	.urb_enqueue		= ehci_urb_enqueue,
+	.urb_dequeue		= ehci_urb_dequeue,
+	.endpoint_disable	= ehci_endpoint_disable,
 
 	/*
 	 * scheduling support
 	 */
-	.get_frame_number = ehci_get_frame,
+	.get_frame_number	= ehci_get_frame,
 
 	/*
 	 * root hub support
 	 */
-	.hub_status_data = ehci_hub_status_data,
-	.hub_control = ehci_hub_control,
+	.hub_status_data	= ehci_hub_status_data,
+	.hub_control		= ehci_hub_control,
 #ifdef	CONFIG_PM
-	.bus_suspend = omap_ehci_bus_suspend,
-	.bus_resume = omap_ehci_bus_resume,
+	.bus_suspend		= omap_ehci_bus_suspend,
+	.bus_resume		= omap_ehci_bus_resume,
 #endif
 };
 
 MODULE_ALIAS("platform:omap-ehci");
 
 static struct platform_driver ehci_hcd_omap_driver = {
-	.probe = ehci_hcd_omap_drv_probe,
-	.remove = ehci_hcd_omap_drv_remove,
-	.shutdown = usb_hcd_platform_shutdown,
-	/*.suspend      = ehci_hcd_omap_drv_suspend, */
-	/*.resume       = ehci_hcd_omap_drv_resume, */
+	.probe			= ehci_hcd_omap_drv_probe,
+	.remove			= ehci_hcd_omap_drv_remove,
+	.shutdown		= usb_hcd_platform_shutdown,
+	/*.suspend		= ehci_hcd_omap_drv_suspend, */
+	/*.resume		= ehci_hcd_omap_drv_resume, */
 	.driver = {
-		.name = "ehci-omap",
-		.bus = &platform_bus_type
+		.name		= "ehci-omap",
+		.bus		= &platform_bus_type
 	}
 };
-- 
1.6.1.3

