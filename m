From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v2 5/8] usb: ehci-omap: use clkdev aliases for functional clocks
Date: Mon, 29 Nov 2010 22:55:34 +0530
Message-ID: <1291051537-23743-6-git-send-email-gadiyar@ti.com>
References: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0K2RZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 12:25:49 -0500
In-Reply-To: <1291051537-23743-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Anand Gadiyar <gadiyar@ti.com>

Use the recently updated aliases to get functional clocks needed by
the driver. This allows the driver to acquire OMAP4-specific clocks
without having to use different clock names for OMAP3 and OMAP4.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 drivers/usb/host/ehci-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index d60efdc..7a4682c 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -287,14 +287,14 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 	}
 	clk_enable(omap->usbhost_ick);
 
-	omap->usbhost_hs_fck = clk_get(omap->dev, "usbhost_120m_fck");
+	omap->usbhost_hs_fck = clk_get(omap->dev, "hs_fck");
 	if (IS_ERR(omap->usbhost_hs_fck)) {
 		ret = PTR_ERR(omap->usbhost_hs_fck);
 		goto err_host_120m_fck;
 	}
 	clk_enable(omap->usbhost_hs_fck);
 
-	omap->usbhost_fs_fck = clk_get(omap->dev, "usbhost_48m_fck");
+	omap->usbhost_fs_fck = clk_get(omap->dev, "fs_fck");
 	if (IS_ERR(omap->usbhost_fs_fck)) {
 		ret = PTR_ERR(omap->usbhost_fs_fck);
 		goto err_host_48m_fck;
-- 
1.7.0.4

