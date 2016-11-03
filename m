From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Thu, 3 Nov 2016 14:26:35 -0700
Message-ID: <20161103212635.GC21430@atomide.com>
References: <20161026142050.GK12024@localhost>
 <20161026143100.rg4pse6mjyq32hxm@atomide.com>
 <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
 <20161027174016.43twztwekvb3b25t@atomide.com>
 <20161027184507.GM12024@localhost>
 <20161027191552.tuutyslp5qtu2b4f@atomide.com>
 <20161028094428.GO12024@localhost>
 <20161028181318.umwn3rx55pg2cvwd@atomide.com>
 <20161031114921.GB4254@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161031114921.GB4254@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161031 04:50]:
> On Fri, Oct 28, 2016 at 11:13:19AM -0700, Tony Lindgren wrote:
> > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161028 02:45]:
> > > On Thu, Oct 27, 2016 at 12:15:52PM -0700, Tony Lindgren wrote:
> > > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161027 11:46]:
> > > > > But then this looks like it could trigger an ABBA deadlock as musb->lock
> > > > > is held while queue_on_resume() takes musb->list_lock, and
> > > > > musb_run_pending() would take the same locks in the reverse order.
> > > > 
> > > > It seems we can avoid that by locking only list_add_tail() and list_del():
> > > > 
> > > > list_for_each_entry_safe(w, _w, &musb->resume_work, node) {
> > > > 	spin_lock_irqsave(&musb->list_lock, flags);
> > > > 	list_del(&w->node);
> > > > 	spin_unlock_irqrestore(&musb->list_lock, flags);
> > > > 	if (w->callback)
> > > > 		w->callback(musb, w->data);
> > > > 	devm_kfree(musb->controller, w);
> > > > }
> > > 
> > > I think you still need to hold the lock while traversing the list (even
> > > if you temporarily release it during the callback).
> > 
> > Hmm yeah we need iterate through the list again to avoid missing new
> > elements being added. I've updated the patch to use a the common
> > while (!list_empty(&musb->resume_work)) loop. Does that solve the
> > concern you had or did you also had some other concern there?
> 
> Yeah, while that minimises the race window it is still possible that the
> timer callback checks pm_runtime_active() after the queue has been
> processed but before the rpm status is updated. 

OK. Sorry for the delay responding, had my motherboard fail
over the weekend..

> How about using a work struct and synchronous get for the deferred case?

Here's the patch updated to use the existing finish_resume_work.
Is that along the lines you were thinking?

Adding also Ladis to Cc too.

Regards,

Tony

8< ----------------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Date: Wed, 2 Nov 2016 19:59:05 -0700
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
And looks like also musb_gadget_queue() suffers from the same problem.

Let's fix the issue by using a list of delayed work then call it on
resume. We can use the existing finish_resume_work for that. Note that
we want to do this only when both musb core and it's parent devices are
awake as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>. This allows us also
to get rid of musb_gadget_work and need_finish_resume flag.

Note that we now also need to get rid of static int first as that
won't work right on devices with two musb instances like am335x.

Note that we don't want to mess with deassert_reset_work as that's
more time sensitive and USB spec related instead of PM runtime related.

Fixes: 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
glue layer")
Reported-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c    | 89 +++++++++++++++++++++++++++++++++--------
 drivers/usb/musb/musb_core.h    |  9 ++++-
 drivers/usb/musb/musb_dsps.c    | 24 +++++++----
 drivers/usb/musb/musb_gadget.c  | 31 +++++++++-----
 drivers/usb/musb/musb_host.h    |  6 ++-
 drivers/usb/musb/musb_virthub.c |  5 +--
 6 files changed, 123 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -578,8 +578,9 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 						| MUSB_PORT_STAT_RESUME;
 				musb->rh_timer = jiffies
 					+ msecs_to_jiffies(USB_RESUME_TIMEOUT);
-				musb->need_finish_resume = 1;
-
+				musb_queue_resume_work(musb,
+						       musb_host_finish_resume,
+						       NULL);
 				musb->xceiv->otg->state = OTG_STATE_A_HOST;
 				musb->is_active = 1;
 				musb_host_resume_root_hub(musb);
