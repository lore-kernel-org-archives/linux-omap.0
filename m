From: Nishanth Menon <menon.nishanth@gmail.com>
Subject: Re: [PATCHv1 1/1] omap3: pm: Delink opp layer and cpufreq
Date: Mon, 31 May 2010 20:29:07 +0300
Message-ID: <4C03F1E3.9030202@gmail.com>
References: <1275309542-26004-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:53514 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756850Ab0EaR3M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 May 2010 13:29:12 -0400
Received: by ey-out-2122.google.com with SMTP id d26so211976eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 31 May 2010 10:29:11 -0700 (PDT)
In-Reply-To: <1275309542-26004-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On 05/31/2010 03:39 PM, Sanjeev Premi wrote:
> The OPP layer was contained in the CONFIG_CPU_FREQ.
> This patch removes this containment relation.
>
> Signed-off-by: Sanjeev Premi<premi@ti.com>
> ---
>   arch/arm/mach-omap2/Makefile          |    6 +-
>   arch/arm/mach-omap2/board-omap3evm.c  |    2 +-
you sure this is the only board file having "omap3-opp.h" ? anyway.. the 
need for board files to use opp_init is gone with my patch
http://marc.info/?l=linux-omap&m=127507237109393&w=2
so I wont harp on it, I would rather post a cleanup patch for all board 
files once the patch is in..(or mebbe kevin could drop the patch that 
adds opp_init_table to board files ;) )..

