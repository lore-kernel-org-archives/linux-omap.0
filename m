From: "Hald, Ulrik Bech" <ubh@ti.com>
Subject: RE: [PATCH v3 1/2] watchdog:OMAP3:Register IVA and SECURE WDT,	make
 clks accessible
Date: Wed, 17 Jun 2009 16:51:54 +0200
Message-ID: <00695C9C8F8B4448856F48142B4AA201BD8D8A6E@dnce02.ent.ti.com>
References: <1245162291-2704-1-git-send-email-ubh@ti.com>
 <1245162291-2704-2-git-send-email-ubh@ti.com>
 <20090617134823.GS6605@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53897 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZFQOwA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 10:52:00 -0400
In-Reply-To: <20090617134823.GS6605@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, June 17, 2009 8:48 AM
> To: Hald, Ulrik Bech
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] watchdog:OMAP3:Register IVA and SECURE WDT,
> make clks accessible
> 
> Hi,
> 
> * Ulrik Bech Hald <ubh@ti.com> [090616 07:20]:
> > Enabling registration of IVA and SECURE WDT devices. Making
> > ick and fck for IVA and SECURE WDTs accessible.
> >
> > Tested on Zoom1 OMAP3 platform
> > Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
> > ---
> > This patch has a dependency on:
> > compilation: PATCH 1/2] OMAP2/3: SoC IDs: add omap_type() for
> determining GP/EMU/HS
> >
> >  arch/arm/mach-omap2/clock34xx.c |   12 +++---
> >  arch/arm/plat-omap/devices.c    |   81 +++++++++++++++++++++++++++++++-
> -------
> >  2 files changed, 71 insertions(+), 22 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-
> omap2/clock34xx.c
> > index 9e43fe5..933ae9e 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -215,11 +215,11 @@ static struct omap_clk omap34xx_clks[] = {
> >  	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_343X),
> >  	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_343X),
> >  	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_343X),
> > -	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_343X),
> > +	CLK("omap_wdt.2", "fck",	&wdt2_fck,	CK_343X),
> >  	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
> >  	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
> > -	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_343X),
> > -	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_343X),
> > +	CLK("omap_wdt.2", "ick",	&wdt2_ick,	CK_343X),
> > +	CLK("omap_wdt.1", "ick",	&wdt1_ick,	CK_343X),
> >  	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_343X),
> >  	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_343X),
> >  	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_343X),
> > @@ -241,14 +241,14 @@ static struct omap_clk omap34xx_clks[] = {
> >  	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_343X),
> >  	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_343X),
> >  	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_343X),
> > -	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_343X),
> > +	CLK("omap_wdt.3", "fck",	&wdt3_fck,	CK_343X),
> >  	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_343X),
> >  	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_343X),
> >  	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_343X),
> >  	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_343X),
> >  	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_343X),
> >  	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_343X),
> > -	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_343X),
> > +	CLK("omap_wdt.3", "ick",	&wdt3_ick,	CK_343X),
> >  	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_343X),
> >  	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_343X),
> >  	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_343X),
> > @@ -275,7 +275,7 @@ static struct omap_clk omap34xx_clks[] = {
> >  	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
> >  	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_343X),
> >  	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_343X),
> > -	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_343X),
> > +	CLK("omap_wdt.1", "fck",	&wdt1_fck,	CK_343X),
> >  };
> >
> >  /* CM_AUTOIDLE_PLL*.AUTO_* bit values */
> 
> To me it looks like you need to make the omap_wdt clock alias rename
> change also for mach-omap1/clock.c.
> 
> Regards,
> 
> Tony
> 

You're right, and it also looks like mach-omap2/clock24xx.c needs the alias rename to omap_wdt.1 as well.

Thanks for looking at it Tony. 

