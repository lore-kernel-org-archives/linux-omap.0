From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Fri, 13 Jan 2017 09:50:20 -0800
Message-ID: <20170113175019.GB2630@atomide.com>
References: <20170112213016.19367-1-tony@atomide.com>
 <927792da-2e90-b2ae-1206-8fcb504d7551@ti.com>
 <20170112221933.GM2630@atomide.com>
 <1c8967b7-d59b-e53d-feeb-80c71464fb94@ti.com>
 <20170112230456.GS2630@atomide.com>
 <aafe7afb-6d8a-2fef-acdd-bd331151d16a@ti.com>
 <20170113000314.GU2630@atomide.com>
 <20170113161731.GV2630@atomide.com>
 <ba31f412-1b92-c4db-a1f4-82448e5ecf18@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ba31f412-1b92-c4db-a1f4-82448e5ecf18-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [170113 09:37]:
> On 01/13/2017 10:17 AM, Tony Lindgren wrote:
> > But anyways here's your basic idea plugged into my recent patch and
> > it seems to work. I maybe have missed something though while reading
> > so please check.
> > 
> > The pm_runtime_get/mark_last_busy/put_autosuspend and WARN_ON() we
> > want to keep in cppi41_irq() at least for now :)
> 
> As per my understanding and testing it looks like might be enough to
> have just pm_runtime_mark_last_busy(cdd->ddev.dev); in cppi41_irq().
> But it can be left as is and yes - over all idea is that irq should
> not be triggered if device is Idle.

OK yeah kicking the autoidle timeout is needed here.

> > And I'm thinking we must also callcppi41_run_queue() with spinlock
> > held to prevent out of order triggering of the DMA transfers.
> > 
> > Does this look OK to you?
> 
> I think yes. My current version is mostly similar to yours.

OK will update description and repost shortly.

> > @@ -1150,6 +1165,11 @@ static int __maybe_unused cppi41_resume(struct device *dev)
> >  static int __maybe_unused cppi41_runtime_suspend(struct device *dev)
> >  {
> >  	struct cppi41_dd *cdd = dev_get_drvdata(dev);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&cdd->lock, flags);
> > +	cdd->is_suspended = true;
> > +	spin_unlock_irqrestore(&cdd->lock, flags);
> >  
> >  	WARN_ON(!list_empty(&cdd->pending));
> 
> Shouldn't we check list_empty() under spin lock?

Yeah let's do that.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