>   arch/arm/mach-omap2/cpufreq34xx.c     |  164 --------------------------------
>   arch/arm/mach-omap2/omap3-opp.h       |   20 ----
>   arch/arm/mach-omap2/opp34xx_data.c    |  166 +++++++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/pm34xx.c          |    1 -
>   arch/arm/plat-omap/Makefile           |    7 +-
>   arch/arm/plat-omap/cpu-omap.c         |   47 +++++++++
>   arch/arm/plat-omap/include/plat/opp.h |   82 +---------------
>   arch/arm/plat-omap/opp.c              |   46 ---------
>   10 files changed, 225 insertions(+), 316 deletions(-)
>   delete mode 100644 arch/arm/mach-omap2/cpufreq34xx.c
>   delete mode 100644 arch/arm/mach-omap2/omap3-opp.h
>   create mode 100644 arch/arm/mach-omap2/opp34xx_data.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index ac08f99..4e51a99 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -55,10 +55,8 @@ AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
>
>   endif
>
> -# CPU Frequency
> -ifeq ($(CONFIG_CPU_FREQ),y)
> -obj-$(CONFIG_ARCH_OMAP3)		+= cpufreq34xx.o
> -endif
> +# OPP definitions for OMAP3
> +obj-$(CONFIG_ARCH_OMAP3)		+= opp34xx_data.o
>
>   # PRCM
>   obj-$(CONFIG_ARCH_OMAP2)		+= cm.o
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index 0a3f5b6..cb97c5d 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -50,11 +50,11 @@
>   #include<plat/common.h>
>   #include<plat/mcspi.h>
>   #include<plat/display.h>
> +#include<plat/opp.h>
>
>   #include "mux.h"
>   #include "sdram-micron-mt46h32m32lf-6.h"
>   #include "hsmmc.h"
> -#include "omap3-opp.h"
>
>   #define GPMC_CS0_BASE  0x60
>   #define GPMC_CS_SIZE   0x30
> diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
> deleted file mode 100644
> index 8747dd6..0000000
> --- a/arch/arm/mach-omap2/cpufreq34xx.c
> +++ /dev/null
> @@ -1,164 +0,0 @@
> -/*
> - * arch/arm/mach-omap2/cpufreq34xx.c
> - * OMAP3 resource init/change_level/validate_level functions
> - *
> - * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
> - *	Nishanth Menon
> - * Copyright (C) 2009 - 2010 Deep Root Systems, LLC.
> - *	Kevin Hilman
> - * Copyright (C) 2010 Nokia Corporation.
> - *      Eduardo Valentin
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> - * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> - * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> - * History:
> - *
> - */
> -
> -#include<linux/module.h>
> -#include<linux/err.h>
> -
> -#include<plat/opp.h>
> -#include<plat/cpu.h>
> -#include "omap3-opp.h"
> -
> -static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
> -	/* OPP1 */
> -	OMAP_OPP_DEF(true, 125000000, 975000),
> -	/* OPP2 */
> -	OMAP_OPP_DEF(true, 250000000, 1075000),
> -	/* OPP3 */
> -	OMAP_OPP_DEF(true, 500000000, 1200000),
> -	/* OPP4 */
> -	OMAP_OPP_DEF(true, 550000000, 1270000),
> -	/* OPP5 */
> -	OMAP_OPP_DEF(true, 600000000, 1350000),
> -	/* Terminator */
> -	OMAP_OPP_DEF(0, 0, 0)
> -};
> -
> -static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
> -	/*
> -	 * OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
> -	 * almost the same than the one at 83MHz thus providing very little
> -	 * gain for the power point of view. In term of energy it will even
> -	 * increase the consumption due to the very negative performance
> -	 * impact that frequency will do to the MPU and the whole system in
> -	 * general.
> -	 */
> -	OMAP_OPP_DEF(false, 41500000, 975000),
> -	/* OPP2 */
> -	OMAP_OPP_DEF(true, 83000000, 1050000),
> -	/* OPP3 */
> -	OMAP_OPP_DEF(true, 166000000, 1150000),
> -	/* Terminator */
> -	OMAP_OPP_DEF(0, 0, 0)
> -};
> -
> -static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
> -	/* OPP1 */
> -	OMAP_OPP_DEF(true, 90000000, 975000),
> -	/* OPP2 */
> -	OMAP_OPP_DEF(true, 180000000, 1075000),
> -	/* OPP3 */
> -	OMAP_OPP_DEF(true, 360000000, 1200000),
> -	/* OPP4 */
> -	OMAP_OPP_DEF(true, 400000000, 1270000),
> -	/* OPP5 */
> -	OMAP_OPP_DEF(true, 430000000, 1350000),
> -	/* Terminator */
> -	OMAP_OPP_DEF(0, 0, 0)
> -};
> -
> -static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
> -	/* OPP1 - OPP50 */
> -	OMAP_OPP_DEF(true,  300000000, 930000),
> -	/* OPP2 - OPP100 */
> -	OMAP_OPP_DEF(true,  600000000, 1100000),
> -	/* OPP3 - OPP-Turbo */
> -	OMAP_OPP_DEF(false, 800000000, 1260000),
> -	/* OPP4 - OPP-SB */
> -	OMAP_OPP_DEF(false, 1000000000, 1350000),
> -	/* Terminator */
> -	OMAP_OPP_DEF(0, 0, 0)
> -};
> -
> -static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
> -	/* OPP1 - OPP50 */
> -	OMAP_OPP_DEF(true, 100000000, 930000),
> -	/* OPP2 - OPP100, OPP-Turbo, OPP-SB */
> -	OMAP_OPP_DEF(true, 200000000, 1137500),
> -	/* Terminator */
> -	OMAP_OPP_DEF(0, 0, 0)
> -};
> -
> -static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
> -	/* OPP1 - OPP50 */
> -	OMAP_OPP_DEF(true,  260000000, 930000),
> -	/* OPP2 - OPP100 */
> -	OMAP_OPP_DEF(true,  520000000, 1100000),
> -	/* OPP3 - OPP-Turbo */
> -	OMAP_OPP_DEF(false, 660000000, 1260000),
> -	/* OPP4 - OPP-SB */
> -	OMAP_OPP_DEF(false, 800000000, 1350000),
> -	/* Terminator */
> -	OMAP_OPP_DEF(0, 0, 0)
> -};
> -
> -int __init omap3_pm_init_opp_table(void)
> -{
> -	int i, r;
> -	struct omap_opp_def **omap3_opp_def_list;
> -	struct omap_opp_def *omap34xx_opp_def_list[] = {
> -		omap34xx_mpu_rate_table,
> -		omap34xx_l3_rate_table,
> -		omap34xx_dsp_rate_table
> -	};
> -	struct omap_opp_def *omap36xx_opp_def_list[] = {
> -		omap36xx_mpu_rate_table,
> -		omap36xx_l3_rate_table,
> -		omap36xx_dsp_rate_table
> -	};
> -	enum opp_t omap3_opps[] = {
> -		OPP_MPU,
> -		OPP_L3,
> -		OPP_DSP
> -	};
> -
> -	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
> -				omap34xx_opp_def_list;
> -
> -	for (i = 0; i<  ARRAY_SIZE(omap3_opps); i++) {
> -		r = opp_init_list(omap3_opps[i], omap3_opp_def_list[i]);
> -		if (r)
> -			break;
> -	}
> -	if (!r)
> -		return 0;
> -
> -	/* Cascading error handling - disable all enabled OPPs */
> -	pr_err("%s: Failed to register %d OPP type\n", __func__,
> -		omap3_opps[i]);
> -	i--;
> -	while (i != -1) {
> -		struct omap_opp *opp;
> -		unsigned long freq = 0;
> -
> -		do {
> -			opp = opp_find_freq_ceil(omap3_opps[i],&freq);
> -			if (IS_ERR(opp))
> -				break;
> -			opp_disable(opp);
> -			freq++;
> -		} while (1);
> -		i--;
> -	}
> -
> -	return r;
> -}
> -
> diff --git a/arch/arm/mach-omap2/omap3-opp.h b/arch/arm/mach-omap2/omap3-opp.h
> deleted file mode 100644
> index 16d9e5b..0000000
> --- a/arch/arm/mach-omap2/omap3-opp.h
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -#ifndef __OMAP3_OPP_H_
> -#define __OMAP3_OPP_H_
> -
> -#include<plat/omap-pm.h>
> -
> -/**
> - * omap3_pm_init_opp_table - OMAP opp table lookup called after cpu is detected.
> - * Initialize the basic opp table here, board files could choose to modify opp
> - * table after the basic initialization
> - */
> -#ifdef CONFIG_CPU_FREQ
> -extern int omap3_pm_init_opp_table(void);
> -#else
> -static inline int omap3_pm_init_opp_table(void)
> -{
> -	return -EINVAL;
> -}
> -#endif
> -
> -#endif

