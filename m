From: Anand Gadiyar <gadiyar@ti.com>
Subject: omap3: ehci: trivial fix of a debug print
Date: Mon, 12 Oct 2009 22:50:20 +0530
Message-ID: <1255368020-23659-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41514 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757149AbZJLRVC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 13:21:02 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9CHKN9k001372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 12:20:25 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>

omap3: ehci: trivial fix of a debug print

We're interested in uhh_hostconfig, not uhh_base. While we
are actually printing the former, we're calling it the latter.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 45b8a7c..73f0b3b 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -363,7 +363,7 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 
 	}
 	ehci_omap_writel(omap->uhh_base, OMAP_UHH_HOSTCONFIG, reg);
-	dev_dbg(omap->dev, "UHH setup done, uhh_base=%x\n", reg);
+	dev_dbg(omap->dev, "UHH setup done, uhh_hostconfig=%x\n", reg);
 
 
 	if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_TLL) ||
