From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH 2/3] OMAP3630: PM: implement Foward Body-Bias for OPP1G
Date: Wed, 21 Apr 2010 16:21:51 -0500
Message-ID: <4BCF6C6F.3030406@ti.com>
References: <1271453603-21929-1-git-send-email-mturquette@ti.com> <1271453603-21929-3-git-send-email-mturquette@ti.com> <20100419074636.GC5325@besouro.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35937 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab0DUVWA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 17:22:00 -0400
In-Reply-To: <20100419074636.GC5325@besouro.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>
Cc: ext Mike Turquette <mturquette@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Gulati, Shweta" <shweta.gulati@ti.com>, "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Eduardo Valentin wrote:
> Hello Mike,
> 
> On Fri, Apr 16, 2010 at 11:33:22PM +0200, ext Mike Turquette wrote:
>> Introduces voltscale_adaptive_body_bias function to voltage.c.
>> voltscale_adaptive_body_bias is called by omap_voltage_scale after a
>> voltage transition has occured.  Currently voltscale_adaptive_body_bias
>> only implements Forward Body-Bias (FBB) for OMAP3630 when MPU runs at
>> 1GHz or higher.  In the future Reverse Body-Bias might be included.
>>
>> FBB is an Adaptive Body-Bias technique to boost performance for weak
>> process devices at high OPPs. This results in voltage boost on the VDD1
>> PMOS back gates when running at maximum OPP.  Current recommendations
>> are to enable FBB on all 3630 regardless of silicon characteristics and
>> EFUSE values.
>>
>> ABB applies to all OMAP silicon based on 45nm process, which includes
>> OMAP4.  OMAP4 recommendations for ABB are not complete and will be added
>> to voltscale_adaptive_body_bias in the future.
> 
> Nice !
> 
>> Signed-off-by: Mike Turquette <mturquette@ti.com>
>> ---
>>  arch/arm/mach-omap2/voltage.c |  129 ++++++++++++++++++++++++++++++++++++++++-
>>  1 files changed, 127 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
>> index c2c8192..98d8bb3 100644
>> --- a/arch/arm/mach-omap2/voltage.c
>> +++ b/arch/arm/mach-omap2/voltage.c
>> @@ -37,6 +37,11 @@
>>  #define VP_IDLE_TIMEOUT		200
>>  #define VP_TRANXDONE_TIMEOUT	300
>>  
>> +#define ABB_MAX_SETTLING_TIME	30
>> +#define ABB_FAST_OPP		1
>> +#define ABB_NOMINAL_OPP		2
>> +#define ABB_SLOW_OPP		3
>> +
>>  /**
>>   * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
>>   * board data or PMIC data
>> @@ -635,6 +640,118 @@ static int vp_forceupdate_scale_voltage(u32 vdd, unsigned long target_volt,
>>  }
>>  
>>  /**
>> + * voltscale_adaptive_body_bias - controls ABB ldo during voltage scaling
>> + * @target_volt: target voltage determines if ABB ldo is active or bypassed
>> + *
>> + * Adaptive Body-Bias is a technique in all OMAP silicon that uses the 45nm
>> + * process.  ABB can boost voltage in high OPPs for silicon with weak
>> + * characteristics (forward Body-Bias) as well as lower voltage in low OPPs
>> + * for silicon with strong characteristics (Reverse Body-Bias).
>> + *
>> + * Only Foward Body-Bias for operating at high OPPs is implemented below, per
>> + * recommendations from silicon team.
>> + * Reverse Body-Bias for saving power in active cases and sleep cases is not
>> + * yet implemented.
>> + * OMAP4 hardward also supports ABB ldo, but no recommendations have been made
>> + * to implement it yet.
>> + */
>> +int voltscale_adaptive_body_bias(unsigned long target_volt)
>> +{
>> +	u32 sr2en_enabled;
>> +	int timeout;
>> +	int sr2_wtcnt_value;
>> +
>> +	/* calculate SR2_WTCNT_VALUE settling time */
>> +	sr2_wtcnt_value = (ABB_MAX_SETTLING_TIME *
>> +			(clk_get_rate("sys_ck") / 1000000) / 8);
>> +
>> +	/* has SR2EN been enabled previously? */
>> +	sr2en_enabled = (prm_read_mod_reg(OMAP3430_GR_MOD,
>> +				OMAP3_PRM_LDO_ABB_CTRL_OFFSET) &
>> +			OMAP3630_SR2EN);
>> +
>> +	/* select fast, nominal or slow OPP for ABB ldo */
>> +	/* FIXME: include OMAP4 once recommendations are complete */
>> +	if (cpu_is_omap3630() && (target_volt >= 1350000)) {
> 
> You are creating two steps to decide if you apply or not FBB.
> Here and also bellow (omap voltage scale). Would it make sense to bind it
> per opp? I mean just a flag on opp dat then you apply or not based on that flag.
> Same for RBB.

Eduardo,

Thanks for reviewing.

There has been some offline discussion about the best way to handle the 
the relationship between FBB enable flags and OPPs:

1) extend OPP table
2) piggyback on Thara's SR hwmod structures
	This probably won't work given Paul's review comments
3) other wacky stuff

After some discussion about the best way to do this I will definitely 
lose the duplicate checks and replace with some nice table look-up.

