From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH] ehci: fix missing kfree in remove path also
Date: Wed, 16 Dec 2009 19:06:10 +0530
Message-ID: <1260970570-28536-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48688 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933801AbZLPNgS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 08:36:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Added missing kfree() in ehci_hcd_omap_remove().

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 74d07f4..2460f0d 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -681,6 +681,7 @@ static int ehci_hcd_omap_remove(struct platform_device *pdev)
 	iounmap(omap->tll_base);
 	iounmap(omap->uhh_base);
 	usb_put_hcd(hcd);
+	kfree(omap);
 
 	return 0;
 }
-- 
1.6.2.4

