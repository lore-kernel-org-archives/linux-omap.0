From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 05/22] OMAP3: PM: Remove OPP id dependency from smartreflex driver
Date: Tue, 27 Apr 2010 11:43:23 -0700
Message-ID: <87sk6gka7o.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
	<1271408597-3066-6-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60814 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177Ab0D0Sn2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 14:43:28 -0400
Received: by pvg2 with SMTP id 2so1594298pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 11:43:27 -0700 (PDT)
In-Reply-To: <1271408597-3066-6-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:33\:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch removes get_vdd1_opp and get_vdd2_opp API's and replaces
> them with get_curr_vdd1_voltage and get_curr_vdd2_voltage API's.
> N-target values are now linked to voltages and the link bewtween
> voltage and n-target values is managed internally in smartreflex
> driver and sr_devices.c.
>
> get_curr_vdd1_voltage and get_curr_vdd2_voltage are added in
> smartreflex driver in this patch. These API's will be moved to the
> voltage driver in a later patch when voltage specific code is separated
> out of smartreflex. The link between various voltages and n-target
> values will also be separated out later.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |  201 +++++++++++++++----------------------
>  arch/arm/mach-omap2/smartreflex.h |   21 +++-
>  arch/arm/mach-omap2/sr_device.c   |   39 ++++++-
>  3 files changed, 129 insertions(+), 132 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 2f89d79..669f1bb 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -48,7 +48,6 @@ struct omap_sr {
>  	int			srid;
>  	int			is_sr_reset;
>  	int			is_autocomp_active;
> -	struct clk		*vdd_opp_clk;
>  	u32			clk_length;
>  	unsigned int		irq;
>  	struct platform_device	*pdev;
> @@ -119,64 +118,65 @@ static void sr_clk_disable(struct omap_sr *sr)
>  	sr->is_sr_reset = 1;
>  }
>  
> -static u8 get_vdd1_opp(void)
> +static unsigned long get_curr_vdd1_voltage(void)
>  {
>  	struct omap_opp *opp;
>  	unsigned long freq;
> -	struct omap_sr *sr_info = _sr_lookup(SR1);
> +	struct clk *dpll1_clk;
>  

> -	if (!sr_info) {
> -		pr_warning("omap_sr struct corresponding to SR1 not found\n");
> -		return 0;
> -	}
> -
> -	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
> +	dpll1_clk = clk_get(NULL, "dpll1_ck");
> +	if (IS_ERR(dpll1_clk))
>  		return 0;
>  
> -	freq = sr_info->vdd_opp_clk->rate;
> -	opp = opp_find_freq_ceil(OPP_MPU, &freq);
> +	freq = dpll1_clk->rate;;
> +	opp = opp_find_freq_exact(OPP_MPU, freq, 1);
>  	if (IS_ERR(opp))
>  		return 0;

I mentioned this in an earlier review, but I think it's best to leave
the clock as part of sr_info.  If you also add the OPP enum value
to sr_info, you could have a single, common function to get current
voltage intstead of a separate one per-VDD.  Otherwise, as additional
voltage domains are added, we need to add another function.

What should result is just a single get_curr_voltage() or similar
which takes an sr_info ptr and doesn't need to sr_lookup()

> -	/*
> -	 * Use higher freq voltage even if an exact match is not available
> -	 * we are probably masking a clock framework bug, so warn
> -	 */
> -	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
> -		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
> -			   __func__, freq, sr_info->vdd_opp_clk->rate);
>  

Removed here, but added back in subsequent patch.  Should be combined.
Another reason to start condensing this series and reworking against
mainline.

> -	return opp_get_opp_id(opp);
> +	return opp_get_voltage(opp);
>  }
>  
> -static u8 get_vdd2_opp(void)
> +static unsigned long get_curr_vdd2_voltage(void)
>  {
>  	struct omap_opp *opp;
>  	unsigned long freq;
> -	struct omap_sr *sr_info = _sr_lookup(SR2);
> +	struct clk *l3_clk;
>  
> -	if (!sr_info) {
> -		pr_warning("omap_sr struct corresponding to SR2 not found\n");
> -		return 0;
> -	}
> -
> -	if (sr_info->vdd_opp_clk == NULL || IS_ERR(sr_info->vdd_opp_clk))
> +	l3_clk = clk_get(NULL, "l3_ick");
> +	if (IS_ERR(l3_clk))
>  		return 0;
>  
> -	freq = sr_info->vdd_opp_clk->rate;
> -	opp = opp_find_freq_ceil(OPP_L3, &freq);
> +	freq = l3_clk->rate;
> +	opp = opp_find_freq_exact(OPP_L3, freq, 1);
>  	if (IS_ERR(opp))
>  		return 0;
>  
> -	/*
> -	 * Use higher freq voltage even if an exact match is not available
> -	 * we are probably masking a clock framework bug, so warn
> -	 */
> -	if (unlikely(freq != sr_info->vdd_opp_clk->rate))
> -		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
> -			   __func__, freq, sr_info->vdd_opp_clk->rate);
> -	return opp_get_opp_id(opp);
> +	return opp_get_voltage(opp);
>  }
>  
> +static int sr_match_volt(struct omap_sr *sr, unsigned long volt,
> +				struct omap_volt_data *volt_data)
> +{
> +	struct omap_smartreflex_data *pdata = sr->pdev->dev.platform_data;
> +	struct omap_device *odev = to_omap_device(sr->pdev);
> +	struct omap_smartreflex_dev_data *sr_dev_data =
> +					odev->hwmods[0]->dev_attr;
> +	int i;
> +
> +	if (!pdata->sr_volt_data) {
> +		pr_notice("voltage table does not exist for SR %d\n", sr->srid);

dev_notice()

> +		return false;
> +	}
> +	for (i = 0; i < sr_dev_data->volts_supported; i++) {
> +		if (pdata->sr_volt_data[i].voltage == volt) {
> +			*volt_data = pdata->sr_volt_data[i];
> +			return true;
> +		}
> +	}
> +	pr_notice("Unable to match the current voltage with \
> +				the voltage table for SR %d\n", sr->srid);

dev_notice()

> +	return false;
> +}
>  

