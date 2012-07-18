From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Wed, 18 Jul 2012 11:06:34 +0100
Message-ID: <WC20120718100634.8301FB@terrafix.co.uk>
References: <WC20120713105737.0900A2@terrafix.co.uk> <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com> <20120717004010.GA6612@animalcreek.com> <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com> <WC20120717100848.280191@terrafix.co.uk> <alpine.DEB.2.00.1207171326510.28834@utopia.booyaka.com> <20120718022035.GC18663@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.keele.netcentral.co.uk ([212.57.235.197]:37942 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751939Ab2GRKH3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 06:07:29 -0400
In-Reply-To: <20120718022035.GC18663@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

-----Original Message-----
From: "Mark A. Greer" <mgreer@animalcreek.com>
To: Paul Walmsley <paul@pwsan.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org
Date: Tue, 17 Jul 2012 19:20:35 -0700
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?

> On Tue, Jul 17, 2012 at 01:28:13PM -0600, Paul Walmsley wrote:
> > Hi Joe, Mark,
> > 
> > On Tue, 17 Jul 2012, Joe Woodward wrote:
> > 
> > > The patch you sent is basically in two halves:
> > >   - the writes to the registers
> > >   - the calling of omap3_iva_idle().
> > > 
> > > If I patch only the writes to the registers then suspend still
> fails.
> > > If I patch only the calling of omap3_iva_idle() then suspend works.
> > > If I patch both the writes to the registers and the calling of
> omap3_iva_idle() then suspend works.
> > 
> > Wow, that's unexpected.  Thanks very much for trying this.
> > 
> > Well Mark, I guess that's your answer.  Looks like the IVA is still 
> > running on that AM3703 chip.  I guess it's probably best to do both 
> > halves, anyway.
> 
> How does this look?
> 
> Based on linux-omap/master (ce6b8b760e2fef013b1038e5398580d187f80c00).
> 
> I'm not very creative when it comes to naming this thing so I'm
> happy if you have a better idea.  I tested it on an am37xevm and
> tried to test on an am35xevm but it appears that the am35xevm is
> broken in that branch. :(
> 
> Mark
> --
> 
> From b889b2642bd16b3d8e5856f39a3ea08d10102aad Mon Sep 17 00:00:00 2001
> From: Mark A. Greer <mgreer@animalcreek.com>
> Date: Tue, 17 Jul 2012 18:50:01 -0700
> Subject: [PATCH] ARM: OMAP3: Add OMAP3_HAS_IVA_REGS feature
> 
> It appears that the am3703 and possibly the am3715 SoCs
> have an active IVA subsystem even though the CONTROL_IDCODE
> register indicates that they don't.  From experimentation,
> it seems that the IVA still requires some registers to be
> initialized even though we don't want it fully functional.
> 
> To accomplish this, add a new feature (OMAP3_HAS_IVA_REGS)
> that indicates that the IVA should be initialized but not
> really used.
> 
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>  arch/arm/mach-omap2/id.c              |    2 +-
>  arch/arm/mach-omap2/pm34xx.c          |    4 ++--
>  arch/arm/plat-omap/include/plat/cpu.h |   22 ++++++++++++----------
>  3 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index 40373db..4072fbd 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -242,7 +242,7 @@ void __init omap3xxx_check_features(void)
>  	OMAP3_CHECK_FEATURE(status, NEON);
>  	OMAP3_CHECK_FEATURE(status, ISP);
>  	if (cpu_is_omap3630())
> -		omap_features |= OMAP3_HAS_192MHZ_CLK;
> +		omap_features |= OMAP3_HAS_192MHZ_CLK | OMAP3_HAS_IVA_REGS;
>  	if (cpu_is_omap3430() || cpu_is_omap3630())
>  		omap_features |= OMAP3_HAS_IO_WAKEUP;
>  	if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
> diff --git a/arch/arm/mach-omap2/pm34xx.c
> b/arch/arm/mach-omap2/pm34xx.c
> index e4fc88c..119cbf0 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -545,7 +545,7 @@ static void __init prcm_setup_regs(void)
>  			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
>  
>  	/* Don't attach IVA interrupts */
> -	if (omap3_has_iva()) {
> +	if (omap3_has_iva() || omap3_has_iva_regs()) {
>  		omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
>  		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
>  		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
> @@ -565,7 +565,7 @@ static void __init prcm_setup_regs(void)
>  	/* Clear any pending PRCM interrupts */
>  	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
>  
> -	if (omap3_has_iva())
> +	if (omap3_has_iva() || omap3_has_iva_regs())
>  		omap3_iva_idle();
>  
>  	omap3_d2d_idle();
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h
> b/arch/arm/plat-omap/include/plat/cpu.h
> index 68b180e..2509bf4 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -451,16 +451,17 @@ extern u32 omap_features;
>  
>  #define OMAP3_HAS_L2CACHE		BIT(0)
>  #define OMAP3_HAS_IVA			BIT(1)
> -#define OMAP3_HAS_SGX			BIT(2)
> -#define OMAP3_HAS_NEON			BIT(3)
> -#define OMAP3_HAS_ISP			BIT(4)
> -#define OMAP3_HAS_192MHZ_CLK		BIT(5)
> -#define OMAP3_HAS_IO_WAKEUP		BIT(6)
> -#define OMAP3_HAS_SDRC			BIT(7)
> -#define OMAP3_HAS_IO_CHAIN_CTRL		BIT(8)
> -#define OMAP4_HAS_MPU_1GHZ		BIT(9)
> -#define OMAP4_HAS_MPU_1_2GHZ		BIT(10)
> -#define OMAP4_HAS_MPU_1_5GHZ		BIT(11)
> +#define OMAP3_HAS_IVA_REGS		BIT(2)
> +#define OMAP3_HAS_SGX			BIT(3)
> +#define OMAP3_HAS_NEON			BIT(4)
> +#define OMAP3_HAS_ISP			BIT(5)
> +#define OMAP3_HAS_192MHZ_CLK		BIT(6)
> +#define OMAP3_HAS_IO_WAKEUP		BIT(7)
> +#define OMAP3_HAS_SDRC			BIT(8)
> +#define OMAP3_HAS_IO_CHAIN_CTRL		BIT(9)
> +#define OMAP4_HAS_MPU_1GHZ		BIT(10)
> +#define OMAP4_HAS_MPU_1_2GHZ		BIT(11)
> +#define OMAP4_HAS_MPU_1_5GHZ		BIT(12)
>  
>  
>  #define OMAP3_HAS_FEATURE(feat,flag)			\
> @@ -472,6 +473,7 @@ static inline unsigned int omap3_has_
> ##feat(void)	\
>  OMAP3_HAS_FEATURE(l2cache, L2CACHE)
>  OMAP3_HAS_FEATURE(sgx, SGX)
>  OMAP3_HAS_FEATURE(iva, IVA)
> +OMAP3_HAS_FEATURE(iva_regs, IVA_REGS)
>  OMAP3_HAS_FEATURE(neon, NEON)
>  OMAP3_HAS_FEATURE(isp, ISP)
>  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> -- 
> 1.7.0.4
> 
> --

Tested on a GUMSTIX Overo AirSTORM (AM3703-based), and that fixes the problem for me, thanks!

Cheers,
Joe

> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


