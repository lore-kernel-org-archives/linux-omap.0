From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v5 2/5] omap3: pm: Using separate clk/volt setup_time for RET and OFF states
Date: Wed, 28 Apr 2010 15:51:19 -0700
Message-ID: <87vdbb9ons.fsf@deeprootsystems.com>
References: <1271677391-2119-1-git-send-email-leslyam@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35926 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab0D1WvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Apr 2010 18:51:24 -0400
Received: by gwj19 with SMTP id 19so5150055gwj.19
        for <linux-omap@vger.kernel.org>; Wed, 28 Apr 2010 15:51:23 -0700 (PDT)
In-Reply-To: <1271677391-2119-1-git-send-email-leslyam@ti.com> (Lesly A. M.'s message of "Mon\, 19 Apr 2010 17\:13\:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lesly A M <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Lesly A M <x0080970@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Lesly A M <leslyam@ti.com> writes:

> This patch will use separate clk/volt setup_time for RET and OFF state,
> also create separate copies of vc parameters for each Si in voltage.c.
>
> Re-programing the setup time according to the target state of CORE power domain.
> The voltsetup2 is used only when the device exits sys_off mode
> (with PRM_VOLTCTRL[3]SEL_OFF set to 1).

This needs more detail.  First, you're moving the voltsetup2 programming
into common code and then also adding dynamic programming of clksetup
and volsetup1.

> Changed vdd0_/vdd1_ to vdd1_/vdd2_ in prcm vc setuptime structure.

Typically, these 3 unrelated changes would be done in 3 separate
patches for easier review.  Especially this last one which is just a
rename.  Mixing rename/cleanup changes with functional changes makes
things very difficult to sort out.

Otherwise, getting much better.  Thanks.  A few minor comments
below...

> Signed-off-by: Lesly A M <x0080970@ti.com>
> Cc: Nishanth Menon <nm@ti.com> 
> Cc: David Derrick <dderrick@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp.c |   21 +----
>  arch/arm/mach-omap2/board-3630sdp.c |    4 +-
>  arch/arm/mach-omap2/board-zoom2.c   |    4 +-
>  arch/arm/mach-omap2/board-zoom3.c   |    4 +-
>  arch/arm/mach-omap2/pm.h            |   18 ----
>  arch/arm/mach-omap2/pm34xx.c        |   26 +-----
>  arch/arm/mach-omap2/voltage.c       |  157 ++++++++++++++++++++++++++--------
>  arch/arm/mach-omap2/voltage.h       |   31 +++++++
>  8 files changed, 165 insertions(+), 100 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index e80f8d4..9cc8569 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -48,7 +48,6 @@
>  #include "mux.h"
>  #include "sdram-qimonda-hyb18m512160af-6.h"
>  #include "hsmmc.h"
> -#include "pm.h"
>  #include "voltage.h"
>  #include "omap3-opp.h"
>  #include "smartreflex-class3.h"
> @@ -79,23 +78,6 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
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
> -};
> -
>  static int board_keymap[] = {
>  	KEY(0, 0, KEY_LEFT),
>  	KEY(0, 1, KEY_RIGHT),
> @@ -348,7 +330,6 @@ static void __init omap_3430sdp_init_irq(void)
>  	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
>  	omap3_pm_init_opp_table();
>  	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
> -	omap_voltage_init_vc(&omap3_setuptime_table);
>  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
>  	omap_init_irq();
>  	omap_gpio_init();
> @@ -897,6 +878,8 @@ static struct omap_musb_board_data musb_board_data = {
>  
>  static void __init omap_3430sdp_init(void)
>  {
> +	omap_voltage_init_vc(NULL);
> +
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>  	omap3430_i2c_init();
>  	platform_add_devices(sdp3430_devices, ARRAY_SIZE(sdp3430_devices));
> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
> index 2fc1d0b..19ecd67 100644
> --- a/arch/arm/mach-omap2/board-3630sdp.c
> +++ b/arch/arm/mach-omap2/board-3630sdp.c
> @@ -25,8 +25,8 @@
>  
>  #include "mux.h"
>  #include "sdram-hynix-h8mbx00u0mer-0em.h"
> -#include "pm.h"
>  #include "omap3-opp.h"
> +#include "voltage.h"
>  
>  #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
>  
> @@ -101,6 +101,8 @@ static struct omap_board_mux board_mux[] __initdata = {
>  
>  static void __init omap_sdp_init(void)
>  {
> +	omap_voltage_init_vc(NULL);

If a board isn't going to override, it shouldn't have to call the
function.  A default VC init should handle the default init for all
boards that don't need to override.  Otherwise, we'll have t add this
call to all board files.

[...]

> @@ -496,18 +488,6 @@ void omap_sram_idle(void)
>  		}
>  		omap_uart_resume_idle(0);
>  		omap_uart_resume_idle(1);
> -		if (core_next_state == PWRDM_POWER_OFF) {
> -			u32 voltctrl = OMAP3430_AUTO_OFF;
> -
> -			if (voltage_off_while_idle)
> -				voltctrl |= OMAP3430_SEL_OFF;
> -			prm_clear_mod_reg_bits(voltctrl,
> -					       OMAP3430_GR_MOD,
> -					       OMAP3_PRM_VOLTCTRL_OFFSET);
> -		} else if (core_next_state == PWRDM_POWER_RET)
> -			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
> -						OMAP3430_GR_MOD,
> -						OMAP3_PRM_VOLTCTRL_OFFSET);

This is all dropped but no equivalent is done in voltage.c, so you
need a better explanation in the changelog as to what's going on here
and why clearing the PRM_VOLTCTRL bits is no longer needed.


>  	}
>  	omap3_intc_resume_idle();
>  
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 11aeb69..bb80631 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -127,25 +127,70 @@ struct vc_reg_info {
>  } vc_reg;
>  
>  /*
> - * Default voltage controller settings for OMAP3
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
>  };
>  
>  /*
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
> +};
> +
> +static struct prm_setup_vc vc_config;
> +
> +/*
>   * Structures containing OMAP3430 voltage supported and various data
>   * associated with it per voltage domain basis. Smartreflex Ntarget
>   * vales are left as 0 as they have to be populated by smartreflex
> @@ -221,28 +266,28 @@ static void __init init_voltagecontroller(void)
>  			VC_VOLRA0_SHIFT));
>  
>  	voltage_write_reg(vc_reg.cmdval0_reg,
> -			(vc_config.vdd0_on << VC_CMD_ON_SHIFT) |
> -			(vc_config.vdd0_onlp << VC_CMD_ONLP_SHIFT) |
> -			(vc_config.vdd0_ret << VC_CMD_RET_SHIFT) |
> -			(vc_config.vdd0_off << VC_CMD_OFF_SHIFT));
> -
> -	voltage_write_reg(vc_reg.cmdval1_reg,
>  			(vc_config.vdd1_on << VC_CMD_ON_SHIFT) |
>  			(vc_config.vdd1_onlp << VC_CMD_ONLP_SHIFT) |
>  			(vc_config.vdd1_ret << VC_CMD_RET_SHIFT) |
>  			(vc_config.vdd1_off << VC_CMD_OFF_SHIFT));
>  
> +	voltage_write_reg(vc_reg.cmdval1_reg,
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
>  }
>  
>  static void vp_latch_vsel(int vp_id)
> @@ -833,22 +878,60 @@ void omap_change_voltscale_method(int voltscale_method)
>   */
>  void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
>  {
> +	if (cpu_is_omap3430())
> +		memcpy(&vc_config, &omap3430_vc_config,
> +				sizeof(struct prm_setup_vc));
> +	else if (cpu_is_omap3630())
> +		memcpy(&vc_config, &omap3630_vc_config,
> +				sizeof(struct prm_setup_vc));
> +
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
> +	/* CLK SETUPTIME for RET & OFF */
> +	vc_config.ret.clksetup = setup_vc->ret.clksetup;
> +	vc_config.off.clksetup = setup_vc->off.clksetup;
> +}
> +
> +void omap_voltage_vc_update(int core_next_state)
> +{
> +	u32 voltctrl = 0;
> +
> +	/* update voltsetup time */
> +	if (core_next_state == PWRDM_POWER_OFF) {
> +		voltctrl = OMAP3430_AUTO_OFF;
> +		prm_write_mod_reg(vc_config.off.clksetup, OMAP3430_GR_MOD,
> +				OMAP3_PRM_CLKSETUP_OFFSET);
> +		prm_write_mod_reg((vc_config.off.voltsetup1_vdd2 <<
> +				OMAP3430_SETUP_TIME2_SHIFT) |
> +				(vc_config.off.voltsetup1_vdd1 <<
> +				OMAP3430_SETUP_TIME1_SHIFT),
> +				OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> +
> +		if (voltage_off_while_idle) {
> +			voltctrl |= OMAP3430_SEL_OFF;
> +			prm_write_mod_reg(vc_config.off.voltsetup2,
> +					OMAP3430_GR_MOD,
> +					OMAP3_PRM_VOLTSETUP2_OFFSET);
> +		}
> +
> +	} else if (core_next_state == PWRDM_POWER_RET) {
> +		voltctrl = OMAP3430_AUTO_RET;
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
> +
> +	prm_set_mod_reg_bits(voltctrl, OMAP3430_GR_MOD,
> +				OMAP3_PRM_VOLTCTRL_OFFSET);
>  }
>  
>  /**
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index 473a953..b0cf1db 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -8,12 +8,41 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * published by the Free Software Foundation.
>   */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP3_VOLTAGE_H
> +#define __ARCH_ARM_MACH_OMAP3_VOLTAGE_H
> +

unrelated change. 

This should be fixed in Thara's original series, not included here.

>  #include "pm.h"
>  
>  /* VoltageDomain instances */
>  #define VDD1	0
>  #define VDD2	1
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

Minor nit (and not your fault since you inherited it):

Please indent the comments to the same level as the code.

Kevin
