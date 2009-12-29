From: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Subject: [patch-v2.6.34 7/9] usb: musb: use only clk framework for clk handling
Date: Wed, 30 Dec 2009 00:59:25 +0200
Message-ID: <1262127567-15202-8-git-send-email-felipe.balbi@nokia.com>
References: <1262127567-15202-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1262127567-15202-1-git-send-email-felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

get rid of the set_clock hackery.

Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
---

Greg, I'll send this patch to you shortly, it's
only here so that Tony can have it in linux-omap-2.6
to avoid breaking any of his boards.

 drivers/usb/musb/musb_core.c |   48 ++++++++++++++----------------------------
 drivers/usb/musb/musb_core.h |    2 -
 drivers/usb/musb/omap2430.c  |   10 +-------
 drivers/usb/musb/tusb6010.c  |   16 +++++--------
 include/linux/usb/musb.h     |    4 +-
 5 files changed, 26 insertions(+), 54 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5eb9318..37ca87d 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -977,10 +977,8 @@ static void musb_shutdown(struct platform_device *pdev)
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_platform_disable(musb);
 	musb_generic_disable(musb);
-	if (musb->clock) {
-		clk_put(musb->clock);
-		musb->clock = NULL;
-	}
+	clk_put(musb->clock);
+	musb->clock = NULL;
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	/* FIXME power down */
@@ -1864,10 +1862,8 @@ static void musb_free(struct musb *musb)
 	musb_platform_exit(musb);
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 
-	if (musb->clock) {
-		clk_disable(musb->clock);
-		clk_put(musb->clock);
-	}
+	clk_disable(musb->clock);
+	clk_put(musb->clock);
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	usb_put_hcd(musb_to_hcd(musb));
@@ -1930,7 +1926,6 @@ bad_config:
 	spin_lock_init(&musb->lock);
 	musb->board_mode = plat->mode;
 	musb->board_set_power = plat->set_power;
-	musb->set_clock = plat->set_clock;
 	musb->min_power = plat->min_power;
 
 	/* Clock usage is chip-specific ... functional clock (DaVinci,
@@ -1938,15 +1933,17 @@ bad_config:
 	 * code does is make sure a clock handle is available; platform
 	 * code manages it during start/stop and suspend/resume.
 	 */
-	if (plat->clock) {
-		musb->clock = clk_get(dev, plat->clock);
-		if (IS_ERR(musb->clock)) {
-			status = PTR_ERR(musb->clock);
-			musb->clock = NULL;
-			goto fail;
-		}
+	musb->clock = clk_get(dev, "ick");
+	if (IS_ERR(musb->clock)) {
+		status = PTR_ERR(musb->clock);
+		musb->clock = NULL;
+		goto fail;
 	}
 
+	status = clk_enable(musb->clock);
+	if (status < 0)
+		goto fail;
+
 	/* The musb_platform_init() call:
 	 *   - adjusts musb->mregs and musb->isr if needed,
 	 *   - may initialize an integrated tranceiver
@@ -2104,8 +2101,7 @@ fail:
 	dev_err(musb->controller,
 		"musb_init_controller failed with status %d\n", status);
 
-	if (musb->clock)
-		clk_put(musb->clock);
+	clk_put(musb->clock);
 	device_init_wakeup(dev, 0);
 	musb_free(musb);
 
@@ -2179,9 +2175,6 @@ static int musb_suspend(struct device *dev)
 	unsigned long	flags;
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 
-	if (!musb->clock)
-		return 0;
-
 	spin_lock_irqsave(&musb->lock, flags);
 
 	if (is_peripheral_active(musb)) {
@@ -2194,10 +2187,7 @@ static int musb_suspend(struct device *dev)
 		 */
 	}
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 0);
-	else
-		clk_disable(musb->clock);
+	clk_disable(musb->clock);
 	spin_unlock_irqrestore(&musb->lock, flags);
 	return 0;
 }
