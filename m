From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 07/23] usb: host: ehci: get rid of pm functions
Date: Mon, 23 Feb 2009 20:55:19 +0200
Message-ID: <1235415335-17408-8-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42446 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbZBWSz6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:55:58 -0500
In-Reply-To: <1235415335-17408-7-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

That was just a useless function call, completely
unneeded. Remove it.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |   20 ++------------------
 1 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index db4576d..1b387cc 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -511,20 +511,6 @@ static int ehci_hcd_omap_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/*-------------------------------------------------------------------------*/
-#ifdef CONFIG_PM
-static int omap_ehci_bus_suspend(struct usb_hcd *hcd)
-{
-	return ehci_bus_suspend(hcd);
-}
-
-static int omap_ehci_bus_resume(struct usb_hcd *hcd)
-{
-	return ehci_bus_resume(hcd);
-}
-#endif
-/*-------------------------------------------------------------------------*/
-
 static const struct hc_driver ehci_omap_hc_driver = {
 	.description = hcd_name,
 	.product_desc		= "OMAP-EHCI Host Controller",
@@ -562,10 +548,8 @@ static const struct hc_driver ehci_omap_hc_driver = {
 	 */
 	.hub_status_data	= ehci_hub_status_data,
 	.hub_control		= ehci_hub_control,
-#ifdef	CONFIG_PM
-	.bus_suspend		= omap_ehci_bus_suspend,
-	.bus_resume		= omap_ehci_bus_resume,
-#endif
+	.bus_suspend		= ehci_bus_suspend,
+	.bus_resume		= ehci_bus_resume,
 };
 
 MODULE_ALIAS("platform:omap-ehci");
-- 
1.6.1.3

