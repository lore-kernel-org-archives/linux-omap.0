From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Thu, 8 Dec 2016 11:32:09 -0800
Message-ID: <20161208193208.GE4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <87lgvqkb6f.fsf@linux.intel.com>
 <20161208153734.GF4264@atomide.com>
 <87a8c6pavm.fsf@linux.intel.com>
 <20161208182521.GA4920@atomide.com>
 <20161208184425.GB4920@atomide.com>
 <8737hy8c1s.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8737hy8c1s.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 11:19]:
> 
> Hi,
> 
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> >> Is there also some dwc3 internal clock? If we assume the usb_otg_ss
> >> module is properly enabled it could be some dwc3 internal clock not
> >> enabled?
> >> 
> >> We do have a srst_udelay needed for enabling musb controller for some
> >> SoCs, I'll check if that's the case here.
> >
> > If there are no dwc3 internal clocks that may be causing the imprecise
> > external abort, then most likely we should apply the following change
> > for srst_udelay. Looks like srst_udelay value of 2 is not enough here
> > but 3 seems to do the job.
> >
> > The issue of the spurious interrupts on dwc3 probe remains though.
> >
> > Regards,
> >
> > Tony
> >
> > 8< ------------------------------------
> > --- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
> > @@ -1952,6 +1952,7 @@ static struct omap_hwmod omap54xx_usb_tll_hs_hwmod = {
> >  static struct omap_hwmod_class_sysconfig omap54xx_usb_otg_ss_sysc = {
> >  	.rev_offs	= 0x0000,
> >  	.sysc_offs	= 0x0010,
> > +	.srst_udelay	= 3,
> 
> nothing against it. Would be nice if TI could confirm this is needed and
> check if other families might also need it.

But as we currently are not using the WRAPRESET bit, the reset
function is nop except for the delay. So this just papers over
the problem with the delay. We are not really resetting anything
until WRAPRESET and probably also CORE_SW_RESET reset are used.

I'm now thinking the original $subject patch for dwc3-omap.c
is the way to go for the fix. Or possibly even writing to the
CORE_SW_RESET bit in dwc3-omap.c probe. The driver needs to be
able to initialize the hardware no matter what it's state is
in probe :)

Then later on we can add separate resets for the wrapper module
and dwc3 core. But that's way too intrusive for a fix for sure.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
