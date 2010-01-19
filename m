From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 14/16] usb: host: ehci: fix missing kfree in remove path also
Date: Tue, 19 Jan 2010 15:14:13 +0200
Message-ID: <1263906855-28341-15-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27322 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab0ASNO7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:59 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Added missing kfree() in ehci_hcd_omap_remove().

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
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
1.6.6.rc0

