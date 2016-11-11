From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue
Date: Fri, 11 Nov 2016 13:03:27 +0100
Message-ID: <20161111120327.GM14744@localhost>
References: <20161108170917.GA3328@localhost>
 <20161108173413.GM2428@atomide.com>
 <20161108190331.GA14744@localhost>
 <20161109012606.GR2428@atomide.com>
 <20161109153953.GG14744@localhost>
 <20161109175437.GZ2428@atomide.com>
 <20161110160423.GJ14744@localhost>
 <20161110174150.GC27724@atomide.com>
 <20161110184255.GL14744@localhost>
 <20161110194003.GI27724@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161110194003.GI27724-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2016 at 12:40:03PM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161110 11:43]:
> > On Thu, Nov 10, 2016 at 10:41:50AM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161110 09:04]:
> > > > I'm afraid that won't work as pm_runtime_get() would still succeed (i.e.
> > > > even after musb_suspend()).
> > > > 
> > > > See 6f3c77b040fc ("PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE,
> > > > even when disabled, v2").
> > > 
> > > But doesn't that assume that we have musb core as in musb->controller
> > > in RPM_ACTIVE state? While if it's been suspended that's not the
> > > case meaning rpm_resume would fail?
> > 
> > Right, and it's still a good idea to check the return value of
> > pm_runtime_get(). It just won't be enough for when RPM_ACTIVE.
> > 
> > > If we have a window for a race there with RPM_ACTIVE set, we could
> > > add musb->is_disabled flag that gets set in musb_suspend().
> > 
> > Yes.
> > 
> > > > > In the long run it would be nice to make whatever optional state polling
> > > > > musb generic with just a glue layer callback.
> > > > 
> > > > Yes, and make sure to stop polling in musb_suspend(). Would it be
> > > > possible to use the enable and disable ops for this until then?
> > > 
> > > Hmm care to explain a bit more? That is assuming that rpm_resume()
> > > won't fail above.. And that using musb->is_disabled flag won't
> > > work..
> > 
> > By stopping the timer in musb->ops->disable which is called during
> > suspend, the race could perhaps also be avoided.
> 
> Yes I think that's the way to go here :) Updated version below
> again.
> 
> Regards,
> 
> Tony
> 
> 8< --------------------------
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
> parent devices are awake, and we need to make sure the DSPS glue
> timer is stopped as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>.
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
>  drivers/usb/musb/musb_core.c   | 110 +++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/musb/musb_core.h   |   7 +++
>  drivers/usb/musb/musb_dsps.c   |  35 +++++++++----
>  drivers/usb/musb/musb_gadget.c |  32 ++++++++++--
>  4 files changed, 166 insertions(+), 18 deletions(-)
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
> @@ -2018,6 +2019,85 @@ static void musb_free(struct musb *musb)
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
> + * musb_queue_resume_work(). Callers must take musb->lock and must hold
> + * an RPM reference.

The RPM reference is needed for musb_queue_resume_work() below, not this
one.

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
> +	}
> +	spin_unlock_irqrestore(&musb->list_lock, flags);
> +
> +	return error;
> +}
> +EXPORT_SYMBOL_GPL(musb_queue_resume_work);
> +
>  static void musb_deassert_reset(struct work_struct *work)
>  {
>  	struct musb *musb;

> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -185,24 +185,19 @@ static void dsps_musb_disable(struct musb *musb)
>  	musb_writel(reg_base, wrp->coreintr_clear, wrp->usb_bitmap);
>  	musb_writel(reg_base, wrp->epintr_clear,
>  			 wrp->txep_bitmap | wrp->rxep_bitmap);
> +	del_timer_sync(&glue->timer);

Don't you want to move starting the timer to dsps_musb_enable() as well?

>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>  }
>  
> -static void otg_timer(unsigned long _musb)
> +/* Caller must take musb->lock */
> +static int dsps_check_status(struct musb *musb, void *unused)
>  {
> -	struct musb *musb = (void *)_musb;
>  	void __iomem *mregs = musb->mregs;
>  	struct device *dev = musb->controller;
>  	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
>  	const struct dsps_musb_wrapper *wrp = glue->wrp;
>  	u8 devctl;
> -	unsigned long flags;
>  	int skip_session = 0;
> -	int err;
> -
> -	err = pm_runtime_get_sync(dev);
> -	if (err < 0)
> -		dev_err(dev, "Poll could not pm_runtime_get: %i\n", err);
>  
>  	/*
>  	 * We poll because DSPS IP's won't expose several OTG-critical
> @@ -212,7 +207,6 @@ static void otg_timer(unsigned long _musb)
>  	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
>  				usb_otg_state_string(musb->xceiv->otg->state));
>  
> -	spin_lock_irqsave(&musb->lock, flags);
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_A_WAIT_VRISE:
>  		mod_timer(&glue->timer, jiffies +
> @@ -245,8 +239,29 @@ static void otg_timer(unsigned long _musb)
>  	default:
>  		break;
>  	}
> -	spin_unlock_irqrestore(&musb->lock, flags);
>  
> +	return 0;
> +}
> +
> +static void otg_timer(unsigned long _musb)
> +{
> +	struct musb *musb = (void *)_musb;
> +	struct device *dev = musb->controller;
> +	unsigned long flags;
> +	int err;
> +
> +	err = pm_runtime_get(dev);
> +	if ((err != -EINPROGRESS) && err < 0) {
> +		dev_err(dev, "Poll could not pm_runtime_get: %i\n", err);
> +

Add pm_runtime_put_noidle() to balance the counter also on errors.

> +		return;
> +	}
> +
> +	spin_lock_irqsave(&musb->lock, flags);
> +	err = musb_queue_resume_work(musb, dsps_check_status, NULL);
> +	if (err < 0)
> +		dev_err(dev, "%s resume work: %i\n", __func__, err);
> +	spin_unlock_irqrestore(&musb->lock, flags);
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  }
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1222,13 +1222,22 @@ void musb_ep_restart(struct musb *musb, struct musb_request *req)
>  		rxstate(musb, req);
>  }
>  
> +static int musb_ep_restart_resume_work(struct musb *musb, void *data)
> +{
> +	struct musb_request *req = data;
> +
> +	musb_ep_restart(musb, req);
> +
> +	return 0;
> +}
> +
>  static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
>  			gfp_t gfp_flags)
>  {
>  	struct musb_ep		*musb_ep;
>  	struct musb_request	*request;
>  	struct musb		*musb;
> -	int			status = 0;
> +	int			status;
>  	unsigned long		lockflags;
>  
>  	if (!ep || !req)
> @@ -1245,6 +1254,16 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
>  	if (request->ep != musb_ep)
>  		return -EINVAL;
>  
> +	status = pm_runtime_get(musb->controller);
> +	if ((status != -EINPROGRESS) && status < 0) {
> +		dev_err(musb->controller,
> +			"pm runtime get failed in %s\n",
> +			__func__);

Missing pm_runtime_put_noidle() here too.

> +
> +		return status;
> +	}
> +	status = 0;
> +

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
