From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 02/23] usb: host: ehci: use dev_name
Date: Mon, 23 Feb 2009 20:55:14 +0200
Message-ID: <1235415335-17408-3-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42405 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754286AbZBWSzt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:55:49 -0500
In-Reply-To: <1235415335-17408-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

We should stop using bus_id to pass the device
name, dev_name() should be used instead.

Cleanup only.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 88ed500..3dd4a68 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -428,7 +428,8 @@ static int ehci_hcd_omap_drv_probe(struct platform_device *dev)
 		retval = -ENOMEM;
 	}
 
-	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev, dev->dev.bus_id);
+	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev,
+			dev_name(&dev->dev));
 	if (!hcd)
 		return -ENOMEM;
 
-- 
1.6.1.3

