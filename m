From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Fri, 28 Oct 2016 11:44:28 +0200
Message-ID: <20161028094428.GO12024@localhost>
References: <20161024173538.26xvlitxiwjmh4fx@atomide.com>
 <20161025083237.GF12024@localhost>
 <20161025151110.vih52s47a2g2col5@atomide.com>
 <20161026142050.GK12024@localhost>
 <20161026143100.rg4pse6mjyq32hxm@atomide.com>
 <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
 <20161027174016.43twztwekvb3b25t@atomide.com>
 <20161027184507.GM12024@localhost>
 <20161027191552.tuutyslp5qtu2b4f@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161027191552.tuutyslp5qtu2b4f-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2016 at 12:15:52PM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161027 11:46]:
> > On Thu, Oct 27, 2016 at 10:40:17AM -0700, Tony Lindgren wrote:

> > > diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> > > --- a/drivers/usb/musb/musb_gadget.c
> > > +++ b/drivers/usb/musb/musb_gadget.c
> > > @@ -1222,6 +1222,13 @@ void musb_ep_restart(struct musb *musb, struct musb_request *req)
> > >  		rxstate(musb, req);
> > >  }
> > >  
> > > +void musb_ep_restart_resume_work(struct musb *musb, void *data)
> > > +{
> > > +	struct musb_request *req = data;
> > > +
> > > +	musb_ep_restart(musb, req);
> > 
> > This one is supposed to be called with musb->lock held (according to the
> > function header anyway).
> 
> Good point, yeah that calls the monster functions txstate and rxstate.
> 
> > >  static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
> > >  			gfp_t gfp_flags)
> > >  {
> > > @@ -1255,7 +1262,7 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
> > >  
> > >  	map_dma_buffer(request, musb, musb_ep);
> > >  
> > > -	pm_runtime_get_sync(musb->controller);
> > > +	pm_runtime_get(musb->controller);
> > >  	spin_lock_irqsave(&musb->lock, lockflags);
> > >  
> > >  	/* don't queue if the ep is down */
> > > @@ -1271,8 +1278,13 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
> > >  	list_add_tail(&request->list, &musb_ep->req_list);
> > >  
> > >  	/* it this is the head of the queue, start i/o ... */
> > > -	if (!musb_ep->busy && &request->list == musb_ep->req_list.next)
> > > -		musb_ep_restart(musb, request);
> > > +	if (!musb_ep->busy && &request->list == musb_ep->req_list.next) {
> > > +		if (pm_runtime_active(musb->controller))
> > > +			musb_ep_restart(musb, request);
> > > +		else
> > > +			musb_queue_on_resume(musb, musb_ep_restart_resume_work,
> > > +					     request);
> > > +	}
> > 
> > But then this looks like it could trigger an ABBA deadlock as musb->lock
> > is held while queue_on_resume() takes musb->list_lock, and
> > musb_run_pending() would take the same locks in the reverse order.
> 
> It seems we can avoid that by locking only list_add_tail() and list_del():
> 
> list_for_each_entry_safe(w, _w, &musb->resume_work, node) {
> 	spin_lock_irqsave(&musb->list_lock, flags);
> 	list_del(&w->node);
> 	spin_unlock_irqrestore(&musb->list_lock, flags);
> 	if (w->callback)
> 		w->callback(musb, w->data);
> 	devm_kfree(musb->controller, w);
> }

I think you still need to hold the lock while traversing the list (even
if you temporarily release it during the callback).

But this is related to another issue; what if a new callback is
registered while musb_runtime_resume is running? It seems we could end
up queueing work which might never be executed (e.g. if queued just
after musb_run_pending() is done or while processing the last
callback).

> Or do you have some better ideas?

Not right now sorry, and I'll be away from keyboard the rest of the day,
I'm afraid.

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
