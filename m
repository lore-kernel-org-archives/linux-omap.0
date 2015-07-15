From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] ARM: OMAP2+: DRA7: clockdomain: change l4per2_7xx_clkdm
 to SW_WKUP
Date: Wed, 15 Jul 2015 20:27:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1507152020240.32764@utopia.booyaka.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com> <1433332284-10766-2-git-send-email-vigneshr@ti.com> <alpine.DEB.2.02.1507151955330.32764@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.02.1507151955330.32764-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, 15 Jul 2015, Paul Walmsley wrote:

> On Wed, 3 Jun 2015, Vignesh R wrote:
> 
> > Legacy IPs like PWMSS, present under l4per2_7xx_clkdm, cannot support
> > smart-idle when its clock domain is in HW_AUTO on DRA7 SoCs. Hence,
> > program clock domain to SW_WKUP.
> > 
> > Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/mach-omap2/clockdomains7xx_data.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clockdomains7xx_data.c b/arch/arm/mach-omap2/clockdomains7xx_data.c
> > index 57d5df0c1fbd..7581e036bda6 100644
> > --- a/arch/arm/mach-omap2/clockdomains7xx_data.c
> > +++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
> > @@ -331,7 +331,7 @@ static struct clockdomain l4per2_7xx_clkdm = {
> >  	.dep_bit	  = DRA7XX_L4PER2_STATDEP_SHIFT,
> >  	.wkdep_srcs	  = l4per2_wkup_sleep_deps,
> >  	.sleepdep_srcs	  = l4per2_wkup_sleep_deps,
> > -	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
> > +	.flags		  = CLKDM_CAN_SWSUP,
> >  };
> >  
> >  static struct clockdomain mpu0_7xx_clkdm = {
> 
> Thanks, queued for v4.2-rc fixes.  Note that I cannot test this, since I 
> don't have a DRA7xx board.

You know, upon further thought, this doesn't make sense.  If the bug
is with the PWMSS IP block specifically, why not just set 
HWMOD_SWSUP_SIDLE on all the IP blocks where the hardware folks didn't 
implement hardware smart-idle?  At least that way, if those legacy IP 
blocks aren't in use, the clockdomain can still enter hardware-supervised 
idle?

This patch basically disables hardware-supervised/smart idle for all of 
the IP blocks in that clockdomain?


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
