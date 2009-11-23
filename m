From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCHV2 4/4] OMAP3: add support for 192Mhz sgx clock
Date: Mon, 23 Nov 2009 15:00:48 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA751E44@dbde02.ent.ti.com>
References: <1258730937-1962-1-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-2-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-3-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-4-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-5-git-send-email-vishwanath.bs@ti.com>
 <4B06C182.4090009@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49252 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755792AbZKWJar convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 04:30:47 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAN9UonW023436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 03:30:53 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAN9UoQs000363
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 15:00:50 +0530 (IST)
In-Reply-To: <4B06C182.4090009@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Menon, Nishanth
> Sent: Friday, November 20, 2009 9:49 PM
> To: Sripathy, Vishwanath
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCHV2 4/4] OMAP3: add support for 192Mhz sgx clock
> 
> unrelated to this patch comment: we might want to consider thinking in
> terms of optimizing the memory as OMAP4 also kicks in.. some sort of
> dynamic clock tree traversal and __initdata method perhaps??


> 
> Hi Vishwa,
> Thanks for the patch, few minor comments follow:
> 
> Sripathy, Vishwanath had written, on 11/20/2009 09:28 AM, the following:
> > SGX can run at 192MHz on 3630 and this patch has changes to support this
> > feature. Basically DPLL4 M2 will be 192Mhz which will be used as SGX
> > Clock. 192Mhz clock is divided by 2 (using CM_CLKSEL_CORE) to generate
> > 96Mh clock
>    ^^^^ <- you probably intended 96Mhz

Yes, is should be 96Mhz.
> >
> > Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c       |   16 +++++++++++++++-
> >  arch/arm/mach-omap2/clock34xx.h       |   33
> +++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
> >  arch/arm/mach-omap2/id.c              |    7 +++++--
> >  arch/arm/plat-omap/include/plat/cpu.h |    3 +++
> >  5 files changed, 58 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-
> omap2/clock34xx.c
> > index 1e35f9a..bce7e46 100755
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -128,6 +128,7 @@ static struct omap_clk omap34xx_clks[] = {
> >  	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_3XXX),
> >  	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_3XXX),
> >  	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_3XXX),
> > +       CLK(NULL,       "omap_192m_alwon_ck", &omap_192m_alwon_ck,
> CK_363X),
> >  	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_3XXX),
> >  	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_3XXX),
> >  	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_3XXX),
> > @@ -1226,7 +1227,20 @@ int __init omap2_clk_init(void)
> >  				OMAP3630_PERIPH_DPLL_SD_DIV_MASK;
> >  			dpll4_dd.mult_mask = OMAP3630_PERIPH_DPLL_MULT_MASK;
> >  			cpu_mask |= RATE_IN_363X;
> > -			}
> > +			cpu_clkflg |= CK_363X;
> 
> I think introduce CK_36XX should be done seperately.

