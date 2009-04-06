From: David Brownell <david-b@pacbell.net>
Subject: [patch omap-git] ehci-omap buildfix
Date: Mon, 6 Apr 2009 02:36:51 -0700
Message-ID: <200904060236.51534.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:37228 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752141AbZDFJgy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2009 05:36:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: OMAP <linux-omap@vger.kernel.org>

device.bus_id doesn't exist any more

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/usb/host/ehci-omap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -432,7 +432,8 @@ static int ehci_hcd_omap_drv_probe(struc
 		retval = -ENOMEM;
 	}
 
-	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev, dev->dev.bus_id);
+	hcd = usb_create_hcd(&ehci_omap_hc_driver, &dev->dev,
+			dev_name(&dev->dev));
 	if (!hcd)
 		return -ENOMEM;
 
