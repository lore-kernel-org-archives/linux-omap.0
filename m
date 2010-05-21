From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/3] OMAP3630: PM: implement Foward Body-Bias for OPP1G
Date: Fri, 21 May 2010 19:30:59 +0300
Message-ID: <20100521163059.GA29098@besouro.research.nokia.com>
References: <1271453603-21929-1-git-send-email-mturquette@ti.com>
 <1271453603-21929-3-git-send-email-mturquette@ti.com>
 <20100521124454.GA19047@besouro.research.nokia.com>
 <4BF6A073.3050802@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:40696 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756614Ab0EUQZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 12:25:28 -0400
Content-Disposition: inline
In-Reply-To: <4BF6A073.3050802@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Mike Turquette <mturquette@ti.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Mike Turquette <mturquette@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Gulati, Shweta" <shweta.gulati@ti.com>, "Menon, Nishanth" <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Jouni Hogander <jouni.hogander@nokia.com>

Hello Mike,

On Fri, May 21, 2010 at 05:02:11PM +0200, ext Mike Turquette wrote:
> Eduardo Valentin wrote:
> > Hello Mike,
> > 
> > 
> > What is not clear to me in this ABB activation is about the idle path.
> > At least, from your patch, it looks like it does care about ABB & system in idle state.
> > 
> > So, my question is, what is the recommendation if system idles in 1GHz OPP with FBB enabled?
> > Should we care to disable it by software and re-enable it while waking up?
> 
> The recommendation for 3630 is to always have FBB enabled at 1GHz or 
> higher on the ARM.  This includes idle states.  There was some internal 
> discussion about disabling FBB around idle, but the decision was to 
> leave it enabled due to stability issues when running at high OPPs. 
> This increases leakage during idle, but not significantly I'm told.  I 
> haven't measured the delta in idle caused by this.


Right. I also expect that it will increase the leakage current during idle.
In this case, I think the beast becomes more interesting. So, better to understand it.

It is worth to know the estimated leakage caused by this feature, as in a normal system,
the idle case should be the one in use in most of the time.


> 
> For OMAP4 recommendations might be to disable around idle path.  My V2 
> patchset (will publish next week) breaks this code up into enable_fbb() 
> disable_fbb() functions which makes this sort of thing easy.
> 
> > Or is it somehow bound to SmartReflex activation (then your patch would rely to the fact that
> > SR is enabled & disabled before & after WFI)?
> 
> No, it does not mirror SR explicitly and this is intentional due to 
> stability issues mentioned above.
> 
> Regards,
> Mike
> 
> >> Signed-off-by: Mike Turquette <mturquette@ti.com>

...

> >> +	if (cpu_is_omap3630() && (target_volt >= 1350000)) {
> >> +		/* program for fast opp - enable FBB */
> >> +		prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
> >> +				(ABB_FAST_OPP << OMAP3630_OPP_SEL_SHIFT),
> >> +				OMAP3430_GR_MOD,
> >> +				OMAP3_PRM_LDO_ABB_SETUP_OFFSET);

Then, the next question is obviously if the hw is smart enough to do not generate
leakage if idle in other OPPs. I mean, will FBB be bound only to 1GHz after this configuration?
For instance, are we going to gain extra leakage if:

1. System decides to go to 1GHz
2. FBB joins the fun
3. System decides to go to lower opp



