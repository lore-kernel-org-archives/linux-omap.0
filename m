From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 17/19] OMAP3+: SR: make enable path use volt_data pointer
Date: Thu, 17 Mar 2011 10:41:04 -0700
Message-ID: <87y64d63wv.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-18-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:43657 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752073Ab1CQRlO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:41:14 -0400
Received: by iyf40 with SMTP id 40so3972219iyf.2
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:41:08 -0700 (PDT)
In-Reply-To: <1299338962-5602-18-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Passing the volt_data pointers across allows us to save us the effort
> of looking up the voltage data pointer from the voltage value at
> multiple layers, we need to look at the voltage data in DVFS layer
> for further processing, so modify the APIs to pass the voltage data
> pointer all the way through to lower layers to the SmartReflex AVS class
> drivers.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Isn't volt_data already reachable from voltdm?

I'd rather than clutter up the APIs with another argument, especially
one that should be derivable from the current one

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex-class3.c |   13 +++----------
>  arch/arm/mach-omap2/smartreflex.c        |   22 ++++++++++------------
>  arch/arm/mach-omap2/smartreflex.h        |    8 +++++---
>  3 files changed, 18 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
> index 2ee48af..1d3eb11 100644
> --- a/arch/arm/mach-omap2/smartreflex-class3.c
> +++ b/arch/arm/mach-omap2/smartreflex-class3.c
> @@ -13,19 +13,12 @@
>  
>  #include "smartreflex.h"
>  
> -static int sr_class3_enable(struct voltagedomain *voltdm)
> +static int sr_class3_enable(struct voltagedomain *voltdm,
> +		struct omap_volt_data *volt_data)
>  {
> -	unsigned long volt = omap_get_operation_voltage(
> -		omap_voltage_get_nom_volt(voltdm));
> -
> -	if (!volt) {
> -		pr_warning("%s: Curr voltage unknown. Cannot enable sr_%s\n",
> -				__func__, voltdm->name);
> -		return -ENODATA;
> -	}
>  
>  	omap_vp_enable(voltdm);
> -	return sr_enable(voltdm, volt);
> +	return sr_enable(voltdm, volt_data);
>  }
>  
>  static int sr_class3_disable(struct voltagedomain *voltdm, int is_volt_reset)
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index b1a7cfe..5c549b9 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -306,7 +306,7 @@ static void sr_start_vddautocomp(struct omap_sr *sr, bool class_start)
>  		return;
>  	}
>  
> -	r = sr_class->enable(sr->voltdm);
> +	r = sr_class->enable(sr->voltdm, omap_voltage_get_nom_volt(sr->voltdm));
>  	if (!r && class_start)
>  		sr->autocomp_active = true;
>  }
> @@ -626,7 +626,7 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
>  /**
>   * sr_enable() - Enables the smartreflex module.
>   * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
> - * @volt:	The voltage at which the Voltage domain associated with
> + * @volt_data:	The voltage at which the Voltage domain associated with
>   *		the smartreflex module is operating at.
>   *		This is required only to program the correct Ntarget value.
>   *
> @@ -634,10 +634,9 @@ int sr_configure_minmax(struct voltagedomain *voltdm)
>   * enable a smartreflex module. Returns 0 on success. Returns error
>   * value if the voltage passed is wrong or if ntarget value is wrong.
>   */
> -int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
> +int sr_enable(struct voltagedomain *voltdm, struct omap_volt_data *volt_data)
>  {
>  	u32 nvalue_reciprocal;
> -	struct omap_volt_data *volt_data;
>  	struct omap_sr *sr = _sr_lookup(voltdm);
>  	int ret;
>  
> @@ -647,19 +646,16 @@ int sr_enable(struct voltagedomain *voltdm, unsigned long volt)
>  		return -EINVAL;
>  	}
>  
> -	volt_data = omap_voltage_get_voltdata(sr->voltdm, volt);
> -
> -	if (IS_ERR(volt_data)) {
> -		dev_warn(&sr->pdev->dev, "%s: Unable to get voltage table"
> -			"for nominal voltage %ld\n", __func__, volt);
> -		return -ENODATA;
> +	if (IS_ERR_OR_NULL(volt_data)) {
> +		dev_warn(&sr->pdev->dev, "%s: bad voltage data\n", __func__);
> +		return -EINVAL;
>  	}
>  
>  	nvalue_reciprocal = sr_retrieve_nvalue(sr, volt_data->sr_efuse_offs);
>  
>  	if (!nvalue_reciprocal) {
>  		dev_warn(&sr->pdev->dev, "%s: NVALUE = 0 at voltage %ld\n",
> -			__func__, volt);
> +			__func__, omap_get_operation_voltage(volt_data));
>  		return -ENODATA;
>  	}
>  
> @@ -816,13 +812,15 @@ int sr_register_class(struct omap_sr_class_data *class_data)
>   * omap_sr_enable() -  API to enable SR clocks and to call into the
>   *			registered smartreflex class enable API.
>   * @voltdm:	VDD pointer to which the SR module to be configured belongs to.
> + * @volt_data:	Voltage data to go to
>   *
>   * This API is to be called from the kernel in order to enable
>   * a particular smartreflex module. This API will do the initial
>   * configurations to turn on the smartreflex module and in turn call
>   * into the registered smartreflex class enable API.
>   */
> -void omap_sr_enable(struct voltagedomain *voltdm)
> +void omap_sr_enable(struct voltagedomain *voltdm,
> +			struct omap_volt_data *volt_data)
>  {
>  	struct omap_sr *sr = _sr_lookup(voltdm);
>  
> diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
> index 4a1ada4..812e86d 100644
> --- a/arch/arm/mach-omap2/smartreflex.h
> +++ b/arch/arm/mach-omap2/smartreflex.h
> @@ -186,7 +186,8 @@ struct omap_sr_pmic_data {
>   * @class_priv_data:	Class specific private data (optional)
>   */
>  struct omap_sr_class_data {
> -	int (*enable)(struct voltagedomain *voltdm);
> +	int (*enable)(struct voltagedomain *voltdm,
> +			struct omap_volt_data *volt_data);
>  	int (*disable)(struct voltagedomain *voltdm, int is_volt_reset);
>  	int (*start)(struct voltagedomain *voltdm, void *class_priv_data);
>  	int (*stop)(struct voltagedomain *voltdm, void *class_priv_data);
> @@ -232,7 +233,8 @@ struct omap_sr_data {
>  };
>  
>  /* Smartreflex module enable/disable interface */
> -void omap_sr_enable(struct voltagedomain *voltdm);
> +void omap_sr_enable(struct voltagedomain *voltdm,
> +			struct omap_volt_data *volt_data);
>  void omap_sr_disable(struct voltagedomain *voltdm);
>  void omap_sr_disable_reset_volt(struct voltagedomain *voltdm);
>  
> @@ -240,7 +242,7 @@ void omap_sr_disable_reset_volt(struct voltagedomain *voltdm);
>  void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
>  
>  /* Smartreflex driver hooks to be called from Smartreflex class driver */
> -int sr_enable(struct voltagedomain *voltdm, unsigned long volt);
> +int sr_enable(struct voltagedomain *voltdm, struct omap_volt_data *volt_data);
>  void sr_disable(struct voltagedomain *voltdm);
>  int sr_notifier_control(struct voltagedomain *voltdm, bool enable);
>  int sr_configure_errgen(struct voltagedomain *voltdm);
