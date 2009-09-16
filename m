From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] EHCI USB: Don't use generic shutdown function
Date: Tue, 15 Sep 2009 19:10:55 -0500
Message-ID: <20090916001055.GA2449@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lixom.net ([66.141.50.11]:36257 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753358AbZIOXz4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Sep 2009 19:55:56 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <me@felipebalbi.com>, Tony Lindgren <tony@atomide.com>

The OMAP EHCI glue code has a layer of driver state struct between
the platform_device and usb_hcd. So it can't use the generic
usb_hcd_platform_shutdown.

This fixes a panic at reboot time.


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 8f8f022..bca3f0c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -701,10 +701,19 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void ehci_hcd_omap_shutdown(struct platform_device *pdev)
+{
+	struct ehci_hcd_omap *omap = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = ehci_to_hcd(omap->ehci);
+
+	if (hcd->driver->shutdown)
+		hcd->driver->shutdown(hcd);
+}
+
 static struct platform_driver ehci_hcd_omap_driver = {
 	.probe			= ehci_hcd_omap_probe,
 	.remove			= ehci_hcd_omap_remove,
-	.shutdown		= usb_hcd_platform_shutdown,
+	.shutdown		= ehci_hcd_omap_shutdown,
 	/*.suspend		= ehci_hcd_omap_suspend, */
 	/*.resume		= ehci_hcd_omap_resume, */
 	.driver = {
