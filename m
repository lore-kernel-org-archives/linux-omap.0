From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap3: sr: Update ON voltage levels based on VSEL
Date: Tue, 24 Nov 2009 15:05:24 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE6A71F5@dbde02.ent.ti.com>
References: <1258983517-16169-1-git-send-email-premi@ti.com>
 <4B0B394B.8040609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40834 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932505AbZKXJfS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 04:35:18 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAO9ZLgA004351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 03:35:24 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAO9ZLHX007014
	for <linux-omap@vger.kernel.org>; Tue, 24 Nov 2009 15:05:21 +0530 (IST)
In-Reply-To: <4B0B394B.8040609@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Tuesday, November 24, 2009 7:09 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap3: sr: Update ON voltage levels based on VSEL
> 
> Premi, Sanjeev had written, on 11/23/2009 07:38 AM, the following:
> > The settings for ON voltage level in the registers
> > PRM_VC_CMD_VAL_0,1 was not updated based on OPP
> > table.
> > 
> > Once the MPU resumes from OFF mode (during idle OR
> > suspend) the VDD1 voltage always returns to 1.2V.
> > 
> > This patch programs the value based on current OPP.
> 
> thanks for flagging this.
> 
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/mach-omap2/smartreflex.c |   19 ++++++++++++++++++-
> >  1 files changed, 18 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/smartreflex.c 
> b/arch/arm/mach-omap2/smartreflex.c
> > index be3a1da..4cbbd6f 100644
> > --- a/arch/arm/mach-omap2/smartreflex.c
> > +++ b/arch/arm/mach-omap2/smartreflex.c
> > @@ -313,6 +313,15 @@ static void sr_configure_vp(int srid)
> >  			PRM_VP1_CONFIG_TIMEOUTEN |
> >  			vsel << OMAP3430_INITVOLTAGE_SHIFT;
> >  
> > +		/*
> > +		 * Update the 'ON' voltage levels based on the VSEL.
> > +		 * (See spruf8c.pdf sec 1.5.3.1)
> > +		 */
> > +		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
> > +				(vsel << OMAP3430_VC_CMD_ON_SHIFT),
> > +				OMAP3430_GR_MOD,
> > +				OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
> > +
> >  		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
> >  					OMAP3_PRM_VP1_CONFIG_OFFSET);
> >  		prm_write_mod_reg(PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
> > @@ -354,6 +363,15 @@ static void sr_configure_vp(int srid)
> >  		else
> >  			vsel = l3_opps[target_opp_no].vsel;
> >  
> > +		/*
> > +		 * Update the 'ON' voltage levels based on the VSEL.
> > +		 * (See spruf8c.pdf sec 1.5.3.1)
> > +		 */
> > +		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
> > +				(vsel << OMAP3430_VC_CMD_ON_SHIFT),
> > +				OMAP3430_GR_MOD,
> > +				OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
> > +
> >  		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
> >  			PRM_VP2_CONFIG_ERRORGAIN |
> >  			PRM_VP2_CONFIG_TIMEOUTEN |
> > @@ -391,7 +409,6 @@ static void sr_configure_vp(int srid)
> >  		/* Clear force bit */
> >  		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, 
> OMAP3430_GR_MOD,
> >  				       OMAP3_PRM_VP2_CONFIG_OFFSET);
> > -
> >  	}
> >  }
> >  
> 
> CMD_VAL_[01] contains:
> OFF, RET, ONLowPower, ON voltages. for VDD1 and VDD2
> 
> ON voltage:
> Here is what I see:
> 
> sr_voltagescale_vcbypass sets the voltage for ON mode. BUT, this is 
> called as part of voltage scale logic (from 
> resource34xx.c::program_opp) 
>   ==> invoked only as part of DVFS transitions.
> 
> The trouble we have is this: IF OFF mode is hit without DVFS 
> transition, 
> we call disable_smartreflex, which in turn calls sr_reset_voltage(). 
> Unfortunately, this function is a wannabe sr_voltagescale_bypass, but 
> does not do what sr_voltagebypass in it's entirety -> critical one 
> being: setting ON voltage based on state it is going into. 

