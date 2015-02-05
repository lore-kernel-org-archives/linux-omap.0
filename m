From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] usb: musb: Fix getting a generic phy for musb_dsps
Date: Thu,  5 Feb 2015 08:35:13 -0800
Message-ID: <1423154113-23463-3-git-send-email-tony@atomide.com>
References: <1423154113-23463-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp6.ore.mailhop.org ([54.149.35.133]:56863 "EHLO
	smtp6.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757733AbbBEQiP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Feb 2015 11:38:15 -0500
In-Reply-To: <1423154113-23463-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>

We still have a combination of legacy phys and generic phys in
use so we need to support both types of phy for musb_dsps.c.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_dsps.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -457,12 +457,25 @@ static int dsps_musb_init(struct musb *musb)
 	if (IS_ERR(musb->xceiv))
 		return PTR_ERR(musb->xceiv);
 
+	musb->phy = devm_phy_get(dev->parent, "usb2-phy");
+
 	/* Returns zero if e.g. not clocked */
 	rev = dsps_readl(reg_base, wrp->revision);
 	if (!rev)
 		return -ENODEV;
 
 	usb_phy_init(musb->xceiv);
+	if (IS_ERR(musb->phy))  {
+		musb->phy = NULL;
+	} else {
+		ret = phy_init(musb->phy);
+		if (ret < 0)
+			return ret;
+		ret = phy_power_on(musb->phy);
+		if (ret)
+			return ret;
+	}
+
 	setup_timer(&glue->timer, otg_timer, (unsigned long) musb);
 
 	/* Reset the musb */
@@ -502,6 +515,10 @@ static int dsps_musb_exit(struct musb *musb)
 
 	del_timer_sync(&glue->timer);
 	usb_phy_shutdown(musb->xceiv);
+	if (musb->phy) {
+		phy_power_off(musb->phy);
+		phy_exit(musb->phy);
+	}
 	debugfs_remove_recursive(glue->dbgfs_root);
 
 	return 0;
-- 
2.1.4

