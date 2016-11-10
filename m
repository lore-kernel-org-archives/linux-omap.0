From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue
Date: Thu, 10 Nov 2016 19:42:55 +0100
Message-ID: <20161110184255.GL14744@localhost>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161107215020.31399-3-tony@atomide.com>
 <20161108170917.GA3328@localhost>
 <20161108173413.GM2428@atomide.com>
 <20161108190331.GA14744@localhost>
 <20161109012606.GR2428@atomide.com>
 <20161109153953.GG14744@localhost>
 <20161109175437.GZ2428@atomide.com>
 <20161110160423.GJ14744@localhost>
 <20161110174150.GC27724@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161110174150.GC27724-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2016 at 10:41:50AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161110 09:04]:
> > On Wed, Nov 09, 2016 at 10:54:38AM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161109 08:40]:
> > > > On Tue, Nov 08, 2016 at 06:26:07PM -0700, Tony Lindgren wrote:
> > > > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161108 12:03]:
> > > > > > On Tue, Nov 08, 2016 at 10:34:13AM -0700, Tony Lindgren wrote:
> > > > > > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161108 10:09]:
> > 
> > > > > > > > In fact, the dsps timer must also be cancelled on suspend, or you could
> > > > > > > > end up calling dsps_check_status() while suspended (it is currently not
> > > > > > > > cancelled until the parent device is suspended, which could be too
> > > > > > > > late).
> > > > > > > 
> > > > > > > And then this should no longer be an issue either.
> > > > > > 
> > > > > > It would still be an issue as a system-suspending device could already
> > > > > > have been runtime-resumed so that dsps_check_status() would be called
> > > > > > directly from the timer function.
> > > > > 
> > > > > The glue layers should do pm_runtime_get_sync(musb->controller) which
> > > > > dsps glue already does. So that's the musb_core.c device instance. And
> > > > > looks like we have dsps_suspend() call del_timer_sync(&glue->timer)
> > > > > already. I think we're safe here.
> > > > 
> > > > But the point is that the controller might be RPM_ACTIVE if the
> > > > controller was already runtime resumed when it is system suspended.
> > > > 
> > > > Since this (and the previous) patch run the work directly from the timer
> > > > callback if active, it could end up accessing the controller after it
> > > > has been system suspended. Specifically, stopping the timer in the glue
> > > > (parent) suspend callback is too late to avoid this.
> > > > 
> > > > 	pm_runtime_get_sync(musb->controller);
> > > > 		musb_runtime_resume()
> > > > 			musb_restore_context();
> > > > 	
> > > > 	...
> > > > 
> > > > 	musb_suspend()
> > > > 		musb_save_context();
> > > > 
> > > > 	otg_timer()
> > > > 		pm_runtime_get();
> > > > 		if (pm_runtime_active(musb->controller))
> > > > 			dsps_check_status();
> > > > 		pm_runtime_put_autosuspend();
> > > > 
> > > > 	dsps_suspend()
> > > > 		del_timer_sync();
> > > > 
> > > 
> > > OK so we need to return without doing anything from otg_timer() on
> > > pm_runtime_get() to avoid that.
> > 
> > I'm afraid that won't work as pm_runtime_get() would still succeed (i.e.
> > even after musb_suspend()).
> > 
> > See 6f3c77b040fc ("PM / Runtime: let rpm_resume() succeed if RPM_ACTIVE,
> > even when disabled, v2").
> 
> But doesn't that assume that we have musb core as in musb->controller
> in RPM_ACTIVE state? While if it's been suspended that's not the
> case meaning rpm_resume would fail?

Right, and it's still a good idea to check the return value of
pm_runtime_get(). It just won't be enough for when RPM_ACTIVE.

> If we have a window for a race there with RPM_ACTIVE set, we could
> add musb->is_disabled flag that gets set in musb_suspend().

Yes.

> > > In the long run it would be nice to make whatever optional state polling
> > > musb generic with just a glue layer callback.
> > 
> > Yes, and make sure to stop polling in musb_suspend(). Would it be
> > possible to use the enable and disable ops for this until then?
> 
> Hmm care to explain a bit more? That is assuming that rpm_resume()
> won't fail above.. And that using musb->is_disabled flag won't
> work..

By stopping the timer in musb->ops->disable which is called during
suspend, the race could perhaps also be avoided.

> > > > > +	if (musb->is_runtime_suspended) {
> > > > > +		list_add_tail(&w->node, &musb->pending_list);
> > > > > +		error = 0;
> > > > > +	} else {
> > > > > +		dev_err(musb->controller, "could not add resume work %p\n",
> > > > > +			callback);
> > > > > +		devm_kfree(musb->controller, w);
> > > > > +		error = -EINPROGRESS;
> > > > 
> > > > But this means you should be able to run the callback below, right? It
> > > > has to be run from somewhere so otherwise the caller needs to retry
> > > > instead.
> > > 
> > > Well there's no longer need to run the callback at that point any longer
> > > and with that removed that should not be an issue.
> > > 
> > > Anyways, musb->is_runtime_suspended is needed to protect anything from
> > > being queued between runtime resume having called musb_run_resume_work()
> > > and before pm_runtime_active() is true. At that point the caller could
> > > just wait for pm_runtime_active() to be set and run the code. But based
> > > on my tests that does not happen and queueing is faster than getting to
> > > the pm_runtime_active() state so we just print errors in those cases if
> > > we ever hit it later on.
> > 
> > But for a generic solution, this race could still be an issue. What
> > about musb_gadget_queue() for example? Would not failing to start I/O
> > if racing with resume be a problem?
> 
> It's probably safest to return an error for cases like that rather
> than attempt to do something and risk corrupting packets. I'll move
> the check to happen earlier musb_gadget_queue() so we don't do
> anything with the request if pm_runtime_get() fails there. That
> should make it easy to add further handling if we ever start really
> hitting that issue.

Ok.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
