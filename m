From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/4] ehci: fix kernel panic in ehci_probe
Date: Tue, 22 Sep 2009 18:42:11 +0530
Message-ID: <1253625132-15050-3-git-send-email-ajay.gupta@ti.com>
References: <1253625132-15050-1-git-send-email-ajay.gupta@ti.com>
 <1253625132-15050-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44007 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756537AbZIVNMf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Sep 2009 09:12:35 -0400
In-Reply-To: <1253625132-15050-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

hcd_priv_size has to be sizeof(struct ehci_hcd).

-       .hcd_priv_size          = sizeof(struct ehci_hcd_omap),
+       .hcd_priv_size          = sizeof(struct ehci_hcd),

Without this kernel panic is observed in probe function.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index f77a99d..a10ecd9 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -748,7 +748,7 @@ static struct platform_driver ehci_hcd_omap_driver = {
 static const struct hc_driver ehci_omap_hc_driver = {
 	.description		= hcd_name,
 	.product_desc		= "OMAP-EHCI Host Controller",
-	.hcd_priv_size		= sizeof(struct ehci_hcd_omap),
+	.hcd_priv_size		= sizeof(struct ehci_hcd),
 
 	/*
 	 * generic hardware linkage
-- 
1.6.2.4

