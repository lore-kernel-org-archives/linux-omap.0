From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] OMAP3 PM: Workaround for DPLL3 Lock issue
Date: Tue, 20 Apr 2010 16:27:43 +0300
Message-ID: <20100420132743.GF4970@codecarver.research.nokia.com>
References: <1270798273-30070-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40563 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754444Ab0DTN1u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 09:27:50 -0400
Content-Disposition: inline
In-Reply-To: <1270798273-30070-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Vishwanath BS <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

> diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
> index fc1b775..a52ae05 100644
> --- a/arch/arm/mach-omap2/resource34xx.c
> +++ b/arch/arm/mach-omap2/resource34xx.c
> @@ -154,7 +154,7 @@ static struct device dummy_dsp_dev;
>  static struct device vdd2_dev;
>  static int vdd1_lock;
>  static int vdd2_lock;
> -static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
> +static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk, *l3_clk;
>  static int curr_vdd1_opp;
>  static int curr_vdd2_opp;
>  static DEFINE_MUTEX(dvfs_mutex);
> @@ -214,7 +214,6 @@ static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_type,
>   */
>  void init_opp(struct shared_resource *resp)
>  {
> -	struct clk *l3_clk;
>  	int ret;
>  	u8 opp_id;
>  	resp->no_of_users = 0;
> @@ -553,3 +552,118 @@ int validate_freq(struct shared_resource *resp, u32 target_level)
>  		return freq_to_opp(&x, OPP_DSP, target_level);
>  	return 0;
>  }
> +
> +static struct omap_opp *c_vdd2_opp;
> +int program_vdd2_opp_3430()
> +{
> +	int ret = 0, div;
> +	unsigned long freq = 0;
> +	struct omap_opp *c_opp, *min_opp;
> +	unsigned long vc, vt;
> +
> +	min_opp = opp_find_freq_ceil(OPP_L3, &freq);

This could be calculated once at boottime.

> +	freq = ULONG_MAX;
> +	c_vdd2_opp = c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
> +
> +	if (opp_get_freq(c_opp) != opp_get_freq(min_opp)) {

opp_get_freq(min_opp) could also be calculated once at boottime.

> +		freq = opp_get_freq(min_opp);
> +		lock_scratchpad_sem();
> +		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +		ret = clk_set_rate(dpll3_clk, freq * div);
> +#ifdef CONFIG_PM
> +		omap3_save_scratchpad_contents();
> +#endif
> +		unlock_scratchpad_sem();
> +	}
> +
> +	/* for omap3430, VDD2 should be at 1.2V */
> +	vt = 1200000;
> +	vc = opp_get_voltage(c_opp);
> +	ret = omap_voltage_scale(VDD2_OPP, vt, vc);
> +	return ret;
> +}
> +
> +int reprogram_vdd2_opp_3430()
> +{
> +	int ret = 0, div;
> +	unsigned long freq = 0;
> +	struct omap_opp *c_opp;
> +	u8 vc, vt;
> +	unsigned long uvdc;
> +
> +	c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
> +	if (opp_get_freq(c_opp) != opp_get_freq(c_vdd2_opp)) {

And then this could become : if (opp_get_freq(c_vdd2_opp) != min_freq) {

> +		freq = opp_get_freq(c_vdd2_opp);
> +		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +		ret = clk_set_rate(dpll3_clk, freq * div);
> +	}
> +	vc = omap_twl_uv_to_vsel(1200000);
> +	uvdc = opp_get_voltage(c_vdd2_opp);
> +	vt = omap_twl_uv_to_vsel(uvdc);
> +	ret = omap_voltage_scale(VDD2_OPP, vt, vc);
> +	return ret;
> +}
> +
> +

And similar for 3630 ...

> +int program_vdd2_opp_3630()
> +{
> +	int ret = 0, div;
> +	unsigned long freq = 0;
> +	struct omap_opp *c_opp, *min_opp, *max_opp;
> +	unsigned long vc, vt;
> +
> +	min_opp = opp_find_freq_ceil(OPP_L3, &freq);
> +	freq = ULONG_MAX;
> +	max_opp = opp_find_freq_floor(OPP_L3, &freq);
> +	c_vdd2_opp = c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
> +
> +	if (opp_get_freq(c_opp) == opp_get_freq(min_opp)) {
> +		vc = opp_get_voltage(c_opp);
> +		vt = opp_get_voltage(max_opp);
> +		ret = omap_voltage_scale(VDD2_OPP, vt, vc);
> +	} else {
> +		freq = opp_get_freq(min_opp);
> +		lock_scratchpad_sem();
> +		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +		ret = clk_set_rate(dpll3_clk, freq * div);
> +#ifdef CONFIG_PM
> +		omap3_save_scratchpad_contents();
> +#endif
> +		unlock_scratchpad_sem();
> +	}
> +
> +	return ret;
> +}
> +
> +int reprogram_vdd2_opp_3630()
> +{
> +	int ret = 0, div;
> +	unsigned long freq = 0;
> +	struct omap_opp *c_opp, *min_opp, *max_opp;
> +	u8 vc, vt;
> +
> +	min_opp = opp_find_freq_ceil(OPP_L3, &freq);
> +	freq = ULONG_MAX;
> +	max_opp = opp_find_freq_floor(OPP_L3, &freq);
> +	c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
> +
> +	if (opp_get_freq(c_opp) == opp_get_freq(c_vdd2_opp)) {
> +			vc = opp_get_voltage(max_opp);
> +			vt  = opp_get_voltage(c_vdd2_opp);
> +
> +			/* ok to scale.. */
> +			ret = omap_voltage_scale(VDD2_OPP, vt, vc);
> +	} else {
> +		freq = opp_get_freq(max_opp);
> +		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
> +			OMAP3430_CLKSEL_L3_MASK;
> +		ret = clk_set_rate(dpll3_clk, freq * div);
> +	}
> +
> +	return ret;
> +}
> +

Cheers,

Peter.

-- 
goa is a state of mind
