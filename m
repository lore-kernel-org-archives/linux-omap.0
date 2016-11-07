From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/4] phy: twl4030-usb: Fix for musb session bit based PM
Date: Mon,  7 Nov 2016 14:50:20 -0700
Message-ID: <20161107215020.31399-5-tony@atomide.com>
References: <20161107215020.31399-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161107215020.31399-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Now with musb driver implementing generic session bit based
PM, we need to have the USB PHYs behaving in a sane way for
platforms implementing PM.

Currently twl4030-usb enables PM in twl4030_phy_power_on()
and then disables it in twl4030_phy_power_off(). This will
block PM runtime for the SoC when no cable is connected.

Fix the issue by moving PM runtime autosuspend call to
happen where it gets called in twl4030_phy_power_on().

Note that this patch should not be backported to anything
before commit 467d5c980709 ("usb: musb: Implement session bit
based runtime PM for musb-core") as before that all the
glue layers implemented their own PM.

Fixes: 467d5c980709 ("usb: musb: Implement session bit based
runtime PM for musb-core")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/phy/phy-twl4030-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -459,8 +459,6 @@ static int twl4030_phy_power_off(struct phy *phy)
 	struct twl4030_usb *twl = phy_get_drvdata(phy);
 
 	dev_dbg(twl->dev, "%s\n", __func__);
-	pm_runtime_mark_last_busy(twl->dev);
-	pm_runtime_put_autosuspend(twl->dev);
 
 	return 0;
 }
@@ -472,6 +470,8 @@ static int twl4030_phy_power_on(struct phy *phy)
 	dev_dbg(twl->dev, "%s\n", __func__);
 	pm_runtime_get_sync(twl->dev);
 	schedule_delayed_work(&twl->id_workaround_work, HZ);
+	pm_runtime_mark_last_busy(twl->dev);
+	pm_runtime_put_autosuspend(twl->dev);
 
 	return 0;
 }
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
