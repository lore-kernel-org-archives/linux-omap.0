From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue
Date: Thu, 10 Nov 2016 17:04:23 +0100
Message-ID: <20161110160423.GJ14744@localhost>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161107215020.31399-3-tony@atomide.com>
 <20161108170917.GA3328@localhost>
 <20161108173413.GM2428@atomide.com>
 <20161108190331.GA14744@localhost>
 <20161109012606.GR2428@atomide.com>
 <20161109153953.GG14744@localhost>
 <20161109175437.GZ2428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161109175437.GZ2428-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 09, 2016 at 10:54:38AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161109 08:40]:
> > On Tue, Nov 08, 2016 at 06:26:07PM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161108 12:03]:
> > > > On Tue, Nov 08, 2016 at 10:34:13AM -0700, Tony Lindgren wrote:
> > > > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161108 10:09]:

> > > > > > In fact, the dsps timer must also be cancelled on suspend, or you could
> > > > > > end up calling dsps_check_status() while suspended (it is currently not
> > > > > > cancelled until the parent device is suspended, which could be too
> > > > > > late).
> > > > > 
> > > > > And then this should no longer be an issue either.
> > > > 
> > > > It would still be an issue as a system-suspending device could already
> > > > have been runtime-resumed so that dsps_check_status() would be called
> > > > directly from the timer function.
> > > 
> > > The glue layers should do pm_runtime_get_sync(musb->controller) which
> > > dsps glue already does. So that's the musb_core.c device instance. And
> > > looks like we have dsps_suspend() call del_timer_sync(&glue->timer)
> > > already. I think we're safe here.
> > 
> > But the point is that the controller might be RPM_ACTIVE if the
> > controller was already runtime resumed when it is system suspended.
> > 
> > Since this (and the previous) patch run the work directly from the timer
> > callback if active, it could end up accessing the controller after it
> > has been system suspended. Specifically, stopping the timer in the glue
> > (parent) suspend callback is too late to avoid this.
> > 
> > 	pm_runtime_get_sync(musb->controller);
> > 		musb_runtime_resume()
> > 			musb_restore_context();
> > 	
> > 	...
> > 
> > 	musb_suspend()
> > 		musb_save_context();
> > 
> > 	otg_timer()
> > 		pm_runtime_get();
> > 		if (pm_runtime_active(musb->controller))
> > 			dsps_check_status();
> > 		pm_runtime_put_autosuspend();
> > 
> > 	dsps_suspend()
> > 		del_timer_sync();
> > 
> 
> OK so we need to return without doing anything from otg_timer() on
> pm_runtime_get() to avoid that.

I'm afraid that won't work as pm_runtime_get() would still succeed (i.e.
even after musb_suspend()).

See 6f3c77b040fc ("PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE,
even when disabled, v2").

> In the long run it would be nice to make whatever optional state polling
> musb generic with just a glue layer callback.

Yes, and make sure to stop polling in musb_suspend(). Would it be
possible to use the enable and disable ops for this until then?

> > > +/*
> > > + * Called to run work if device is active or else queue the work to happen
> > > + * on resume. Caller must take musb->lock.
> > 
> > Caller must also hold an RPM reference.
> 
> Good point, will add.
> 
> > > +	if (musb->is_runtime_suspended) {
> > > +		list_add_tail(&w->node, &musb->pending_list);
> > > +		error = 0;
> > > +	} else {
> > > +		dev_err(musb->controller, "could not add resume work %p\n",
> > > +			callback);
> > > +		devm_kfree(musb->controller, w);
> > > +		error = -EINPROGRESS;
> > 
> > But this means you should be able to run the callback below, right? It
> > has to be run from somewhere so otherwise the caller needs to retry
> > instead.
> 
> Well there's no longer need to run the callback at that point any longer
> and with that removed that should not be an issue.
> 
> Anyways, musb->is_runtime_suspended is needed to protect anything from
> being queued between runtime resume having called musb_run_resume_work()
> and before pm_runtime_active() is true. At that point the caller could
> just wait for pm_runtime_active() to be set and run the code. But based
> on my tests that does not happen and queueing is faster than getting to
> the pm_runtime_active() state so we just print errors in those cases if
> we ever hit it later on.

But for a generic solution, this race could still be an issue. What
about musb_gadget_queue() for example? Would not failing to start I/O
if racing with resume be a problem?

> Sounds like the rest of your comments are no longer an issue, please
> let me know if that's not the case.

I think the barrier comment for the WARN_ON on musb_runtime_suspend()
still applies.

> 8< ---------------------------
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
>  drivers/usb/musb/musb_core.c   | 112 +++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/musb/musb_core.h   |   7 +++
>  drivers/usb/musb/musb_dsps.c   |  34 +++++++++----
>  drivers/usb/musb/musb_gadget.c |  21 ++++++--
>  4 files changed, 157 insertions(+), 17 deletions(-)
 
> @@ -2622,14 +2714,18 @@ static int musb_runtime_suspend(struct device *dev)
>  {
>  	struct musb	*musb = dev_to_musb(dev);
>  
> +	WARN_ON(!list_empty(&musb->pending_list));
>  	musb_save_context(musb);
> +	musb->is_runtime_suspended = 1;

Isn't the compiler free to reorder the store to is_runtime_suspended
here so that the WARN_ON could trigger when queuing is racing with
runtime suspend?

Removing the WARN_ON, or moving it under list_lock while updating
is_runtime_suspended should do.

>  	return 0;
>  }

> +static void otg_timer(unsigned long _musb)
> +{
> +	struct musb *musb = (void *)_musb;
> +	struct device *dev = musb->controller;
> +	unsigned long flags;
> +	int err;
> +
> +	err = pm_runtime_get(dev);
> +	if (err < 0) {
> +		dev_err(dev, "Poll could not pm_runtime_get: %i\n", err);

So as mentioned above, this would not be sufficient to detect that dev
has been (system) suspended.

> +
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
> @@ -1222,6 +1222,15 @@ void musb_ep_restart(struct musb *musb, struct musb_request *req)
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
> @@ -1255,7 +1264,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
>  
>  	map_dma_buffer(request, musb, musb_ep);
>  
> -	pm_runtime_get_sync(musb->controller);
> +	pm_runtime_get(musb->controller);

Add the missing error handling here too?

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
