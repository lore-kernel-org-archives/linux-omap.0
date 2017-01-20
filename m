From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4 3/2] dmaengine: cppi41: Clean up pointless warnings
Date: Fri, 20 Jan 2017 13:31:26 -0800
Message-ID: <20170120213125.GO7403@atomide.com>
References: <20170119164908.9472-1-tony@atomide.com>
 <20170120200753.GM7403@atomide.com>
 <20170120210650.GG14571@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170120210650.GG14571@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170120 13:08]:
> On Fri, Jan 20, 2017 at 12:07:53PM -0800, Tony Lindgren wrote:
> > With patches "dmaengine: cppi41: Fix runtime PM timeouts with USB mass
> > storage", and "dmaengine: cppi41: Fix oops in cppi41_runtime_resume",
> > the pm_runtime_get/put() in cppi41_irq() is no longer needed. We now
> > guarantee that cppi41 is enabled when dma is in use.
> > 
> > We can still get pointless error -115 when musb is configured as a
> > usb peripheral. That's because we should now check for the state of
> > is_suspended instead.
> 
> I am not sure I understand this paragraph. Do you mean we still get
> harmless -115 in peripheral mode? If so how is it caused by is_suspended
> check? And the comment below for the check implies the WARN_ON() never
> happens...

Yes I noticed we can still get it in peripheral mode. And it's a bogus
warning now because we should now be using the new cdd->is_suspended
instead.

It happens because cppi41_runtime_resume() has not yet completed and is
calling cppi41_run_queue() that produces the interrupt. So that that point
we have cppi41 active with !cdd->is_suspended, but pm_runtime_get() still
returns -EINPROGRESS (115).

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