/Ulrik
> 
> > diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> > old mode 100644
> > new mode 100755
> > index a64b692..de5182c
> > --- a/arch/arm/plat-omap/devices.c
> > +++ b/arch/arm/plat-omap/devices.c
> > @@ -288,42 +288,91 @@ static inline void omap_init_uwire(void) {}
> >
> >  #if	defined(CONFIG_OMAP_WATCHDOG) ||
> defined(CONFIG_OMAP_WATCHDOG_MODULE)
> >
> > -static struct resource wdt_resources[] = {
> > +#define	OMAP34XX_WDT1_BASE	0x4830c000
> > +#define	OMAP34XX_WDT2_BASE	0x48314000
> > +#define	OMAP34XX_WDT3_BASE	0x49030000
> > +#define	OMAP2430_WDT_BASE	0x49016000
> > +#define	OMAP2420_WDT_BASE	0x48022000
> > +#define	OMAP16XX_WDT_BASE	0xfffeb000
> > +
> > +static struct resource wdt1_resources[] = {
> >  	{
> > -		.flags		= IORESOURCE_MEM,
> > +		.flags = IORESOURCE_MEM,
> >  	},
> >  };
> >
> > -static struct platform_device omap_wdt_device = {
> > -	.name	   = "omap_wdt",
> > -	.id	     = -1,
> > -	.num_resources	= ARRAY_SIZE(wdt_resources),
> > -	.resource	= wdt_resources,
> > +static struct resource wdt2_resources[] = {
> > +	{
> > +		.flags = IORESOURCE_MEM,
> > +	},
> > +};
> > +
> > +static struct resource wdt3_resources[] = {
> > +	{
> > +		.flags = IORESOURCE_MEM,
> > +	},
> > +};
> > +
> > +/* SECURE WDT */
> > +static struct platform_device omap_wdt1_device = {
> > +	.name = "omap_wdt",
> > +	.id = 1,
> > +	.num_resources = ARRAY_SIZE(wdt1_resources),
> > +	.resource = wdt1_resources,
> > +};
> > +
> > +/* MPU WDT */
> > +static struct platform_device omap_wdt2_device = {
> > +	.name = "omap_wdt",
> > +	.id = 2,
> > +	.num_resources = ARRAY_SIZE(wdt2_resources),
> > +	.resource = wdt2_resources,
> > +};
> > +
> > +/* IVA WDT */
> > +static struct platform_device omap_wdt3_device = {
> > +	.name = "omap_wdt",
> > +	.id = 3,
> > +	.num_resources = ARRAY_SIZE(wdt3_resources),
> > +	.resource = wdt3_resources,
> >  };
> >
> >  static void omap_init_wdt(void)
> >  {
> >  	if (cpu_is_omap16xx())
> > -		wdt_resources[0].start = 0xfffeb000;
> > +		wdt2_resources[0].start = OMAP16XX_WDT_BASE;
> >  	else if (cpu_is_omap2420())
> > -		wdt_resources[0].start = 0x48022000; /* WDT2 */
> > +		wdt2_resources[0].start = OMAP2420_WDT_BASE;
> >  	else if (cpu_is_omap2430())
> > -		wdt_resources[0].start = 0x49016000; /* WDT2 */
> > -	else if (cpu_is_omap343x())
> > -		wdt_resources[0].start = 0x48314000; /* WDT2 */
> > -	else if (cpu_is_omap44xx())
> > -		wdt_resources[0].start = 0x4a314000;
> > +		wdt2_resources[0].start = OMAP2430_WDT_BASE;
> > +	else if (cpu_is_omap343x()) {
> > +		wdt1_resources[0].start = OMAP34XX_WDT1_BASE;
> > +		wdt1_resources[0].end = wdt1_resources[0].start + 0x4f;
> > +		wdt2_resources[0].start = OMAP34XX_WDT2_BASE;
> > +		wdt3_resources[0].start = OMAP34XX_WDT3_BASE;
> > +		wdt3_resources[0].end = wdt3_resources[0].start + 0x4f;
> > +	}
> >  	else
> >  		return;
> >
> > -	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
> > +	wdt2_resources[0].end = wdt2_resources[0].start + 0x4f;
> >
> > -	(void) platform_device_register(&omap_wdt_device);
> > +	/* MPU WDT present across omap family */
> > +	(void) platform_device_register(&omap_wdt2_device);
> > +
> > +	if (cpu_is_omap34xx()) {
> > +		(void) platform_device_register(&omap_wdt3_device);
> > +		if (omap_type() == OMAP2_DEVICE_TYPE_SEC
> > +			|| omap_type() == OMAP2_DEVICE_TYPE_EMU)
> > +			(void) platform_device_register(&omap_wdt1_device);
> > +	}
> >  }
> > +
> >  #else
> >  static inline void omap_init_wdt(void) {}
> >  #endif
> >
> > +
> >  /*---------------------------------------------------------------------
> ----*/
> >
> >  #if defined(CONFIG_HW_RANDOM_OMAP) ||
> defined(CONFIG_HW_RANDOM_OMAP_MODULE)
> > --
> > 1.5.4.3
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