@@ -1969,6 +1970,7 @@ static struct musb *allocate_instance(struct device *dev,
 	INIT_LIST_HEAD(&musb->control);
 	INIT_LIST_HEAD(&musb->in_bulk);
 	INIT_LIST_HEAD(&musb->out_bulk);
+	INIT_LIST_HEAD(&musb->pending_list);
 
 	musb->vbuserr_retry = VBUSERR_RETRY_COUNT;
 	musb->a_wait_bcon = OTG_TIME_A_WAIT_BCON;
@@ -2018,6 +2020,64 @@ static void musb_free(struct musb *musb)
 	musb_host_free(musb);
 }
 
+struct musb_pending_work {
+	void (*callback)(struct musb *musb, void *data);
+	void *data;
+	struct list_head node;
+};
+
+static void musb_pending_work(struct work_struct *work)
+{
+	struct musb *musb;
+	struct musb_pending_work *w;
+	unsigned long flags;
+
+	musb = container_of(work, struct musb, finish_resume_work.work);
+	pm_runtime_get_sync(musb->controller);
+	spin_lock_irqsave(&musb->list_lock, flags);
+	while (!list_empty(&musb->pending_list)) {
+		w = list_first_entry(&musb->pending_list,
+				     struct musb_pending_work,
+				     node);
+		list_del(&w->node);
+		spin_unlock_irqrestore(&musb->list_lock, flags);
+		if (w->callback)
+			w->callback(musb, w->data);
+		devm_kfree(musb->controller, w);
+		spin_lock_irqsave(&musb->list_lock, flags);
+	}
+	spin_unlock_irqrestore(&musb->list_lock, flags);
+	pm_runtime_mark_last_busy(musb->controller);
+	pm_runtime_put_autosuspend(musb->controller);
+}
+
+void musb_queue_resume_work(struct musb *musb,
+			    void (*callback)(struct musb *musb, void *data),
+			    void *data)
+{
+	struct musb_pending_work *w;
+	unsigned long flags;
+
+	if (!callback)
+		return;
+
+	w = devm_kzalloc(musb->controller, sizeof(*w), GFP_ATOMIC);
+	if (!w)
+		return;
+
+	w->callback = callback;
+	w->data = data;
+	spin_lock_irqsave(&musb->list_lock, flags);
+	list_add_tail(&w->node, &musb->pending_list);
+	spin_unlock_irqrestore(&musb->list_lock, flags);
+}
+EXPORT_SYMBOL_GPL(musb_queue_resume_work);
+
+void musb_cancel_resume_work(struct musb *musb)
+{
+	cancel_delayed_work_sync(&musb->finish_resume_work);
+}
+
 static void musb_deassert_reset(struct work_struct *work)
 {
 	struct musb *musb;
@@ -2065,6 +2125,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	}
 
 	spin_lock_init(&musb->lock);
+	spin_lock_init(&musb->list_lock);
 	musb->board_set_power = plat->set_power;
 	musb->min_power = plat->min_power;
 	musb->ops = plat->platform_ops;
@@ -2215,7 +2276,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	/* Init IRQ workqueue before request_irq */
 	INIT_WORK(&musb->irq_work, musb_irq_work);
 	INIT_DELAYED_WORK(&musb->deassert_reset_work, musb_deassert_reset);
