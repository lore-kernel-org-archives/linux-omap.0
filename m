From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/2] usb: ehci-omap: fix Si version related programming
Date: Tue,  4 May 2010 13:15:23 +0530
Message-ID: <1272959123-31362-2-git-send-email-ajay.gupta@ti.com>
References: <1272959123-31362-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42495 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756532Ab0EDHpd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 May 2010 03:45:33 -0400
In-Reply-To: <1272959123-31362-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, felipe.balbi@nokia.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

AM3517 is based on ES3.1 thus ES2.x related programming is invalid
for it so updating ES2.x programming.

Also fixed below checkpatch warning:
WARNING: unnecessary whitespace before a quoted newline

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 drivers/usb/host/ehci-omap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index e55fd58..d5ff3e2 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -352,8 +352,8 @@ static int omap_start_ehc(struct ehci_hcd_omap *omap, struct usb_hcd *hcd)
 		reg &= ~OMAP_UHH_HOSTCONFIG_P3_CONNECT_STATUS;
 
 	/* Bypass the TLL module for PHY mode operation */
-	 if (omap_rev() <= OMAP3430_REV_ES2_1) {
-		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1 \n");
+	if (cpu_is_omap3430() && (omap_rev() <= OMAP3430_REV_ES2_1)) {
+		dev_dbg(omap->dev, "OMAP3 ES version <= ES2.1\n");
 		if ((omap->port_mode[0] == EHCI_HCD_OMAP_MODE_PHY) ||
 			(omap->port_mode[1] == EHCI_HCD_OMAP_MODE_PHY) ||
 				(omap->port_mode[2] == EHCI_HCD_OMAP_MODE_PHY))
-- 
1.6.2.4

