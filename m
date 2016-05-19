From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 00/15] Get MUSB PM runtime working again
Date: Thu, 19 May 2016 08:26:02 -0700
Message-ID: <20160519152601.GV5995@atomide.com>
References: <1463014396-4095-1-git-send-email-tony@atomide.com>
 <20160517211541.GA30701@uda0271908>
 <20160517215403.GP5995@atomide.com>
 <20160517220502.GA24963@uda0271908>
 <20160518180737.GQ5995@atomide.com>
 <20160518181020.GB7522@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160518181020.GB7522@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160518 11:12]:
> On Wed, May 18, 2016 at 11:07:37AM -0700, Tony Lindgren wrote:
> > 
> > Is this with or without the $subject series?
> 
> Without.

OK sounds like you have a fix coming for that issue.

> > > I tried to enable some dynamic-debug log, but was unable to see any
> > > glue. I will try to enable musb reg access log tomorrow to see if I can
> > > find anything.
> > 
> > OK, I'm looking at implementing proper PM runtime for dsps.

And here's something to play with for PM runtime on top of the
$subject series.

Currently it only works in PIO mode and relies on keeping the
polling going.. See notes below about the GPIO mode.

BTW, looks like we can then just also remove try_idle also for
dsps glue layer.

Regards,

Tony

8< ----------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Wed, 18 May 2016 08:22:31 -0700
Subject: [PATCH] usb: musb: Add PM runtime support for dsps glue for PIO mode

This gets basic PM runtime working for dsps glue layer uwing
PIO mode.

For now, we must keep polling enabled as typically at least
one of the controllers has ID pin tied down. Later on we can
add support for remuxing USB data lines to GPIO mode to leave
out the polling where possible.

Note that this shuts down the device currently only with
CONFIG_MUSB_PIO_ONLY=y as cppi41 is a child of musb_am335x.c
and needs PM runtime fixed up first.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -144,6 +144,7 @@ struct dsps_glue {
 	const struct dsps_musb_wrapper *wrp; /* wrapper register offsets */
 	struct timer_list timer;	/* otg_workaround timer */
 	unsigned long last_timer;    /* last timer data for each instance */
+	bool powered;
 	bool sw_babble_enabled;
 
 	struct dsps_context context;
@@ -250,6 +251,35 @@ static void dsps_musb_disable(struct musb *musb)
 	dsps_writeb(musb->mregs, MUSB_DEVCTL, 0);
 }
 
+static void dsps_musb_set_power(struct musb *musb, bool enabled)
+{
+	struct dsps_glue *glue = dev_get_drvdata(musb->controller->parent);
+	int err;
+
+	if (enabled == glue->powered) {
+		dev_warn(musb->controller, "Power already %i\n",
+			 glue->powered);
+		return;
+	}
+
+	if (glue->powered) {
+		dev_dbg(musb->controller, "Disabling power\n");
+		pm_runtime_mark_last_busy(musb->controller);
+		pm_runtime_put_autosuspend(musb->controller);
+		glue->powered = false;
+	} else {
+		dev_dbg(musb->controller, "Enabling power\n");
+		err = pm_runtime_get_sync(musb->controller);
+		if (err < 0) {
+			dev_err(musb->controller,
+				"Could not pm_runtime_get: %i\n",
+				err);
+			return;
+		}
+		glue->powered = true;
+	}
+}
+
 static void otg_timer(unsigned long _musb)
 {
 	struct musb *musb = (void *)_musb;
@@ -260,6 +290,11 @@ static void otg_timer(unsigned long _musb)
 	u8 devctl;
 	unsigned long flags;
 	int skip_session = 0;
+	int err;
+
+	err = pm_runtime_get_sync(dev);
+	if (err < 0)
+		dev_err(dev, "Poll could not pm_runtime_get: %i\n", err);
 
 	/*
 	 * We poll because DSPS IP's won't expose several OTG-critical
@@ -287,6 +322,7 @@ static void otg_timer(unsigned long _musb)
 		}
 		if (!(devctl & MUSB_DEVCTL_SESSION) && !skip_session)
 			dsps_writeb(mregs, MUSB_DEVCTL, MUSB_DEVCTL_SESSION);
+		dsps_musb_set_power(musb, false);
 		mod_timer(&glue->timer, jiffies +
 				msecs_to_jiffies(wrp->poll_timeout));
 		break;
@@ -294,11 +330,18 @@ static void otg_timer(unsigned long _musb)
 		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
 		dsps_writel(musb->ctrl_base, wrp->coreintr_set,
 			    MUSB_INTR_VBUSERROR << wrp->usb_shift);
+		dsps_musb_set_power(musb, false);
+		break;
+	case OTG_STATE_UNDEFINED:
 		break;
 	default:
+		dsps_musb_set_power(musb, true);
 		break;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static irqreturn_t dsps_interrupt(int irq, void *hci)
@@ -362,7 +405,6 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 			MUSB_HST_MODE(musb);
 			musb->xceiv->otg->default_a = 1;
 			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
-			del_timer(&glue->timer);
 		} else {
 			musb->is_active = 0;
 			MUSB_DEV_MODE(musb);
@@ -382,9 +424,10 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 	if (musb->int_tx || musb->int_rx || musb->int_usb)
 		ret |= musb_interrupt(musb);
 
-	/* Poll for ID change in OTG port mode */
-	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
-			musb->port_mode == MUSB_PORT_MODE_DUAL_ROLE)
+	/* Poll for ID change and device connect */
+	if (musb->xceiv->otg->state == OTG_STATE_A_IDLE ||
+	    musb->xceiv->otg->state == OTG_STATE_A_WAIT_BCON ||
+	    musb->xceiv->otg->state == OTG_STATE_B_IDLE)
 		mod_timer(&glue->timer, jiffies +
 				msecs_to_jiffies(wrp->poll_timeout));
 out:
@@ -498,6 +541,7 @@ static int dsps_musb_exit(struct musb *musb)
 	phy_power_off(musb->phy);
 	phy_exit(musb->phy);
 	debugfs_remove_recursive(glue->dbgfs_root);
+	dsps_musb_set_power(musb, false);
 
 	return 0;
 }
@@ -808,6 +852,8 @@ static int dsps_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, glue);
 	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
@@ -819,11 +865,15 @@ static int dsps_probe(struct platform_device *pdev)
 	if (ret)
 		goto err3;
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 err3:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 err2:
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
@@ -835,7 +885,8 @@ static int dsps_remove(struct platform_device *pdev)
 	platform_device_unregister(glue->musb);
 
 	/* disable usbss clocks */
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