-	INIT_DELAYED_WORK(&musb->finish_resume_work, musb_host_finish_resume);
+	INIT_DELAYED_WORK(&musb->finish_resume_work, musb_pending_work);
 
 	/* setup musb parts of the core (especially endpoints) */
 	status = musb_core_init(plat->config->multipoint
@@ -2310,7 +2371,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 
 fail3:
 	cancel_work_sync(&musb->irq_work);
-	cancel_delayed_work_sync(&musb->finish_resume_work);
+	musb_cancel_resume_work(musb);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	if (musb->dma_controller)
 		musb_dma_controller_destroy(musb->dma_controller);
@@ -2377,7 +2438,7 @@ static int musb_remove(struct platform_device *pdev)
 	musb_exit_debugfs(musb);
 
 	cancel_work_sync(&musb->irq_work);
-	cancel_delayed_work_sync(&musb->finish_resume_work);
+	musb_cancel_resume_work(musb);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	pm_runtime_get_sync(musb->controller);
 	musb_host_cleanup(musb);
@@ -2603,11 +2664,9 @@ static int musb_resume(struct device *dev)
 	mask = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV;
 	if ((devctl & mask) != (musb->context.devctl & mask))
 		musb->port1_status = 0;
-	if (musb->need_finish_resume) {
-		musb->need_finish_resume = 0;
-		schedule_delayed_work(&musb->finish_resume_work,
-				      msecs_to_jiffies(USB_RESUME_TIMEOUT));
-	}
+
+	schedule_delayed_work(&musb->finish_resume_work,
+			      msecs_to_jiffies(USB_RESUME_TIMEOUT));
 
 	/*
 	 * The USB HUB code expects the device to be in RPM_ACTIVE once it came
@@ -2633,8 +2692,8 @@ static int musb_runtime_suspend(struct device *dev)
 
 static int musb_runtime_resume(struct device *dev)
 {
-	struct musb	*musb = dev_to_musb(dev);
-	static int	first = 1;
+	struct musb *musb = dev_to_musb(dev);
+	struct delayed_work *d = &musb->finish_resume_work;
 
 	/*
 	 * When pm_runtime_get_sync called for the first time in driver
@@ -2645,12 +2704,8 @@ static int musb_runtime_resume(struct device *dev)
 	 * Also context restore without save does not make
 	 * any sense
 	 */
-	if (!first)
+	if (d->work.func) {
 		musb_restore_context(musb);
-	first = 0;
-
-	if (musb->need_finish_resume) {
-		musb->need_finish_resume = 0;
 		schedule_delayed_work(&musb->finish_resume_work,
 				msecs_to_jiffies(USB_RESUME_TIMEOUT));
 	}
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
@@ -312,7 +313,6 @@ struct musb {
 	struct work_struct	irq_work;
 	struct delayed_work	deassert_reset_work;
 	struct delayed_work	finish_resume_work;
-	struct delayed_work	gadget_work;
 	u16			hwvers;
 
 	u16			intrrxe;
@@ -337,6 +337,7 @@ struct musb {
 	struct list_head	control;	/* of musb_qh */
 	struct list_head	in_bulk;	/* of musb_qh */
 	struct list_head	out_bulk;	/* of musb_qh */
+	struct list_head	pending_list;	/* pending work list */
 
 	struct timer_list	otg_timer;
 	struct notifier_block	nb;
@@ -404,7 +405,6 @@ struct musb {
 
 	/* is_suspended means USB B_PERIPHERAL suspend */
 	unsigned		is_suspended:1;
-	unsigned		need_finish_resume :1;
 
 	/* may_wakeup means remote wakeup is enabled */
 	unsigned		may_wakeup:1;
@@ -540,6 +540,11 @@ extern irqreturn_t musb_interrupt(struct musb *);
 
 extern void musb_hnp_stop(struct musb *musb);
 
+void musb_queue_resume_work(struct musb *musb,
+			    void (*callback)(struct musb *musb, void *data),
+			    void *data);
+void musb_cancel_resume_work(struct musb *musb);
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
+static void dsps_check_status(struct musb *musb, void *unused)
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
@@ -246,6 +240,22 @@ static void otg_timer(unsigned long _musb)
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
+	if (pm_runtime_active(dev))
+		dsps_check_status(musb, NULL);
+	else
+		musb_queue_resume_work(musb, dsps_check_status, NULL);
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1222,6 +1222,16 @@ void musb_ep_restart(struct musb *musb, struct musb_request *req)
 		rxstate(musb, req);
 }
 
+void musb_ep_restart_resume_work(struct musb *musb, void *data)
+{
+	struct musb_request *req = data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&musb->lock, flags);
+	musb_ep_restart(musb, req);
+	spin_unlock_irqrestore(&musb->lock, flags);
+}
+
 static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 			gfp_t gfp_flags)
 {
@@ -1255,7 +1265,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 
 	map_dma_buffer(request, musb, musb_ep);
 
-	pm_runtime_get_sync(musb->controller);
+	pm_runtime_get(musb->controller);
 	spin_lock_irqsave(&musb->lock, lockflags);
 
 	/* don't queue if the ep is down */
@@ -1271,8 +1281,14 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
 	list_add_tail(&request->list, &musb_ep->req_list);
 
 	/* it this is the head of the queue, start i/o ... */
-	if (!musb_ep->busy && &request->list == musb_ep->req_list.next)
-		musb_ep_restart(musb, request);
+	if (!musb_ep->busy && &request->list == musb_ep->req_list.next) {
+		if (pm_runtime_active(musb->controller))
+			musb_ep_restart(musb, request);
+		else
+			musb_queue_resume_work(musb,
+					       musb_ep_restart_resume_work,
+					       request);
+	}
 
 unlock:
 	spin_unlock_irqrestore(&musb->lock, lockflags);
@@ -1650,12 +1666,10 @@ static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 	return usb_phy_set_power(musb->xceiv, mA);
 }
 
-static void musb_gadget_work(struct work_struct *work)
+static void musb_gadget_work(struct musb *musb, void *unused)
 {
-	struct musb *musb;
 	unsigned long flags;
 
-	musb = container_of(work, struct musb, gadget_work.work);
 	pm_runtime_get_sync(musb->controller);
 	spin_lock_irqsave(&musb->lock, flags);
 	musb_pullup(musb, musb->softconnect);
@@ -1677,7 +1691,7 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
 	spin_lock_irqsave(&musb->lock, flags);
 	if (is_on != musb->softconnect) {
 		musb->softconnect = is_on;
-		schedule_delayed_work(&musb->gadget_work, 0);
+		musb_queue_resume_work(musb, musb_gadget_work, NULL);
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
@@ -1849,7 +1863,6 @@ int musb_gadget_setup(struct musb *musb)
 #elif IS_ENABLED(CONFIG_USB_MUSB_GADGET)
 	musb->g.is_otg = 0;
 #endif
-	INIT_DELAYED_WORK(&musb->gadget_work, musb_gadget_work);
 	musb_g_init_endpoints(musb);
 
 	musb->is_active = 0;
@@ -1871,7 +1884,7 @@ void musb_gadget_cleanup(struct musb *musb)
 	if (musb->port_mode == MUSB_PORT_MODE_HOST)
 		return;
 
-	cancel_delayed_work_sync(&musb->gadget_work);
+	musb_cancel_resume_work(musb);
 	usb_del_gadget_udc(&musb->g);
 }
 
diff --git a/drivers/usb/musb/musb_host.h b/drivers/usb/musb/musb_host.h
--- a/drivers/usb/musb/musb_host.h
+++ b/drivers/usb/musb/musb_host.h
@@ -94,7 +94,7 @@ extern void musb_host_resume_root_hub(struct musb *musb);
 extern void musb_host_poke_root_hub(struct musb *musb);
 extern void musb_port_suspend(struct musb *musb, bool do_suspend);
 extern void musb_port_reset(struct musb *musb, bool do_reset);
-extern void musb_host_finish_resume(struct work_struct *work);
+void musb_host_finish_resume(struct musb *musb, void *data);
 #else
 static inline struct musb *hcd_to_musb(struct usb_hcd *hcd)
 {
@@ -126,7 +126,9 @@ static inline void musb_host_poll_rh_status(struct musb *musb)	{}
 static inline void musb_host_poke_root_hub(struct musb *musb)	{}
 static inline void musb_port_suspend(struct musb *musb, bool do_suspend) {}
 static inline void musb_port_reset(struct musb *musb, bool do_reset) {}
-static inline void musb_host_finish_resume(struct work_struct *work) {}
+static inline void musb_host_finish_resume(struct musb *musb, void *data)
+{
+}
 #endif
 
 struct usb_hcd;
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -43,14 +43,11 @@
 
 #include "musb_core.h"
 
-void musb_host_finish_resume(struct work_struct *work)
+void musb_host_finish_resume(struct musb *musb, void *unused)
 {
-	struct musb *musb;
 	unsigned long flags;
 	u8 power;
 
-	musb = container_of(work, struct musb, finish_resume_work.work);
