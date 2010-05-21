From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/3] OMAP3630: PM: implement Foward Body-Bias for OPP1G
Date: Fri, 21 May 2010 15:44:54 +0300
Message-ID: <20100521124454.GA19047@besouro.research.nokia.com>
References: <1271453603-21929-1-git-send-email-mturquette@ti.com>
 <1271453603-21929-3-git-send-email-mturquette@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23547 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab0EUMjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 08:39:09 -0400
Content-Disposition: inline
In-Reply-To: <1271453603-21929-3-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Turquette <mturquette@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Thara Gopinath <thara@ti.com>, Shweta Gulati <shweta.gulati@ti.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Mike Turquette <mturquette@ti.com>

Hello Mike,

On Fri, Apr 16, 2010 at 11:33:22PM +0200, ext Mike Turquette wrote:
> Introduces voltscale_adaptive_body_bias function to voltage.c.
> voltscale_adaptive_body_bias is called by omap_voltage_scale after a
> voltage transition has occured.  Currently voltscale_adaptive_body_bias
> only implements Forward Body-Bias (FBB) for OMAP3630 when MPU runs at
> 1GHz or higher.  In the future Reverse Body-Bias might be included.
> 
> FBB is an Adaptive Body-Bias technique to boost performance for weak
> process devices at high OPPs. This results in voltage boost on the VDD1
> PMOS back gates when running at maximum OPP.  Current recommendations
> are to enable FBB on all 3630 regardless of silicon characteristics and
> EFUSE values.
> 
> ABB applies to all OMAP silicon based on 45nm process, which includes
> OMAP4.  OMAP4 recommendations for ABB are not complete and will be added
> to voltscale_adaptive_body_bias in the future.


What is not clear to me in this ABB activation is about the idle path.
At least, from your patch, it looks like it does care about ABB & system in idle state.

So, my question is, what is the recommendation if system idles in 1GHz OPP with FBB enabled?
Should we care to disable it by software and re-enable it while waking up?

Or is it somehow bound to SmartReflex activation (then your patch would rely to the fact that
SR is enabled & disabled before & after WFI)?

> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> ---
>  arch/arm/mach-omap2/voltage.c |  129 ++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 127 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index c2c8192..98d8bb3 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -37,6 +37,11 @@
>  #define VP_IDLE_TIMEOUT		200
>  #define VP_TRANXDONE_TIMEOUT	300
>  
> +#define ABB_MAX_SETTLING_TIME	30
> +#define ABB_FAST_OPP		1
> +#define ABB_NOMINAL_OPP		2
> +#define ABB_SLOW_OPP		3
> +
>  /**
>   * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
>   * board data or PMIC data
> @@ -635,6 +640,118 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt,
>  }
>  
>  /**
> + * voltscale_adaptive_body_bias - controls ABB ldo during voltage scaling
> + * @target_volt: target voltage determines if ABB ldo is active or bypassed
> + *
> + * Adaptive Body-Bias is a technique in all OMAP silicon that uses the 45nm
> + * process.  ABB can boost voltage in high OPPs for silicon with weak
> + * characteristics (forward Body-Bias) as well as lower voltage in low OPPs
> + * for silicon with strong characteristics (Reverse Body-Bias).
> + *
> + * Only Foward Body-Bias for operating at high OPPs is implemented below, per
> + * recommendations from silicon team.
> + * Reverse Body-Bias for saving power in active cases and sleep cases is not
> + * yet implemented.
> + * OMAP4 hardward also supports ABB ldo, but no recommendations have been made
> + * to implement it yet.
> + */
> +int voltscale_adaptive_body_bias(unsigned long target_volt)
> +{
> +	u32 sr2en_enabled;
> +	int timeout;
> +	int sr2_wtcnt_value;
> +
> +	/* calculate SR2_WTCNT_VALUE settling time */
> +	sr2_wtcnt_value = (ABB_MAX_SETTLING_TIME *
> +			(clk_get_rate("sys_ck") / 1000000) / 8);
> +
> +	/* has SR2EN been enabled previously? */
> +	sr2en_enabled = (prm_read_mod_reg(OMAP3430_GR_MOD,
> +				OMAP3_PRM_LDO_ABB_CTRL_OFFSET) &
> +			OMAP3630_SR2EN);
> +
> +	/* select fast, nominal or slow OPP for ABB ldo */
> +	/* FIXME: include OMAP4 once recommendations are complete */
> +	if (cpu_is_omap3630() && (target_volt >= 1350000)) {
> +		/* program for fast opp - enable FBB */
> +		prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
> +				(ABB_FAST_OPP << OMAP3630_OPP_SEL_SHIFT),
> +				OMAP3430_GR_MOD,
> +				OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
> +
> +		/* enable the ABB ldo if not done already */
> +		if (!sr2en_enabled)
> +			prm_set_mod_reg_bits(OMAP3630_SR2EN,
> +					OMAP3430_GR_MOD,
> +					OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
> +	} else if (sr2en_enabled) {
> +		/* program for nominal opp - bypass ABB ldo */
> +		prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
> +				(ABB_NOMINAL_OPP << OMAP3630_OPP_SEL_SHIFT),
> +				OMAP3430_GR_MOD,
> +				OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
> +	} else {
> +		/* nothing to do here yet... might enable RBB here someday */
> +		return 0;
> +	}
> +
> +	/* set ACTIVE_FBB_SEL for all 45nm silicon */
> +	prm_set_mod_reg_bits(OMAP3630_ACTIVE_FBB_SEL,
> +			OMAP3430_GR_MOD,
> +			OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
> +
> +	/* program settling time of 30us for ABB ldo transition */
> +	prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_MASK,
> +			(sr2_wtcnt_value << OMAP3630_SR2_WTCNT_VALUE_SHIFT),
> +			OMAP3430_GR_MOD,
> +			OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
> +
> +	/* clear ABB ldo interrupt status */
> +	prm_write_mod_reg(OMAP3630_ABB_LDO_TRANXDONE_ST,
> +			OCP_MOD,
> +			OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
> +
> +	/* enable ABB LDO OPP change */
> +	prm_set_mod_reg_bits(OMAP3630_OPP_CHANGE,
> +			OMAP3430_GR_MOD,
> +			OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
> +
> +	timeout = 0;
> +
> +	/* wait until OPP change completes */
> +	while ((timeout < ABB_MAX_SETTLING_TIME ) &&
> +			(!(prm_read_mod_reg(OCP_MOD,
> +					    OMAP2_PRCM_IRQSTATUS_MPU_OFFSET) &
> +			   OMAP3630_ABB_LDO_TRANXDONE_ST))) {
> +		udelay(1);
> +		timeout++;
> +	}
> +
> +	if (timeout == ABB_MAX_SETTLING_TIME)
> +		pr_debug("ABB: TRANXDONE timed out waiting for OPP change\n");
> +
> +	timeout = 0;
> +
> +	/* Clear all pending TRANXDONE interrupts/status */
> +	while (timeout < ABB_MAX_SETTLING_TIME) {
> +		prm_write_mod_reg(OMAP3630_ABB_LDO_TRANXDONE_ST,
> +				OCP_MOD,
> +				OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
> +		if (!(prm_read_mod_reg(OCP_MOD,
> +						OMAP2_PRCM_IRQSTATUS_MPU_OFFSET)
> +					& OMAP3630_ABB_LDO_TRANXDONE_ST))
> +			break;
> +
> +		udelay(1);
> +		timeout++;
> +	}
> +	if (timeout == ABB_MAX_SETTLING_TIME)
> +		pr_debug("ABB: TRANXDONE timed out trying to clear status\n");
> +
> +	return 0;
> +}
> +
> +/**
>   * get_curr_vdd1_voltage : Gets the current non-auto-compensated vdd1 voltage
>   *
>   * This is a temporary placeholder for this API. This should ideally belong
> @@ -758,11 +875,19 @@ void omap_voltageprocessor_disable(int vp_id)
>  int omap_voltage_scale(int vdd, unsigned long target_volt,
>  					unsigned long current_volt)
>  {
> +	int ret;
> +
>  	if (voltscale_vpforceupdate)
> -		return vp_forceupdate_scale_voltage(vdd, target_volt,
> +		ret = vp_forceupdate_scale_voltage(vdd, target_volt,
>  								current_volt);
>  	else
> -		return vc_bypass_scale_voltage(vdd, target_volt, current_volt);
> +		ret = vc_bypass_scale_voltage(vdd, target_volt, current_volt);
> +
> +	/* FIXME OMAP4 needs ABB too; recommendations not yet complete */
> +	if (ret && (cpu_is_omap3630() && vdd == VDD1))
> +		ret = voltscale_adaptive_body_bias(target_volt);
> +
> +	return ret;
>  }
>  
>  /**
> -- 
> 1.6.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
