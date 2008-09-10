From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] MUSB: fix memory corruption when using more than max
	endpoints
Date: Wed, 10 Sep 2008 16:52:03 -0700
Message-ID: <20080910235202.GU21163@atomide.com>
References: <1221026036-26477-1-git-send-email-khilman@deeprootsystems.com> <20080910103616.GQ16796@gandalf.research.nokia.com> <48C7AD83.60703@deeprootsystems.com> <20080910112656.GR16796@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20080910112656.GR16796-f9ZlEuEWxVfta4EC/59zMBl4MBrZKKet0E9HWUfgJXw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: ext Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org> [080910 04:27]:
> On Wed, Sep 10, 2008 at 02:20:35PM +0300, ext Kevin Hilman wrote:
> > Felipe Balbi wrote:
> >> Let's keep linux-usb on the loop for musb related patches ;-)
> >>
> >> On Wed, Sep 10, 2008 at 08:53:56AM +0300, ext Kevin Hilman wrote:
> >>> There is no check if platform code passes in more endpoints (num_eps)
> >>> than the maximum number of enpoints (MUSB_C_NUM_EPS.)  The result is
> >>> that allocate_instance() happily writes past the end of 'struct musb'
> >>> corrupting memory.
> >>>
> >>> The fix below increases the max to 32 (used on omap3) and also adds a
> >>> BUG() if the platform code requests more than the max.
> >>>
> >>> This memory corruption was triggering various forms of crashes/panics
> >>> with kmem_cache_alloc() in the backtrace.
> >>>
> >>> Signed-off-by: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
> >>
> >> Looks ok, I'll put to my series.
> >>
> >>> ---
> >>>  drivers/usb/musb/musb_core.c |    1 +
> >>>  drivers/usb/musb/musb_core.h |    2 +-
> >>>  2 files changed, 2 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> >>> index c939f81..a132d9f 100644
> >>> --- a/drivers/usb/musb/musb_core.c
> >>> +++ b/drivers/usb/musb/musb_core.c
> >>> @@ -1806,6 +1806,7 @@ allocate_instance(struct device *dev,
> >>>  	musb->ctrl_base = mbase;
> >>>  	musb->nIrq = -ENODEV;
> >>>  	musb->config = config;
> >>> +	BUG_ON(musb->config->num_eps > MUSB_C_NUM_EPS);
> >>
> >> It's good to have this check here.
> >>
> >>>  	for (epnum = 0, ep = musb->endpoints;
> >>>  			epnum < musb->config->num_eps;
> >>>  			epnum++, ep++) {
> >>> diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> >>> index 8222725..5040ceb 100644
> >>> --- a/drivers/usb/musb/musb_core.h
> >>> +++ b/drivers/usb/musb/musb_core.h
> >>> @@ -153,7 +153,7 @@ static inline void musb_host_rx(struct musb *m, u8 e) {}
> >>>  /****************************** CONSTANTS ********************************/
> >>>   #ifndef MUSB_C_NUM_EPS
> >>> -#define MUSB_C_NUM_EPS ((u8)16)
> >>> +#define MUSB_C_NUM_EPS ((u8)32)
> >>
> >> 16 is the right number.
> >>
> >
> > If 16 is the right number, arch/arm/mach-omap2/usb-musb.c going to trigger 
> > this BUG every time since it sets num_eps = 32.
> >
> > I don't know much about MUSB enbpoints, but if 16 is the correct max, then 
> > the platform code should be updated.
> 
> Check recent Dave's patches to usb-musb.c ;-)

I guess you're talking about 8cc4af26d1e2b01cd9dc2c5e6b166d08946bc2e6
that I just pushed?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
