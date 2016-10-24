From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Mon, 24 Oct 2016 10:35:38 -0700
Message-ID: <20161024173538.26xvlitxiwjmh4fx@atomide.com>
References: <20161020153749.GC12413@localhost>
 <20161021070848.rum7wrlihjayqdbh@atomide.com>
 <20161021092530.GO2765@localhost>
 <20161021094904.q66kjsl33yzf2kir@atomide.com>
 <20161021110725.GA5192@localhost>
 <20161021112745.lancojpgv4h6aqpw@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161021112745.lancojpgv4h6aqpw-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161021 04:28]:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161021 04:08]:
> > > Agreed, that is clearly wrong to call from softirq context. I need to
> > > figure out what is right fix here but don't have access to my bbb
> > > until next week.
> > 
> > Ok, I'll make do with irq_safe meanwhile.
> 
> OK

Below is a fix against v4.9-rc2 that seems to work for me.

Regards,

Tony

8< ---------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Mon, 24 Oct 2016 09:18:02 -0700
Subject: [PATCH] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue

Commit 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
glue layer") wrongly added a call for pm_runtime_get_sync to otg_timer
that runs in softirq context. That causes a "BUG: sleeping function called
from invalid context" every time when polling the cable status:

[<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
[<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
[<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
[<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
[<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
[<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)

I did not notice that as I did not have CONFIG_DEBUG_ATOMIC_SLEEP enabled.

Let's fix the issue by adding dsps_check_status() and dsps_runtime_resume()
functions. And let's have otg_timer() check for the PM runtime status, and
if not already enabled, have dsps_runtime_resume() call dsps_check_status()
directly.

Fixes: 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
glue layer")
Reported-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_dsps.c | 46 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -188,9 +188,8 @@ static void dsps_musb_disable(struct musb *musb)
 	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
 }
 
-static void otg_timer(unsigned long _musb)
+static void dsps_check_status(struct musb *musb)
 {
-	struct musb *musb = (void *)_musb;
 	void __iomem *mregs = musb->mregs;
 	struct device *dev = musb->controller;
 	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
@@ -198,11 +197,6 @@ static void otg_timer(unsigned long _musb)
 	u8 devctl;
 	unsigned long flags;
 	int skip_session = 0;
-	int err;
-
-	err = pm_runtime_get_sync(dev);
-	if (err < 0)
-		dev_err(dev, "Poll could not pm_runtime_get: %i\n", err);
 
 	/*
 	 * We poll because DSPS IP's won't expose several OTG-critical
@@ -246,7 +240,25 @@ static void otg_timer(unsigned long _musb)
 		break;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+}
+
+static void otg_timer(unsigned long _musb)
+{
+	struct musb *musb = (void *)_musb;
+	struct device *dev = musb->controller;
+	int err;
+
+	err = pm_runtime_get(dev);
+	if (err < 0)
+		dev_err(dev, "Poll could not pm_runtime_get: %i\n", err);
+
+	/* If not active, dsps_runtime_resume() will call us again */
+	if (!pm_runtime_active(dev))
+		goto done;
+
+	dsps_check_status(musb);
 
+done:
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 }
@@ -847,6 +859,21 @@ static const struct of_device_id musb_dsps_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, musb_dsps_of_match);
 
+static int dsps_runtime_resume(struct device *dev)
+{
+	struct dsps_glue *glue = dev_get_drvdata(dev);
+	struct musb *musb;
+
+	if (!glue->musb)
+		return 0;
+
+	musb = platform_get_drvdata(glue->musb);
+	if (musb)
+		dsps_check_status(musb);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int dsps_suspend(struct device *dev)
 {
@@ -900,7 +927,10 @@ static int dsps_resume(struct device *dev)
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(dsps_pm_ops, dsps_suspend, dsps_resume);
+static const struct dev_pm_ops dsps_pm_ops = {
+	SET_RUNTIME_PM_OPS(NULL, dsps_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(dsps_suspend, dsps_resume)
+};
 
 static struct platform_driver dsps_usbss_driver = {
 	.probe		= dsps_probe,
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
