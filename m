From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/4] musb fixes for v4.9-rc cycle
Date: Tue, 8 Nov 2016 15:05:30 -0700
Message-ID: <20161108220530.GO2428@atomide.com>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161108133821.GA1855@localhost.localdomain>
 <20161108144934.GK2428@atomide.com>
 <20161108145550.GL2428@atomide.com>
 <20161108171951.GA27533@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161108171951.GA27533-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161108 10:20]:
> On Tue, Nov 08, 2016 at 07:55:50AM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161108 07:50]:
> > > Weird, I have not figured out what happens there..
> > > 
> > > The only thing I'm still wondering about is if phy-twl4030-usb.c
> > > is losing ID pin interrupts occasionally but have not been
> > > able to verify that. Maybe try the following additional patch
> > > and see if it makes any difference?
> > 
> > And eventually the glue layers only should need to do this on
> > init:
> > 
> > pm_runtime_enable(glue->dev);
> > 
> > And this on the exit path:
> > 
> > pm_runtime_disable(glue->dev);
> > 
> > And musb core as the child device should keep things awake
> > when needed.
> 
> Tested your patch, does not work, does not trigger "USB link status err"
> both without and with pm_runtime_enable/disable.

OK. The patch below still works for me with musb_core.c
autosuspend_delay set to 100. Also works with it set to 10.

Note that we had two timeouts without this.. Can you try
playing with the timeout in musb_core.c and see if that
helps?

Regards,

Tony

8< ------------------
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1898,8 +1898,7 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 		musb->quirk_retries = 3;
 	} else {
 		musb_dbg(musb, "Allow PM with no session: %02x", devctl);
-		pm_runtime_mark_last_busy(musb->controller);
-		pm_runtime_put_autosuspend(musb->controller);
+		pm_runtime_put_sync_suspend(musb->controller);
 	}
 
 	musb->session = s;
@@ -2268,7 +2267,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	 * 500 ms for some margin.
 	 */
 	pm_runtime_use_autosuspend(musb->controller);
-	pm_runtime_set_autosuspend_delay(musb->controller, 500);
+	pm_runtime_set_autosuspend_delay(musb->controller, 100);
 	pm_runtime_enable(musb->controller);
 	pm_runtime_get_sync(musb->controller);
 
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -513,17 +513,18 @@ static int omap2430_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(glue->dev);
-	pm_runtime_use_autosuspend(glue->dev);
-	pm_runtime_set_autosuspend_delay(glue->dev, 100);
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err2;
+		goto err3;
 	}
 
 	return 0;
 
+err3:
+	pm_runtime_disable(glue->dev);
+
 err2:
 	platform_device_put(musb);
 
@@ -535,10 +536,7 @@ static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue *glue = platform_get_drvdata(pdev);
 
-	pm_runtime_get_sync(glue->dev);
 	platform_device_unregister(glue->musb);
-	pm_runtime_put_sync(glue->dev);
-	pm_runtime_dont_use_autosuspend(glue->dev);
 	pm_runtime_disable(glue->dev);
 
 	return 0;
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
