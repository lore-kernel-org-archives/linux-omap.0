From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue
Date: Wed, 9 Nov 2016 16:39:53 +0100
Message-ID: <20161109153953.GG14744@localhost>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161107215020.31399-3-tony@atomide.com>
 <20161108170917.GA3328@localhost>
 <20161108173413.GM2428@atomide.com>
 <20161108190331.GA14744@localhost>
 <20161109012606.GR2428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161109012606.GR2428-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 08, 2016 at 06:26:07PM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161108 12:03]:
> > On Tue, Nov 08, 2016 at 10:34:13AM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161108 10:09]:
> > > > On Mon, Nov 07, 2016 at 02:50:18PM -0700, Tony Lindgren wrote:
> > > > > @@ -2604,6 +2669,9 @@ static int musb_resume(struct device *dev)
> > > > >  	mask = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV;
> > > > >  	if ((devctl & mask) != (musb->context.devctl & mask))
> > > > >  		musb->port1_status = 0;
> > > > > +
> > > > > +	schedule_delayed_work(&musb->pending_resume_work, 0);
> > > > > +
> > > > 
> > > > The interactions with system suspend looks a bit suspicious. It seems
> > > > you need to drain any pending resume work on suspend for example.
> > > > 
> > > > And then the above should not be needed, right?
> > > 
> > > Hmm that's an interesting idea. I think that would allow us to get
> > > rid of the delayed work if we check the list both on resume and
> > > suspend :)
> > 
> > Note that I was referring to draining the runtime-resume work on system
> > suspend above. I think we still want the delayed work considering that
> > we could stay active for long periods of time.
> 
> It seems it's the delayed work causing these race issues, so I'd like
> to avoid it. I think we can do it all from PM runtime resume and
> checking at the end of musb_queue_resume_work(). We need to introduce
> is_runtime_suspended though. This is along the lines of what we have
> in Documentation/power/runtime_pm.txt if you search for completion
> there.

Sure, if you can avoid processing the deferred work also at
runtime-suspend then getting rid of the delayed work would be preferred.

> Below is a version doing things without delayed work, care to check
> again if you still see races there?

I believe there are still some issues however.

> > > > In fact, the dsps timer must also be cancelled on suspend, or you could
> > > > end up calling dsps_check_status() while suspended (it is currently not
> > > > cancelled until the parent device is suspended, which could be too
> > > > late).
> > > 
> > > And then this should no longer be an issue either.
> > 
> > It would still be an issue as a system-suspending device could already
> > have been runtime-resumed so that dsps_check_status() would be called
> > directly from the timer function.
> 
> The glue layers should do pm_runtime_get_sync(musb->controller) which
> dsps glue already does. So that's the musb_core.c device instance. And
> looks like we have dsps_suspend() call del_timer_sync(&glue->timer)
> already. I think we're safe here.

But the point is that the controller might be RPM_ACTIVE if the
controller was already runtime resumed when it is system suspended.

Since this (and the previous) patch run the work directly from the timer
callback if active, it could end up accessing the controller after it
has been system suspended. Specifically, stopping the timer in the glue
(parent) suspend callback is too late to avoid this.

	pm_runtime_get_sync(musb->controller);
		musb_runtime_resume()
			musb_restore_context();
	
	...

	musb_suspend()
		musb_save_context();

	otg_timer()
		pm_runtime_get();
		if (pm_runtime_active(musb->controller))
			dsps_check_status();
		pm_runtime_put_autosuspend();

	dsps_suspend()
		del_timer_sync();

