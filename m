From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Mon, 12 Sep 2016 08:39:49 -0700
Message-ID: <20160912153947.k4gnggur6usyujii@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
for 2430 glue layer") moved PHY enable/disable calls to happen from
omap2430_musb_enable/disable(). That broke enumeration for several
devices as PM runtime in the PHY will never enable it.

The root cause of the problem is unpaired calls from musb_core.c to
musb_platform_enable/disable in musb_core.c as reported by
Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>.

As musb_platform_enable/disable are being called from various functions,
let's not attempt to make them paiered immediately. This would require
fixing all the callers like musb_remove.

Instead, let's first fix the regression in a minimal way by removing
the initial call to musb_platform_disable.

AFAIK the initial musb_platform_disable call has always been just an
attempted workaround for the 2430 glue layer announcing itself too
early before the gadgets are configured. And that issue finally
got fixed with commit a118df07f5b1 ("usb: musb: Don't set d+ high
before enable for 2430 glue layer").

We now also need to fix the twl4030-phy accordingly making it's
PM runtime call only needed in twl4030_phy_power_on and have it
autosuspend. The cable state will keep the phy active when connected.

Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Fixes: a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
for 2430 glue layer")
Reported-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Acked-by: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Reported-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---

Changes since v1: Updated description

This is needed as a regression fix for the v4.8-rc cycle please.

---
 drivers/phy/phy-twl4030-usb.c | 4 ++--
 drivers/usb/musb/musb_core.c  | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -447,8 +447,6 @@ static int twl4030_phy_power_off(struct phy *phy)
 	struct twl4030_usb *twl = phy_get_drvdata(phy);
 
 	dev_dbg(twl->dev, "%s\n", __func__);
-	pm_runtime_mark_last_busy(twl->dev);
-	pm_runtime_put_autosuspend(twl->dev);
 
 	return 0;
 }
@@ -465,6 +463,8 @@ static int twl4030_phy_power_on(struct phy *phy)
 		twl4030_i2c_access(twl, 0);
 	twl->linkstat = MUSB_UNKNOWN;
 	schedule_delayed_work(&twl->id_workaround_work, HZ);
+	pm_runtime_mark_last_busy(twl->dev);
+	pm_runtime_put_autosuspend(twl->dev);
 
 	return 0;
 }
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2142,7 +2142,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	}
 
 	/* be sure interrupts are disabled before connecting ISR */
-	musb_platform_disable(musb);
 	musb_generic_disable(musb);
 
 	/* Init IRQ workqueue before request_irq */
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
