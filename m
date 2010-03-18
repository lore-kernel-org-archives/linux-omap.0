From: ambresh <a0393775@ti.com>
Subject: Re: [PATCH v2 2/2] OMAP3630 SDRC: Change in DVFS Latency Formula
 for OMAP3630
Date: Thu, 18 Mar 2010 12:47:55 +0530
Message-ID: <4BA1D3A3.7090708@ti.com>
References: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com> <1268888148-10983-2-git-send-email-pramod.gurav@ti.com> <1268888148-10983-3-git-send-email-pramod.gurav@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------010603040008080701000504"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60857 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab0CRHSA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 03:18:00 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2I7Hu1d004405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 02:17:59 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o2I7Hu9u005573
	for <linux-omap@vger.kernel.org>; Thu, 18 Mar 2010 12:47:56 +0530 (IST)
In-Reply-To: <1268888148-10983-3-git-send-email-pramod.gurav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gurav , Pramod" <pramod.gurav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

--------------010603040008080701000504
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Gurav , Pramod wrote:
> This patch uses new formula to derive the dpll3 clock Stabilization
> delay during DVFS for OMAP3630. The formula used is :
> Latency = 2 * SYS_CLK + 10 * CLKOUTX2
> 
> 1usec buffer time is added for safety.
> 
> Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
> Signed-off-by: Pramod Gurav <pramod.gurav@ti.com>
> 
> ---
>  arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   60 ++++++++++++++++++++++----------
>  1 files changed, 41 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> index 29421b1..58979ec 100644
> --- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> +++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
> @@ -40,6 +40,9 @@
>  #define		SHIFT_DPLL_N		8
>  #define		SHIFT_DPLL_M2		27
>  
> +#define		AVOID_TRUNC_1000	1000
> +#define		AVOID_TRUNC_100		100
> +
>  /*
>   * CORE DPLL (DPLL3) M2 divider rate programming functions
>   *
> @@ -67,7 +70,7 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
>  	u32 clk_sel_regval;
>  	u32 core_dpll_mul_m, core_dpll_div_n, core_dpll_clkoutdiv_m2;
>  	u32 sys_clk_rate, sdrc_clk_stab;
> -	u32 refclk, clkoutx2, switch_latency;
> +	u32 refclk, clkoutx2, switch_latency, dpll_lock_freq;
>  	unsigned int delay_sram;
>  
>  	if (!clk || !rate)
> @@ -100,28 +103,47 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
>  	core_dpll_clkoutdiv_m2 = (clk_sel_regval >> SHIFT_DPLL_M2) &
>  							DPLL_M2_MASK;
>  	sys_clk_rate = clk_get_rate(sys_ck_p);
> -
>  	sys_clk_rate = sys_clk_rate / CYCLES_PER_MHZ;
>  
> -	/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
> -	refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
> -	clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
> -					(sys_clk_rate * core_dpll_mul_m * 2);
> -	switch_latency =  refclk + 8 * clkoutx2;
> -
> -	/* Adding 2us to sdrc clk stab */
> -	sdrc_clk_stab =  switch_latency + 2;
> -
> -	delay_sram = delay_sram_val();
> -
> -	/*
> -	 * Calculate the number of MPU cycles
> -	 * to wait for SDRC to stabilize
> -	 */
> -
>  	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
> +	delay_sram = delay_sram_val();
>  
> -	c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
> +	if (cpu_is_omap3630()) {
> +		/*
> +		 * wait time for L3 clk stabilization =
> +		 * 2*SYS_CLK + 10*CLKOUTX2
> +		 */
> +		/*
> +		 * To avoid truncation of floating values, AVOID_TRUNC_1000 &
> +		 * AVOID_TRUNC_100 are multiplied and divided appropriately
> +		 */
> +		refclk = 2 * (AVOID_TRUNC_1000 / sys_clk_rate);
> +		dpll_lock_freq = (AVOID_TRUNC_1000 * AVOID_TRUNC_100 *
> +					(core_dpll_div_n + 1))/
> +					(2 * sys_clk_rate * core_dpll_mul_m);
> +		clkoutx2 = 10 * (dpll_lock_freq * core_dpll_clkoutdiv_m2) /
> +							AVOID_TRUNC_100;
> +		switch_latency = refclk + clkoutx2;
> +
> +		/* Adding 1000 nano seconds to sdrc clk stab */
> +		sdrc_clk_stab = switch_latency + 1000;
> +		c = ((sdrc_clk_stab * _mpurate) /
> +					(delay_sram * 2 * AVOID_TRUNC_1000));
> +	} else {
> +		/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2 */
> +		refclk = (4 * (core_dpll_div_n + 1)) / sys_clk_rate;
> +		clkoutx2 = ((core_dpll_div_n + 1) * core_dpll_clkoutdiv_m2) /
> +					(sys_clk_rate * core_dpll_mul_m * 2);
> +		switch_latency =  refclk + 8 * clkoutx2;
> +
> +		/* Adding 2us to sdrc clk stab */
> +		sdrc_clk_stab =  switch_latency + 2;
> +		/*
> +		 * Calculate the number of MPU cycles to wait for
> +		 * SDRC to stabilize
> +		 */
> +		c = ((sdrc_clk_stab * _mpurate) / (delay_sram * 2));
> +	}
>  
-PFA,

- Attached patch provides further optimized 3630 & 3430 path for 
calculating M2 stablization delay.

- The formula used to compute clkoutx2, is actually calculating for 
clkoutm2x2 according to trm  clkoutx2 = (Fref * 2 * M)/ (N + 1).
  (Thanks to Eduardo for pointing this).

Thanks,
Ambresh

>  	pr_debug("m = %d, n = %d, m2 =%d\n", core_dpll_mul_m, core_dpll_div_n,
>  						core_dpll_clkoutdiv_m2);