Yes. One thing I found was that many functions have a bit of overlapping
functionality - possibly complete in completely differen respect - but
doesn't help flow.

> (ideally, it 
> should set the RET/ON voltage based on the state it is going 
> into - but 
> that'd be an optimization thing)..
> 
> Now, without your patch, the OPP voltage is based on nominal OPP at 
> which the system boots up on and CMD_VAL_0::ON voltage is not 
> set when 
> disable_smartreflex::reset_voltage is called. ON voltage is 
> some value 
> someone has set in the reg.

Actually, without DVFS the mpurate argument is useful in setting the
desired OPP. This functionality was fixed few months back. Hence, the
patch is able to set correct value in this patch.

> 
> For this, we come to the interesting part, we should now also look at 
> arch/arm/mach-omap2/pm34xx.c::configure_vc function - which 
> is another 
> function who hits the ON ret and OFF voltage values based on 
> prm_setup - 
> this  is where your bug comes from:  defaults:
> 92         .vdd0_on = 0x30,        /* 1.2v */

Initially, I did go the board specific way (to test the implementation);
but then the OPPs and the voltages aren't board specific. So, had to
find a good point where only one table is used.

Moving further as the new OPP layer shapes up, I believe we need
simple SR APIs:

e.g. (just some pseudo code)

#define VDD1		1
#define VDD2		2
#define VDD3		3	/* may be in future */

#define VC_VOLTS_OFF	0
#define VC_VOLTS_RET	1
#define VC_VOLTS_ON	2

#define VC_OFF_CLEAR_MASK	...
#define VC_RET_CLEAR_MASK	...
#define VC_ON_CLEAR_MASK	...

#define VC_OFF_SHIFT		...
#define VC_RET_SHIFT		...
#define VC_ON_SHIFT		...

#define V1000		1000	/* 1.00 V */
#define V1100		1100	/* 1.10 V */
#define V1200		1200	/* 1.20 V */

int vc_voltage_set(u8 domain, u8 cond, u16 volts)
{
	int ret;
	u32 reg, val;
	u32 vcoeff;
	
	if (domain == VDD1)
		reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
	else if (domain == VDD2)
		reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET;
	else
		return -1 ;
		/* add print as well */
		
	/* Convert voltage to a 'coeff' based on the current OPP */
	/* coeff is a generic equiv of 'vsel' in OPP table       */
	if (volts_to_coeff (volts, &vcoeff)) {
		val = read_register (reg);
		
		if (cond == VC_VOLTS_OFF) {
			val &= VC_OFF_CLEAR_MASK;
			val |= (coeff << VC_OFF_SHIFT);
			
			write_register(reg, val);
		}
		/* and so on */
	} else {
		return -1 ;
	}
	
	return 0;
}

> 
> But voila, this can be updated by omap3_pm_init_vc - e.g. see 
> arch/arm/mach-omap2/board-3430sdp.c
> 
> You have few options here to proceed:
> a) Modify the board file to update the ON/OFF/RET voltages you'd like 
> for your board.
> b) Fix configure_vc to take boot-up OPP voltage.
> c) Given the current state of code, but I think we dont handle 
> disable_smartreflex correctly @ various OPPs and states. I do 
> agree that 
> we badly need to clean this path up. While I work on that, could I 
> request this logic be moved across to sr_resetvoltage instead as a 
> temporary standin for the immediate bug and others not using 
> pm_init_vc 
> function from hitting this bug?

I am not looking at code currently - away from the git tree. Will take
a look at it.

~sanjeev

> 
> I think (a) might be a quicker solution for you. Do let me know if I 
> missed something.
> 
> -- 
> Regards,
> Nishanth Menon
> 