Extending the OPP table is gross for OMAP2 and OMAP3430.  Piggybacking 
on SR stuff is just a hack and there is no real relationship between ABB 
ldo and SR.  The crux of the issue is how to relate FBB enable flags to 
OPP table.  hwmod?  Ideas on this are very welcome.

>> +		/* program for fast opp - enable FBB */
>> +		prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
>> +				(ABB_FAST_OPP << OMAP3630_OPP_SEL_SHIFT),
>> +				OMAP3430_GR_MOD,
>> +				OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
>> +
>> +		/* enable the ABB ldo if not done already */
>> +		if (!sr2en_enabled)
>> +			prm_set_mod_reg_bits(OMAP3630_SR2EN,
>> +					OMAP3430_GR_MOD,
>> +					OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
>> +	} else if (sr2en_enabled) {
>> +		/* program for nominal opp - bypass ABB ldo */
>> +		prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
>> +				(ABB_NOMINAL_OPP << OMAP3630_OPP_SEL_SHIFT),
>> +				OMAP3430_GR_MOD,
>> +				OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
>> +	} else {
>> +		/* nothing to do here yet... might enable RBB here someday */
>> +		return 0;
>> +	}
>> +
>> +	/* set ACTIVE_FBB_SEL for all 45nm silicon */
>> +	prm_set_mod_reg_bits(OMAP3630_ACTIVE_FBB_SEL,
>> +			OMAP3430_GR_MOD,
>> +			OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
>> +
>> +	/* program settling time of 30us for ABB ldo transition */
>> +	prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_MASK,
>> +			(sr2_wtcnt_value << OMAP3630_SR2_WTCNT_VALUE_SHIFT),
>> +			OMAP3430_GR_MOD,
>> +			OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
>> +
>> +	/* clear ABB ldo interrupt status */
>> +	prm_write_mod_reg(OMAP3630_ABB_LDO_TRANXDONE_ST,
>> +			OCP_MOD,
>> +			OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
>> +
>> +	/* enable ABB LDO OPP change */
>> +	prm_set_mod_reg_bits(OMAP3630_OPP_CHANGE,
>> +			OMAP3430_GR_MOD,
>> +			OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
>> +
>> +	timeout = 0;
>> +
>> +	/* wait until OPP change completes */
>> +	while ((timeout < ABB_MAX_SETTLING_TIME ) &&
>> +			(!(prm_read_mod_reg(OCP_MOD,
>> +					    OMAP2_PRCM_IRQSTATUS_MPU_OFFSET) &
>> +			   OMAP3630_ABB_LDO_TRANXDONE_ST))) {
>> +		udelay(1);
>> +		timeout++;
>> +	}
>> +
>> +	if (timeout == ABB_MAX_SETTLING_TIME)
>> +		pr_debug("ABB: TRANXDONE timed out waiting for OPP change\n");
>> +
>> +	timeout = 0;
>> +
>> +	/* Clear all pending TRANXDONE interrupts/status */
>> +	while (timeout < ABB_MAX_SETTLING_TIME) {
>> +		prm_write_mod_reg(OMAP3630_ABB_LDO_TRANXDONE_ST,
>> +				OCP_MOD,
>> +				OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
>> +		if (!(prm_read_mod_reg(OCP_MOD,
>> +						OMAP2_PRCM_IRQSTATUS_MPU_OFFSET)
>> +					& OMAP3630_ABB_LDO_TRANXDONE_ST))
>> +			break;
>> +
>> +		udelay(1);
>> +		timeout++;
>> +	}
> 
> Is there any other way of implementing the above instead of busy loop / udelay?

I can defer the work for 30us if that is what you mean.  Not sure we 
want to always wait for the length of the timeout to continue though. 
Any time spent at 1GHz on 3630 should be "protected" by running FBB.

Or did you have something else in mind besides a workqueue on a timer?

> 
>> +	if (timeout == ABB_MAX_SETTLING_TIME)
>> +		pr_debug("ABB: TRANXDONE timed out trying to clear status\n");
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>>   * get_curr_vdd1_voltage : Gets the current non-auto-compensated vdd1 voltage
>>   *
>>   * This is a temporary placeholder for this API. This should ideally belong
>> @@ -758,11 +875,19 @@ void omap_voltageprocessor_disable(int vp_id)
>>  int omap_voltage_scale(int vdd, unsigned long target_volt,
>>  					unsigned long current_volt)
>>  {
>> +	int ret;
>> +
>>  	if (voltscale_vpforceupdate)
>> -		return vp_forceupdate_scale_voltage(vdd, target_volt,
>> +		ret = vp_forceupdate_scale_voltage(vdd, target_volt,
>>  								current_volt);
>>  	else
>> -		return vc_bypass_scale_voltage(vdd, target_volt, current_volt);
>> +		ret = vc_bypass_scale_voltage(vdd, target_volt, current_volt);
>> +
>> +	/* FIXME OMAP4 needs ABB too; recommendations not yet complete */
>> +	if (ret && (cpu_is_omap3630() && vdd == VDD1))
> 
> I meant here. I guess would be better to have just one place to check if you apply or not.

I think I will keep the cpu_is_* check here, and then 
voltscale_adaptive_body_bias can use a nice table look-up instead of 
rechecking as I mentioned above.

Thanks much,
Mike

>> +		ret = voltscale_adaptive_body_bias(target_volt);
>> +
>> +	return ret;
>>  }
>>  
>>  /**
>> -- 
>> 1.6.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

