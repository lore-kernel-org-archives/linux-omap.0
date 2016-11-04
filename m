From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Fri, 4 Nov 2016 15:16:15 +0100
Message-ID: <20161104141615.GA16119@localhost>
References: <20161026143100.rg4pse6mjyq32hxm@atomide.com>
 <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
 <20161027174016.43twztwekvb3b25t@atomide.com>
 <20161027184507.GM12024@localhost>
 <20161027191552.tuutyslp5qtu2b4f@atomide.com>
 <20161028094428.GO12024@localhost>
 <20161028181318.umwn3rx55pg2cvwd@atomide.com>
 <20161031114921.GB4254@localhost>
 <20161103212635.GC21430@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161103212635.GC21430-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 03, 2016 at 02:26:35PM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161031 04:50]:
> > On Fri, Oct 28, 2016 at 11:13:19AM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161028 02:45]:
> > > > On Thu, Oct 27, 2016 at 12:15:52PM -0700, Tony Lindgren wrote:
> > > > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161027 11:46]:
> > > > > > But then this looks like it could trigger an ABBA deadlock as musb->lock
> > > > > > is held while queue_on_resume() takes musb->list_lock, and
> > > > > > musb_run_pending() would take the same locks in the reverse order.
> > > > > 
> > > > > It seems we can avoid that by locking only list_add_tail() and list_del():
> > > > > 
> > > > > list_for_each_entry_safe(w, _w, &musb->resume_work, node) {
> > > > > 	spin_lock_irqsave(&musb->list_lock, flags);
> > > > > 	list_del(&w->node);
> > > > > 	spin_unlock_irqrestore(&musb->list_lock, flags);
> > > > > 	if (w->callback)
> > > > > 		w->callback(musb, w->data);
> > > > > 	devm_kfree(musb->controller, w);
> > > > > }
> > > > 
> > > > I think you still need to hold the lock while traversing the list (even
> > > > if you temporarily release it during the callback).
> > > 
> > > Hmm yeah we need iterate through the list again to avoid missing new
> > > elements being added. I've updated the patch to use a the common
> > > while (!list_empty(&musb->resume_work)) loop. Does that solve the
> > > concern you had or did you also had some other concern there?
> > 
> > Yeah, while that minimises the race window it is still possible that the
> > timer callback checks pm_runtime_active() after the queue has been
> > processed but before the rpm status is updated. 
> 
> OK. Sorry for the delay responding, had my motherboard fail
> over the weekend..

Ouch. Hope the recovery process wasn't too painful.

> > How about using a work struct and synchronous get for the deferred case?
> 
> Here's the patch updated to use the existing finish_resume_work.
> Is that along the lines you were thinking?

Along those lines, yes, but I'm not sure about reusing
finish_resume_work currently used to deassert resume signalling only.

If work is already queued it seems you could end up deasserting resume
prematurely for example. It currently also add unnecessary latency to
other deferred work.

You also forgot to queue musb_host_finish_resume() from
musb_port_suspend() which looks like it would break port resume.

