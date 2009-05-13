From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: SR: Fix SR driver to check for omap-pm return values
Date: Wed, 13 May 2009 07:52:12 -0700
Message-ID: <87skj9838j.fsf@deeprootsystems.com>
References: <1240988319-30282-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:11708 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753182AbZEMOwO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2009 10:52:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so435480rvb.1
        for <linux-omap@vger.kernel.org>; Wed, 13 May 2009 07:52:15 -0700 (PDT)
In-Reply-To: <1240988319-30282-1-git-send-email-rnayak@ti.com> (Rajendra Nayak's message of "Wed\, 29 Apr 2009 12\:28\:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra Nayak <rnayak@ti.com> writes:

> This patch checks for the return values of omap_pm_vddx_get_opp()
> in SR driver and acts accordingly. With no SRF layer enabled the OMAP-PM layer
> api is unable to return the current OPP.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, pushing to the PM branch.

I preferred this approach to Roger's approach as I don't currently
like the idea of making PM_NONE and PM_NOOP dependent on SRF, even for
just OPPs.

Kevin


> ---
>  arch/arm/mach-omap2/smartreflex.c |   42 +++++++++++++++++++++++++++++++++---
>  1 files changed, 38 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index ae5c336..04baa8e 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -247,13 +247,19 @@ static void sr_set_nvalues(struct omap_sr *sr)
>  static void sr_configure_vp(int srid)
>  {
>  	u32 vpconfig;
> +	u32 vsel;
>  
>  	if (srid == SR1) {
> +		if (!omap_pm_vdd1_get_opp())
> +			/* Assume Nominal OPP as current OPP unknown */
> +			vsel = mpu_opps[VDD1_OPP3].vsel;
> +		else
> +			vsel = mpu_opps[omap_pm_vdd1_get_opp()].vsel;
> +
>  		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
>  			PRM_VP1_CONFIG_ERRORGAIN |
>  			PRM_VP1_CONFIG_TIMEOUTEN |
> -			mpu_opps[omap_pm_vdd1_get_opp()].vsel <<
> -			OMAP3430_INITVOLTAGE_SHIFT;
> +			vsel << OMAP3430_INITVOLTAGE_SHIFT;
>  
>  		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
>  					OMAP3_PRM_VP1_CONFIG_OFFSET);
> @@ -289,11 +295,16 @@ static void sr_configure_vp(int srid)
>  				       OMAP3_PRM_VP1_CONFIG_OFFSET);
>  
>  	} else if (srid == SR2) {
> +		if (!omap_pm_vdd2_get_opp())
> +			/* Assume Nominal OPP */
> +			vsel = l3_opps[VDD2_OPP3].vsel;
> +		else
> +			vsel = l3_opps[omap_pm_vdd2_get_opp()].vsel;
> +
>  		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
>  			PRM_VP2_CONFIG_ERRORGAIN |
>  			PRM_VP2_CONFIG_TIMEOUTEN |
> -			l3_opps[omap_pm_vdd2_get_opp()].vsel <<
> -			OMAP3430_INITVOLTAGE_SHIFT;
> +			vsel << OMAP3430_INITVOLTAGE_SHIFT;
>  
>  		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
>  					OMAP3_PRM_VP2_CONFIG_OFFSET);
> @@ -387,10 +398,18 @@ static int sr_reset_voltage(int srid)
>  
>  	if (srid == SR1) {
>  		target_opp_no = omap_pm_vdd1_get_opp();
> +		if (!target_opp_no) {
> +			pr_info("Current OPP unknown: Cannot reset voltage\n");
> +			return 1;
> +		}
>  		vsel = mpu_opps[target_opp_no].vsel;
>  		reg_addr = R_VDD1_SR_CONTROL;
>  	} else if (srid == SR2) {
>  		target_opp_no = omap_pm_vdd2_get_opp();
> +		if (!target_opp_no) {
> +			pr_info("Current OPP unknown: Cannot reset voltage\n");
> +			return 1;
> +		}
>  		vsel = l3_opps[target_opp_no].vsel;
>  		reg_addr = R_VDD2_SR_CONTROL;
>  	}
> @@ -620,6 +639,11 @@ void enable_smartreflex(int srid)
>  			else if (srid == SR2)
>  				target_opp_no = omap_pm_vdd2_get_opp();
>  
> +			if (!target_opp_no) {
> +				pr_info("Current OPP unknown \
> +						 Cannot configure SR\n");
> +			}
> +
>  			sr_configure(sr);
>  
>  			if (!sr_enable(sr, target_opp_no))
> @@ -754,6 +778,11 @@ static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
>  
>  	current_vdd1opp_no = omap_pm_vdd1_get_opp();
>  
> +	if (!current_vdd1opp_no) {
> +		pr_err("sr_vdd1_autocomp: Current VDD1 opp unknown\n");
> +		return -EINVAL;
> +	}
> +
>  	if (value == 0)
>  		sr_stop_vddautocomap(SR1);
>  	else
> @@ -792,6 +821,11 @@ static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
>  
>  	current_vdd2opp_no = omap_pm_vdd2_get_opp();
>  
> +	if (!current_vdd2opp_no) {
> +		pr_err("sr_vdd2_autocomp: Current VDD2 opp unknown\n");
> +		return -EINVAL;
> +	}
> +
>  	if (value == 0)
>  		sr_stop_vddautocomap(SR2);
>  	else
> -- 
> 1.5.4.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
