From: NeilBrown <neil@brown.name>
Subject: [PATCH 2/6] phy: twl4030-usb: remove pointless 'suspended' test in
 'suspend' callback.
Date: Thu, 16 Apr 2015 18:03:04 +1000
Message-ID: <20150416080304.23307.25251.stgit@notabene.brown>
References: <20150416075945.23307.24424.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41565 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933574AbbDPIFG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Apr 2015 04:05:06 -0400
In-Reply-To: <20150416075945.23307.24424.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, GTA04 owners <gta04-owner@goldelico.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

When the runtime_suspend callback is running, 'runtime_status'
is always RPM_SUSPENDING, so pm_runtime_suspended() will always
fail.
Similarly while the runtime_resume callback is running
'runtime_status' is RPM_RESUMING, so pm_runtime_active() will
always fail.

So remove these two pointless tests.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/phy/phy-twl4030-usb.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 3078f80bf520..590c2b1c1a94 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -396,8 +396,6 @@ static int twl4030_usb_runtime_suspend(struct device *dev)
 	struct twl4030_usb *twl = dev_get_drvdata(dev);
 
 	dev_dbg(twl->dev, "%s\n", __func__);
-	if (pm_runtime_suspended(dev))
-		return 0;
 
 	__twl4030_phy_power(twl, 0);
 	regulator_disable(twl->usb1v5);
@@ -413,8 +411,6 @@ static int twl4030_usb_runtime_resume(struct device *dev)
 	int res;
 
 	dev_dbg(twl->dev, "%s\n", __func__);
-	if (pm_runtime_active(dev))
-		return 0;
 
 	res = regulator_enable(twl->usb3v1);
 	if (res)