> 8< ----------------------------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Wed, 2 Nov 2016 19:59:05 -0700
> Subject: [PATCH] usb: musb: Fix sleeping function called from invalid
>  context for hdrc glue
> 
> Commit 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> glue layer") wrongly added a call for pm_runtime_get_sync to otg_timer
> that runs in softirq context. That causes a "BUG: sleeping function called
> from invalid context" every time when polling the cable status:
> 
> [<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
> [<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
> [<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
> [<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
> [<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
> [<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)
> 
> I did not notice that as I did not have CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> And looks like also musb_gadget_queue() suffers from the same problem.
> 
> Let's fix the issue by using a list of delayed work then call it on
> resume. We can use the existing finish_resume_work for that. Note that
> we want to do this only when both musb core and it's parent devices are
> awake as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>. This allows us also
> to get rid of musb_gadget_work and need_finish_resume flag.
> 
> Note that we now also need to get rid of static int first as that
> won't work right on devices with two musb instances like am335x.
> 
> Note that we don't want to mess with deassert_reset_work as that's
> more time sensitive and USB spec related instead of PM runtime related.
> 
> Fixes: 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> glue layer")
> Reported-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c    | 89 +++++++++++++++++++++++++++++++++--------
>  drivers/usb/musb/musb_core.h    |  9 ++++-
>  drivers/usb/musb/musb_dsps.c    | 24 +++++++----
>  drivers/usb/musb/musb_gadget.c  | 31 +++++++++-----
>  drivers/usb/musb/musb_host.h    |  6 ++-
>  drivers/usb/musb/musb_virthub.c |  5 +--
>  6 files changed, 123 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -578,8 +578,9 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
>  						| MUSB_PORT_STAT_RESUME;
>  				musb->rh_timer = jiffies
>  					+ msecs_to_jiffies(USB_RESUME_TIMEOUT);
> -				musb->need_finish_resume = 1;
> -
> +				musb_queue_resume_work(musb,
> +						       musb_host_finish_resume,
> +						       NULL);
>  				musb->xceiv->otg->state = OTG_STATE_A_HOST;
>  				musb->is_active = 1;
>  				musb_host_resume_root_hub(musb);
> @@ -1969,6 +1970,7 @@ static struct musb *allocate_instance(struct device *dev,
>  	INIT_LIST_HEAD(&musb->control);
>  	INIT_LIST_HEAD(&musb->in_bulk);
>  	INIT_LIST_HEAD(&musb->out_bulk);
> +	INIT_LIST_HEAD(&musb->pending_list);
>  
>  	musb->vbuserr_retry = VBUSERR_RETRY_COUNT;
>  	musb->a_wait_bcon = OTG_TIME_A_WAIT_BCON;
> @@ -2018,6 +2020,64 @@ static void musb_free(struct musb *musb)
>  	musb_host_free(musb);
>  }
>  
> +struct musb_pending_work {
> +	void (*callback)(struct musb *musb, void *data);
> +	void *data;
> +	struct list_head node;
> +};
> +
> +static void musb_pending_work(struct work_struct *work)
> +{
> +	struct musb *musb;
> +	struct musb_pending_work *w;
> +	unsigned long flags;
> +
> +	musb = container_of(work, struct musb, finish_resume_work.work);
> +	pm_runtime_get_sync(musb->controller);

Should still check for errors here.

> +	spin_lock_irqsave(&musb->list_lock, flags);
> +	while (!list_empty(&musb->pending_list)) {
> +		w = list_first_entry(&musb->pending_list,
> +				     struct musb_pending_work,
> +				     node);
> +		list_del(&w->node);
> +		spin_unlock_irqrestore(&musb->list_lock, flags);
> +		if (w->callback)
> +			w->callback(musb, w->data);
> +		devm_kfree(musb->controller, w);
> +		spin_lock_irqsave(&musb->list_lock, flags);
> +	}
> +	spin_unlock_irqrestore(&musb->list_lock, flags);
> +	pm_runtime_mark_last_busy(musb->controller);
> +	pm_runtime_put_autosuspend(musb->controller);
> +}
> +
> +void musb_queue_resume_work(struct musb *musb,
> +			    void (*callback)(struct musb *musb, void *data),
> +			    void *data)
> +{
> +	struct musb_pending_work *w;
> +	unsigned long flags;
> +
> +	if (!callback)
> +		return;

WARN_ON (e.g. in case someone switches the arguments)?

> +
> +	w = devm_kzalloc(musb->controller, sizeof(*w), GFP_ATOMIC);
> +	if (!w)
> +		return;
> +
> +	w->callback = callback;
> +	w->data = data;
> +	spin_lock_irqsave(&musb->list_lock, flags);
> +	list_add_tail(&w->node, &musb->pending_list);
> +	spin_unlock_irqrestore(&musb->list_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(musb_queue_resume_work);
> +
> +void musb_cancel_resume_work(struct musb *musb)
> +{
> +	cancel_delayed_work_sync(&musb->finish_resume_work);
> +}
> +
>  static void musb_deassert_reset(struct work_struct *work)
>  {
>  	struct musb *musb;
> @@ -2065,6 +2125,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  	}
>  
>  	spin_lock_init(&musb->lock);
> +	spin_lock_init(&musb->list_lock);
>  	musb->board_set_power = plat->set_power;
>  	musb->min_power = plat->min_power;
>  	musb->ops = plat->platform_ops;
> @@ -2215,7 +2276,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  	/* Init IRQ workqueue before request_irq */
>  	INIT_WORK(&musb->irq_work, musb_irq_work);
>  	INIT_DELAYED_WORK(&musb->deassert_reset_work, musb_deassert_reset);
> -	INIT_DELAYED_WORK(&musb->finish_resume_work, musb_host_finish_resume);
> +	INIT_DELAYED_WORK(&musb->finish_resume_work, musb_pending_work);
>  
>  	/* setup musb parts of the core (especially endpoints) */
>  	status = musb_core_init(plat->config->multipoint
> @@ -2310,7 +2371,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  
>  fail3:
>  	cancel_work_sync(&musb->irq_work);
> -	cancel_delayed_work_sync(&musb->finish_resume_work);
> +	musb_cancel_resume_work(musb);
>  	cancel_delayed_work_sync(&musb->deassert_reset_work);
>  	if (musb->dma_controller)
>  		musb_dma_controller_destroy(musb->dma_controller);
> @@ -2377,7 +2438,7 @@ static int musb_remove(struct platform_device *pdev)
>  	musb_exit_debugfs(musb);
>  
>  	cancel_work_sync(&musb->irq_work);
> -	cancel_delayed_work_sync(&musb->finish_resume_work);
> +	musb_cancel_resume_work(musb);
>  	cancel_delayed_work_sync(&musb->deassert_reset_work);
>  	pm_runtime_get_sync(musb->controller);
>  	musb_host_cleanup(musb);
> @@ -2603,11 +2664,9 @@ static int musb_resume(struct device *dev)
>  	mask = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV;
>  	if ((devctl & mask) != (musb->context.devctl & mask))
>  		musb->port1_status = 0;
> -	if (musb->need_finish_resume) {
> -		musb->need_finish_resume = 0;
> -		schedule_delayed_work(&musb->finish_resume_work,
> -				      msecs_to_jiffies(USB_RESUME_TIMEOUT));
> -	}
> +
> +	schedule_delayed_work(&musb->finish_resume_work,
> +			      msecs_to_jiffies(USB_RESUME_TIMEOUT));
>  
>  	/*
>  	 * The USB HUB code expects the device to be in RPM_ACTIVE once it came
> @@ -2633,8 +2692,8 @@ static int musb_runtime_suspend(struct device *dev)
>  
>  static int musb_runtime_resume(struct device *dev)
>  {
> -	struct musb	*musb = dev_to_musb(dev);
> -	static int	first = 1;
> +	struct musb *musb = dev_to_musb(dev);
> +	struct delayed_work *d = &musb->finish_resume_work;
>  
>  	/*
>  	 * When pm_runtime_get_sync called for the first time in driver
> @@ -2645,12 +2704,8 @@ static int musb_runtime_resume(struct device *dev)
>  	 * Also context restore without save does not make
>  	 * any sense
>  	 */

Perhaps using a dedicated initialised flag in struct musb would be more
self-explanatory (and less error prone) than overloading
finish_resume_work->work.func. Could be done in a preparatory patch.

Otherwise the above comment should probably be updated and mention this
use of d->work.func.

> -	if (!first)
> +	if (d->work.func) {
>  		musb_restore_context(musb);
> -	first = 0;
> -
> -	if (musb->need_finish_resume) {
> -		musb->need_finish_resume = 0;
>  		schedule_delayed_work(&musb->finish_resume_work,

Use d as first argument here?

>  				msecs_to_jiffies(USB_RESUME_TIMEOUT));

Perhaps sleep in musb_host_finish_resume() instead of always adding this
delay which is only needed for deasserting resume signalling and not for
generic (runtime) resume work (if you decide to use a common work
queue).

But why schedule from resume at all? It seems you could just schedule
the deferred-work processing directly after having registered a
callback.

> -static void musb_gadget_work(struct work_struct *work)
> +static void musb_gadget_work(struct musb *musb, void *unused)
>  {
> -	struct musb *musb;
>  	unsigned long flags;
>  
> -	musb = container_of(work, struct musb, gadget_work.work);
>  	pm_runtime_get_sync(musb->controller);

The get would already have been taken care of by musb_pending_work().

>  	spin_lock_irqsave(&musb->lock, flags);
>  	musb_pullup(musb, musb->softconnect);
> @@ -1677,7 +1691,7 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
>  	spin_lock_irqsave(&musb->lock, flags);
>  	if (is_on != musb->softconnect) {
>  		musb->softconnect = is_on;
> -		schedule_delayed_work(&musb->gadget_work, 0);
> +		musb_queue_resume_work(musb, musb_gadget_work, NULL);

You also need a pm_runtime_get() here to actually trigger the resume.

But if already resumed, the gadget work would not run until next
suspend-resume cycle. So if you want to reuse the resume work for this,
then you need to check the active status here and do the work directly
if already resumed as for musb_gadget_queue(). Or just always schedule
deferred work as mentioned above.

>  	}
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  
> @@ -1849,7 +1863,6 @@ int musb_gadget_setup(struct musb *musb)
>  #elif IS_ENABLED(CONFIG_USB_MUSB_GADGET)
>  	musb->g.is_otg = 0;
>  #endif
> -	INIT_DELAYED_WORK(&musb->gadget_work, musb_gadget_work);
>  	musb_g_init_endpoints(musb);
>  
>  	musb->is_active = 0;
> @@ -1871,7 +1884,7 @@ void musb_gadget_cleanup(struct musb *musb)
>  	if (musb->port_mode == MUSB_PORT_MODE_HOST)
>  		return;
>  
> -	cancel_delayed_work_sync(&musb->gadget_work);
> +	musb_cancel_resume_work(musb);

Doing this here as well, looks a bit weird but I guess it is needed for
the probe error path where musb_gadget_cleanup() is called before
cancelling the pending work (remove() would not need it, though).

>  	usb_del_gadget_udc(&musb->g);
>  }

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
