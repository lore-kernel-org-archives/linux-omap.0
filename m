From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: hwmod: AM335x/AM43x: add hwmod
 support for tscadc on am43x-evm
Date: Fri, 21 Nov 2014 05:26:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411210519520.9204@utopia.booyaka.com>
References: <1415099728-10959-1-git-send-email-vigneshr@ti.com> <1415099728-10959-3-git-send-email-vigneshr@ti.com> <alpine.DEB.2.02.1411200706441.9204@utopia.booyaka.com> <546EC6D4.7080906@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <546EC6D4.7080906-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, 21 Nov 2014, Vignesh R wrote:

> On 11/20/2014 12:39 PM, Paul Walmsley wrote:
> > On Tue, 4 Nov 2014, Vignesh R wrote:
> >
> >> This patch adds hwmod support for tscadc to work on am43xx-evm. The am33xx
> >> hwmod structures of tscadc has been moved to ipblock_data so that it can
> >> be reused in am43xx. The clock domain names are separately set for am33xx
> >> and am43xx. Thus tscadc dt entries can now be added to am43xx board
> >> dt files.
> >>
> >> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> > ...
> >
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
> >> index 6e57b8ad0db5..b92a7c7825fa 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
> >> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
> > ...
> >
> >> +static void am33xx_hwmod_clockdomain(void)
> >> +{
> >> +	CLKDMNAME(am33xx_l4_hs_hwmod, "l4hs_clkdm");
> >> +	CLKDMNAME(am33xx_adc_tsc_hwmod, "l4_wkup_clkdm");
> >> +}
> >> +
> >> +static void am43xx_hwmod_clockdomain(void)
> >> +{
> >> +	CLKDMNAME(am33xx_l4_hs_hwmod, "l3_clkdm");
> >> +	CLKDMNAME(am33xx_adc_tsc_hwmod, "l3s_tsc_clkdm");
> >> +}
> >> +
> > ...
> >
> >> +	am33xx_hwmod_clockdomain();
> > I looked at this patch and the one before it.  Is there some reason why we 
> > need to share these two hwmods between AM33xx and AM43xx?  It seems 
> > cleaner just to add the ADC data directly to the AM43xx hwmod data file, 
> > not touch the AM33xx data, and not add another runtime data update for the 
> > clockdomains.  Unless there's something that I'm missing?
> 
> 
> I wanted to reuse hwmod structures. Except for clockdomain and offset,
> rest of the hwmod data are same for AM33xx and AM43xx. Adding data to AM43xx
> hwmod file just duplicates these structures. Do you still want me to move them
> to AM43xx file?

Yes.  It looks to me like the number of lines saved by eliminating the 
duplication is not too different than the number of lines added with the 
dynamic clockdomain rewriting.  Plus then we can avoid the dynamic 
clockdomain rewriting that we are only doing for two IP blocks.  Ideally 
the hwmod data is meant to be static, not changed at runtime.  For the 
moment we are stuck with the CLKCTRL rewriting but I personally consider 
that to be a hack.


- Paul
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
