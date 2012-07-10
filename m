From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH v2 04/14] ARM: OMAP5: Add minimal support for OMAP5430
 SOC
Date: Tue, 10 Jul 2012 06:25:49 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA69538@DBDE01.ent.ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
 <1341566515-22665-5-git-send-email-santosh.shilimkar@ti.com>
 <4FFA9B61.8030808@ti.com> <20120709131156.GH1122@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48457 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586Ab2GJGZ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jul 2012 02:25:57 -0400
In-Reply-To: <20120709131156.GH1122@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "R, Sricharan" <r.sricharan@ti.com>

On Mon, Jul 09, 2012 at 18:41:58, Tony Lindgren wrote:
> * Vaibhav Hiremath <hvaibhav@ti.com> [120709 01:55]:
> > On 7/6/2012 2:51 PM, Santosh Shilimkar wrote:
> > > --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> > > +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> > > @@ -39,6 +39,7 @@ struct omap_clk {
> > >  #define CK_443X		(1 << 11)
> > >  #define CK_TI816X	(1 << 12)
> > >  #define CK_446X		(1 << 13)
> > > +#define CK_54XX		(1 << 14)
> > 
> > This is conflicting with AM33XX, you may want to rebase it again, since
> > AM33xx clock tree is already pushed and available in
> > linux-omap/devel-am33xx-part2.
> 
> Heh these CK_XXXX defines are now running out of the u16 cpu_mask.
> 
> They really should be replaced with SoC specific lists of clocks
> rather than bloating the cpu_mask and repeating it for every clock
> that's compiled in for 800+ times.
> 
> Below (untested) is what could be done in the short term.
> 
> I wonder if we could #define CK_OMAP_DUMMY 0 that's always set
> for non-shared clocks if they only get set in some *_data.c
> file in a unique way?
> 
> Paul got any better ideas?
> 
> Regards,
> 
> Tony
> 
> 
> --- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
> +++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
> @@ -26,26 +26,29 @@ struct omap_clk {
>  	}
>  
>  /* Platform flags for the clkdev-OMAP integration code */
> +
> +#ifdef CONFIG_ARCH_OMAP1
>  #define CK_310		(1 << 0)
>  #define CK_7XX		(1 << 1)	/* 7xx, 850 */
>  #define CK_1510		(1 << 2)
>  #define CK_16XX		(1 << 3)	/* 16xx, 17xx, 5912 */
> -#define CK_242X		(1 << 4)
> -#define CK_243X		(1 << 5)	/* 243x, 253x */
> -#define CK_3430ES1	(1 << 6)	/* 34xxES1 only */
> -#define CK_3430ES2PLUS	(1 << 7)	/* 34xxES2, ES3, non-Sitara 35xx only */
> -#define CK_AM35XX	(1 << 9)	/* Sitara AM35xx */
> -#define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
> -#define CK_443X		(1 << 11)
> -#define CK_TI816X	(1 << 12)
> -#define CK_446X		(1 << 13)
> -#define CK_AM33XX	(1 << 14)	/* AM33xx specific clocks */
> -#define CK_1710		(1 << 15)	/* 1710 extra for rate selection */
> -
> +#define CK_1710		(1 << 4)	/* 1710 extra for rate selection */
> +#endif
>  
> +#ifdef CONFIG_ARCH_OMAP2PLUS
> +#define CK_242X		(1 << 0)
> +#define CK_243X		(1 << 1)	/* 243x, 253x */
> +#define CK_3430ES1	(1 << 2)	/* 34xxES1 only */
> +#define CK_3430ES2PLUS	(1 << 3)	/* 34xxES2, ES3, non-Sitara 35xx only */
> +#define CK_AM35XX	(1 << 4)	/* Sitara AM35xx */
> +#define CK_36XX		(1 << 5)	/* 36xx/37xx-specific clocks */
> +#define CK_443X		(1 << 6)
> +#define CK_TI816X	(1 << 7)
> +#define CK_446X		(1 << 8)
> +#define CK_AM33XX	(1 << 9)	/* AM33xx specific clocks */
>  #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
>  #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
> -
> +#endif
>  
>  #endif

This also will not scale up in the future and will end up again in the same 
situation.

Just a quick thought, may work here,

I looked at the usage of cpu_mask and rates.flag and I believe we can 
restrict both to given SoC, something like,

OMAP34XX ->
          ES1
          ES2PLUS
          36XX
          AM35XX
          ...

OMAP4 ->
          443X
          446X

AM33XX ->
          AM335X
          TI816X
          TI814X
          ...

XYZ...  ->
          ...


The proposal would be,

To make cpu_mask and rate.flags 32 bit wide and divide it in 16-16 bits -

Lower 16 bits => describe SoC it is applicable to
Upper 16 bit => describes silicon versions or families

Thanks,
Vaibhav