> >> +
> >> +		/* enable the ABB ldo if not done already */
> >> +		if (!sr2en_enabled)
> >> +			prm_set_mod_reg_bits(OMAP3630_SR2EN,
> >> +					OMAP3430_GR_MOD,
> >> +					OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
> >> +	} else if (sr2en_enabled) {
> >> +		/* program for nominal opp - bypass ABB ldo */
> >> +		prm_rmw_mod_reg_bits(OMAP3630_OPP_SEL_MASK,
> >> +				(ABB_NOMINAL_OPP << OMAP3630_OPP_SEL_SHIFT),
> >> +				OMAP3430_GR_MOD,
> >> +				OMAP3_PRM_LDO_ABB_SETUP_OFFSET);


If this part disables the thing, then while going to lower opp should not increase leakage.
Otherwise, would be nice to think in something to avoid that. Maybe lowering opp before entering idle,
if going from 1GHz to idle :(


Of course that, depending on the governor in use, usually we lower opp before going to idle..
But transition from 1GHz to idle is still possible. That's why having some numbers of estimated
leakage is important.

> >> +	} else {
> >> +		/* nothing to do here yet... might enable RBB here someday */
> >> +		return 0;
> >> +	}
> >> +
> >> +	/* set ACTIVE_FBB_SEL for all 45nm silicon */
> >> +	prm_set_mod_reg_bits(OMAP3630_ACTIVE_FBB_SEL,
> >> +			OMAP3430_GR_MOD,
> >> +			OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
> >> +
> >> +	/* program settling time of 30us for ABB ldo transition */
> >> +	prm_rmw_mod_reg_bits(OMAP3630_SR2_WTCNT_VALUE_MASK,
> >> +			(sr2_wtcnt_value << OMAP3630_SR2_WTCNT_VALUE_SHIFT),
> >> +			OMAP3430_GR_MOD,
> >> +			OMAP3_PRM_LDO_ABB_CTRL_OFFSET);
> >> +
> >> +	/* clear ABB ldo interrupt status */
> >> +	prm_write_mod_reg(OMAP3630_ABB_LDO_TRANXDONE_ST,
> >> +			OCP_MOD,
> >> +			OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
> >> +
> >> +	/* enable ABB LDO OPP change */
> >> +	prm_set_mod_reg_bits(OMAP3630_OPP_CHANGE,
> >> +			OMAP3430_GR_MOD,
> >> +			OMAP3_PRM_LDO_ABB_SETUP_OFFSET);
> >> +
> >> +	timeout = 0;
> >> +
> >> +	/* wait until OPP change completes */
> >> +	while ((timeout < ABB_MAX_SETTLING_TIME ) &&
> >> +			(!(prm_read_mod_reg(OCP_MOD,
> >> +					    OMAP2_PRCM_IRQSTATUS_MPU_OFFSET) &
> >> +			   OMAP3630_ABB_LDO_TRANXDONE_ST))) {
> >> +		udelay(1);
> >> +		timeout++;
> >> +	}
> >> +
> >> +	if (timeout == ABB_MAX_SETTLING_TIME)
> >> +		pr_debug("ABB: TRANXDONE timed out waiting for OPP change\n");
> >> +
> >> +	timeout = 0;
> >> +
> >> +	/* Clear all pending TRANXDONE interrupts/status */
> >> +	while (timeout < ABB_MAX_SETTLING_TIME) {
> >> +		prm_write_mod_reg(OMAP3630_ABB_LDO_TRANXDONE_ST,
> >> +				OCP_MOD,
> >> +				OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
> >> +		if (!(prm_read_mod_reg(OCP_MOD,
> >> +						OMAP2_PRCM_IRQSTATUS_MPU_OFFSET)
> >> +					& OMAP3630_ABB_LDO_TRANXDONE_ST))
> >> +			break;
> >> +
> >> +		udelay(1);
> >> +		timeout++;
> >> +	}
> >> +	if (timeout == ABB_MAX_SETTLING_TIME)
> >> +		pr_debug("ABB: TRANXDONE timed out trying to clear status\n");
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +/**
> >>   * get_curr_vdd1_voltage : Gets the current non-auto-compensated vdd1 voltage
> >>   *
> >>   * This is a temporary placeholder for this API. This should ideally belong
> >> @@ -758,11 +875,19 @@ void omap_voltageprocessor_disable(int vp_id)
> >>  int omap_voltage_scale(int vdd, unsigned long target_volt,
> >>  					unsigned long current_volt)
> >>  {
> >> +	int ret;
> >> +
> >>  	if (voltscale_vpforceupdate)
> >> -		return vp_forceupdate_scale_voltage(vdd, target_volt,
> >> +		ret = vp_forceupdate_scale_voltage(vdd, target_volt,
> >>  								current_volt);
> >>  	else
> >> -		return vc_bypass_scale_voltage(vdd, target_volt, current_volt);
> >> +		ret = vc_bypass_scale_voltage(vdd, target_volt, current_volt);
> >> +
> >> +	/* FIXME OMAP4 needs ABB too; recommendations not yet complete */
> >> +	if (ret && (cpu_is_omap3630() && vdd == VDD1))
> >> +		ret = voltscale_adaptive_body_bias(target_volt);
> >> +
> >> +	return ret;
> >>  }
> >>  
> >>  /**
> >> -- 
> >> 1.6.3.2
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
