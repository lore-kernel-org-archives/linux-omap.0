From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Thu, 8 Dec 2016 10:44:26 -0800
Message-ID: <20161208184425.GB4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <87lgvqkb6f.fsf@linux.intel.com>
 <20161208153734.GF4264@atomide.com>
 <87a8c6pavm.fsf@linux.intel.com>
 <20161208182521.GA4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161208182521.GA4920-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161208 10:25]:
> * Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 09:52]:
> > 
> > Hi,
> > 
> > Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> > > * Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 01:45]:
> > >> 
> > >> Hi,
> > >> 
> > >> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> > >> > Somehow starting with v4.9-rc7 there have been imprecise
> > >> 
> > >> There's nothing touching dwc3 since v4.9-rc5.
> > >
> > > Right, nothing obvious has changed. I think it's just a slight timing
> > > change in the code that started triggering it.
> > 
> > could be
> > 
> > >> > external aborts on omap5-uevm dwc3 controller. I have not been
> > >> > able to bisect what exactly triggered this as it does not always
> > >> > happen. It seems that something changed with probing that
> > >> > now exposes the issue:
> > >> >
> > >> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> > >> 
> > >> hmmm, clock disabled... dwc3-omap shouldn't have pm runtime at all.
> > >
> > > It does for the interconnect target module clkctrl register via PM
> > > runtime. That's the "usb_otg_ss" module.
> > 
> > but that's all hidden in omap_device.c, we don't touch it from driver
> > perspective.
> 
> The call to pm_runtime_get_sync() in dwc3_omap_probe() will use it.
> 
> Is there also some dwc3 internal clock? If we assume the usb_otg_ss
> module is properly enabled it could be some dwc3 internal clock not
> enabled?
> 
> We do have a srst_udelay needed for enabling musb controller for some
> SoCs, I'll check if that's the case here.

If there are no dwc3 internal clocks that may be causing the imprecise
external abort, then most likely we should apply the following change
for srst_udelay. Looks like srst_udelay value of 2 is not enough here
but 3 seems to do the job.

The issue of the spurious interrupts on dwc3 probe remains though.

Regards,

Tony

8< ------------------------------------
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1952,6 +1952,7 @@ static struct omap_hwmod omap54xx_usb_tll_hs_hwmod = {
 static struct omap_hwmod_class_sysconfig omap54xx_usb_otg_ss_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
+	.srst_udelay	= 3,
 	.sysc_flags	= (SYSC_HAS_DMADISABLE | SYSC_HAS_MIDLEMODE |
 			   SYSC_HAS_SIDLEMODE),
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
