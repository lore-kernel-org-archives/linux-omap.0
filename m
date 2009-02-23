From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 08/23] usb: host: ehci: reorganize structures
Date: Mon, 23 Feb 2009 20:52:36 +0200
Message-ID: <1235415171-17376-9-git-send-email-me@felipebalbi.com>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
 <1235415171-17376-2-git-send-email-me@felipebalbi.com>
 <1235415171-17376-3-git-send-email-me@felipebalbi.com>
 <1235415171-17376-4-git-send-email-me@felipebalbi.com>
 <1235415171-17376-5-git-send-email-me@felipebalbi.com>
 <1235415171-17376-6-git-send-email-me@felipebalbi.com>
 <1235415171-17376-7-git-send-email-me@felipebalbi.com>
 <1235415171-17376-8-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:46672 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513AbZBWSxc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:53:32 -0500
In-Reply-To: <1235415171-17376-8-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Felipe Balbi <me@felipebalbi.com>

Move the platform_driver closer to its functions.
No functional changes.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 1b387cc..e66f5f9 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -511,6 +511,18 @@ static int ehci_hcd_omap_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static struct platform_driver ehci_hcd_omap_driver = {
+	.probe			= ehci_hcd_omap_drv_probe,
+	.remove			= ehci_hcd_omap_drv_remove,
+	.shutdown		= usb_hcd_platform_shutdown,
+	/*.suspend		= ehci_hcd_omap_drv_suspend, */
+	/*.resume		= ehci_hcd_omap_drv_resume, */
+	.driver = {
+		.name		= "ehci-omap",
+		.bus		= &platform_bus_type
+	}
+};
+
 static const struct hc_driver ehci_omap_hc_driver = {
 	.description = hcd_name,
 	.product_desc		= "OMAP-EHCI Host Controller",
@@ -554,14 +566,3 @@ static const struct hc_driver ehci_omap_hc_driver = {
 
 MODULE_ALIAS("platform:omap-ehci");
 
-static struct platform_driver ehci_hcd_omap_driver = {
-	.probe			= ehci_hcd_omap_drv_probe,
-	.remove			= ehci_hcd_omap_drv_remove,
-	.shutdown		= usb_hcd_platform_shutdown,
-	/*.suspend		= ehci_hcd_omap_drv_suspend, */
-	/*.resume		= ehci_hcd_omap_drv_resume, */
-	.driver = {
-		.name		= "ehci-omap",
-		.bus		= &platform_bus_type
-	}
-};
-- 
1.6.1.3

