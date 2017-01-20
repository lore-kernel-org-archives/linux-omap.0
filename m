From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv4 0/2] cppi41 dma fixes for v4.10-rc cycle
Date: Fri, 20 Jan 2017 11:32:54 -0600
Message-ID: <20170120173137.GB14571@uda0271908>
References: <20170119164908.9472-1-tony@atomide.com>
 <20170120172003.GN3573@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170120172003.GN3573@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 20, 2017 at 10:50:03PM +0530, Vinod Koul wrote:
> On Thu, Jan 19, 2017 at 08:49:06AM -0800, Tony Lindgren wrote:
> > Hi all,
> > 
> > I'm using v4 naming here as the earlier patch "dmaengine: cppi41: Add dma
> > support to da8xx" has been separated from the error -115 issue. We've
> > identified so far three musb and cppi41 regressions:
> 
> Hi,
> 
> Can we get some tested-by for this series?

Tested-by: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, or
Acked-by: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, whichever you prefer ;)

Regards,
-Bin.

> 
> > 
> > 1. Error -71 regression with musb
> > 
> >    This is not dma related, and fixed with recently posted patch
> >    "[PATCH 1/2] usb: musb: Fix host mode error -71 regression".
> > 
> > 2. Error -115 regression with cppi41 dma with musb
> > 
> >    This regression was caused by commit 098de42ad670 ("dmaengine:
> >    cppi41: Fix unpaired pm runtime when only a USB hub is connected")
> >    and causes runtime PM autosuspend delay to time out on active dma
> >    transfers when connecting a mass storage device to a usb hub.
> >    This is fixed in the first patch in this series.
> > 
> > 3. Race with runtime PM and cppi41_dma_issue_pending()
> > 
> >    This is really a separate issue from the error -115 problem, and
> >    fixed with the second patch in this series. That's minimal v4
> >    version of the "dmaengine: cppi41: Fix oops in cppi41_runtime_resume"
> >    patch.
> > 
> > Regards,
> > 
> > Tony
> > 
> > 
> > Tony Lindgren (2):
> >   dmaengine: cppi41: Fix runtime PM timeouts with USB mass storage
> >   dmaengine: cppi41: Fix oops in cppi41_runtime_resume
> > 
> >  drivers/dma/cppi41.c | 56 ++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 41 insertions(+), 15 deletions(-)
> > 
> > -- 
> > 2.11.0
> 
> -- 
> ~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