[...]

> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index ea0ddd3..b14ba50 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -242,6 +242,17 @@ extern u32 current_vdd2_opp;
>  #endif
>  
>  /**
> + * omap_volt_data - Omap voltage specific data.
> + *
> + * @voltage	: The possible voltage value
> + * @sr_nvalue	: Smartreflex N target value at voltage <voltage>
> + */
> +struct omap_volt_data {
> +	unsigned long	voltage;
> +	u32		sr_nvalue;
> +};
> +
> +/**
>   * omap_smartreflex_dev_data - Smartreflex device specific data
>   *
>   * @volts_supported	: Number of distinct voltages possible for the VDD
> @@ -295,10 +306,10 @@ struct omap_smartreflex_dev_data {
>   * @device_idle		: fn pointer to be pouplated with omap_device idle API
>   */
>  struct omap_smartreflex_data {
> -	u32		senp_mod;
> -	u32		senn_mod;
> -	u32		*sr_nvalue;
> -	bool		enable_on_init;
> +	u32				senp_mod;
> +	u32				senn_mod;
> +	struct omap_volt_data		*sr_volt_data;

minor nit: drop the sr_ prefix

> +	bool				enable_on_init;
>  	int (*device_enable)(struct platform_device *pdev);
>  	int (*device_shutdown)(struct platform_device *pdev);
>  	int (*device_idle)(struct platform_device *pdev);
> @@ -307,7 +318,7 @@ struct omap_smartreflex_data {
>  void enable_smartreflex(int srid);
>  void disable_smartreflex(int srid);
>  int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
> -void sr_start_vddautocomap(int srid, u32 target_opp_no);
> +void sr_start_vddautocomap(int srid, unsigned long volt);
>  int sr_stop_vddautocomap(int srid);
>  #else
>  static inline void enable_smartreflex(int srid) {}
> diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
> index a9c1ef0..544d575 100644
> --- a/arch/arm/mach-omap2/sr_device.c
> +++ b/arch/arm/mach-omap2/sr_device.c
> @@ -51,8 +51,9 @@ static void __init sr_read_efuse(
>  			!dev_data->efuse_nvalues_offs))
>  		return;
>  
> -	sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> -			dev_data->volts_supported , GFP_KERNEL);
> +	if (WARN_ON(!sr_data->sr_volt_data))
> +		return;
> +
>  	sr_data->senn_mod = (omap_ctrl_readl(dev_data->efuse_sr_control) &
>  				(0x3 << dev_data->sennenable_shift) >>
>  				dev_data->sennenable_shift);
> @@ -60,7 +61,7 @@ static void __init sr_read_efuse(
>  				(0x3 << dev_data->senpenable_shift) >>
>  				dev_data->senpenable_shift);
>  	for (i = 0; i < dev_data->volts_supported; i++)
> -		sr_data->sr_nvalue[i] = omap_ctrl_readl(
> +		sr_data->sr_volt_data[i].sr_nvalue = omap_ctrl_readl(
>  				dev_data->efuse_nvalues_offs[i]);
>  }
>  
> @@ -78,12 +79,13 @@ static void __init sr_set_testing_nvalues(
>  			!dev_data->test_nvalues))
>  		return;
>  
> -	sr_data->sr_nvalue = kzalloc(sizeof(sr_data->sr_nvalue) *
> -			dev_data->volts_supported , GFP_KERNEL);
> +	if (WARN_ON(!sr_data->sr_volt_data))
> +		return;
> +
>  	sr_data->senn_mod = dev_data->test_sennenable;
>  	sr_data->senp_mod = dev_data->test_senpenable;
>  	for (i = 0; i < dev_data->volts_supported; i++)
> -		sr_data->sr_nvalue[i] = dev_data->test_nvalues[i];
> +		sr_data->sr_volt_data[i].sr_nvalue = dev_data->test_nvalues[i];
>  }
>  
>  static void __init sr_set_nvalues(struct omap_smartreflex_dev_data *dev_data,
> @@ -97,6 +99,28 @@ static void __init sr_set_nvalues(struct omap_smartreflex_dev_data *dev_data,
>  	}
>  }
>  
> +static void __init omap34xx_sr_volt_details(struct omap_smartreflex_data
> +						*sr_data, int srid,
> +						int volt_count)
> +{
> +	sr_data->sr_volt_data = kzalloc(sizeof(sr_data->sr_volt_data) *
> +				volt_count , GFP_KERNEL);
> +	if (WARN_ON(!sr_data->sr_volt_data))
> +		return;
> +
> +	if (srid == SR1) {
> +		sr_data->sr_volt_data[0].voltage = 975000;
> +		sr_data->sr_volt_data[1].voltage = 1075000;
> +		sr_data->sr_volt_data[2].voltage = 1200000;
> +		sr_data->sr_volt_data[3].voltage = 1270000;
> +		sr_data->sr_volt_data[4].voltage = 1350000;
> +	} else if (srid == SR2) {
> +		sr_data->sr_volt_data[0].voltage = 975000;
> +		sr_data->sr_volt_data[1].voltage = 1050000;
> +		sr_data->sr_volt_data[2].voltage = 1150000;
> +	}
> +}
> +

again, more stuff added that is removed later.  Time to start condensing
as it's getting hard to keep track of.

[...]

Kevin

