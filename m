From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Thu, 27 Oct 2016 10:40:17 -0700
Message-ID: <20161027174016.43twztwekvb3b25t@atomide.com>
References: <20161021094904.q66kjsl33yzf2kir@atomide.com>
 <20161021110725.GA5192@localhost>
 <20161021112745.lancojpgv4h6aqpw@atomide.com>
 <20161024173538.26xvlitxiwjmh4fx@atomide.com>
 <20161025083237.GF12024@localhost>
 <20161025151110.vih52s47a2g2col5@atomide.com>
 <20161026142050.GK12024@localhost>
 <20161026143100.rg4pse6mjyq32hxm@atomide.com>
 <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161027164416.GL12024@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161027 09:45]:
> On Thu, Oct 27, 2016 at 08:14:46AM -0700, Tony Lindgren wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161026 07:32]:
> 
> > 8< -------------------------------
> > From tony Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > Date: Tue, 25 Oct 2016 08:42:00 -0700
> > Subject: [PATCH] usb: musb: Fix sleeping function called from invalid
> >  context for hdrc glue
> > 
> > Commit 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> > glue layer") wrongly added a call for pm_runtime_get_sync to otg_timer
> > that runs in softirq context. That causes a "BUG: sleeping function called
> > from invalid context" every time when polling the cable status:
> > 
> > [<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
> > [<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
> > [<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
> > [<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
> > [<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
> > [<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)
> > 
> > I did not notice that as I did not have CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> > 
> > Let's fix the issue by adding dsps_check_status() and then register a
> > callback with musb_runtime_resume() so it gets called only when musb core
> > and it's parent devices are awake. Note that we don't want to do this from
> > PM runtime resume in musb_dsps.c as musb core is not awake yet at that
> > point as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>.
> 
> It seems some chunks are missing since this patch only runs the
> deferred work at remove and not at runtime resume, effectively breaking
> detection.

Oops sorry yeah looks like I had that in a separate debug hacks patch..

> > Note that musb_gadget_queue() also suffers from a similar issue when
> > connecting the cable and cannot use pm_runtime_get_sync().
> 
> You seem to have left that pm_runtime_get_sync() in there though.

And that one I must have hosed when cleaning up, thanks for noticing
these. Updated patch below.

Regards,

Tony

8< ---------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Tue, 25 Oct 2016 08:42:00 -0700
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

Let's fix the issue by adding dsps_check_status() and then register a
callback with musb_runtime_resume() so it gets called only when musb core
and it's parent devices are awake. Note that we don't want to do this from
PM runtime resume in musb_dsps.c as musb core is not awake yet at that
point as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>.

Note that musb_gadget_queue() also suffers from a similar issue when
connecting the cable and cannot use pm_runtime_get_sync().

Fixes: 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
glue layer")
Reported-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c   | 48 ++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/musb/musb_core.h   |  7 ++++++
 drivers/usb/musb/musb_dsps.c   | 29 +++++++++++++++++++------
 drivers/usb/musb/musb_gadget.c | 18 +++++++++++++---
 4 files changed, 90 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -122,7 +122,6 @@ MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" MUSB_DRIVER_NAME);
 
-
 /*-------------------------------------------------------------------------*/
 
 static inline struct musb *dev_to_musb(struct device *dev)
@@ -1896,6 +1895,46 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 	musb->session = s;
 }
 
+struct musb_resume_work {
+	void (*callback)(struct musb *musb, void *data);
+	void *data;
+	struct list_head node;
+};
+
+void musb_queue_on_resume(struct musb *musb,
+			  void (*callback)(struct musb *musb, void *data),
+			  void *data)
+{
+	struct musb_resume_work *w;
+	unsigned long flags;
+
+	w = devm_kzalloc(musb->controller, sizeof(*w), GFP_ATOMIC);
+	if (!w)
+		return;
+
+	w->callback = callback;
+	w->data = data;
+	spin_lock_irqsave(&musb->list_lock, flags);
+	list_add_tail(&w->node, &musb->resume_work);
+	spin_unlock_irqrestore(&musb->list_lock, flags);
+}
+EXPORT_SYMBOL_GPL(musb_queue_on_resume);
+
+static void musb_run_pending(struct musb *musb)
+{
+	struct musb_resume_work *w, *_w;
+	unsigned long flags;
+
+	spin_lock_irqsave(&musb->list_lock, flags);
+	list_for_each_entry_safe(w, _w, &musb->resume_work, node) {
+		if (w->callback)
+			w->callback(musb, w->data);
+		list_del(&w->node);
+		devm_kfree(musb->controller, w);
+	}
+	spin_unlock_irqrestore(&musb->list_lock, flags);
+}
+
 /* Only used to provide driver mode change events */
 static void musb_irq_work(struct work_struct *data)
 {
@@ -1969,6 +2008,7 @@ static struct musb *allocate_instance(struct device *dev,
 	INIT_LIST_HEAD(&musb->control);
 	INIT_LIST_HEAD(&musb->in_bulk);
 	INIT_LIST_HEAD(&musb->out_bulk);
+	INIT_LIST_HEAD(&musb->resume_work);
 
 	musb->vbuserr_retry = VBUSERR_RETRY_COUNT;
 	musb->a_wait_bcon = OTG_TIME_A_WAIT_BCON;
@@ -2065,6 +2105,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	}
 
 	spin_lock_init(&musb->lock);
+	spin_lock_init(&musb->list_lock);
 	musb->board_set_power = plat->set_power;
 	musb->min_power = plat->min_power;
 	musb->ops = plat->platform_ops;
@@ -2374,6 +2415,7 @@ static int musb_remove(struct platform_device *pdev)
 	 *  - Peripheral mode: peripheral is deactivated (or never-activated)
 	 *  - OTG mode: both roles are deactivated (or never-activated)
 	 */
+	musb_run_pending(musb);
 	musb_exit_debugfs(musb);
 
 	cancel_work_sync(&musb->irq_work);
@@ -2645,8 +2687,10 @@ static int musb_runtime_resume(struct device *dev)
 	 * Also context restore without save does not make
 	 * any sense
 	 */
-	if (!first)
+	if (!first) {
 		musb_restore_context(musb);
+		musb_run_pending(musb);
+	}
 	first = 0;
 
 	if (musb->need_finish_resume) {
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -303,6 +303,7 @@ struct musb_context_registers {
 struct musb {
 	/* device lock */
 	spinlock_t		lock;
+	spinlock_t		list_lock;	/* resume work list lock */
 
 	struct musb_io		io;
 	const struct musb_platform_ops *ops;
@@ -337,6 +338,7 @@ struct musb {
 	struct list_head	control;	/* of musb_qh */
 	struct list_head	in_bulk;	/* of musb_qh */
 	struct list_head	out_bulk;	/* of musb_qh */
+	struct list_head	resume_work;	/* pending work on resume */
 
 	struct timer_list	otg_timer;
 	struct notifier_block	nb;
@@ -540,6 +542,11 @@ extern irqreturn_t musb_interrupt(struct musb *);
 
 extern void musb_hnp_stop(struct musb *musb);
 
+extern void
+musb_queue_on_resume(struct musb *musb,
+		     void (*callback)(struct musb *musb, void *data),
+		     void *data);
+
 static inline void musb_platform_set_vbus(struct musb *musb, int is_on)
 {
 	if (musb->ops->set_vbus)
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
@@ -246,6 +240,27 @@ static void otg_timer(unsigned long _musb)
 		break;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
+}
+
+static void dsps_check_status_resume_work(struct musb *musb, void *unused)
+{
+	dsps_check_status(musb);
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
+	if (pm_runtime_active(dev))
+		dsps_check_status(musb);
+	else
+		musb_queue_on_resume(musb, dsps_check_status_resume_work, NULL);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1222,6 +1222,13 @@ void musb_ep_restart(struct musb *musb, struct musb_request *req)
 		rxstate(musb, req);
 }
 
+void musb_ep_restart_resume_work(struct musb *musb, void *data)
+{
+	struct musb_request *req = data;
+
+	musb_ep_restart(musb, req);
+}
+
 static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 			gfp_t gfp_flags)
 {
@@ -1255,7 +1262,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 
 	map_dma_buffer(request, musb, musb_ep);
 
-	pm_runtime_get_sync(musb->controller);
+	pm_runtime_get(musb->controller);
 	spin_lock_irqsave(&musb->lock, lockflags);
 
 	/* don't queue if the ep is down */
@@ -1271,8 +1278,13 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	list_add_tail(&request->list, &musb_ep->req_list);
 
 	/* it this is the head of the queue, start i/o ... */
-	if (!musb_ep->busy && &request->list == musb_ep->req_list.next)
-		musb_ep_restart(musb, request);
+	if (!musb_ep->busy && &request->list == musb_ep->req_list.next) {
+		if (pm_runtime_active(musb->controller))
+			musb_ep_restart(musb, request);
+		else
+			musb_queue_on_resume(musb, musb_ep_restart_resume_work,
+					     request);
+	}
 
 unlock:
 	spin_unlock_irqrestore(&musb->lock, lockflags);
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
