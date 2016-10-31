From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: musb RPM sleep-while-atomic in 4.9-rc1
Date: Mon, 31 Oct 2016 12:49:21 +0100
Message-ID: <20161031114921.GB4254@localhost>
References: <20161025151110.vih52s47a2g2col5@atomide.com>
 <20161026142050.GK12024@localhost>
 <20161026143100.rg4pse6mjyq32hxm@atomide.com>
 <20161027151446.ffj6w2tydf6ymv7c@atomide.com>
 <20161027164416.GL12024@localhost>
 <20161027174016.43twztwekvb3b25t@atomide.com>
 <20161027184507.GM12024@localhost>
 <20161027191552.tuutyslp5qtu2b4f@atomide.com>
 <20161028094428.GO12024@localhost>
 <20161028181318.umwn3rx55pg2cvwd@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161028181318.umwn3rx55pg2cvwd-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 28, 2016 at 11:13:19AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161028 02:45]:
> > On Thu, Oct 27, 2016 at 12:15:52PM -0700, Tony Lindgren wrote:
> > > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161027 11:46]:
> > > > But then this looks like it could trigger an ABBA deadlock as musb->lock
> > > > is held while queue_on_resume() takes musb->list_lock, and
> > > > musb_run_pending() would take the same locks in the reverse order.
> > > 
> > > It seems we can avoid that by locking only list_add_tail() and list_del():
> > > 
> > > list_for_each_entry_safe(w, _w, &musb->resume_work, node) {
> > > 	spin_lock_irqsave(&musb->list_lock, flags);
> > > 	list_del(&w->node);
> > > 	spin_unlock_irqrestore(&musb->list_lock, flags);
> > > 	if (w->callback)
> > > 		w->callback(musb, w->data);
> > > 	devm_kfree(musb->controller, w);
> > > }
> > 
> > I think you still need to hold the lock while traversing the list (even
> > if you temporarily release it during the callback).
> 
> Hmm yeah we need iterate through the list again to avoid missing new
> elements being added. I've updated the patch to use a the common
> while (!list_empty(&musb->resume_work)) loop. Does that solve the
> concern you had or did you also had some other concern there?

Yeah, while that minimises the race window it is still possible that the
timer callback checks pm_runtime_active() after the queue has been
processed but before the rpm status is updated. 

How about using a work struct and synchronous get for the deferred case?

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
