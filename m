From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Thu, 27 Oct 2016 20:45:07 +0200
Message-ID: <20161027184507.GM12024@localhost>
References: <20161021110725.GA5192@localhost>
 <20161021112745.lancojpgv4h6aqpw@atomide.com>
 <20161024173538.26xvlitxiwjmh4fx@atomide.com>
 <20161025083237.GF12024@localhost>
 <20161025151110.vih52s47a2g2col5@atomide.com>
 <20161026142050.GK12024@localhost>
 <20161026143100.rg4pse6mjyq32hxm@atomide.com>
 <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
 <20161027174016.43twztwekvb3b25t@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161027174016.43twztwekvb3b25t-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2016 at 10:40:17AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161027 09:45]:
> > On Thu, Oct 27, 2016 at 08:14:46AM -0700, Tony Lindgren wrote:
> > > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161026 07:32]:
> > 
> > > 8< -------------------------------
> > > From tony Mon Sep 17 00:00:00 2001
> > > From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > Date: Tue, 25 Oct 2016 08:42:00 -0700
> > > Subject: [PATCH] usb: musb: Fix sleeping function called from invalid
> > >  context for hdrc glue
> > > 
> > > Commit 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
> > > glue layer") wrongly added a call for pm_runtime_get_sync to otg_timer
> > > that runs in softirq context. That causes a "BUG: sleeping function called
> > > from invalid context" every time when polling the cable status:
> > > 
> > > [<c015ebb4>] (__might_sleep) from [<c0413d60>] (__pm_runtime_resume+0x9c/0xa0)
> > > [<c0413d60>] (__pm_runtime_resume) from [<c04d0bc4>] (otg_timer+0x3c/0x254)
> > > [<c04d0bc4>] (otg_timer) from [<c0191180>] (call_timer_fn+0xfc/0x41c)
> > > [<c0191180>] (call_timer_fn) from [<c01915c0>] (expire_timers+0x120/0x210)
> > > [<c01915c0>] (expire_timers) from [<c0191acc>] (run_timer_softirq+0xa4/0xdc)
> > > [<c0191acc>] (run_timer_softirq) from [<c010168c>] (__do_softirq+0x12c/0x594)
> > > 
> > > I did not notice that as I did not have CONFIG_DEBUG_ATOMIC_SLEEP enabled.
> > > 
> > > Let's fix the issue by adding dsps_check_status() and then register a
> > > callback with musb_runtime_resume() so it gets called only when musb core
> > > and it's parent devices are awake. Note that we don't want to do this from
> > > PM runtime resume in musb_dsps.c as musb core is not awake yet at that
> > > point as noted by Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>.
> > 
> > It seems some chunks are missing since this patch only runs the
> > deferred work at remove and not at runtime resume, effectively breaking
> > detection.
> 
> Oops sorry yeah looks like I had that in a separate debug hacks patch..
> 
> > > Note that musb_gadget_queue() also suffers from a similar issue when
> > > connecting the cable and cannot use pm_runtime_get_sync().
> > 
> > You seem to have left that pm_runtime_get_sync() in there though.
> 
> And that one I must have hosed when cleaning up, thanks for noticing
> these. Updated patch below.

I had a couple of inline comments to the previous version about locking
in the gadget code as well (hidden after too much context). Looks like
there's a lock missing for the deferred work, and something that seems
like a possible ABBA deadlock.

> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1222,6 +1222,13 @@ void musb_ep_restart(struct musb *musb, struct musb_request *req)
>  		rxstate(musb, req);
>  }
>  
> +void musb_ep_restart_resume_work(struct musb *musb, void *data)
> +{
> +	struct musb_request *req = data;
> +
> +	musb_ep_restart(musb, req);

This one is supposed to be called with musb->lock held (according to the
function header anyway).

> +}
> +
>  static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
>  			gfp_t gfp_flags)
>  {
> @@ -1255,7 +1262,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
>  
>  	map_dma_buffer(request, musb, musb_ep);
>  
> -	pm_runtime_get_sync(musb->controller);
> +	pm_runtime_get(musb->controller);
>  	spin_lock_irqsave(&musb->lock, lockflags);
>  
>  	/* don't queue if the ep is down */
> @@ -1271,8 +1278,13 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
>  	list_add_tail(&request->list, &musb_ep->req_list);
>  
>  	/* it this is the head of the queue, start i/o ... */
> -	if (!musb_ep->busy && &request->list == musb_ep->req_list.next)
> -		musb_ep_restart(musb, request);
> +	if (!musb_ep->busy && &request->list == musb_ep->req_list.next) {
> +		if (pm_runtime_active(musb->controller))
> +			musb_ep_restart(musb, request);
> +		else
> +			musb_queue_on_resume(musb, musb_ep_restart_resume_work,
> +					     request);
> +	}

But then this looks like it could trigger an ABBA deadlock as musb->lock
is held while queue_on_resume() takes musb->list_lock, and
musb_run_pending() would take the same locks in the reverse order.

>  
>  unlock:
>  	spin_unlock_irqrestore(&musb->lock, lockflags);

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
