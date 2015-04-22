From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCH] thermal: ti-soc-thermal: dra7: Implement Workaround for
 Errata i813
Date: Wed, 22 Apr 2015 18:25:58 +0530
Message-ID: <55379A5E.2000602@ti.com>
References: <1429179514-21677-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1429179514-21677-1-git-send-email-j-keerthy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: Keerthy <j-keerthy@ti.com>, rui.zhang@intel.com, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Thursday 16 April 2015 03:48 PM, Keerthy wrote:
> DESCRIPTION
>
> Spurious Thermal Alert: Talert can happen randomly while the device remains under the temperature limit
> defined for this event to trig. This spurious event is caused by a incorrect re-synchronization between
> clock domains. The comparison between configured threshold and current temperature value can happen
> while the value is transitioning (metastable), thus causing inappropriate event generation.
> No spurious event occurs as long as the threshold value stays unchanged. Spurious event can be
> generated while a thermal alert threshold is modified in
> CONTROL_BANDGAP_THRESHOLD_MPU/GPU/CORE/DSPEVE/IVA_n.
> WORKAROUND
>
> Spurious event generation can be avoided by performing following sequence when the threshold is
> modified:
> 1. Mask the hot/cold events at the thermal IP level.
> 2. Modify Threshold.
> 3. Unmask the hot/cold events at the thermal IP level.

Hi Eduardo,

I got a confirmation that the errata is applicable only to OMPA5 and not 
DRA7. I have posted a fresh series with that taken care.

https://www.mail-archive.com/linux-omap@vger.kernel.org/msg116354.html

Thanks,
Keerthy

>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>   .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  3 +-
>   drivers/thermal/ti-soc-thermal/ti-bandgap.c        | 41 +++++++++++++++++++++-
>   drivers/thermal/ti-soc-thermal/ti-bandgap.h        |  4 ++-
>   3 files changed, 45 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> index 58b5c66..4cd051d 100644
> --- a/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> +++ b/drivers/thermal/ti-soc-thermal/dra752-thermal-data.c
> @@ -421,7 +421,8 @@ const struct ti_bandgap_data dra752_data = {
>   			TI_BANDGAP_FEATURE_TALERT |
>   			TI_BANDGAP_FEATURE_COUNTER_DELAY |
>   			TI_BANDGAP_FEATURE_HISTORY_BUFFER |
> -			TI_BANDGAP_FEATURE_ERRATA_814,
> +			TI_BANDGAP_FEATURE_ERRATA_814 |
> +			TI_BANDGAP_FEATURE_ERRATA_813,
>   	.fclock_name = "l3instr_ts_gclk_div",
>   	.div_ck_name = "l3instr_ts_gclk_div",
>   	.conv_table = dra752_adc_to_temp,
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> index 94acd80..c2c585a 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
> @@ -445,7 +445,7 @@ static int ti_bandgap_update_alert_threshold(struct ti_bandgap *bgp, int id,
>   {
>   	struct temp_sensor_data *ts_data = bgp->conf->sensors[id].ts_data;
>   	struct temp_sensor_registers *tsr;
> -	u32 thresh_val, reg_val, t_hot, t_cold;
> +	u32 thresh_val, reg_val, t_hot, t_cold, ctrl;
>   	int err = 0;
>
>   	tsr = bgp->conf->sensors[id].registers;
> @@ -477,8 +477,47 @@ static int ti_bandgap_update_alert_threshold(struct ti_bandgap *bgp, int id,
>   		  ~(tsr->threshold_thot_mask | tsr->threshold_tcold_mask);
>   	reg_val |= (t_hot << __ffs(tsr->threshold_thot_mask)) |
>   		   (t_cold << __ffs(tsr->threshold_tcold_mask));
> +
> +	/**
> +	 * Errata i813:
> +	 * Spurious Thermal Alert: Talert can happen randomly while the device
> +	 * remains under the temperature limit defined for this event to trig.
> +	 * This spurious event is caused by a incorrect re-synchronization
> +	 * between clock domains. The comparison between configured threshold
> +	 * and current temperature value can happen while the value is
> +	 * transitioning (metastable), thus causing inappropriate event
> +	 * generation. No spurious event occurs as long as the threshold value
> +	 * stays unchanged. Spurious event can be generated while a thermal
> +	 * alert threshold is modified in
> +	 * CONTROL_BANDGAP_THRESHOLD_MPU/GPU/CORE/DSPEVE/IVA_n.
> +	 */
> +
> +	if (TI_BANDGAP_HAS(bgp, ERRATA_813)) {
> +		/* Mask t_hot and t_cold events at the IP Level */
> +		ctrl = ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
> +
> +		if (hot)
> +			ctrl &= ~tsr->mask_hot_mask;
> +		else
> +			ctrl &= ~tsr->mask_cold_mask;
> +
> +		ti_bandgap_writel(bgp, ctrl, tsr->bgap_mask_ctrl);
> +	}
> +
> +	/* Write the threshold value */
>   	ti_bandgap_writel(bgp, reg_val, tsr->bgap_threshold);
>
> +	if (TI_BANDGAP_HAS(bgp, ERRATA_813)) {
> +		/* Unmask t_hot and t_cold events at the IP Level */
> +		ctrl = ti_bandgap_readl(bgp, tsr->bgap_mask_ctrl);
> +		if (hot)
> +			ctrl |= tsr->mask_hot_mask;
> +		else
> +			ctrl |= tsr->mask_cold_mask;
> +
> +		ti_bandgap_writel(bgp, ctrl, tsr->bgap_mask_ctrl);
> +	}
> +
>   	if (err) {
>   		dev_err(bgp->dev, "failed to reprogram thot threshold\n");
>   		err = -EIO;
> diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> index b2da3fc..0c52f7a 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> +++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
> @@ -320,7 +320,8 @@ struct ti_temp_sensor {
>    *
>    * TI_BANDGAP_FEATURE_ERRATA_814 - used to workaorund when the bandgap device
>    *	has Errata 814
> - *
> + * TI_BANDGAP_FEATURE_ERRATA_813 - used to workaorund when the bandgap device
> + *	has Errata 813
>    * TI_BANDGAP_HAS(b, f) - macro to check if a bandgap device is capable of a
>    *      specific feature (above) or not. Return non-zero, if yes.
>    */
> @@ -335,6 +336,7 @@ struct ti_temp_sensor {
>   #define TI_BANDGAP_FEATURE_COUNTER_DELAY	BIT(8)
>   #define TI_BANDGAP_FEATURE_HISTORY_BUFFER	BIT(9)
>   #define TI_BANDGAP_FEATURE_ERRATA_814		BIT(10)
> +#define TI_BANDGAP_FEATURE_ERRATA_813		BIT(11)
>   #define TI_BANDGAP_HAS(b, f)			\
>   			((b)->conf->features & TI_BANDGAP_FEATURE_ ## f)
>
>