Ack. It should have been part of patch3.
> 
> > +		}
> > +
> > +		if (omap3_has_192mhz_clk()) {
> > +			omap_96m_alwon_fck.parent = &omap_192m_alwon_ck;
> > +			omap_96m_alwon_fck.init = &omap2_init_clksel_parent;
> > +			omap_96m_alwon_fck.clksel_reg =
> > +					OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
> > +			omap_96m_alwon_fck.clksel_mask =
> > +						OMAP3630_CLKSEL_96M_MASK;
> > +			omap_96m_alwon_fck.clksel = omap_96m_alwon_fck_clksel;
> > +			omap_96m_alwon_fck.recalc = &omap2_clksel_recalc;
> > +		}
> > +
> >  	}
> >
> >  	clk_init(&omap2_clk_functions);
> > diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-
> omap2/clock34xx.h
> > index 93c92e5..6fe89df 100644
> > --- a/arch/arm/mach-omap2/clock34xx.h
> > +++ b/arch/arm/mach-omap2/clock34xx.h
> > @@ -654,12 +654,31 @@ static struct clk dpll4_m2x2_ck = {
> >  	.recalc		= &omap3_clkoutx2_recalc,
> >  };
> >
> > +/* Adding 192MHz Clock node needed by SGX */
> > +static struct clk omap_192m_alwon_ck = {
> > +	.name           = "omap_192m_alwon_ck",
> > +	.ops            = &clkops_null,
> > +	.parent         = &dpll4_m2x2_ck,
> > +	.recalc         = &followparent_recalc,
> > +};
> > +
> >  /*
> >   * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
> >   * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
> >   * 96M_ALWON_FCLK (called "omap_96m_alwon_fck" below) and
> >   * CM_96K_(F)CLK.
> >   */
> > +static const struct clksel_rate omap_96m_alwon_fck_rates[] = {
> > +	{ .div = 1, .val = 1, .flags = RATE_IN_363X },
> > +	{ .div = 2, .val = 2, .flags = RATE_IN_363X | DEFAULT_RATE },
> > +	{ .div = 0 }
> > +};
> > +
> > +static const struct clksel omap_96m_alwon_fck_clksel[] = {
> > +	{ .parent = &omap_192m_alwon_ck, .rates = omap_96m_alwon_fck_rates },
> > +	{ .parent = NULL }
> > +};
> > +
> >  static struct clk omap_96m_alwon_fck = {
> >  	.name		= "omap_96m_alwon_fck",
> >  	.ops		= &clkops_null,
> > @@ -1223,6 +1242,18 @@ static const struct clksel_rate sgx_core_rates[] = {
> >  	{ .div = 3, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
> >  	{ .div = 4, .val = 1, .flags = RATE_IN_3XXX },
> >  	{ .div = 6, .val = 2, .flags = RATE_IN_3XXX },
> > +	{ .div = 2, .val = 5, .flags = RATE_IN_363X },
> dont we have more options here? thinking: does this mean that all 3XXX
> and 36XX defines are valid ones for SGX?

>From PRCM point of view all 3XXX configurations are valid for 3430. All 3XXX and 363X are valid for 3630. May be SGX driver not use all these configurations, however Clock node should support all. 

> 
> > +	{ .div = 0 },
> > +};
> > +
> > +static const struct clksel_rate sgx_192m_rates[] = {
> > +	{ .div = 1,  .val = 4, .flags = RATE_IN_363X | DEFAULT_RATE },
> > +	{ .div = 0 },
> > +};
> > +
> > +static const struct clksel_rate sgx_corex2_rates[] = {
> > +	{ .div = 3, .val = 6, .flags = RATE_IN_363X | DEFAULT_RATE },
> > +	{ .div = 5, .val = 7, .flags = RATE_IN_363X },
> >  	{ .div = 0 },
> >  };
> >
> > @@ -1234,6 +1265,8 @@ static const struct clksel_rate sgx_96m_rates[] = {
> >  static const struct clksel sgx_clksel[] = {
> >  	{ .parent = &core_ck,	 .rates = sgx_core_rates },
> >  	{ .parent = &cm_96m_fck, .rates = sgx_96m_rates },
> > +	{ .parent = &omap_192m_alwon_ck, .rates = sgx_192m_rates },
> > +	{ .parent = &corex2_fck, .rates = sgx_corex2_rates },
> >  	{ .parent = NULL },
> >  };
> >
> > diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-
> regbits-34xx.h
> > index a6383f9..39b3399 100644
> > --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> > +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> > @@ -336,6 +336,8 @@
> >  #define OMAP3430_CLKSEL_L4_MASK				(0x3 << 2)
> >  #define OMAP3430_CLKSEL_L3_SHIFT			0
> >  #define OMAP3430_CLKSEL_L3_MASK				(0x3 << 0)
> > +#define OMAP3630_CLKSEL_96M_SHIFT                      12
> > +#define OMAP3630_CLKSEL_96M_MASK                       (0x3 << 12)
> >
> >  /* CM_CLKSTCTRL_CORE */
> >  #define OMAP3430ES1_CLKTRCTRL_D2D_SHIFT			4
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 3c1194c..b1bc79d 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -176,8 +176,10 @@ void __init omap3_check_features(void)
> >  	OMAP3_CHECK_FEATURE(status, NEON);
> >  	OMAP3_CHECK_FEATURE(status, ISP);
> >
> > -	if (cpu_is_omap3630())
> > -		omap3_features |= OMAP3_HAS_JTYPE_DPLL4;
> > +	if (cpu_is_omap3630()) {
> > +		omap3_features |= OMAP3_HAS_JTYPE_DPLL4 |
> > +							OMAP3_HAS_192MHZ_CLK;
> might be better to do this as a next entry -> you may want other chips
> having 192Mhz to also use it..
> 
> Please Ref: http://patchwork.kernel.org/patch/61671/ to see how it is
> done clean.

Ack. Will do it as part of V3
> 
> > +	}
> >  	/*
> >  	 * TODO: Get additional info (where applicable)
> >  	 *       e.g. Size of L2 cache.
> > @@ -319,6 +321,7 @@ void __init omap3_cpuinfo(void)
> >  	OMAP3_SHOW_FEATURE(neon);
> >  	OMAP3_SHOW_FEATURE(isp);
> >  	OMAP3_SHOW_FEATURE(jtype_dpll4);
> > +	OMAP3_SHOW_FEATURE(192mhz_clk);
> >  	printk(")\n");
> >  }
> >
> > diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-
> omap/include/plat/cpu.h
> > index 65c08d5..1dffe25 100644
> > --- a/arch/arm/plat-omap/include/plat/cpu.h
> > +++ b/arch/arm/plat-omap/include/plat/cpu.h
> > @@ -498,6 +498,7 @@ extern u32 omap3_features;
> >  #define OMAP3_HAS_NEON			BIT(3)
> >  #define OMAP3_HAS_ISP			BIT(4)
> >  #define OMAP3_HAS_JTYPE_DPLL4		BIT(5)
> > +#define OMAP3_HAS_192MHZ_CLK		BIT(6)
> >
> >  #define OMAP3_HAS_FEATURE(feat,flag)			\
> >  static inline unsigned int omap3_has_ ##feat(void)	\
> > @@ -511,4 +512,6 @@ OMAP3_HAS_FEATURE(iva, IVA)
> >  OMAP3_HAS_FEATURE(neon, NEON)
> >  OMAP3_HAS_FEATURE(isp, ISP)
> >  OMAP3_HAS_FEATURE(jtype_dpll4, JTYPE_DPLL4)
> > +OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
> > +
> EOL
> >  #endif
> 
> 
> --
> Regards,
> Nishanth Menon