@@ -2207,13 +2197,7 @@ static int musb_resume_noirq(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct musb	*musb = dev_to_musb(&pdev->dev);
 
-	if (!musb->clock)
-		return 0;
-
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 1);
-	else
-		clk_enable(musb->clock);
+	clk_enable(musb->clock);
 
 	/* for static cmos like DaVinci, register values were preserved
 	 * unless for some reason the whole soc powered down or the USB
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 03d5090..3816d79 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -394,8 +394,6 @@ struct musb {
 	u8 board_mode;		/* enum musb_mode */
 	int			(*board_set_power)(int state);
 
-	int			(*set_clock)(struct clk *clk, int is_active);
-
 	u8			min_power;	/* vbus for periph, in mA/2 */
 
 	bool			is_host;
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 83beeac..b8e2451 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -273,10 +273,7 @@ int musb_platform_suspend(struct musb *musb)
 
 	otg_set_suspend(musb->xceiv, 1);
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 0);
-	else
-		clk_disable(musb->clock);
+	clk_disable(musb->clock);
 
 	return 0;
 }
@@ -290,10 +287,7 @@ static int musb_platform_resume(struct musb *musb)
 
 	otg_set_suspend(musb->xceiv, 0);
 
-	if (musb->set_clock)
-		musb->set_clock(musb->clock, 1);
-	else
-		clk_enable(musb->clock);
+	clk_enable(musb->clock);
 
 	l = omap_readl(OTG_SYSCONFIG);
 	l &= ~ENABLEWAKEUP;	/* disable wakeup */
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 88b587c..67ba2b9 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -279,12 +279,10 @@ static int tusb_draw_power(struct otg_transceiver *x, unsigned mA)
 	 * Keep clock active when enabled. Note that this is not tied to
 	 * drawing VBUS, as with OTG mA can be less than musb->min_power.
 	 */
-	if (musb->set_clock) {
-		if (mA)
-			musb->set_clock(musb->clock, 1);
-		else
-			musb->set_clock(musb->clock, 0);
-	}
+	if (mA)
+		clk_enable(musb->clock);
+	else
+		clk_disable(musb->clock);
 
 	/* tps65030 seems to consume max 100mA, with maybe 60mA available
 	 * (measured on one board) for things other than tps and tusb.
@@ -531,8 +529,7 @@ static void tusb_source_power(struct musb *musb, int is_on)
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
 	if (is_on) {
-		if (musb->set_clock)
-			musb->set_clock(musb->clock, 1);
+		clk_enable(musb->clock);
 		timer = OTG_TIMER_MS(OTG_TIME_A_WAIT_VRISE);
 		musb->xceiv->default_a = 1;
 		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
@@ -571,8 +568,7 @@ static void tusb_source_power(struct musb *musb, int is_on)
 
 		devctl &= ~MUSB_DEVCTL_SESSION;
 		conf &= ~TUSB_DEV_CONF_USB_HOST_MODE;
-		if (musb->set_clock)
-			musb->set_clock(musb->clock, 0);
+		clk_disable(musb->clock);
 	}
 	prcm &= ~(TUSB_PRCM_MNGMT_15_SW_EN | TUSB_PRCM_MNGMT_33_SW_EN);
 
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index d437556..50d5441 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -62,7 +62,7 @@ struct musb_hdrc_platform_data {
 	u8		mode;
 
 	/* for clk_get() */
-	const char	*clock;
+	const char	*clock __deprecated;
 
 	/* (HOST or OTG) switch VBUS on/off */
 	int		(*set_vbus)(struct device *dev, int is_on);
@@ -80,7 +80,7 @@ struct musb_hdrc_platform_data {
 	int		(*set_power)(int state);
 
 	/* Turn device clock on or off */
-	int		(*set_clock)(struct clk *clock, int is_on);
+	int		(*set_clock)(struct clk *clock, int is_on) __deprecated;
 
 	/* MUSB configuration-specific details */
 	struct musb_hdrc_config	*config;
-- 
1.6.6.35.g1d85d

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
