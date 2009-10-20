From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 16/17] OMAP3: PM: Write voltage and clock setup times dynamically in idle loop
Date: Tue, 20 Oct 2009 10:47:52 -0700
Message-ID: <87aazmj6t3.fsf@deeprootsystems.com>
References: <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-14-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-15-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-16-git-send-email-tero.kristo@nokia.com>
	<1255690150-16853-17-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:63060 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbZJTRru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:47:50 -0400
Received: by pxi1 with SMTP id 1so1559435pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 10:47:54 -0700 (PDT)
In-Reply-To: <1255690150-16853-17-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 16 Oct 2009 13\:49\:09 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> It is suggested by TI (SWPA152 February 2009) to write clksetup,
> voltsetup_time1, voltsetup_time2, voltsetup2 dynamically in idle loop.

Can you summarize the reasons why?

> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   36 +++++++++++++++++++++++++-----------
>  1 files changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index f492142..ae83121 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -575,6 +575,30 @@ void omap_sram_idle(void)
>  	if (regset_save_on_suspend)
>  		pm_dbg_regset_save(1);
>  
> +	/* Write voltage setup times which are changed dynamically */

AFAICT, we only set these values at init time and they are never
changed.  Are there some forthcoming patches that change these
dynamically?

Kevin

> +	if (core_next_state == PWRDM_POWER_OFF) {
> +		prm_write_mod_reg(0, OMAP3430_GR_MOD,
> +				OMAP3_PRM_VOLTSETUP1_OFFSET);
> +		prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
> +				OMAP3_PRM_VOLTSETUP2_OFFSET);
> +		prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
> +				OMAP3_PRM_CLKSETUP_OFFSET);
> +	} else {
> +		prm_write_mod_reg((prm_setup.voltsetup_time2 <<
> +				OMAP3430_SETUP_TIME2_SHIFT) |
> +				(prm_setup.voltsetup_time1 <<
> +				OMAP3430_SETUP_TIME1_SHIFT),
> +				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> +		prm_write_mod_reg(0, OMAP3430_GR_MOD,
> +				OMAP3_PRM_VOLTSETUP2_OFFSET);
> +		/*
> +		 * Use static 1 as only HF_CLKOUT is turned off.
> +		 * Value taken from application note SWPA152
> +		 */
> +		prm_write_mod_reg(0x1, OMAP3430_GR_MOD,
> +				OMAP3_PRM_CLKSETUP_OFFSET);
> +	}
> +
>  	/*
>  	 * omap3_arm_context is the location where ARM registers
>  	 * get saved. The restore path then reads from this
> @@ -1379,19 +1403,9 @@ static void __init configure_vc(void)
>  			  OMAP3430_GR_MOD,
>  			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
>  
> -	/* Write setup times */
> -	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
> -			OMAP3_PRM_CLKSETUP_OFFSET);
> -	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
> -			OMAP3430_SETUP_TIME2_SHIFT) |
> -			(prm_setup.voltsetup_time1 <<
> -			OMAP3430_SETUP_TIME1_SHIFT),
> -			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> -
> +	/* Write static setup times */
>  	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
>  			OMAP3_PRM_VOLTOFFSET_OFFSET);
> -	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTSETUP2_OFFSET);
>  
>  	pm_dbg_regset_init(1);
>  	pm_dbg_regset_init(2);
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
