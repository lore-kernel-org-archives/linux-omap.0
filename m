From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH v2 2/2] OMAP3630 SDRC: Change in DVFS Latency Formula
 for OMAP3630
Date: Fri, 19 Mar 2010 18:47:38 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703045F2FF1@dbde02.ent.ti.com>
References: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com>
 <1268888148-10983-2-git-send-email-pramod.gurav@ti.com>
 <1268888148-10983-3-git-send-email-pramod.gurav@ti.com>
 <4BA1D3A3.7090708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48526 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752368Ab0CSNRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Mar 2010 09:17:43 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2JDHeIg017653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 08:17:42 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2JDHdel018998
	for <linux-omap@vger.kernel.org>; Fri, 19 Mar 2010 18:47:39 +0530 (IST)
In-Reply-To: <4BA1D3A3.7090708@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Ambresh" <ambresh@ti.com>, "Gurav , Pramod" <pramod.gurav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: K, Ambresh
> Sent: Thursday, March 18, 2010 12:48 PM
> To: Gurav , Pramod
> Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath
> Subject: Re: [PATCH v2 2/2] OMAP3630 SDRC: Change in DVFS Latency Formula for
> OMAP3630
> 
> Gurav , Pramod wrote:
> > This patch uses new formula to derive the dpll3 clock Stabilization
> > delay during DVFS for OMAP3630. The formula used is :
> > Latency = 2 * SYS_CLK + 10 * CLKOUTX2
> >
> > 1usec buffer time is added for safety.
> >
> > Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
> > Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>
> >
> > ---
> >  arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   60
> ++++++++++++++++++++++----------
> >  1 files changed, 41 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-
> omap2/clkt34xx_dpll3m2.c
> > index 29421b1..58979ec 100644
> > --- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> > +++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> > @@ -40,6 +40,9 @@
> >  #define		SHIFT_DPLL_N		8
> >  #define		SHIFT_DPLL_M2		27
> >
> > +#define		AVOID_TRUNC_1000	1000
> > +#define		AVOID_TRUNC_100		100
> > +
> >  /*
> >   * CORE DPLL (DPLL3) M2 divider rate programming functions
> >   *
> > @@ -67,7 +70,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned
> long rate)
> >  	u32 clk_sel_regval;
> >  	u32 core_dpll_mul_m, core_dpll_div_n, core_dpll_clkoutdiv_m2;
> >  	u32 sys_clk_rate, sdrc_clk_stab;
> > -	u32 refclk, clkoutx2, switch_latency;
> > +	u32 refclk, clkoutx2, switch_latency, dpll_lock_freq;
> >  	unsigned int delay_sram;
> >
> >  	if (!clk || !rate)
> > @@ -100,28 +103,47 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk,
> unsigned long rate)
> >  	core_dpll_clkoutdiv_m2 = (clk_sel_regval >> SHIFT_DPLL_M2) &
> >  							DPLL_M2_MASK;
> >  	sys_clk_rate = clk_get_rate(sys_ck_p);
> > -
> >  	sys_clk_rate = sys_clk_rate / CYCLES_PER_MHZ;
> >
> > -	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
> > -	refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
> > -	clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
> > -					(sys_clk_rate * core_dpll_mul_m * 2);
> > -	switch_latency =  refclk + 8 * clkoutx2;
> > -
> > -	/* Adding 2us to sdrc clk stab */
> > -	sdrc_clk_stab =  switch_latency + 2;
> > -
> > -	delay_sram = delay_sram_val();
> > -
> > -	/*
> > -	 * Calculate the number of MPU cycles
> > -	 * to wait for SDRC to stabilize
> > -	 */
> > -
> >  	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
> > +	delay_sram = delay_sram_val();
> >
> > -	c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
> > +	if (cpu_is_omap3630()) {
> > +		/*
> > +		 * wait time for L3 clk stabilization =
> > +		 * 2*SYS_CLK + 10*CLKOUTX2
> > +		 */
> > +		/*
> > +		 * To avoid truncation of floating values, AVOID_TRUNC_1000 &
> > +		 * AVOID_TRUNC_100 are multiplied and divided appropriately
> > +		 */
> > +		refclk = 2 * (AVOID_TRUNC_1000 / sys_clk_rate);
> > +		dpll_lock_freq = (AVOID_TRUNC_1000 * AVOID_TRUNC_100 *
> > +					(core_dpll_div_n + 1))/
> > +					(2 * sys_clk_rate * core_dpll_mul_m);
> > +		clkoutx2 = 10 * (dpll_lock_freq * core_dpll_clkoutdiv_m2) /
> > +							AVOID_TRUNC_100;
> > +		switch_latency = refclk + clkoutx2;
> > +
> > +		/* Adding 1000 nano seconds to sdrc clk stab */
> > +		sdrc_clk_stab = switch_latency + 1000;
> > +		c = ((sdrc_clk_stab * _mpurate) /
> > +					(delay_sram * 2 * AVOID_TRUNC_1000));
> > +	} else {
> > +		/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
> > +		refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
> > +		clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
> > +					(sys_clk_rate * core_dpll_mul_m * 2);
> > +		switch_latency =  refclk + 8 * clkoutx2;
> > +
> > +		/* Adding 2us to sdrc clk stab */
> > +		sdrc_clk_stab =  switch_latency + 2;
> > +		/*
> > +		 * Calculate the number of MPU cycles to wait for
> > +		 * SDRC to stabilize
> > +		 */
> > +		c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
> > +	}
> >
> -PFA,
> 
> - Attached patch provides further optimized 3630 & 3430 path for
> calculating M2 stablization delay.
> 
> - The formula used to compute clkoutx2, is actually calculating for
> clkoutm2x2 according to trm  clkoutx2 = (Fref * 2 * M)/ (N + 1).
>   (Thanks to Eduardo for pointing this).
> 
No, CLKOUTX2 is dependent on M2. Pls refer to table 3-45 (DPLL Operating Mode and Latency) in 3630 TRM Version D. 

Regards
Vishwa
> Thanks,
> Ambresh
> 
> >  	pr_debug("m = %d, n = %d, m2 =%d\n", core_dpll_mul_m, core_dpll_div_n,
> >  						core_dpll_clkoutdiv_m2);

