From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH/RFC 1/3] OMAP3: VC: create common init code
Date: Mon, 25 Jan 2010 11:32:13 -0800
Message-ID: <87eile6kw2.fsf@deeprootsystems.com>
References: <1264122141-17886-1-git-send-email-khilman@deeprootsystems.com>
	<1264122141-17886-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f173.google.com ([209.85.223.173]:42210 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab0AYTcR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jan 2010 14:32:17 -0500
Received: by iwn3 with SMTP id 3so1196492iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 25 Jan 2010 11:32:16 -0800 (PST)
In-Reply-To: <1264122141-17886-2-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 21 Jan 2010 17\:02\:19 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Lesly A M <x0080970@ti.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Move VC init code from PM core into separate VC core.
>
> No functional changes.

FYI... retracting this patch as Thara is working on the same reorg as part of
the SmartReflex rework.

Kevin

> ---
>  arch/arm/mach-omap2/Makefile        |    3 +-
>  arch/arm/mach-omap2/board-3430sdp.c |    1 +
>  arch/arm/mach-omap2/pm.h            |   25 --------
>  arch/arm/mach-omap2/pm34xx.c        |   91 ---------------------------
>  arch/arm/mach-omap2/vc.c            |  116 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/vc.h            |   47 ++++++++++++++
>  6 files changed, 166 insertions(+), 117 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/vc.c
>  create mode 100644 arch/arm/mach-omap2/vc.h
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 4ca93f1..4c6f017 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -37,7 +37,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP24XX)		+= sleep24xx.o
> -obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
> +obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o \
> +					   vc.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)		+= smartreflex.o
>  endif
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index 7d68445..65ab469 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -48,6 +48,7 @@
>  #include "mmc-twl4030.h"
>  #include "pm.h"
>  #include "omap3-opp.h"
> +#include "vc.h"
>  
>  #define SDP3430_TS_GPIO_IRQ_SDPV1	3
>  #define SDP3430_TS_GPIO_IRQ_SDPV2	2
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 75aa685..78b5a06 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -40,31 +40,6 @@ inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
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
> -#ifdef CONFIG_PM
> -extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
> -#else
> -static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
> -{
> -}
> -#endif
> -
>  extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
>  extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>  
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 190f25c..df437a5 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -95,22 +95,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
>  
> -static struct prm_setup_vc prm_setup = {
> -	.clksetup = 0xff,
> -	.voltsetup_time1 = 0xfff,
> -	.voltsetup_time2 = 0xfff,
> -	.voltoffset = 0xff,
> -	.voltsetup2 = 0xff,
> -	.vdd0_on = 0x30,	/* 1.2v */
> -	.vdd0_onlp = 0x20,	/* 1.0v */
> -	.vdd0_ret = 0x1e,	/* 0.975v */
> -	.vdd0_off = 0x00,	/* 0.6v */
> -	.vdd1_on = 0x2c,	/* 1.15v */
> -	.vdd1_onlp = 0x20,	/* 1.0v */
> -	.vdd1_ret = 0x1e,	/* .975v */
> -	.vdd1_off = 0x00,	/* 0.6v */
> -};
> -
>  static inline void omap3_per_save_context(void)
>  {
>  	omap_gpio_save_context();
> @@ -1072,26 +1056,6 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
>  	return -EINVAL;
>  }
>  
> -void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
> -{
> -	if (!setup_vc)
> -		return;
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
> -}
> -
>  static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
>  {
>  	struct power_state *pwrst;
> @@ -1228,60 +1192,5 @@ err2:
>  	return ret;
>  }
>  
> -static void __init configure_vc(void)
> -{
> -
> -	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
> -			  (R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
> -			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
> -	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
> -			  (R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
> -			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
> -
> -	prm_write_mod_reg((prm_setup.vdd0_on << OMAP3430_VC_CMD_ON_SHIFT) |
> -		(prm_setup.vdd0_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> -		(prm_setup.vdd0_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> -		(prm_setup.vdd0_off << OMAP3430_VC_CMD_OFF_SHIFT),
> -		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
> -
> -	prm_write_mod_reg((prm_setup.vdd1_on << OMAP3430_VC_CMD_ON_SHIFT) |
> -		(prm_setup.vdd1_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> -		(prm_setup.vdd1_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> -		(prm_setup.vdd1_off << OMAP3430_VC_CMD_OFF_SHIFT),
> -		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
> -
> -	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
> -			  OMAP3_PRM_VC_CH_CONF_OFFSET);
> -
> -	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
> -			  OMAP3430_GR_MOD,
> -			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
> -
> -	/* Write setup times */
> -	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
> -			OMAP3_PRM_CLKSETUP_OFFSET);
> -	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
> -			OMAP3430_SETUP_TIME2_SHIFT) |
> -			(prm_setup.voltsetup_time1 <<
> -			OMAP3430_SETUP_TIME1_SHIFT),
> -			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> -
> -	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTOFFSET_OFFSET);
> -	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
> -			OMAP3_PRM_VOLTSETUP2_OFFSET);
> -}
> -
> -static int __init omap3_pm_early_init(void)
> -{
> -	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
> -				OMAP3_PRM_POLCTRL_OFFSET);
> -
> -	configure_vc();
> -
> -	return 0;
> -}
> -
> -arch_initcall(omap3_pm_early_init);
>  late_initcall(omap3_pm_init);
>  
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> new file mode 100644
> index 0000000..61d1e4a
> --- /dev/null
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -0,0 +1,116 @@
> +/*
> + * OMAP 2/3 Voltage Controller
> + *
> + * Author: Kevin Hilman, Deep Root Systems, LLC
> + *
> + * Based originally on code from pm34xx.c
> + * Copyright (C) 2006-2008 Nokia Corporation
> + * Tony Lindgren <tony@atomide.com>
> + * Jouni Hogander
> + *
> + * Copyright (C) 2010 Deep Root Systems, LLC. 
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include "vc.h"
> +#include "prm-regbits-34xx.h"
> +#include "smartreflex.h"
> +
> +/* #include "prm.h" */
> +
> +static struct prm_setup_vc prm_setup = {
> +	.clksetup = 0xff,
> +	.voltsetup_time1 = 0xfff,
> +	.voltsetup_time2 = 0xfff,
> +	.voltoffset = 0xff,
> +	.voltsetup2 = 0xff,
> +	.vdd0_on = 0x30,	/* 1.2v */
> +	.vdd0_onlp = 0x20,	/* 1.0v */
> +	.vdd0_ret = 0x1e,	/* 0.975v */
> +	.vdd0_off = 0x00,	/* 0.6v */
> +	.vdd1_on = 0x2c,	/* 1.15v */
> +	.vdd1_onlp = 0x20,	/* 1.0v */
> +	.vdd1_ret = 0x1e,	/* .975v */
> +	.vdd1_off = 0x00,	/* 0.6v */
> +};
> +
> +void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
> +{
> +	if (!setup_vc)
> +		return;
> +
> +	prm_setup.clksetup = setup_vc->clksetup;
> +	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
> +	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
> +	prm_setup.voltoffset = setup_vc->voltoffset;
> +	prm_setup.voltsetup2 = setup_vc->voltsetup2;
> +	prm_setup.vdd0_on = setup_vc->vdd0_on;
> +	prm_setup.vdd0_onlp = setup_vc->vdd0_onlp;
> +	prm_setup.vdd0_ret = setup_vc->vdd0_ret;
> +	prm_setup.vdd0_off = setup_vc->vdd0_off;
> +	prm_setup.vdd1_on = setup_vc->vdd1_on;
> +	prm_setup.vdd1_onlp = setup_vc->vdd1_onlp;
> +	prm_setup.vdd1_ret = setup_vc->vdd1_ret;
> +	prm_setup.vdd1_off = setup_vc->vdd1_off;
> +}
> +
> +static void __init configure_vc(void)
> +{
> +
> +	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
> +			  (R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
> +			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
> +	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
> +			  (R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
> +			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
> +
> +	prm_write_mod_reg((prm_setup.vdd0_on << OMAP3430_VC_CMD_ON_SHIFT) |
> +		(prm_setup.vdd0_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> +		(prm_setup.vdd0_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> +		(prm_setup.vdd0_off << OMAP3430_VC_CMD_OFF_SHIFT),
> +		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
> +
> +	prm_write_mod_reg((prm_setup.vdd1_on << OMAP3430_VC_CMD_ON_SHIFT) |
> +		(prm_setup.vdd1_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
> +		(prm_setup.vdd1_ret << OMAP3430_VC_CMD_RET_SHIFT) |
> +		(prm_setup.vdd1_off << OMAP3430_VC_CMD_OFF_SHIFT),
> +		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
> +
> +	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
> +			  OMAP3_PRM_VC_CH_CONF_OFFSET);
> +
> +	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
> +			  OMAP3430_GR_MOD,
> +			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
> +
> +	/* Write setup times */
> +	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
> +			OMAP3_PRM_CLKSETUP_OFFSET);
> +	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
> +			OMAP3430_SETUP_TIME2_SHIFT) |
> +			(prm_setup.voltsetup_time1 <<
> +			OMAP3430_SETUP_TIME1_SHIFT),
> +			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
> +
> +	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
> +			OMAP3_PRM_VOLTOFFSET_OFFSET);
> +	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
> +			OMAP3_PRM_VOLTSETUP2_OFFSET);
> +}
> +
> +static int __init omap3_vc_early_init(void)
> +{
> +	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
> +				OMAP3_PRM_POLCTRL_OFFSET);
> +
> +	configure_vc();
> +
> +	return 0;
> +}
> +
> +arch_initcall(omap3_vc_early_init);
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> new file mode 100644
> index 0000000..ba6dc1b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -0,0 +1,47 @@
> +/*
> + * OMAP 2/3 Voltage Controller
> + *
> + * Author: Kevin Hilman, Deep Root Systems, LLC
> + *
> + * Based originally on code from pm34xx.c
> + * Copyright (C) 2006-2008 Nokia Corporation
> + * Tony Lindgren <tony@atomide.com>
> + * Jouni Hogander
> + *
> + * Copyright (C) 2010 Deep Root Systems, LLC. 
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#ifndef __ARCH_ARM_MACH_OMAP2_VC_H
> +#define __ARCH_ARM_MACH_OMAP2_VC_H
> +
> +#include <linux/types.h>
> +
> +struct prm_setup_vc {
> +	u16 clksetup;
> +	u16 voltsetup_time1;
> +	u16 voltsetup_time2;
> +	u16 voltoffset;
> +	u16 voltsetup2;
> +	/* PRM_VC_CMD_VAL_0 specific bits */
> +	u16 vdd0_on;
> +	u16 vdd0_onlp;
> +	u16 vdd0_ret;
> +	u16 vdd0_off;
> +	/* PRM_VC_CMD_VAL_1 specific bits */
> +	u16 vdd1_on;
> +	u16 vdd1_onlp;
> +	u16 vdd1_ret;
> +	u16 vdd1_off;
> +};
> +#ifdef CONFIG_PM
> +extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
> +#else
> +static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc) 
> +{
> +}
> +#endif
> +
> +#endif
> -- 
> 1.6.6