finding it difficult to align with this change, you introduce 
omap3_pm_init_opp_table later into plat/opp.h which defeats generic 
nature of opp.h - as it was supposed to be used for other omaps as well..

> diff --git a/arch/arm/mach-omap2/opp34xx_data.c b/arch/arm/mach-omap2/opp34xx_data.c
> new file mode 100644
> index 0000000..7017d6d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/opp34xx_data.c
> @@ -0,0 +1,166 @@
> +/*
> + * arch/arm/mach-omap2/cpufreq34xx.c
one more reason why i think i prefer not to have file names in comment 
headers ;) they get forgotten to be modified..

> + * OMAP3 resource init/change_level/validate_level functions
> + *
> + * Copyright (C) 2009 - 2010 Texas Instruments Incorporated.
> + *	Nishanth Menon
> + * Copyright (C) 2009 - 2010 Deep Root Systems, LLC.
> + *	Kevin Hilman
> + * Copyright (C) 2010 Nokia Corporation.
> + *      Eduardo Valentin
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * THIS PACKAGE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
> + * IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
> + * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
> + * History:
> + *
> + */
> +
> +#include<linux/module.h>
> +#include<linux/err.h>
> +
> +#include<plat/opp.h>
> +#include<plat/cpu.h>
> +
> +static struct omap_opp_def __initdata omap34xx_mpu_rate_table[] = {
> +	/* OPP1 */
> +	OMAP_OPP_DEF(true, 125000000, 975000),
> +	/* OPP2 */
> +	OMAP_OPP_DEF(true, 250000000, 1075000),
> +	/* OPP3 */
> +	OMAP_OPP_DEF(true, 500000000, 1200000),
> +	/* OPP4 */
> +	OMAP_OPP_DEF(true, 550000000, 1270000),
> +	/* OPP5 */
> +	OMAP_OPP_DEF(true, 600000000, 1350000),
> +	/* OPP6 */
> +	OMAP_OPP_DEF(true, 720000000, 1350000),
> +	/* Terminator */
> +	OMAP_OPP_DEF(0, 0, 0)
> +};
> +
> +static struct omap_opp_def __initdata omap34xx_l3_rate_table[] = {
> +	/*
> +	 * OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
> +	 * almost the same than the one at 83MHz thus providing very little
> +	 * gain for the power point of view. In term of energy it will even
> +	 * increase the consumption due to the very negative performance
> +	 * impact that frequency will do to the MPU and the whole system in
> +	 * general.
> +	 */
> +	OMAP_OPP_DEF(false, 41500000, 975000),
> +	/* OPP2 */
> +	OMAP_OPP_DEF(true, 83000000, 1050000),
> +	/* OPP3 */
> +	OMAP_OPP_DEF(true, 166000000, 1150000),
> +	/* Terminator */
> +	OMAP_OPP_DEF(0, 0, 0)
> +};
> +
> +static struct omap_opp_def __initdata omap34xx_dsp_rate_table[] = {
> +	/* OPP1 */
> +	OMAP_OPP_DEF(true, 90000000, 975000),
> +	/* OPP2 */
> +	OMAP_OPP_DEF(true, 180000000, 1075000),
> +	/* OPP3 */
> +	OMAP_OPP_DEF(true, 360000000, 1200000),
> +	/* OPP4 */
> +	OMAP_OPP_DEF(true, 400000000, 1270000),
> +	/* OPP5 */
> +	OMAP_OPP_DEF(true, 430000000, 1350000),
> +	/* OPP6 */
> +	OMAP_OPP_DEF(true, 520000000, 1350000),
> +	/* Terminator */
> +	OMAP_OPP_DEF(0, 0, 0)
> +};
> +
> +static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
> +	/* OPP1 - OPP50 */
> +	OMAP_OPP_DEF(true,  300000000, 930000),
> +	/* OPP2 - OPP100 */
> +	OMAP_OPP_DEF(true,  600000000, 1100000),
> +	/* OPP3 - OPP-Turbo */
> +	OMAP_OPP_DEF(false, 800000000, 1260000),
> +	/* OPP4 - OPP-SB */
> +	OMAP_OPP_DEF(false, 1000000000, 1350000),
> +	/* Terminator */
> +	OMAP_OPP_DEF(0, 0, 0)
> +};
> +
> +static struct omap_opp_def __initdata omap36xx_l3_rate_table[] = {
> +	/* OPP1 - OPP50 */
> +	OMAP_OPP_DEF(true, 100000000, 930000),
> +	/* OPP2 - OPP100, OPP-Turbo, OPP-SB */
> +	OMAP_OPP_DEF(true, 200000000, 1137500),
> +	/* Terminator */
> +	OMAP_OPP_DEF(0, 0, 0)
> +};
> +
> +static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
> +	/* OPP1 - OPP50 */
> +	OMAP_OPP_DEF(true,  260000000, 930000),
> +	/* OPP2 - OPP100 */
> +	OMAP_OPP_DEF(true,  520000000, 1100000),
> +	/* OPP3 - OPP-Turbo */
> +	OMAP_OPP_DEF(false, 660000000, 1260000),
> +	/* OPP4 - OPP-SB */
> +	OMAP_OPP_DEF(false, 800000000, 1350000),
> +	/* Terminator */
> +	OMAP_OPP_DEF(0, 0, 0)
> +};
> +
> +int __init omap3_pm_init_opp_table(void)
> +{
> +	int i, r;
> +	struct omap_opp_def **omap3_opp_def_list;
> +	struct omap_opp_def *omap34xx_opp_def_list[] = {
> +		omap34xx_mpu_rate_table,
> +		omap34xx_l3_rate_table,
> +		omap34xx_dsp_rate_table
> +	};
> +	struct omap_opp_def *omap36xx_opp_def_list[] = {
> +		omap36xx_mpu_rate_table,
> +		omap36xx_l3_rate_table,
> +		omap36xx_dsp_rate_table
> +	};
> +	enum opp_t omap3_opps[] = {
> +		OPP_MPU,
> +		OPP_L3,
> +		OPP_DSP
> +	};
> +
> +	omap3_opp_def_list = cpu_is_omap3630() ? omap36xx_opp_def_list :
> +				omap34xx_opp_def_list;
> +
> +	for (i = 0; i<  ARRAY_SIZE(omap3_opps); i++) {
> +		r = opp_init_list(omap3_opps[i], omap3_opp_def_list[i]);
> +		if (r)
> +			break;
> +	}
> +	if (!r)
> +		return 0;
> +
> +	/* Cascading error handling - disable all enabled OPPs */
> +	pr_err("%s: Failed to register %d OPP type\n", __func__,
> +		omap3_opps[i]);
> +	i--;
> +	while (i != -1) {
> +		struct omap_opp *opp;
> +		unsigned long freq = 0;
> +
> +		do {
> +			opp = opp_find_freq_ceil(omap3_opps[i],&freq);
> +			if (IS_ERR(opp))
> +				break;
> +			opp_disable(opp);
> +			freq++;
> +		} while (1);
> +		i--;
> +	}
> +
> +	return r;
> +}
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 48857a4..271d49f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -53,7 +53,6 @@
>   #include "prm.h"
>   #include "pm.h"
>   #include "sdrc.h"
> -#include "omap3-opp.h"
>
>   #ifdef CONFIG_SUSPEND
>   static suspend_state_t suspend_state = PM_SUSPEND_ON;
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 2b9ebf0..ee79885 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -13,10 +13,9 @@ obj-  :=
>   obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
>
>   # OPP support in (OMAP3+ only at the moment)
> -# XXX The OPP TWL/TPS code should only be included when a TWL/TPS
> -# PMIC is selected.
> -ifdef CONFIG_CPU_FREQ
> -obj-$(CONFIG_ARCH_OMAP3) += opp.o opp_twl_tps.o
> +ifdef CONFIG_ARCH_OMAP3
> +obj-y				+= opp.o
> +obj-$(CONFIG_TWL4030_POWER)	+= opp_twl_tps.o
NAK. you just need TWL4030_CORE not power here. any reason to retain 
power? it has no dependency on power..

