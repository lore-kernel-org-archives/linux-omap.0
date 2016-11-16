From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] dma: cpp41: Fix handling of error path
Date: Wed, 16 Nov 2016 09:11:55 -0800
Message-ID: <20161116171155.GQ4082@atomide.com>
References: <20161111192852.25399-1-tony@atomide.com>
 <8d1e380a-ec75-3893-ea50-65e1526d58ea@ti.com>
 <20161115205816.GN4082@atomide.com>
 <91726bb9-4919-22a4-174b-9c89e1001421@ti.com>
 <20161116145455.GP4082@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161116145455.GP4082-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161116 06:55]:
> * Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [161115 22:25]:
> > On Wednesday 16 November 2016 02:28 AM, Tony Lindgren wrote:
> > > * Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> [161115 00:35]:
> > >> If pm_runtime_get_sync() fails due to callback error, then
> > >> rpm_callback() sets dev.power.runtime_error to an error value which gets
> > >> cleared by an explicit call to pm_runtime_set_suspended().
> > >>
> > >> This will tell the framework that the status of device is suspended.
> > >> Else, the failure will be sticky and on subsequent attempts,
> > >> rpm_resume() will keep returning early instead of trying to resume the
> > >> device again.
> > >>
> > >> This is as far as I can gather from code. So, I believe the recovery
> > >> path should be:
> > >>
> > >> 	if (error < 0) {
> > >> 		pm_runtime_set_suspended(cdd->ddev.dev);
> > >> 		pm_runtime_put_noidle(cdd->ddev.dev);
> > >>
> > >> 		...
> > > 
> > > Well we should test this :)
> > 
> > Yes, right! Was this patch created to fix an error in practice or just
> > based on code review?
> 
> Based on code review for related musb fixes. I'll test the above today
> at some point.

OK so adding pm_runtime_set_suspended() allows retries, but it also seems
dangerous as it clears dev.power.runtime_error. I think we're better of
not having cppi41 work at all on errors which now happens. Otherwise some
errors could just get ignored and we may even risk corrupting data.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
