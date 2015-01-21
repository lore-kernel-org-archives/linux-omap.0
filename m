From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Add clock domain support for dm816x
Date: Wed, 21 Jan 2015 02:05:50 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1501210128020.5450@utopia.booyaka.com>
References: <1421191355-12835-1-git-send-email-tony@atomide.com> <1421191355-12835-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37403 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbAUCFv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 21:05:51 -0500
In-Reply-To: <1421191355-12835-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, Brian Hutchinson <b.hutchman@gmail.com>

Hi 

On Tue, 13 Jan 2015, Tony Lindgren wrote:

> From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> 
> This patch adds required definitions and structures for clockdomain
> initialization, so omap3xxx_clockdomains_init() was substituted by
> new ti81xx_clockdomains_init() while early initialization of
> TI81XX platform.
> 
> This code is based on the TI81XX-LINUX-PSP-04.04.00.02 patches
> published at:
> 
> http://downloads.ti.com/dsps/dsps_public_sw/psp/LinuxPSP/TI81XX_04_04/04_04_00_02/index_FDS.html
> 
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
> [tony@atomide.com: updated to apply, renamed to clockdomains81xx.c
>  fixed to use am33xx_clkdm_operations]
> Signed-off-by: Tony Lindgren <tony@atomide.com>

A few comments below based on SPRUGX8B:

> ---
>  arch/arm/mach-omap2/Makefile                |   2 +
>  arch/arm/mach-omap2/clockdomain.h           |   1 +
>  arch/arm/mach-omap2/clockdomains81xx_data.c | 191 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/cm81xx.h                |  61 +++++++++
>  arch/arm/mach-omap2/io.c                    |   4 +-
>  5 files changed, 257 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/clockdomains81xx_data.c
>  create mode 100644 arch/arm/mach-omap2/cm81xx.h
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 3a6463f..352873c 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -171,6 +171,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common)
>  obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
>  obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
>  obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
> +obj-$(CONFIG_SOC_TI81XX)		+= $(clockdomain-common)
> +obj-$(CONFIG_SOC_TI81XX)		+= clockdomains81xx_data.o
>  obj-$(CONFIG_SOC_AM43XX)		+= $(clockdomain-common)
>  obj-$(CONFIG_SOC_AM43XX)		+= clockdomains43xx_data.o
>  obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
> diff --git a/arch/arm/mach-omap2/clockdomain.h b/arch/arm/mach-omap2/clockdomain.h
> index 82c37b1..77bab5f 100644
> --- a/arch/arm/mach-omap2/clockdomain.h
> +++ b/arch/arm/mach-omap2/clockdomain.h
> @@ -216,6 +216,7 @@ extern void __init omap242x_clockdomains_init(void);
>  extern void __init omap243x_clockdomains_init(void);
>  extern void __init omap3xxx_clockdomains_init(void);
>  extern void __init am33xx_clockdomains_init(void);
> +extern void __init ti81xx_clockdomains_init(void);
>  extern void __init omap44xx_clockdomains_init(void);
>  extern void __init omap54xx_clockdomains_init(void);
>  extern void __init dra7xx_clockdomains_init(void);
> diff --git a/arch/arm/mach-omap2/clockdomains81xx_data.c b/arch/arm/mach-omap2/clockdomains81xx_data.c
> new file mode 100644
> index 0000000..05c4635
> --- /dev/null
> +++ b/arch/arm/mach-omap2/clockdomains81xx_data.c
> @@ -0,0 +1,191 @@
> +/*
> + * TI81XX Clock Domain data.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + * Copyright (C) 2013 SKTB SKiT, http://www.skitlab.ru/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_81XX_H
> +#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_81XX_H
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +
> +#include "clockdomain.h"
> +
> +#include "cm81xx.h"
> +
> +/*
> + * - Add other domains as required
> + * - Fill up associated powerdomans (especially ALWON powerdomains are NULL at
> + *   the moment
> + * - Consider dependencies across domains (probably not applicable till now)

Minor comment: I guess these are to-do items; would suggest explicitly 
putting a "To-do" header on this list.

> + */
> +
> +/* Common TI81XX */

