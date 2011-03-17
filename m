From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH V3 07/19] OMAP3+: voltage: add transdone APIs
Date: Thu, 17 Mar 2011 10:14:50 -0700
Message-ID: <87sjul8y9h.fsf@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-8-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:42269 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846Ab1CQROy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 13:14:54 -0400
Received: by mail-yi0-f44.google.com with SMTP id 13so1596886yic.17
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:14:53 -0700 (PDT)
In-Reply-To: <1299338962-5602-8-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sat, 5 Mar 2011 20:59:10 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>

Nishanth Menon <nm@ti.com> writes:

> Transdone event in Voltage processor gives us fine grained status on

s/Transdone/Transaction done/

> the current status of the voltage communication with the PMIC.
> Unfortunately, IRQ generation by VP is based on the start of the
> transmission to VC from VP, not at the end (or the completion of
> the voltage setting). Hence any users of voltage layer who need
> to know fine grained information such as confirmation if the voltage
> is actually send to PMIC, needs to depend on this status.

This changelog explains why we need to check the transaction done bit,
but the patch doesn't add this feature, it just creates a new API for an
existing feature.

To minimize confusion, the changelog should be more clear that it is
just generalizing an existing feature by creating an API for it.  It
currently makes it sound like it is changing current behavior.

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c |   57 +++++++++++++++++++++++++++++++++++------
>  arch/arm/mach-omap2/voltage.h |    2 +
>  2 files changed, 51 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index a12ac1e..2d70d13 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -455,10 +455,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  	 * is <3us
>  	 */
>  	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
> -		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
> -			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
> -		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
> -		      vdd->vp_data->prm_irqst_data->tranxdone_status))
> +		omap_vp_clear_transdone(&vdd->voltdm);
> +		if (!omap_vp_is_transdone(&vdd->voltdm))
>  			break;
>  		udelay(1);
>  	}
> @@ -506,10 +504,8 @@ static int vp_forceupdate_scale_voltage(struct omap_vdd_info *vdd,
>  	 */
>  	timeout = 0;
>  	while (timeout++ < VP_TRANXDONE_TIMEOUT) {
> -		vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
> -			       prm_irqst_ocp_mod_offs, prm_irqst_reg);
> -		if (!(vdd->read_reg(prm_irqst_ocp_mod_offs, prm_irqst_reg) &
> -		      vdd->vp_data->prm_irqst_data->tranxdone_status))
> +		omap_vp_clear_transdone(&vdd->voltdm);
> +		if (!omap_vp_is_transdone(&vdd->voltdm))
>  			break;
>  		udelay(1);
>  	}
> @@ -824,6 +820,51 @@ void omap_vp_disable(struct voltagedomain *voltdm)
>  }
>  
>  /**
> + * omap_vp_is_transdone() - is voltage transfer done on vp?
> + * @voltdm:	pointer to the VDD which is to be scaled.
> + *
> + * VP's transdone bit is the only way to ensure that the transfer
> + * of the voltage value has actually been send over to the PMIC
> + * This is hence useful for all users of voltage domain to precisely
> + * identify once the PMIC voltage has been set by the voltage processor
> + */
> +bool omap_vp_is_transdone(struct voltagedomain *voltdm)
> +{
> +	struct omap_vdd_info *vdd;
> +
> +	if (IS_ERR_OR_NULL(voltdm)) {

As with some of the other patches, checking for error on input
parameters doesn't make much sense.   Checking for NULL should suffice.

> +		pr_warning("%s: Bad Params vdm=%p\n", __func__, voltdm);
> +		return false;
> +	}
> +
> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
> +	return (vdd->read_reg(prm_irqst_ocp_mod_offs,
> +		vdd->vp_data->prm_irqst_data->prm_irqst_reg) &
> +		vdd->vp_data->prm_irqst_data->tranxdone_status) ? true : false;
> +}
> +
> +/**
> + * omap_vp_clear_transdone() - clear voltage transfer done status on vp
> + * @voltdm:	pointer to the VDD which is to be scaled.
> + */
> +bool omap_vp_clear_transdone(struct voltagedomain *voltdm)
> +{
> +	struct omap_vdd_info *vdd;
> +
> +	if (IS_ERR_OR_NULL(voltdm)) {

ditto

> +		pr_warning("%s: Bad Params vdm=%p\n", __func__, voltdm);
> +		return false;
> +	}
> +
> +	vdd = container_of(voltdm, struct omap_vdd_info, voltdm);
> +	vdd->write_reg(vdd->vp_data->prm_irqst_data->tranxdone_status,
> +			prm_irqst_ocp_mod_offs,
> +			vdd->vp_data->prm_irqst_data->prm_irqst_reg);
> +
> +	return true;
> +}
> +
> +/**
>   * omap_voltage_scale_vdd() - API to scale voltage of a particular
>   *				voltage domain.
>   * @voltdm:	pointer to the VDD which is to be scaled.
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 6e9acd6..5b4e363 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -150,6 +150,8 @@ void omap_voltage_get_volttable(struct voltagedomain *voltdm,
>  struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedomain *voltdm,
>  		unsigned long volt);
>  struct omap_volt_data *omap_voltage_get_nom_volt(struct voltagedomain *voltdm);
> +bool omap_vp_is_transdone(struct voltagedomain *voltdm);
> +bool omap_vp_clear_transdone(struct voltagedomain *voltdm);
>  struct dentry *omap_voltage_get_dbgdir(struct voltagedomain *voltdm);
>  int __init omap_voltage_early_init(s16 prm_mod, s16 prm_irqst_mod,
>  				   struct omap_vdd_info *omap_vdd_array[],

Kevin
