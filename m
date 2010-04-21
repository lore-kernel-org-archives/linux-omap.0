From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH 2/3] OMAP3630: PM: implement Foward Body-Bias for OPP1G
Date: Wed, 21 Apr 2010 17:13:30 -0500
Message-ID: <4BCF788A.9080003@ti.com>
References: <1271453603-21929-1-git-send-email-mturquette@ti.com> <1271453603-21929-3-git-send-email-mturquette@ti.com> <alpine.DEB.2.00.1004192257510.23407@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45570 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756202Ab0DUWNj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Apr 2010 18:13:39 -0400
In-Reply-To: <alpine.DEB.2.00.1004192257510.23407@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Mike Turquette <mturquette@gmail.com>, "eduardo.valentin@nokia.com" <eduardo.valentin@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Gulati, Shweta" <shweta.gulati@ti.com>, "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

Paul Walmsley wrote:
> Hi Mike,
> 
> some comments.
> 
> On Fri, 16 Apr 2010, Mike Turquette wrote:
> 
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
> Great work on the patch changelog and kerneldoc on the functions - I wish 
> everyone wrote patch changelogs like this.
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
> 
> Please move this code to a separate file - would suggest mach-omap2/abb.c.  
> The rationale here is that many OMAP2+ platforms won't need this code, and 
> we can skip compiling it in those cases.

Paul,

Thanks for reviewing.

Moving the code to a new file is fine.  Next patchset will do this.

> 
>> @@ -37,6 +37,11 @@
>>  #define VP_IDLE_TIMEOUT		200
>>  #define VP_TRANXDONE_TIMEOUT	300
>>  
> 
> Please add a bit of documentation here to indicate what unit 
> ABB_MAX_SETTLING_TIME is in, and where this number comes from.
> 
>> +#define ABB_MAX_SETTLING_TIME	30
> 
> Please add some documentation here to to note that these are the 
> PRM_LDO_ABB_SETUP.OPP_SEL register bitfield values.

Will do.

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
> 
> Please consider adding a short section describing the function return 
> values (per Documentation/kernel-doc-nano-HOWTO.txt).

Good catch.  Forgot about that part.

>> + */
>> +int voltscale_adaptive_body_bias(unsigned long target_volt)
> 
> Since this code appears to be OMAP36xx-specific, please note that in the 
> function name.  Also this is VDD1-specific, so might be worth noting that 
> there as well.
> 
> It's probably worth splitting this single function up into init(), 
> enable(), disable(), and probably a _transition_poll() function.
> 
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
> 
> The above code should be separated out into a function that is run once at 
> init.  (and then perhaps once every time these registers are changed - 
> will the ROM code touch these when entering or exiting off-mode?) No point 
> always executing this stuff for every OPP change if it only needs to be 
> done infrequently.  PRM accesses, especially reads, slow the ARM down, so 
> it's worthwhile avoiding them.

Yes, this is  a goof.  My original patch for the Android 2.6.29 kernel 
had the one-time setup stuff in prcm_setup_regs, wrapped in cpu_is_3630. 
  I can call an abb_init function there or just bang the registers directly.

>> +
>> +	/* select fast, nominal or slow OPP for ABB ldo */
>> +	/* FIXME: include OMAP4 once recommendations are complete */
>> +	if (cpu_is_omap3630() && (target_volt >= 1350000)) {
> 
> Please integrate this type of information into the OPP table or 
> somewhere similar, since this is SoC-specific configuration data.

This is a big question mark I think.  Check out Eduardo's review thread 
for more discussion on this.

>> +		/* program for fast opp - enable FBB */
>> +		prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
>> +				(ABB_FAST_OPP << OMAP3630_OPP_SEL_SHIFT),
>> +				OMAP3430_GR_MOD,
>> +				OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
> 
> Can you foresee a situation in which there would be multiple FBB-using 
> OPPs?  If so, it might be worth keeping track of the previous contents of 
> this register in RAM, to avoid the PRM accesses.

Yes, that is possible.

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
> 
> Can this be moved to init code?

Probably.  Don't think there is ever a time when we'll want to disable this.

> By the way, what is the hardware's exact definition of a 'fast 
> OPP'/'nominal OPP'/'slow OPP' ?

Fast OPP = FBB (forward body-bias)
Nominal OPP = bypass
Slow OPP = RBB (reverse body-bias)

>> +	/* program settling time of 30us for ABB ldo transition */
>> +	prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_MASK,
>> +			(sr2_wtcnt_value << OMAP3630_SR2_WTCNT_VALUE_SHIFT),
>> +			OMAP3430_GR_MOD,
>> +			OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
> 
> Looks like this can also be moved to init code.

Agreed.

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
> 
> I take it that this code is executing with interrupts disabled?
> 
> Can the ABB LDO interrupt just be disabled, and the 
> PRM_LDO_ABB_SETUP.OPP_CHANGE bit read to determine if the LDO change is 
> complete?  That might cut out some of the code that polls this TRANXDONE 
> interrupt, which seems hacky if reading OPP_CHANGE works.

I never set PRM_IRQENABLE_MPU.ABB_LDO_TRANXDONE_EN because we don't need 
an interrupt to sample PRM_IRQSTATUS_MPU.ABB_LDO_TRANXDONE_ST.  It seems 
wise to avoid the interrupt path if possible.

However you raise an interesting point.  The TRM does state that 
PRM_LDO_ABB_SETUP.OPP_CHANGE is automatically cleared by HW when the 
transition completes, so this bit should technically give us the same 
information as PRM_IRQSTATUS_MPU.ABB_LDO_TRANXDONE_ST.  I'll look into it.

>> +		udelay(1);
>> +		timeout++;
>> +	}
> 
> Will the ABB LDO always take 30us to transition if that is what was 
> programmed, or can it finish early?  If the former, then presumably this 
> loop timeout needs to be increased?

It can finish earlier, and often does.  Usually between 15-24us IIRC.

>> +	if (timeout == ABB_MAX_SETTLING_TIME)
>> +		pr_debug("ABB: TRANXDONE timed out waiting for OPP change\n");
> 
> Should be a WARN() instead since this should never happen.

OK.

>> +	timeout = 0;
>> +
>> +	/* Clear all pending TRANXDONE interrupts/status */
>> +	while (timeout < ABB_MAX_SETTLING_TIME) {
> 
> Can this interrupt status register really take 30 microseconds to clear?

Yeah this can probably die.  There are some quirks about 
prcm_interrupt_handler that I'm trying to solve here, but I think I'll 
follow that up with another patch soon instead of doing it this way.

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
>> +	if (timeout == ABB_MAX_SETTLING_TIME)
>> +		pr_debug("ABB: TRANXDONE timed out trying to clear status\n");
> 
> Should be a WARN() instead since this should never happen.

OK.

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
> 
> 
> Is it safe to leave VDD1 FBB enabled while switching to a lower voltage?  
> If it is unknown, shouldn't there be a test here to determine whether the 
> voltage is going down, and disabling FBB in that case?

It is safe.  It is NOT safe to run at 1GHz without FBB enabled on 3630, 
so I think the current sequencing is fine in that we will always step 
the frequency down, then the voltage and finally bypass ABB.

Regards,
Mike

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
>>
> 
> 
> - Paul