>   endif
>
>   # omap_device support (OMAP2+ only at the moment)
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index 0674405..d46b8d0 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -121,6 +121,53 @@ static int omap_target(struct cpufreq_policy *policy,
>   	return ret;
>   }
>
> +#ifdef CONFIG_ARCH_OMAP3
> +void opp_init_cpufreq_table(enum opp_t opp_type,
> +			    struct cpufreq_frequency_table **table)
> +{
> +	int i = 0, j;
> +	int opp_num;
> +	struct cpufreq_frequency_table *freq_table;
> +	struct omap_opp *opp;
> +
> +	if (opp_type>= OPP_TYPES_MAX) {
> +		pr_warning("%s: failed to initialize frequency"
> +				"table\n", __func__);
> +		return;
> +	}
> +
> +	opp_num = opp_get_opp_count(opp_type);
> +	if (opp_num<  0) {
> +		pr_err("%s: no opp table?\n", __func__);
> +		return;
> +	}
> +
> +	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
> +			     (opp_num + 1), GFP_ATOMIC);
> +	if (!freq_table) {
> +		pr_warning("%s: failed to allocate frequency"
> +				"table\n", __func__);
> +		return;
> +	}
> +
> +	opp = _opp_list[opp_type];
> +	opp += opp_num;
> +	for (j = opp_num; j>= 0; j--) {
> +		if (opp->enabled) {
> +			freq_table[i].index = i;
> +			freq_table[i].frequency = opp->rate / 1000;
> +			i++;
> +		}
> +		opp--;
> +	}
> +
> +	freq_table[i].index = i;
> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	*table =&freq_table[0];
> +}
> +#endif
> +
errrr.... why? it used to be here and was moved to opp.c - see
http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=commit;h=9a6b00f70e9f4bce30ad4f8fab41a24bd3706dbd
you are essentially reverting that patch!

