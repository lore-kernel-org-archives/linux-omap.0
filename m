From: Rick Bronson <rick@efn.org>
Subject: RE: Mistral AM37x (with AM3715) devel board networking broken
Date: Thu, 11 Nov 2010 12:10:32 -0800
Message-ID: <E1PGdTc-0002PY-Rp@amazonia.comcast.net>
References: <B85A65D85D7EB246BE421B3FB0FBB5930234992A00@dbde02.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from efn.org ([206.192.230.249]:44509 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107Ab0KKUKd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Nov 2010 15:10:33 -0500
In-reply-to: <B85A65D85D7EB246BE421B3FB0FBB5930234992A00@dbde02.ent.ti.com>
	(premi@ti.com)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: premi@ti.com

Hi,

  I've found the problem and below is the fix.  It appears your
SMSC9200 is faster than mine ;-)  Once in a while mine gets through the
smsc911x_soft_reset() in 100 us but most of the time it takes a full
250 ms.

  Rick

--- linux/drivers/net/smsc911x.c.~1~	2010-11-08 19:53:03.000000000 -0800
+++ linux/drivers/net/smsc911x.c	2010-11-11 12:00:18.000000000 -0800
@@ -791,8 +791,8 @@
 		return -ENODEV;
 	}
 
-	SMSC_TRACE(PROBE, "PHY %d: addr %d, phy_id 0x%08X",
-			phy_addr, phydev->addr, phydev->phy_id);
+	SMSC_TRACE(PROBE, "PHY %s: addr %d, phy_id 0x%08X",
+			dev_name(&phydev->dev), phydev->addr, phydev->phy_id);
 
 	ret = phy_connect_direct(dev, phydev,
 			&smsc911x_phy_adjust_link, 0,
@@ -1124,11 +1124,11 @@
 
 	/* Reset the LAN911x */
 	smsc911x_reg_write(pdata, HW_CFG, HW_CFG_SRST_);
-	timeout = 10;
-	do {
-		udelay(10);
-		temp = smsc911x_reg_read(pdata, HW_CFG);
-	} while ((--timeout) && (temp & HW_CFG_SRST_));
+	timeout = 10000;  /* this can take up to 1/4 sec */
+	while ((smsc911x_reg_read(pdata, HW_CFG) & HW_CFG_SRST_) && timeout) {
+		udelay(100);
+		timeout--;
+	}
 
 	if (unlikely(temp & HW_CFG_SRST_)) {
 		SMSC_WARNING(DRV, "Failed to complete reset");
