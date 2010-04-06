From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [PATCH v4 2/5] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Tue, 06 Apr 2010 13:11:17 -0700
Message-ID: <87fx38nxy2.fsf@deeprootsystems.com>
References: <1270030840-2056-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f193.google.com ([209.85.222.193]:58207 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649Ab0DFULW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 16:11:22 -0400
Received: by pzk31 with SMTP id 31so336284pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 06 Apr 2010 13:11:21 -0700 (PDT)
In-Reply-To: <1270030840-2056-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Wed\, 31 Mar 2010 15\:50\:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> This patch will use separate clk/volt setup_time for RET and OFF state,
> also create separate copies of vc parameters for each Si in voltage.c.
>
> Updates the clksetup time from board file, since clksetup time depends on
> the OSC/XTAL used on the board. Re-programing the setup time according
> to the target state of CORE power domain.
> The voltsetup2 is used only when the device exits sys_off mode
> (with PRM_VOLTCTRL[3]SEL_OFF set to 1).
>
> Changed vdd0_/vdd1_ to vdd1_/vdd2_ in prcm vc setuptime structure.
>
> Signed-off-by: Lesly A M <x0080970@ti.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c |   28 +++----
>  arch/arm/mach-omap2/board-3630sdp.c |   15 ++++
>  arch/arm/mach-omap2/board-zoom2.c   |   15 ++++
>  arch/arm/mach-omap2/board-zoom3.c   |   15 ++++
>  arch/arm/mach-omap2/pm.h            |   17 ----
>  arch/arm/mach-omap2/pm34xx.c        |   14 +++-
>  arch/arm/mach-omap2/voltage.c       |  150 ++++++++++++++++++++++++++---------
>  arch/arm/mach-omap2/voltage.h       |   30 +++++++
>  8 files changed, 209 insertions(+), 75 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 6ee9f20..4439813 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -77,21 +77,16 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
>  	{1, 10000, 30000, 300000},
>  };
>  
> -/* FIXME: These are not the optimal setup values to be used on 3430sdp*/
> -static struct prm_setup_vc omap3_setuptime_table = {
> -	.clksetup = 0xff,
> -	.voltsetup_time1 = 0xfff,
> -	.voltsetup_time2 = 0xfff,
> -	.voltoffset = 0xff,
> -	.voltsetup2 = 0xff,
> -	.vdd0_on = 0x30,
> -	.vdd0_onlp = 0x20,
> -	.vdd0_ret = 0x1e,
> -	.vdd0_off = 0x00,
> -	.vdd1_on = 0x2c,
> -	.vdd1_onlp = 0x20,
> -	.vdd1_ret = 0x1e,
> -	.vdd1_off = 0x00,
> +/* CLKSETUP TIME which depends on the OSC/XTAL used on the board */
> +static struct prm_setup_vc omap3_setuptime = {
> +	/* CLK SETUPTIME for RET */
> +	.ret = {
> +		.clksetup = 0x1,
> +	},
> +	/* CLK SETUPTIME for OFF */
> +	.off = {
> +		.clksetup = 0x14A,
> +	},
>  };
>  
>  static int board_keymap[] = {
> @@ -345,7 +340,6 @@ static void __init omap_3430sdp_init_irq(void)
>  	omap_board_config = sdp3430_config;
>  	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
>  	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
> -	omap_voltage_init_vc(&omap3_setuptime_table);
>  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
>  			     omap3_dsp_rate_table, omap3_l3_rate_table);
>  	omap_init_irq();
> @@ -895,6 +889,8 @@ static struct omap_musb_board_data musb_board_data = {
>  
>  static void __init omap_3430sdp_init(void)
>  {
> +	omap_voltage_init_vc(&omap3_setuptime);
> +
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap3430_i2c_init();
>  	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
> index 3937a47..d04987d 100644
> --- a/arch/arm/mach-omap2/board-3630sdp.c
> +++ b/arch/arm/mach-omap2/board-3630sdp.c
> @@ -25,6 +25,19 @@
>  
>  #include "mux.h"
>  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> +#include "voltage.h"
> +
> +/* CLKSETUP TIME which depends on the OSC/XTAL used on the board */
> +static struct prm_setup_vc omap3_setuptime = {
> +	/* CLK SETUPTIME for RET */
> +	.ret = {
> +		.clksetup = 0x1,
> +	},
> +	/* CLK SETUPTIME for OFF */
> +	.off = {
> +		.clksetup = 0x14A,
> +	},
> +};
>  
>  #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
>  
> @@ -96,6 +109,8 @@ static struct omap_board_mux board_mux[] __initdata = {
>  
>  static void __init omap_sdp_init(void)
>  {
> +	omap_voltage_init_vc(&omap3_setuptime);
> +
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
>  	zoom_peripherals_init();
>  	board_smc91x_init();
> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
> index a2cdfdd..37f43dd 100644
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -26,6 +26,19 @@
>  #include "mux.h"
>  #include "sdram-micron-mt46h32m32lf-6.h"
>  #include "omap3-opp.h"
> +#include "voltage.h"
> +
> +/* CLKSETUP TIME which depends on the OSC/XTAL used on the board */
> +static struct prm_setup_vc omap3_setuptime = {
> +	/* CLK SETUPTIME for RET */
> +	.ret = {
> +		.clksetup = 0x1,
> +	},
> +	/* CLK SETUPTIME for OFF */
> +	.off = {
> +		.clksetup = 0x14A,
> +	},
> +};
>  
>  static void __init omap_zoom2_init_irq(void)
>  {
> @@ -81,6 +94,8 @@ static struct omap_board_mux board_mux[] __initdata = {
>  
>  static void __init omap_zoom2_init(void)
>  {
> +	omap_voltage_init_vc(&omap3_setuptime);
> +
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	zoom_peripherals_init();
>  	zoom_debugboard_init();
> diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
> index 9a4b2aa..76858d5 100644
> --- a/arch/arm/mach-omap2/board-zoom3.c
> +++ b/arch/arm/mach-omap2/board-zoom3.c
> @@ -24,6 +24,19 @@
>  
>  #include "mux.h"
>  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> +#include "voltage.h"
> +
> +/* CLKSETUP TIME which depends on the OSC/XTAL used on the board */
> +static struct prm_setup_vc omap3_setuptime = {
> +	/* CLK SETUPTIME for RET */
> +	.ret = {
> +		.clksetup = 0x1,
> +	},
> +	/* CLK SETUPTIME for OFF */
> +	.off = {
> +		.clksetup = 0x14A,
> +	},
> +};

All of the board file structs are identical and also match the
defaults setup on voltage.c.  The board files should only need
to set these values if they want to override the defaults.

>  static void __init omap_zoom_map_io(void)
>  {
> @@ -65,6 +78,8 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
>  
>  static void __init omap_zoom_init(void)
>  {
> +	omap_voltage_init_vc(&omap3_setuptime);
> +
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
>  	zoom_peripherals_init();
>  	zoom_debugboard_init();
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 26dc5c8..7e3726d 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -40,23 +40,6 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
>  }
>  #endif
>  
> -struct prm_setup_vc {
> -	u16 clksetup;
> -	u16 voltsetup_time1;
> -	u16 voltsetup_time2;
> -	u16 voltoffset;
> -	u16 voltsetup2;
> -/* PRM_VC_CMD_VAL_0 specific bits */
> -	u16 vdd0_on;
> -	u16 vdd0_onlp;
> -	u16 vdd0_ret;
> -	u16 vdd0_off;
> -/* PRM_VC_CMD_VAL_1 specific bits */
> -	u16 vdd1_on;
> -	u16 vdd1_onlp;
> -	u16 vdd1_ret;
> -	u16 vdd1_off;
> -};
>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>  
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 81f78d3..a62a505 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -359,6 +359,7 @@ void omap_sram_idle(void)
>  	int core_prev_state, per_prev_state;
>  	u32 sdrc_pwr = 0;
>  	int per_state_modified = 0;
> +	u32 voltctrl = 0;
>  
>  	if (!_omap_sram_idle)
>  		return;
> @@ -423,20 +424,25 @@ void omap_sram_idle(void)
>  		omap_uart_prepare_idle(0);
>  		omap_uart_prepare_idle(1);
>  		if (core_next_state == PWRDM_POWER_OFF) {
> -			u32 voltctrl = OMAP3430_AUTO_OFF;
> +			voltctrl = OMAP3430_AUTO_OFF;
>  
>  			if (voltage_off_while_idle)
>  				voltctrl |= OMAP3430_SEL_OFF;
>  			prm_set_mod_reg_bits(voltctrl,
>  					     OMAP3430_GR_MOD,
>  					     OMAP3_PRM_VOLTCTRL_OFFSET);
> -			omap3_core_save_context();
> -			omap3_prcm_save_context();
>  		} else if (core_next_state == PWRDM_POWER_RET) {
>  			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
>  						OMAP3430_GR_MOD,
>  						OMAP3_PRM_VOLTCTRL_OFFSET);
>  		}
> +		/* Update the voltsetup time for RET/OFF */
> +		update_voltsetup_time(core_next_state);
> +
> +		if (core_next_state == PWRDM_POWER_OFF) {
> +			omap3_core_save_context();
> +			omap3_prcm_save_context();
> +		}

While updating the voltage related changes here, you should also move
these other VC related changes into voltage.c, possibly into the same
function with a more generic name: omap_voltage_vc_update() or
something.

>  		/* Enable IO-PAD and IO-CHAIN wakeups */
>  		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
>  		omap3_enable_io_chain();
> @@ -496,7 +502,7 @@ void omap_sram_idle(void)
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
>  		if (core_next_state == PWRDM_POWER_OFF) {
> -			u32 voltctrl = OMAP3430_AUTO_OFF;
> +			voltctrl = OMAP3430_AUTO_OFF;
>  
>  			if (voltage_off_while_idle)
>  				voltctrl |= OMAP3430_SEL_OFF;
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 89a1ab1..b588ace 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -69,25 +69,70 @@ struct vc_reg_info {
>  	void __iomem *vc_bypass_val_reg;
>  } vc_reg;
>  
> -/**
> - * Default voltage controller settings for OMAP3
> +/*
> + * Default voltage controller settings for OMAP3430
>   */
> -static struct prm_setup_vc vc_config = {
> -	.clksetup = 0xff,
> -	.voltsetup_time1 = 0xfff,
> -	.voltsetup_time2 = 0xfff,
> -	.voltoffset = 0xff,
> -	.voltsetup2 = 0xff,
> -	.vdd0_on = 0x30,        /* 1.2v */
> -	.vdd0_onlp = 0x20,      /* 1.0v */
> -	.vdd0_ret = 0x1e,       /* 0.975v */
> -	.vdd0_off = 0x00,       /* 0.6v */
> -	.vdd1_on = 0x2c,        /* 1.15v */
> +struct __initdata prm_setup_vc omap3430_vc_config = {
> +	/* CLK & VOLT SETUPTIME for RET */
> +	.ret = {
> +		.clksetup = 0x1,
> +		.voltsetup1_vdd1 = 0x005B,
> +		.voltsetup1_vdd2 = 0x0055,
> +		.voltsetup2 = 0x0,
> +		.voltoffset = 0x0,
> +	},
> +	/* CLK & VOLT SETUPTIME for OFF */
> +	.off = {
> +		.clksetup = 0x14A,
> +		.voltsetup1_vdd1 = 0x00B3,
> +		.voltsetup1_vdd2 = 0x00A0,
> +		.voltsetup2 = 0x118,
> +		.voltoffset = 0x32,
> +	},
> +	/* VC COMMAND VALUES for VDD1/VDD2 */
> +	.vdd1_on = 0x30,        /* 1.2v */
>  	.vdd1_onlp = 0x20,      /* 1.0v */
> -	.vdd1_ret = 0x1e,       /* .975v */
> +	.vdd1_ret = 0x1e,       /* 0.975v */
>  	.vdd1_off = 0x00,       /* 0.6v */
> +	.vdd2_on = 0x2c,        /* 1.15v */
> +	.vdd2_onlp = 0x20,      /* 1.0v */
> +	.vdd2_ret = 0x1e,       /* 0.975v */
> +	.vdd2_off = 0x00,       /* 0.6v */
> +};
> +
> +/*
> + * Default voltage controller settings for OMAP3630
> + */
> +struct __initdata prm_setup_vc omap3630_vc_config = {
> +	/* CLK & VOLT SETUPTIME for RET */
> +	.ret = {
> +		.clksetup = 0x1,
> +		.voltsetup1_vdd1 = 0x005B,
> +		.voltsetup1_vdd2 = 0x0055,
> +		.voltsetup2 = 0x0,
> +		.voltoffset = 0x0,
> +	},
> +	/* CLK & VOLT SETUPTIME for OFF */
> +	.off = {
> +		.clksetup = 0x14A,
> +		.voltsetup1_vdd1 = 0x00B3,
> +		.voltsetup1_vdd2 = 0x00A0,
> +		.voltsetup2 = 0x118,
> +		.voltoffset = 0x32,
> +	},
> +	/* VC COMMAND VALUES for VDD1/VDD2 */
> +	.vdd1_on = 0x28,	/* 1.1v */
> +	.vdd1_onlp = 0x20,	/* 1.0v */
> +	.vdd1_ret = 0x13,	/* 0.83v */
> +	.vdd1_off = 0x00,	/* 0.6v */
> +	.vdd2_on = 0x2B,	/* 1.1375v */
> +	.vdd2_onlp = 0x20,	/* 1.0v */
> +	.vdd2_ret = 0x13,	/* 0.83v */
> +	.vdd2_off = 0x00,	/* 0.6v */
>  };
>  
> +static struct prm_setup_vc vc_config;
> +
>  static inline u32 voltage_read_reg(void __iomem *offset)
>  {
>  	return __raw_readl(offset);
> @@ -149,28 +194,28 @@ static void __init init_voltagecontroller(void)
>  			VC_VOLRA0_SHIFT));
>  
>  	voltage_write_reg(vc_reg.vc_cmdval0_reg,
> -			(vc_config.vdd0_on << VC_CMD_ON_SHIFT) |
> -			(vc_config.vdd0_onlp << VC_CMD_ONLP_SHIFT) |
> -			(vc_config.vdd0_ret << VC_CMD_RET_SHIFT) |
> -			(vc_config.vdd0_off << VC_CMD_OFF_SHIFT));
> -
> -	voltage_write_reg(vc_reg.vc_cmdval1_reg,
>  			(vc_config.vdd1_on << VC_CMD_ON_SHIFT) |
>  			(vc_config.vdd1_onlp << VC_CMD_ONLP_SHIFT) |
>  			(vc_config.vdd1_ret << VC_CMD_RET_SHIFT) |
>  			(vc_config.vdd1_off << VC_CMD_OFF_SHIFT));
>  
> +	voltage_write_reg(vc_reg.vc_cmdval1_reg,
> +			(vc_config.vdd2_on << VC_CMD_ON_SHIFT) |
> +			(vc_config.vdd2_onlp << VC_CMD_ONLP_SHIFT) |
> +			(vc_config.vdd2_ret << VC_CMD_RET_SHIFT) |
> +			(vc_config.vdd2_off << VC_CMD_OFF_SHIFT));
> +
>  	voltage_write_reg(vc_ch_conf_reg, VC_CMD1 | VC_RAV1);
>  
>  	voltage_write_reg(vc_i2c_cfg_reg, VC_MCODE_SHIFT | VC_HSEN);
>  
>  	/* Write setup times */
> -	voltage_write_reg(prm_clksetup_reg, vc_config.clksetup);
> +	voltage_write_reg(prm_clksetup_reg, vc_config.ret.clksetup);
>  	voltage_write_reg(prm_voltsetup1_reg,
> -			(vc_config.voltsetup_time2 << VC_SETUP_TIME2_SHIFT) |
> -			(vc_config.voltsetup_time1 << VC_SETUP_TIME1_SHIFT));
> -	voltage_write_reg(prm_voltoffset_reg, vc_config.voltoffset);
> -	voltage_write_reg(prm_voltsetup2_reg, vc_config.voltsetup2);
> +		(vc_config.ret.voltsetup1_vdd2 << VC_SETUP_TIME2_SHIFT) |
> +		(vc_config.ret.voltsetup1_vdd1 << VC_SETUP_TIME1_SHIFT));
> +	voltage_write_reg(prm_voltoffset_reg, vc_config.ret.voltoffset);
> +	voltage_write_reg(prm_voltsetup2_reg, vc_config.ret.voltsetup2);
>  
>  	pm_dbg_regset_init(1);
>  	pm_dbg_regset_init(2);
> @@ -497,19 +542,48 @@ void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
>  	if (!setup_vc)
>  		return;
>  
> -	vc_config.clksetup = setup_vc->clksetup;
> -	vc_config.voltsetup_time1 = setup_vc->voltsetup_time1;
> -	vc_config.voltsetup_time2 = setup_vc->voltsetup_time2;
> -	vc_config.voltoffset = setup_vc->voltoffset;
> -	vc_config.voltsetup2 = setup_vc->voltsetup2;
> -	vc_config.vdd0_on = setup_vc->vdd0_on;
> -	vc_config.vdd0_onlp = setup_vc->vdd0_onlp;
> -	vc_config.vdd0_ret = setup_vc->vdd0_ret;
> -	vc_config.vdd0_off = setup_vc->vdd0_off;
> -	vc_config.vdd1_on = setup_vc->vdd1_on;
> -	vc_config.vdd1_onlp = setup_vc->vdd1_onlp;
> -	vc_config.vdd1_ret = setup_vc->vdd1_ret;
> -	vc_config.vdd1_off = setup_vc->vdd1_off;
> +	if (cpu_is_omap3430())
> +		memcpy(&vc_config, &omap3430_vc_config,
> +				sizeof(struct prm_setup_vc));
> +	else if (cpu_is_omap3630())
> +		memcpy(&vc_config, &omap3630_vc_config,
> +				sizeof(struct prm_setup_vc));
> +
> +	/* CLK SETUPTIME for RET & OFF */
> +	vc_config.ret.clksetup = setup_vc->ret.clksetup;
> +	vc_config.off.clksetup = setup_vc->off.clksetup;

Here you should check if setup_vc is NULL, only override
if a non-NULL struct is passed in.

> +}
> +
> +void update_voltsetup_time(int core_next_state)
> +{
> +	/* update voltsetup time */
> +	if (core_next_state == PWRDM_POWER_OFF) {
> +		prm_write_mod_reg(vc_config.off.clksetup, OMAP3430_GR_MOD,
> +				OMAP3_PRM_CLKSETUP_OFFSET);
> +		prm_write_mod_reg((vc_config.off.voltsetup1_vdd2 <<
> +				OMAP3430_SETUP_TIME2_SHIFT) |
> +				(vc_config.off.voltsetup1_vdd1 <<
> +				OMAP3430_SETUP_TIME1_SHIFT),
> +				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> +
> +		if (voltage_off_while_idle)
> +			prm_write_mod_reg(vc_config.off.voltsetup2,
> +					OMAP3430_GR_MOD,
> +					OMAP3_PRM_VOLTSETUP2_OFFSET);
> +
> +	} else if (core_next_state == PWRDM_POWER_RET) {
> +		prm_write_mod_reg(vc_config.ret.clksetup, OMAP3430_GR_MOD,
> +				OMAP3_PRM_CLKSETUP_OFFSET);
> +		prm_write_mod_reg((vc_config.ret.voltsetup1_vdd2 <<
> +				OMAP3430_SETUP_TIME2_SHIFT) |
> +				(vc_config.ret.voltsetup1_vdd1 <<
> +				OMAP3430_SETUP_TIME1_SHIFT),
> +				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> +
> +		/* clear voltsetup2_reg if sys_off not enabled */
> +		prm_write_mod_reg(vc_config.ret.voltsetup2, OMAP3430_GR_MOD,
> +				OMAP3_PRM_VOLTSETUP2_OFFSET);
> +	}
>  }
>  
>  /**
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index be67dbe..c8bbea3 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -8,12 +8,40 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +#ifndef __ARCH_ARM_MACH_OMAP3_VOLTAGE_H
> +#define __ARCH_ARM_MACH_OMAP3_VOLTAGE_H
> +
>  #include "pm.h"
>  
>  /* SMART REFLEX I2C slave address */
>  #define VP1	1
>  #define VP2	2
>  
> +struct setuptime_vc{
> +	u16 clksetup;
> +	u16 voltsetup1_vdd1;
> +	u16 voltsetup1_vdd2;
> +	u16 voltsetup2;
> +	u16 voltoffset;
> +};
> +
> +struct prm_setup_vc {
> +/* CLK & VOLT SETUPTIME for RET */
> +	struct setuptime_vc ret;
> +/* CLK & VOLT SETUPTIME for OFF */
> +	struct setuptime_vc off;
> +/* PRM_VC_CMD_VAL_0 specific bits */
> +	u16 vdd1_on;
> +	u16 vdd1_onlp;
> +	u16 vdd1_ret;
> +	u16 vdd1_off;
> +/* PRM_VC_CMD_VAL_1 specific bits */
> +	u16 vdd2_on;
> +	u16 vdd2_onlp;
> +	u16 vdd2_ret;
> +	u16 vdd2_off;
> +};
> +
>  /* Number of scalable voltage domains that has an independent Voltage processor
>   * Can change for OMAP4
>   */
> @@ -73,6 +101,8 @@ extern int get_vdd2_opp(void);
>  void omap_voltageprocessor_enable(int vp_id);
>  void omap_voltageprocessor_disable(int vp_id);
>  void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
> +void update_voltsetup_time(int core_next_state);

Noice the name of this function doesn't match the API pattern of the others.
Please fix.

Kevin

>  void omap_voltage_init(void);
>  int omap_voltage_scale(int vdd, u8 target_vsel, u8 current_vsel);
>  void omap_reset_voltage(int vdd);
> +#endif
> -- 
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
