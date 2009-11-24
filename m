From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: sr: Update ON voltage levels based on VSEL
Date: Mon, 23 Nov 2009 19:39:23 -0600
Message-ID: <4B0B394B.8040609@ti.com>
References: <1258983517-16169-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44151 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369AbZKXBjS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 20:39:18 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAO1dOfA002612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 19:39:24 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id nAO1dOeU005978
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 19:39:24 -0600 (CST)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAO1dObj000732
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 19:39:24 -0600 (CST)
In-Reply-To: <1258983517-16169-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 11/23/2009 07:38 AM, the following:
> The settings for ON voltage level in the registers
> PRM_VC_CMD_VAL_0,1 was not updated based on OPP
> table.
> 
> Once the MPU resumes from OFF mode (during idle OR
> suspend) the VDD1 voltage always returns to 1.2V.
> 
> This patch programs the value based on current OPP.

thanks for flagging this.

> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   19 ++++++++++++++++++-
>  1 files changed, 18 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index be3a1da..4cbbd6f 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -313,6 +313,15 @@ static void sr_configure_vp(int srid)
>  			PRM_VP1_CONFIG_TIMEOUTEN |
>  			vsel << OMAP3430_INITVOLTAGE_SHIFT;
>  
> +		/*
> +		 * Update the 'ON' voltage levels based on the VSEL.
> +		 * (See spruf8c.pdf sec 1.5.3.1)
> +		 */
> +		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
> +				(vsel << OMAP3430_VC_CMD_ON_SHIFT),
> +				OMAP3430_GR_MOD,
> +				OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
> +
>  		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
>  					OMAP3_PRM_VP1_CONFIG_OFFSET);
>  		prm_write_mod_reg(PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
> @@ -354,6 +363,15 @@ static void sr_configure_vp(int srid)
>  		else
>  			vsel = l3_opps[target_opp_no].vsel;
>  
> +		/*
> +		 * Update the 'ON' voltage levels based on the VSEL.
> +		 * (See spruf8c.pdf sec 1.5.3.1)
> +		 */
> +		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
> +				(vsel << OMAP3430_VC_CMD_ON_SHIFT),
> +				OMAP3430_GR_MOD,
> +				OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
> +
>  		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
>  			PRM_VP2_CONFIG_ERRORGAIN |
>  			PRM_VP2_CONFIG_TIMEOUTEN |
> @@ -391,7 +409,6 @@ static void sr_configure_vp(int srid)
>  		/* Clear force bit */
>  		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
>  				       OMAP3_PRM_VP2_CONFIG_OFFSET);
> -
>  	}
>  }
>  

CMD_VAL_[01] contains:
OFF, RET, ONLowPower, ON voltages. for VDD1 and VDD2

ON voltage:
Here is what I see:

sr_voltagescale_vcbypass sets the voltage for ON mode. BUT, this is 
called as part of voltage scale logic (from resource34xx.c::program_opp) 
  ==> invoked only as part of DVFS transitions.

The trouble we have is this: IF OFF mode is hit without DVFS transition, 
we call disable_smartreflex, which in turn calls sr_reset_voltage(). 
Unfortunately, this function is a wannabe sr_voltagescale_bypass, but 
does not do what sr_voltagebypass in it's entirety -> critical one 
being: setting ON voltage based on state it is going into. (ideally, it 
should set the RET/ON voltage based on the state it is going into - but 
that'd be an optimization thing)..

Now, without your patch, the OPP voltage is based on nominal OPP at 
which the system boots up on and CMD_VAL_0::ON voltage is not set when 
disable_smartreflex::reset_voltage is called. ON voltage is some value 
someone has set in the reg.

For this, we come to the interesting part, we should now also look at 
arch/arm/mach-omap2/pm34xx.c::configure_vc function - which is another 
function who hits the ON ret and OFF voltage values based on prm_setup - 
this  is where your bug comes from:  defaults:
92         .vdd0_on = 0x30,        /* 1.2v */

But voila, this can be updated by omap3_pm_init_vc - e.g. see 
arch/arm/mach-omap2/board-3430sdp.c

You have few options here to proceed:
a) Modify the board file to update the ON/OFF/RET voltages you'd like 
for your board.
b) Fix configure_vc to take boot-up OPP voltage.
c) Given the current state of code, but I think we dont handle 
disable_smartreflex correctly @ various OPPs and states. I do agree that 
we badly need to clean this path up. While I work on that, could I 
request this logic be moved across to sr_resetvoltage instead as a 
temporary standin for the immediate bug and others not using pm_init_vc 
function from hitting this bug?

I think (a) might be a quicker solution for you. Do let me know if I 
missed something.

-- 
Regards,
Nishanth Menon