--------------010603040008080701000504
Content-Type: text/x-patch; name="M2_stablization.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="M2_stablization.patch"

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 02ab136..83125a1 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -47,6 +47,16 @@
 
 #define CYCLES_PER_MHZ			1000000
 
+#define DPLL_M_MASK     		0x7ff
+#define DPLL_N_MASK     		0x7f
+#define DPLL_M2_MASK    		0x1f
+#define SHIFT_DPLL_M    		16
+#define SHIFT_DPLL_N    		8
+#define SHIFT_DPLL_M2   		27
+
+#define AVOID_TRUNC_1000		1000
+#define AVOID_TRUNC_100         	100
+
 /*
  * DPLL5_FREQ_FOR_USBHOST: USBHOST and USBTLL are the only clocks
  * that are sourced by DPLL5, and both of these require this clock
@@ -203,7 +213,7 @@ int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 
 
 /*
- * CORE DPLL (DPLL3) rate programming functions
+ * CORE DPLL (DPLL3) M2 divider rate programming functions
  *
  * These call into SRAM code to do the actual CM writes, since the SDRAM
  * is clocked from DPLL3.
@@ -221,10 +231,14 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 {
 	u32 new_div = 0;
 	u32 unlock_dll = 0;
-	u32 c;
-	unsigned long validrate, sdrcrate, _mpurate;
+	u32 c, delay_sram;
+	u32 clk_sel_regval, sys_clk;
+	u32 core_dpll_mul_m, core_dpll_div_n, core_dpll_clkoutdiv_m2;
+	u32 sys_clk_rate, sdrc_clk_stab;
+	u32 refclk, clkoutx2, switch_latency, dpll_lock_freq;
 	struct omap_sdrc_params *sdrc_cs0;
 	struct omap_sdrc_params *sdrc_cs1;
+	unsigned long validrate, sdrcrate, _mpurate;
 	int ret;
 
 	if (!clk || !rate)
@@ -249,16 +263,52 @@ int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
 		unlock_dll = 1;
 	}
 
-	/*
-	 * XXX This only needs to be done when the CPU frequency changes
-	 */
+	clk_sel_regval = __raw_readl(clk->clksel_reg);
+
+	/* Get the M, N and M2 values required for getting sdrc clk stab */
+	core_dpll_mul_m = (clk_sel_regval >> SHIFT_DPLL_M) & DPLL_M_MASK;
+	core_dpll_div_n = (clk_sel_regval >> SHIFT_DPLL_N) & DPLL_N_MASK;
+	core_dpll_clkoutdiv_m2 = (clk_sel_regval >> SHIFT_DPLL_M2) &
+							DPLL_M2_MASK;
+
+	/* sys_ck rate  */
+	sys_clk_rate = sys_ck_p->rate;
+	sys_clk_rate = sys_clk_rate / CYCLES_PER_MHZ;
 	_mpurate = arm_fck_p->rate / CYCLES_PER_MHZ;
-	c = (_mpurate << SDRC_MPURATE_SCALE) >> SDRC_MPURATE_BASE_SHIFT;
-	c += 1;  /* for safety */
-	c *= SDRC_MPURATE_LOOPS;
-	c >>= SDRC_MPURATE_SCALE;
-	if (c == 0)
-		c = 1;
+
+	delay_sram = delay_sram_val();
+
+        sys_clk = AVOID_TRUNC_1000 / sys_clk_rate;
+	/* To avoid truncation of floating values, AVOID_TRUNC_1000 &
+	 * AVOID_TRUNC_100 are multiplied and divided appropriately
+	 */
+	dpll_lock_freq = ((AVOID_TRUNC_1000 * AVOID_TRUNC_100) *
+					(core_dpll_div_n + 1)) /
+					(2 * sys_clk_rate * core_dpll_mul_m);
+
+	clkoutx2 = dpll_lock_freq / AVOID_TRUNC_100;
+
+	if (cpu_is_omap3630()) {
+		/*
+		 * wait time for L3 clk stabilization = 2*SYS_CLK + 10*CLKOUTX2
+		 */
+		switch_latency = (2 * sys_clk) + (8 * clkoutx2);
+		/* Adding 1000 nano seconds to sdrc clk stab */
+		sdrc_clk_stab = switch_latency + 1000;
+	} else {
+		/* wait time for L3 clk stabilization = 4*REFCLK + 8*CLKOUTX2*/
+		refclk = (core_dpll_div_n + 1) * sys_clk;
+		switch_latency = (4 * refclk) + (8 * clkoutx2);
+		/* Adding 2000ns to sdrc clk stab */
+		sdrc_clk_stab =  switch_latency + 2000;
+	}
+		c = ((sdrc_clk_stab * _mpurate) /
+				(delay_sram * 2 * AVOID_TRUNC_1000));
+
+	pr_debug("m = %d, n = %d, m2 =%d\n", core_dpll_mul_m, core_dpll_div_n,
+						core_dpll_clkoutdiv_m2);
+	pr_debug("switch_latency = %d, sys_clk_rate = %d, cycles = %d\n",
+					switch_latency, sys_clk_rate, c);
 
 	pr_debug("clock: changing CORE DPLL rate from %lu to %lu\n", clk->rate,
 		 validrate);
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 74ae936..79584b0 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -458,7 +458,7 @@ unsigned int  measure_sram_delay(unsigned int loop)
 
 	/*  calculate the sram delay */
 	error_gain = mpurate / gt_rate;
-	delay_sram = (error_gain * diff) / (loop * 2);
+	delay_sram = (error_gain * diff) / (loop);
 	delay_sram += error_gain;
 
 	return delay_sram;

--------------010603040008080701000504--
