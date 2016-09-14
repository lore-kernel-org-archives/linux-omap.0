From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCHv3] usb: musb: Fix unbalanced platform_disable
Date: Wed, 14 Sep 2016 11:10:19 -0700
Message-ID: <20160914181019.22937-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
the initial call to musb_platform_disable. To do that in a safe way,
we need to call the glue specific *_musb_disable() directly in the
glue layer *_musb_init() as noted by Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>.

AFAIK the initial musb_platform_disable call has always been just an
attempted workaround for the 2430 glue layer announcing itself too
early before the gadgets are configured. And that issue finally
got fixed with commit a118df07f5b1 ("usb: musb: Don't set d+ high
before enable for 2430 glue layer").

Further, most of the glue layers already do a reset of the musb
controller in the *_musb_init(), so later on we may want to
consider removing the calls to *__musb_disable() where a reset is
already done.

Note that we now also need to fix the twl4030-phy accordingly making
it's PM runtime call only needed in twl4030_phy_power_on and have it
autosuspend. The cable state will keep the phy active when connected.

Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

I've kept the 2430 glue layer related acks as those parts did
not change. For the glue layers doing things in *_musb_disable(),
I've tested da8xx, am35x and musb_dsps glue layers.

Changes since v2:

- Added glue layer calls to *_musb_disable() from *_musb_init()
  where needed as suggested by Bin

---
 drivers/phy/phy-twl4030-usb.c | 4 ++--
 drivers/usb/musb/am35x.c      | 1 +
 drivers/usb/musb/da8xx.c      | 1 +
 drivers/usb/musb/davinci.c    | 1 +
 drivers/usb/musb/musb_core.c  | 1 -
 drivers/usb/musb/musb_dsps.c  | 1 +
 drivers/usb/musb/sunxi.c      | 3 +++
 drivers/usb/musb/tusb6010.c   | 1 +
 8 files changed, 10 insertions(+), 3 deletions(-)

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
diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -381,6 +381,7 @@ static int am35x_musb_init(struct musb *musb)
 
 	msleep(5);
 
+	am35x_musb_disable(musb);
 	musb->isr = am35x_musb_interrupt;
 
 	/* clear level interrupt */
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -440,6 +440,7 @@ static int da8xx_musb_init(struct musb *musb)
 		 rev, __raw_readl(CFGCHIP2),
 		 musb_readb(reg_base, DA8XX_USB_CTRL_REG));
 
+	da8xx_musb_disable(musb);
 	musb->isr = da8xx_musb_interrupt;
 	return 0;
 fail:
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -432,6 +432,7 @@ static int davinci_musb_init(struct musb *musb)
 		revision, __raw_readl(USB_PHY_CTRL),
 		musb_readb(tibase, DAVINCI_USB_CTRL_REG));
 
+	davinci_musb_disable(musb);
 	musb->isr = davinci_musb_interrupt;
 	return 0;
 
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 74fc306..f7dc3df 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2142,7 +2142,6 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	}
 
 	/* be sure interrupts are disabled before connecting ISR */
-	musb_platform_disable(musb);
 	musb_generic_disable(musb);
 
 	/* Init IRQ workqueue before request_irq */
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -441,6 +441,7 @@ static int dsps_musb_init(struct musb *musb)
 	/* Reset the musb */
 	musb_writel(reg_base, wrp->control, (1 << wrp->reset));
 
+	dsps_musb_disable(musb);
 	musb->isr = dsps_interrupt;
 
 	/* reset the otgdisable bit, needed for host mode to work */
diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -93,6 +93,8 @@ struct sunxi_glue {
 	struct notifier_block	host_nb;
 };
 
+static void sunxi_musb_disable(struct musb *musb);
+
 /* phy_power_on / off may sleep, so we use a workqueue  */
 static void sunxi_musb_work(struct work_struct *work)
 {
@@ -265,6 +267,7 @@ static int sunxi_musb_init(struct musb *musb)
 	if (ret)
 		goto error_unregister_notifier;
 
+	sunxi_musb_disable(musb);
 	musb->isr = sunxi_musb_interrupt;
 
 	/* Stop the musb-core from doing runtime pm (not supported on sunxi) */
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1149,6 +1149,7 @@ static int tusb_musb_init(struct musb *musb)
 				ret);
 		goto done;
 	}
+	tusb_musb_disable(musb);
 	musb->isr = tusb_musb_interrupt;
 
 	musb->xceiv->set_power = tusb_draw_power;
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
