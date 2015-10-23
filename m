From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: MUSB peripheral DMA regression caused by driver core runtime PM
 change
Date: Fri, 23 Oct 2015 09:43:00 -0700
Message-ID: <20151023163957.GW3078@atomide.com>
References: <20151021234134.GQ3078@atomide.com>
 <20151022180216.GT3078@atomide.com>
 <20151022230133.GV3078@atomide.com>
 <562A2D0D.3060104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <562A2D0D.3060104-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [151023 05:50]:
> On 10/23/2015 02:01 AM, Tony Lindgren wrote:
> >* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151022 11:03]:
> >>* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [151021 16:44]:
> >>>Hi all,
> >>>
> >>>I noticed a regresssino in v4.3-rc series to day with MUSB gadgets
> >>>and DMA. Doing a git bisect between v4.2..v4.3-rc1 on it pointed to:
> >>>
> >>>ddef08dd00f5 ("Driver core: wakeup the parent device before trying probe")
> >>>
> >>>With the commit above reverted things work fine with DMA and USB gadgets.
> >>>
> >>>This is on omap3 with CONFIG_USB_INVENTRA_DMA selected. Selecting
> >>>CONFIG_MUSB_PIO_ONLY still works even without reverting ddef08dd00f5.
> >>>
> >>>Anybody got ideas what might be wrong? Some wrong runtime PM usage
> >>>under drivers/usb/musb?
> >>
> >>Here's some more debug info on where things are different initializing
> >>the USB gadgets. I added some printks and diffed the dmesg output. The
> >>added calls from commit ddef08dd00f5 start with dd:
> >
> >Well turns out the problem actually happens earlier. We end up calling
> >omap2430_runtime_resume with NULL struct musb while EPROBE_DEFER
> >probing.
> >
> >No ideas yet how it should be fixed though.
> >
> 
> I'm not sure, but below diff might help
> 
> diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> index 70f2b8a..aba8ca7 100644
> --- a/drivers/usb/musb/omap2430.c
> +++ b/drivers/usb/musb/omap2430.c
> @@ -391,6 +391,8 @@ static int omap2430_musb_init(struct musb *musb)
>         }
>         musb->isr = omap2430_musb_interrupt;
> 
> +       pm_runtime_enable(glue->dev);
> +
>         status = pm_runtime_get_sync(dev);
>         if (status < 0) {
>                 dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
> @@ -626,8 +628,6 @@ static int omap2430_probe(struct platform_device *pdev)
>                 goto err2;
>         }
> 
> -       pm_runtime_enable(&pdev->dev);
> -
>         ret = platform_device_add(musb);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to register musb device\n");

Well almost.. We need to now also ensure that things are enabled during
omap2430_musb_init. Something like this might be the minimal fix for the
-rc cycle.

8< ---------------------
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 23 Oct 2015 09:03:22 -0700
Subject: [PATCH] usb: musb: omap2430: Fix regression caused by driver core
 change

Commit ddef08dd00f5 ("Driver core: wakeup the parent device before trying
probe") started automatically ensuring the parent device is enabled when
the child gets probed.

This however caused a regression for MUSB omap2430 interface as the
runtime PM for the parent device needs the child initialized to access
the MUSB hardware registers.

Let's delay the enabling of PM runtime for the parent until the child
has been properly initialized as suggested in an earlier patch by
Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>.

In addition to delaying pm_runtime_enable, we now also need to make sure
the parent is enabled during omap2430_musb_init. We also want to propagate
an error from omap2430_runtime_resume if struct musb is not initialized.

Note that we use pm_runtime_put_noidle here for both the child and parent
to prevent an extra runtime_suspend/resume cycle.

Let's also add some comments to avoid confusion between the
two different devices.

Fixes: ddef08dd00f5 ("Driver core: wakeup the parent device before
trying probe")
Suggested-by: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -391,9 +391,20 @@ static int omap2430_musb_init(struct musb *musb)
 	}
 	musb->isr = omap2430_musb_interrupt;
 
+	/*
+	 * Enable runtime PM for musb parent (this driver). We can't
+	 * do it earlier as struct musb is not yet allocated and we
+	 * need to touch the musb registers for runtime PM.
+	 */
+	pm_runtime_enable(glue->dev);
+	status = pm_runtime_get_sync(glue->dev);
+	if (status < 0)
+		goto err1;
+
 	status = pm_runtime_get_sync(dev);
 	if (status < 0) {
 		dev_err(dev, "pm_runtime_get_sync FAILED %d\n", status);
+		pm_runtime_put_sync(glue->dev);
 		goto err1;
 	}
 
@@ -426,6 +437,7 @@ static int omap2430_musb_init(struct musb *musb)
 	phy_power_on(musb->phy);
 
 	pm_runtime_put_noidle(musb->controller);
+	pm_runtime_put_noidle(glue->dev);
 	return 0;
 
 err1:
@@ -626,7 +638,11 @@ static int omap2430_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	pm_runtime_enable(&pdev->dev);
+	/*
+	 * Note that we cannot enable PM runtime yet for this
+	 * driver as we need struct musb initialized first.
+	 * See omap2430_musb_init above.
+	 */
 
 	ret = platform_device_add(musb);
 	if (ret) {
@@ -675,11 +691,12 @@ static int omap2430_runtime_resume(struct device *dev)
 	struct omap2430_glue		*glue = dev_get_drvdata(dev);
 	struct musb			*musb = glue_to_musb(glue);
 
-	if (musb) {
-		omap2430_low_level_init(musb);
-		musb_writel(musb->mregs, OTG_INTERFSEL,
-				musb->context.otg_interfsel);
-	}
+	if (!musb)
+		return -EPROBE_DEFER;
+
+	omap2430_low_level_init(musb);
+	musb_writel(musb->mregs, OTG_INTERFSEL,
+		    musb->context.otg_interfsel);
 
 	return 0;
 }
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