I can't comment on how many of these are truly common; since I haven't 
cross-checked this file against the 814x TRM.  But if you haven't had the 
chance to cross-check it against the 814x TRM either, I'd suggest starting 
by making this file explicitly 816x-specific.

> +static struct clockdomain alwon_l3_slow_81xx_clkdm = {
> +	.name		= "l3s_clkdm",

This should mention "alwon" in the name like the other L3 always-on 
clockdomains, since there's another L3 Slow clockdomain on this chip 
that's in the DEFAULT power domain, according to Section 18.7.6.4 
"CM_DEFAULT_L3_SLOW_CLKSTCTRL Register"

> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> +	.clkdm_offs	= TI81XX_CM_ALWON_L3_SLOW_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-136 "CM_ALWON_L3_SLOW_CLKSTCTRL Register Field 
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's 
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain alwon_l3_med_81xx_clkdm = {
> +	.name		= "alwon_l3_med_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> +	.clkdm_offs	= TI81XX_CM_ALWON_L3_MED_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-138 "CM_ALWON_L3_MED_CLKSTCTRL Register Field 
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain alwon_l3_fast_81xx_clkdm = {
> +	.name		= "alwon_l3_fast_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> +	.clkdm_offs	= TI81XX_CM_ALWON_L3_FAST_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> +};
> +
> +static struct clockdomain alwon_ethernet_81xx_clkdm = {
> +	.name		= "alwon_ethernet_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> +	.clkdm_offs	= TI81XX_CM_ETHERNET_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-137 "CM_ETHERNET_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +/* OCMC clock domain */

Hmm I think this comment is wrong, there are two other clock domains 
labeled "OCMC".

> +static struct clockdomain mmu_81xx_clkdm = {
> +	.name		= "mmu_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> +	.clkdm_offs	= TI81XX_CM_MMU_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-139 "CM_MMU_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain mmu_cfg_81xx_clkdm = {
> +	.name		= "mmu_cfg_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> +	.clkdm_offs	= TI81XX_CM_MMUCFG_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-140 "CM_MMUCFG_CLKSTCTRL Register Field 
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +/* TI816X only */
> +static struct clockdomain alwon_mpu_816x_clkdm = {
> +	.name		= "alwon_mpu_clkdm",
> +	.pwrdm		= { .name = "alwon_pwrdm" },
> +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> +	.clkdm_offs	= TI81XX_CM_ALWON_MPU_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-143 "CM_ALWON_MPU_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain active_gem_816x_clkdm = {
> +	.name		= "active_gem_clkdm",
> +	.pwrdm		= { .name = "active_pwrdm" },
> +	.cm_inst	= TI816X_CM_ACTIVE_MOD,
> +	.clkdm_offs	= TI816X_CM_ACTIVE_GEM_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-72 "CM_GEM_CLKSTCTRL Register Field Descriptions", 
only SW_SLEEP and SW_WKUP are supported.  So if that's correct, this 
should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain ivahd0_816x_clkdm = {
> +	.name		= "ivahd0_clkdm",
> +	.pwrdm		= { .name = "ivahd0_pwrdm" },
> +	.cm_inst	= TI816X_CM_IVAHD0_MOD,
> +	.clkdm_offs	= TI816X_CM_IVAHD0_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-91 "CM_IVAHD0_CLKSTCTRL Register Field 
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's 
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain ivahd1_816x_clkdm = {
> +	.name		= "ivahd1_clkdm",
> +	.pwrdm		= { .name = "ivahd1_pwrdm" },
> +	.cm_inst	= TI816X_CM_IVAHD1_MOD,
> +	.clkdm_offs	= TI816X_CM_IVAHD1_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-95 "CM_IVAHD1_CLKSTCTRL Register Field 
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's 
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain ivahd2_816x_clkdm = {
> +	.name		= "ivahd2_clkdm",
> +	.pwrdm		= { .name = "ivahd2_pwrdm" },
> +	.cm_inst	= TI816X_CM_IVAHD2_MOD,
> +	.clkdm_offs	= TI816X_CM_IVAHD2_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-99 "CM_IVAHD2_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain sgx_816x_clkdm = {
> +	.name		= "sgx_clkdm",
> +	.pwrdm		= { .name = "sgx_pwrdm" },
> +	.cm_inst	= TI816X_CM_SGX_MOD,
> +	.clkdm_offs	= TI816X_CM_SGX_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-103 "CM_SGX_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain default_l3_med_816x_clkdm = {
> +	.name		= "default_l3_med_clkdm",
> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_L3_MED_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-78 "CM_DEFAULT_L3_FAST_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain default_ducati_816x_clkdm = {

I can't find any mention of the Ducati in the TRM.  Does this SoC have a 
Ducati?

According to the TRM here, looks like this should just be 
"default_816x_clkdm" ?  The corresponding register is named 
CM_DEFAULT_CLKSTCTRL.  It references two clockdomains, GCLKINTR and 
GCLKIN200TR, but I can't find any other mention of those in the TRM, so, 
no idea what they're associated with.

> +	.name		= "default_ducati_clkdm",
> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_DUCATI_CLKDM,

(see 'Ducati' comments above)

> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-81 "CM_DEFAULT_CLKSTCTRL Register Field 
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's 
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain default_pcie_816x_clkdm = {
> +	.name		= "default_pcie_clkdm",

The TRM calls this the "DEFAULT_PCI" clockdomain - would suggest sticking 
to the TRM and register name to avoid confusion.

> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_PCI_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-79 "CM_DEFAULT_PCI_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain default_usb_816x_clkdm = {

The TRM calls this "DEFAULT_L3_SLOW" - would suggest sticking to the TRM 
and register name to avoid confusion.

> +	.name		= "default_usb_clkdm",

As above

> +	.pwrdm		= { .name = "default_pwrdm" },
> +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> +	.clkdm_offs	= TI816X_CM_DEFAULT_L3_SLOW_CLKDM,
> +	.flags		= CLKDM_CAN_HWSUP_SWSUP,

According to Table 18-80 "CM_DEFAULT_L3_SLOW_CLKSTCTRL Register Field
Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's
correct, this should be CLKDM_CAN_SWSUP.

> +};
> +
> +static struct clockdomain *clockdomains_ti81xx[] __initdata = {
> +	&alwon_mpu_816x_clkdm,
> +	&alwon_l3_slow_81xx_clkdm,
> +	&alwon_l3_med_81xx_clkdm,
> +	&alwon_l3_fast_81xx_clkdm,
> +	&alwon_ethernet_81xx_clkdm,
> +	&mmu_81xx_clkdm,
> +	&mmu_cfg_81xx_clkdm,
> +	&active_gem_816x_clkdm,
> +	&ivahd0_816x_clkdm,
> +	&ivahd1_816x_clkdm,
> +	&ivahd2_816x_clkdm,
> +	&sgx_816x_clkdm,
> +	&default_l3_med_816x_clkdm,
> +	&default_ducati_816x_clkdm,
> +	&default_pcie_816x_clkdm,
> +	&default_usb_816x_clkdm,
> +	NULL,
> +};

As the comment at the top of the file suggests, this is missing a lot 
of clockdomains.  The TRM lists 56 ALWON clockdomains, 13 DEFAULT 
clockdomains, 4 ACTIVE clockdomains, etc. 

> +
> +void __init ti81xx_clockdomains_init(void)
> +{
> +	clkdm_register_platform_funcs(&am33xx_clkdm_operations);
> +	clkdm_register_clkdms(clockdomains_ti81xx);
> +	clkdm_complete_init();
> +}
> +#endif
> diff --git a/arch/arm/mach-omap2/cm81xx.h b/arch/arm/mach-omap2/cm81xx.h
> new file mode 100644
> index 0000000..8d82ddc
> --- /dev/null
> +++ b/arch/arm/mach-omap2/cm81xx.h
> @@ -0,0 +1,61 @@
> +/*
> + * Clock domain register offsets for TI81XX.
> + *
> + * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
> + * Copyright (C) 2013 SKTB SKiT, http://www.skitlab.ru/
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef __ARCH_ARM_MACH_OMAP2_CM_TI81XX_H
> +#define __ARCH_ARM_MACH_OMAP2_CM_TI81XX_H
> +
> +/* TI81XX common CM module offsets */
> +#define TI81XX_CM_ALWON_MOD			0x1400	/* 1KB */
> +
> +/* TI816X CM module offsets */
> +#define TI816X_CM_ACTIVE_MOD			0x0400	/* 256B */
> +#define TI816X_CM_DEFAULT_MOD			0x0500	/* 256B */
> +#define TI816X_CM_IVAHD0_MOD			0x0600	/* 256B */
> +#define TI816X_CM_IVAHD1_MOD			0x0700	/* 256B */
> +#define TI816X_CM_IVAHD2_MOD			0x0800	/* 256B */
> +#define TI816X_CM_SGX_MOD			0x0900	/* 256B */
> +
> +/* ALWON */
> +#define TI81XX_CM_ALWON_MPU_CLKDM		0x001C
> +#define TI81XX_CM_ALWON_L3_SLOW_CLKDM		0x0000
> +#define TI81XX_CM_ALWON_L3_MED_CLKDM		0x0004
> +#define TI81XX_CM_ALWON_L3_FAST_CLKDM		0x0030
> +#define TI81XX_CM_ETHERNET_CLKDM		0x0004
> +#define TI81XX_CM_MMU_CLKDM			0x000C
> +#define TI81XX_CM_MMUCFG_CLKDM			0x0010

Nit: please consider ordering these macros by offset, rather than 
alphabetically by name.

> +
> +/* ACTIVE */
> +#define TI816X_CM_ACTIVE_GEM_CLKDM		0x0000
> +
> +/* IVAHD0 */
> +#define TI816X_CM_IVAHD0_CLKDM			0x0000
> +
> +/* IVAHD1 */
> +#define TI816X_CM_IVAHD1_CLKDM			0x0000
> +
> +/* IVAHD2 */
> +#define TI816X_CM_IVAHD2_CLKDM			0x0000
> +
> +/* SGX */
> +#define TI816X_CM_SGX_CLKDM			0x0000
> +
> +/* DEFAULT */
> +#define TI816X_CM_DEFAULT_L3_MED_CLKDM		0x0004
> +#define TI816X_CM_DEFAULT_DUCATI_CLKDM		0x0018

There's no Ducati clockdomain listed in the TRM, it's just 
"DEFAULT".  

> +#define TI816X_CM_DEFAULT_PCI_CLKDM		0x0010
> +#define TI816X_CM_DEFAULT_L3_SLOW_CLKDM		0x0014

Consider ordering these macros by offset, rather than 
alphabetically by name.

> +
> +#endif
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index e4a5630..ccf238c 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -504,7 +504,7 @@ void __init ti814x_init_early(void)
>  	ti81xx_check_features();
>  	omap3xxx_voltagedomains_init();
>  	omap3xxx_powerdomains_init();
> -	omap3xxx_clockdomains_init();
> +	ti81xx_clockdomains_init();
>  	omap3xxx_hwmod_init();
>  	omap_hwmod_init_postsetup();
>  	if (of_have_populated_dt())
> @@ -523,7 +523,7 @@ void __init ti816x_init_early(void)
>  	ti81xx_check_features();
>  	omap3xxx_voltagedomains_init();
>  	omap3xxx_powerdomains_init();
> -	omap3xxx_clockdomains_init();
> +	ti81xx_clockdomains_init();
>  	omap3xxx_hwmod_init();
>  	omap_hwmod_init_postsetup();
>  	if (of_have_populated_dt())
> -- 
> 2.1.4
> 


- Paul
