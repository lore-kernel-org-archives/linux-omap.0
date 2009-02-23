From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 09/23] usb: host: ehci: better function names
Date: Mon, 23 Feb 2009 20:55:21 +0200
Message-ID: <1235415335-17408-10-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42461 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862AbZBWS4C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:56:02 -0500
In-Reply-To: <1235415335-17408-9-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

The "drv" in the function names was there just to make
it bigger, remove it so we have 4 characters smaller
lines. Also remove the platform_bus_type from platform_driver
since platform_driver_register() already does that.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e66f5f9..f5ffc5b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -404,14 +404,13 @@ static const struct hc_driver ehci_omap_hc_driver;
 /* always called with process context; sleeping is OK */
 
 /**
- * ehci_hcd_omap_drv_probe - initialize TI-based HCDs
- * Context: !in_interrupt()
+ * ehci_hcd_omap_probe - initialize TI-based HCDs
  *
  * Allocates basic resources for this USB host controller, and
  * then invokes the start() method for the HCD associated with it
  * through the hotplug entry's driver_data.
  */
-static int ehci_hcd_omap_drv_probe(struct platform_device *pdev)
+static int ehci_hcd_omap_probe(struct platform_device *pdev)
 {
 	struct ehci_hcd *ehci;
 	struct resource *res;
@@ -484,22 +483,18 @@ err_disabled:
 	return ret;
 }
 
-/*-------------------------------------------------------------------------*/
-
 /* may be called without controller electrically present */
 /* may be called with controller, bus, and devices active */
 
 /**
- * ehci_hcd_omap_drv_remove - shutdown processing for EHCI HCDs
+ * ehci_hcd_omap_remove - shutdown processing for EHCI HCDs
  * @pdev: USB Host Controller being removed
- * Context: !in_interrupt()
  *
  * Reverses the effect of usb_ehci_hcd_omap_probe(), first invoking
  * the HCD's stop() method.  It is always called from a thread
  * context, normally "rmmod", "apmd", or something similar.
- *
  */
-static int ehci_hcd_omap_drv_remove(struct platform_device *pdev)
+static int ehci_hcd_omap_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 
@@ -512,17 +507,18 @@ static int ehci_hcd_omap_drv_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver ehci_hcd_omap_driver = {
-	.probe			= ehci_hcd_omap_drv_probe,
-	.remove			= ehci_hcd_omap_drv_remove,
+	.probe			= ehci_hcd_omap_probe,
+	.remove			= ehci_hcd_omap_remove,
 	.shutdown		= usb_hcd_platform_shutdown,
-	/*.suspend		= ehci_hcd_omap_drv_suspend, */
-	/*.resume		= ehci_hcd_omap_drv_resume, */
+	/*.suspend		= ehci_hcd_omap_suspend, */
+	/*.resume		= ehci_hcd_omap_resume, */
 	.driver = {
 		.name		= "ehci-omap",
-		.bus		= &platform_bus_type
 	}
 };
 
+/*-------------------------------------------------------------------------*/
+
 static const struct hc_driver ehci_omap_hc_driver = {
 	.description = hcd_name,
 	.product_desc		= "OMAP-EHCI Host Controller",
-- 
1.6.1.3