> 8< ----------------------
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
> resume. Note that we want to do this only when musb core and it's
> parent devices are awake as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>.
> 
> Later on we may be able to remove other delayed work in the musb driver
> and just do it from pending_resume_work. But this should be done only
> for delayed work that does not have other timing requirements beyond
> just being run on resume.
> 
> Fixes: 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> glue layer")
> Reported-by: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/usb/musb/musb_core.c   | 114 +++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/musb/musb_core.h   |   7 +++
>  drivers/usb/musb/musb_dsps.c   |  31 +++++++----
>  drivers/usb/musb/musb_gadget.c |  21 ++++++--
>  4 files changed, 156 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -1969,6 +1969,7 @@ static struct musb *allocate_instance(struct device *dev,
>  	INIT_LIST_HEAD(&musb->control);
>  	INIT_LIST_HEAD(&musb->in_bulk);
>  	INIT_LIST_HEAD(&musb->out_bulk);
> +	INIT_LIST_HEAD(&musb->pending_list);
>  
>  	musb->vbuserr_retry = VBUSERR_RETRY_COUNT;
>  	musb->a_wait_bcon = OTG_TIME_A_WAIT_BCON;
> @@ -2018,6 +2019,87 @@ static void musb_free(struct musb *musb)
>  	musb_host_free(musb);
>  }
>  
> +struct musb_pending_work {
> +	int (*callback)(struct musb *musb, void *data);
> +	void *data;
> +	struct list_head node;
> +};
> +
> +/*
> + * Called from musb_runtime_resume(), musb_resume(), and
> + * musb_queue_resume_work(). Callers must take musb->lock.
> + */
> +static int musb_run_resume_work(struct musb *musb)
> +{
> +	struct musb_pending_work *w, *_w;
> +	unsigned long flags;
> +	int error = 0;
> +
> +	spin_lock_irqsave(&musb->list_lock, flags);
> +	list_for_each_entry_safe(w, _w, &musb->pending_list, node) {
> +		if (w->callback) {
> +			error = w->callback(musb, w->data);
> +			if (error < 0) {
> +				dev_err(musb->controller,
> +					"resume callback %p failed: %i\n",
> +					w->callback, error);
> +			}
> +		}
> +		list_del(&w->node);
> +		devm_kfree(musb->controller, w);
> +	}
> +	spin_unlock_irqrestore(&musb->list_lock, flags);
> +
> +	return error;
> +}
> +
> +/*
> + * Called to run work if device is active or else queue the work to happen
> + * on resume. Caller must take musb->lock.

Caller must also hold an RPM reference.

> + *
> + * Note that we cowardly refuse queuing work after musb PM runtime
> + * resume is done calling musb_run_resume_work() and return -EINPROGRESS
> + * instead.
> + */
> +int musb_queue_resume_work(struct musb *musb,
> +			   int (*callback)(struct musb *musb, void *data),
> +			   void *data)
> +{
> +	struct musb_pending_work *w;
> +	unsigned long flags;
> +	int error;
> +
> +	if (WARN_ON(!callback))
> +		return -EINVAL;
> +
> +	if (pm_runtime_active(musb->controller))
> +		return callback(musb, data);
> +
> +	w = devm_kzalloc(musb->controller, sizeof(*w), GFP_ATOMIC);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	w->callback = callback;
> +	w->data = data;
> +	spin_lock_irqsave(&musb->list_lock, flags);
> +	if (musb->is_runtime_suspended) {
> +		list_add_tail(&w->node, &musb->pending_list);
> +		error = 0;
> +	} else {
> +		dev_err(musb->controller, "could not add resume work %p\n",
> +			callback);
> +		devm_kfree(musb->controller, w);
> +		error = -EINPROGRESS;

But this means you should be able to run the callback below, right? It
has to be run from somewhere so otherwise the caller needs to retry
instead.

> +	}
> +	spin_unlock_irqrestore(&musb->list_lock, flags);
> +
> +	if (pm_runtime_active(musb->controller))
> +		return musb_run_resume_work(musb);
> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(musb_queue_resume_work);
> +
>  static void musb_deassert_reset(struct work_struct *work)
>  {
>  	struct musb *musb;
> @@ -2065,6 +2147,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
>  	}
>  
>  	spin_lock_init(&musb->lock);
> +	spin_lock_init(&musb->list_lock);
>  	musb->board_set_power = plat->set_power;
>  	musb->min_power = plat->min_power;
>  	musb->ops = plat->platform_ops;
> @@ -2556,6 +2639,7 @@ static int musb_suspend(struct device *dev)
>  	struct musb	*musb = dev_to_musb(dev);
>  	unsigned long	flags;
>  
> +	WARN_ON(!list_empty(&musb->pending_list));

And this also depends on anyone attempting to queue work having first
gotten an RPM reference (so that driver core runtime resumes the device
before calling suspend()).

But no, there's actually still a window were this could be false when
work is queued while runtime resuming (and eventually is executed from
musb_queue_resume_work()).

>  	musb_platform_disable(musb);
>  	musb_generic_disable(musb);
>  
> @@ -2579,9 +2663,11 @@ static int musb_suspend(struct device *dev)
>  
>  static int musb_resume(struct device *dev)
>  {
> -	struct musb	*musb = dev_to_musb(dev);
> -	u8		devctl;
> -	u8		mask;
> +	struct musb *musb = dev_to_musb(dev);
> +	unsigned long flags;
> +	int error;
> +	u8 devctl;
> +	u8 mask;
>  
>  	/*
>  	 * For static cmos like DaVinci, register values were preserved
> @@ -2599,6 +2685,7 @@ static int musb_resume(struct device *dev)
>  	mask = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV;
>  	if ((devctl & mask) != (musb->context.devctl & mask))
>  		musb->port1_status = 0;
> +
>  	if (musb->need_finish_resume) {
>  		musb->need_finish_resume = 0;
>  		schedule_delayed_work(&musb->finish_resume_work,
> @@ -2615,6 +2702,13 @@ static int musb_resume(struct device *dev)
>  
>  	musb_start(musb);
>  
> +	spin_lock_irqsave(&musb->lock, flags);
> +	error = musb_run_resume_work(musb);
> +	if (error)
> +		dev_err(musb->controller, "resume work failed with %i\n",
> +			error);
> +	spin_unlock_irqrestore(&musb->lock, flags);
> +
>  	return 0;
>  }
>  
> @@ -2622,14 +2716,18 @@ static int musb_runtime_suspend(struct device *dev)
>  {
>  	struct musb	*musb = dev_to_musb(dev);
>  
> +	WARN_ON(!list_empty(&musb->pending_list));

This does not seem to hold as work could get queued while RPM_SUSPENDING
unless you also take the list_lock here (or add explicit barriers).

>  	musb_save_context(musb);
> +	musb->is_runtime_suspended = 1;
>  
>  	return 0;
>  }

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
