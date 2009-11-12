From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 4/5] OMAP3: PM: Write voltage and clock setup times dynamically in idle loop
Date: Thu, 12 Nov 2009 07:31:36 -0800
Message-ID: <87eio3vjxj.fsf@deeprootsystems.com>
References: <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-4-git-send-email-tero.kristo@nokia.com>
	<1258020444-3809-5-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:34828 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbZKLPbe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 10:31:34 -0500
Received: by pxi26 with SMTP id 26so1706957pxi.21
        for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 07:31:40 -0800 (PST)
In-Reply-To: <1258020444-3809-5-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 12 Nov 2009 12\:07\:23 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> It is suggested by TI (SWPA152 February 2009) to write clksetup,
> voltsetup_time1, voltsetup_time2, voltsetup2 dynamically in idle loop.
>
> This allows us to optimize the voltage + clock setup times according to the
> used power save mode.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

You also need to fixup the current users of this, currently only
board-3430sdp.c I think.

Kevin

> ---
>  arch/arm/mach-omap2/pm.h     |   10 ++++-
>  arch/arm/mach-omap2/pm34xx.c |   87 +++++++++++++++++++++++------------------
>  2 files changed, 57 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index b576424..d10e0c1 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -24,12 +24,18 @@ extern int omap3_can_sleep(void);
>  extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
>  extern int omap3_idle_init(void);
>  
> -struct prm_setup_vc {
> +struct prm_setup_times_vc {
>  	u16 clksetup;
>  	u16 voltsetup_time1;
>  	u16 voltsetup_time2;
> -	u16 voltoffset;
>  	u16 voltsetup2;
> +	u16 voltsetup1;
> +};
> +
> +struct prm_setup_vc {
> +	struct prm_setup_times_vc *setup_times;
> +	struct prm_setup_times_vc *setup_times_off;
> +	u16 voltoffset;
>  /* PRM_VC_CMD_VAL_0 specific bits */
>  	u16 vdd0_on;
>  	u16 vdd0_onlp;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 796d726..2f9f4a0 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -82,12 +82,17 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
>  
> -static struct prm_setup_vc prm_setup = {
> +static struct prm_setup_times_vc prm_setup_times_default = {
>  	.clksetup = 0xff,
>  	.voltsetup_time1 = 0xfff,
>  	.voltsetup_time2 = 0xfff,
> -	.voltoffset = 0xff,
>  	.voltsetup2 = 0xff,
> +};
> +
> +static struct prm_setup_vc prm_setup_default = {
> +	.setup_times = &prm_setup_times_default,
> +	.setup_times_off = NULL,
> +	.voltoffset = 0xff,
>  	.vdd0_on = 0x30,	/* 1.2v */
>  	.vdd0_onlp = 0x20,	/* 1.0v */
>  	.vdd0_ret = 0x1e,	/* 0.975v */
> @@ -98,6 +103,8 @@ static struct prm_setup_vc prm_setup = {
>  	.vdd1_off = 0x00,	/* 0.6v */
>  };
>  
> +static struct prm_setup_vc *prm_setup = &prm_setup_default;
> +
>  static inline void omap3_per_save_context(void)
>  {
>  	omap_gpio_save_context();
> @@ -338,6 +345,16 @@ static void restore_table_entry(void)
>  	restore_control_register(control_reg_value);
>  }
>  
> +static void prm_program_setup_times(struct prm_setup_times_vc *times)
> +{
> +	prm_write_mod_reg(times->voltsetup1, OMAP3430_GR_MOD,
> +			OMAP3_PRM_VOLTSETUP1_OFFSET);
> +	prm_write_mod_reg(times->voltsetup2, OMAP3430_GR_MOD,
> +			OMAP3_PRM_VOLTSETUP2_OFFSET);
> +	prm_write_mod_reg(times->clksetup, OMAP3430_GR_MOD,
> +			OMAP3_PRM_CLKSETUP_OFFSET);
> +}
> +
>  void omap_sram_idle(void)
>  {
>  	/* Variable to tell what needs to be saved and restored
> @@ -422,6 +439,9 @@ void omap_sram_idle(void)
>  					     OMAP3_PRM_VOLTCTRL_OFFSET);
>  			omap3_core_save_context();
>  			omap3_prcm_save_context();
> +			if (prm_setup->setup_times_off != NULL)
> +				prm_program_setup_times(prm_setup->
> +					setup_times_off);
>  		} else if (core_next_state == PWRDM_POWER_RET) {
>  			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
>  						OMAP3430_GR_MOD,
> @@ -479,11 +499,13 @@ void omap_sram_idle(void)
>  		}
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
> -		if (core_next_state == PWRDM_POWER_OFF)
> +		if (core_next_state == PWRDM_POWER_OFF) {
>  			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF,
>  					       OMAP3430_GR_MOD,
>  					       OMAP3_PRM_VOLTCTRL_OFFSET);
> -		else if (core_next_state == PWRDM_POWER_RET)
> +			if (prm_setup->setup_times_off != NULL)
> +				prm_program_setup_times(prm_setup->setup_times);
> +		} else if (core_next_state == PWRDM_POWER_RET)
>  			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
>  						OMAP3430_GR_MOD,
>  						OMAP3_PRM_VOLTCTRL_OFFSET);
> @@ -1043,24 +1065,21 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
>  	return -EINVAL;
>  }
>  
> +static void omap3_init_prm_setup_times(struct prm_setup_times_vc *conf)
> +{
> +	if (!conf)
> +		return;
> +
> +	conf->voltsetup1 =
> +		(conf->voltsetup_time2 << OMAP3430_SETUP_TIME2_SHIFT) |
> +		(conf->voltsetup_time1 << OMAP3430_SETUP_TIME1_SHIFT);
> +}
> +
>  void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
>  {
>  	if (!setup_vc)
>  		return;
> -
> -	prm_setup.clksetup = setup_vc->clksetup;
> -	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
> -	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
> -	prm_setup.voltoffset = setup_vc->voltoffset;
> -	prm_setup.voltsetup2 = setup_vc->voltsetup2;
> -	prm_setup.vdd0_on = setup_vc->vdd0_on;
> -	prm_setup.vdd0_onlp = setup_vc->vdd0_onlp;
> -	prm_setup.vdd0_ret = setup_vc->vdd0_ret;
> -	prm_setup.vdd0_off = setup_vc->vdd0_off;
> -	prm_setup.vdd1_on = setup_vc->vdd1_on;
> -	prm_setup.vdd1_onlp = setup_vc->vdd1_onlp;
> -	prm_setup.vdd1_ret = setup_vc->vdd1_ret;
> -	prm_setup.vdd1_off = setup_vc->vdd1_off;
> +	prm_setup = setup_vc;
>  }
>  
>  static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
> @@ -1206,16 +1225,16 @@ static void __init configure_vc(void)
>  			  (R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
>  			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
>  
> -	prm_write_mod_reg((prm_setup.vdd0_on << OMAP3430_VC_CMD_ON_SHIFT) |
> -		(prm_setup.vdd0_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> -		(prm_setup.vdd0_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> -		(prm_setup.vdd0_off << OMAP3430_VC_CMD_OFF_SHIFT),
> +	prm_write_mod_reg((prm_setup->vdd0_on << OMAP3430_VC_CMD_ON_SHIFT) |
> +		(prm_setup->vdd0_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> +		(prm_setup->vdd0_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> +		(prm_setup->vdd0_off << OMAP3430_VC_CMD_OFF_SHIFT),
>  		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
>  
> -	prm_write_mod_reg((prm_setup.vdd1_on << OMAP3430_VC_CMD_ON_SHIFT) |
> -		(prm_setup.vdd1_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> -		(prm_setup.vdd1_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> -		(prm_setup.vdd1_off << OMAP3430_VC_CMD_OFF_SHIFT),
> +	prm_write_mod_reg((prm_setup->vdd1_on << OMAP3430_VC_CMD_ON_SHIFT) |
> +		(prm_setup->vdd1_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> +		(prm_setup->vdd1_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> +		(prm_setup->vdd1_off << OMAP3430_VC_CMD_OFF_SHIFT),
>  		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
>  
>  	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
> @@ -1226,19 +1245,11 @@ static void __init configure_vc(void)
>  			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
>  
>  	/* Write setup times */
> -	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
> -			OMAP3_PRM_CLKSETUP_OFFSET);
> -	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
> -			OMAP3430_SETUP_TIME2_SHIFT) |
> -			(prm_setup.voltsetup_time1 <<
> -			OMAP3430_SETUP_TIME1_SHIFT),
> -			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> -
> -	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
> +	omap3_init_prm_setup_times(prm_setup->setup_times);
> +	omap3_init_prm_setup_times(prm_setup->setup_times_off);
> +	prm_program_setup_times(prm_setup->setup_times);
> +	prm_write_mod_reg(prm_setup->voltoffset, OMAP3430_GR_MOD,
>  			OMAP3_PRM_VOLTOFFSET_OFFSET);
> -	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTSETUP2_OFFSET);
> -
>  	pm_dbg_regset_init(1);
>  	pm_dbg_regset_init(2);
>  }
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