>   static int __init omap_cpu_init(struct cpufreq_policy *policy)
>   {
>   	int result = 0;
> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> index 7d16a46..51b1776 100644
> --- a/arch/arm/plat-omap/include/plat/opp.h
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -15,7 +15,6 @@
>   #define __ASM_ARM_OMAP_OPP_H
>
>   #include<linux/err.h>
> -#include<linux/cpufreq.h>
>
>   #ifdef CONFIG_ARCH_OMAP3
>   enum opp_t {
> @@ -66,7 +65,6 @@ struct omap_opp_def {
>
>   struct omap_opp;
>
> -#ifdef CONFIG_CPU_FREQ
>
>   /**
>    * opp_get_voltage() - Gets the voltage corresponding to an opp
> @@ -233,79 +231,11 @@ struct omap_opp * __deprecated opp_find_by_opp_id(enum opp_t opp_type,
>   						  u8 opp_id);
>   u8 __deprecated opp_get_opp_id(struct omap_opp *opp);
>
> -void opp_init_cpufreq_table(enum opp_t opp_type,
> -			    struct cpufreq_frequency_table **table);
> -#else
> -static inline unsigned long opp_get_voltage(const struct omap_opp *opp)
> -{
> -	return 0;
> -}
> -
> -static inline unsigned long opp_get_freq(const struct omap_opp *opp)
> -{
> -	return 0;
> -}
> -
> -static inline int opp_get_opp_count(struct omap_opp *oppl)
> -{
> -	return 0;
> -}
> -
> -static inline struct omap_opp *opp_find_freq_exact(struct omap_opp *oppl,
> -				     unsigned long freq, bool enabled)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline struct omap_opp *opp_find_freq_floor(struct omap_opp *oppl,
> -				     unsigned long *freq)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline struct omap_opp *opp_find_freq_ceil(struct omap_opp *oppl,
> -					unsigned long *freq)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline
> -struct omap_opp __init *opp_init_list(const struct omap_opp_def *opp_defs)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline struct omap_opp *opp_add(struct omap_opp *oppl,
> -			 const struct omap_opp_def *opp_def)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline int opp_enable(struct omap_opp *opp)
> -{
> -	return 0;
> -}
> -
> -static inline int opp_disable(struct omap_opp *opp)
> -{
> -	return 0;
> -}
> -
> -static inline struct omap_opp * __deprecated
> -opp_find_by_opp_id(struct omap_opp *opps, u8 opp_id)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline u8 __deprecated opp_get_opp_id(struct omap_opp *opp)
> -{
> -	return 0;
> -}
> -
> -static inline void opp_init_cpufreq_table(struct omap_opp *opps,
> -			    struct cpufreq_frequency_table **table)
> -{
> -}
> +/**
> + * omap3_pm_init_opp_table() - Initialize the OPP table for OMAP3 devices.
> + *
> + * Initializes the OPP table for the current OMAP3 device.
> + */
> +int __init omap3_pm_init_opp_table(void);
NAK. opp. is meant to be used by omap2, OMAP4 etc..
when you removed from omap3-opp.h, it kinda needed you to have it here, 
which breaks the generic nature of this header.

>
> -#endif		/* CONFIG_CPU_FREQ */
>   #endif		/* __ASM_ARM_OMAP_OPP_H */
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index 13da451..3ed3ec1 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -351,49 +351,3 @@ int opp_disable(struct omap_opp *opp)
>   	opp->enabled = false;
>   	return 0;
>   }
> -
> -/* XXX document */
> -void opp_init_cpufreq_table(enum opp_t opp_type,
> -			    struct cpufreq_frequency_table **table)
> -{
> -	int i = 0, j;
> -	int opp_num;
> -	struct cpufreq_frequency_table *freq_table;
> -	struct omap_opp *opp;
> -
> -	if (opp_type>= OPP_TYPES_MAX) {
> -		pr_warning("%s: failed to initialize frequency"
> -				"table\n", __func__);
> -		return;
> -	}
> -
> -	opp_num = opp_get_opp_count(opp_type);
> -	if (opp_num<  0) {
> -		pr_err("%s: no opp table?\n", __func__);
> -		return;
> -	}
> -
> -	freq_table = kmalloc(sizeof(struct cpufreq_frequency_table) *
> -			     (opp_num + 1), GFP_ATOMIC);
> -	if (!freq_table) {
> -		pr_warning("%s: failed to allocate frequency"
> -				"table\n", __func__);
> -		return;
> -	}
> -
> -	opp = _opp_list[opp_type];
> -	opp += opp_num;
> -	for (j = opp_num; j>= 0; j--) {
> -		if (opp->enabled) {
> -			freq_table[i].index = i;
> -			freq_table[i].frequency = opp->rate / 1000;
> -			i++;
> -		}
> -		opp--;
> -	}
> -
> -	freq_table[i].index = i;
> -	freq_table[i].frequency = CPUFREQ_TABLE_END;
> -
> -	*table =&freq_table[0];
> -}
not sure why you removed this..
