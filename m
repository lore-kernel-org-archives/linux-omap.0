From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Wed, 18 Jan 2017 16:42:23 -0800
Message-ID: <20170119004223.GO7403@atomide.com>
References: <20170117175524.3484-1-tony@atomide.com>
 <20170118142501.GA10928@uda0271908>
 <20170118165308.GC7403@atomide.com>
 <f33ba3b1-a35d-8d63-35ec-db1e0ca96c54@ti.com>
 <20170118181541.GJ7403@atomide.com>
 <20170118184432.GK7403@atomide.com>
 <20170118184840.GD10928@uda0271908>
 <20170118204859.GN7403@atomide.com>
 <20170118211309.GE10928@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170118211309.GE10928@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 13:14]:
> On Wed, Jan 18, 2017 at 12:48:59PM -0800, Tony Lindgren wrote:
> > And here's a fix for the error -71 regression.
> > 
> > Bin, can you review and test your earlier case mentioned in
> > commit 9298b4aad37e ("usb: musb: fix device hotplug behind hub") with
> > the patch below to make sure this is safe to do now starting with v4.9?
> > 
> 
> This solves the issue, and the patch looks good to me. Thanks for fixing
> it up.

OK will post a two patch musb fixes series with this and the
short in dma fix as that's what's keeping cpp41 channels hanging.

Then after that I'll post a series of two cpp41 fixes.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
