From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Thu, 12 Jan 2017 14:19:34 -0800
Message-ID: <20170112221933.GM2630@atomide.com>
References: <20170112213016.19367-1-tony@atomide.com>
 <927792da-2e90-b2ae-1206-8fcb504d7551@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <927792da-2e90-b2ae-1206-8fcb504d7551-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170112 13:54]:
> On 01/12/2017 03:30 PM, Tony Lindgren wrote:
>
> Sry, but even if it looks better it might still race with PM runtime :(
> 
> > -	if (likely(pm_runtime_active(cdd->ddev.dev)))
> > +	if (likely(atomic_read(&cdd->active)))
> >  		push_desc_queue(c);
> >  	else
> 
> 
> - CPU is here (-EINPROGRESS and active == 0) and then preempted 
> - PM runtime will finish cppi41_runtime_resume and clean-up pending descs
> - CPU return here and adds desc to the pending queue
> - oops
> 
> Am I wrong?

We had cppi41_dma_issue_pending() getting called from atomic contex and
cppi41_runtime_resume() getting preempted where cppi41_dma_issue_pending()
would add to the queue.

If what you're saying can happen in some cases, then we again see the
WARN_ON(!list_empty(&cdd->pending)) in cppi41_runtime_suspend(). At least
so far I have no longer been able to make happen today.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
