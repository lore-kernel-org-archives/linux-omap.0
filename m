From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 3/8] OMAP: powerdomain: Arch specific funcs for state
 control
Date: Tue, 12 Oct 2010 01:41:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010120136550.16871@utopia.booyaka.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com> <1285245291-26442-2-git-send-email-rnayak@ti.com> <1285245291-26442-3-git-send-email-rnayak@ti.com> <1285245291-26442-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51792 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab0JLHly (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Oct 2010 03:41:54 -0400
In-Reply-To: <1285245291-26442-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, b-cousson@ti.com

On Thu, 23 Sep 2010, Rajendra Nayak wrote:

> Define the following architecture specific funtions for omap2/3/4
> .pwrdm_set_next_pwrst
> .pwrdm_read_next_pwrst
> .pwrdm_read_pwrst
> .pwrdm_read_prev_pwrst
> 
> Convert the platform-independent framework to call these functions.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    5 +++
>  arch/arm/mach-omap2/io.c               |    5 ++-
>  arch/arm/mach-omap2/powerdomains.h     |    8 ++++
>  arch/arm/mach-omap2/powerdomains2xxx.c |   58 +++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomains44xx.c |   59 ++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/powerdomain.c       |   45 ++++++++++++------------
>  6 files changed, 157 insertions(+), 23 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/powerdomains2xxx.c
>  create mode 100644 arch/arm/mach-omap2/powerdomains44xx.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 42209b5..a3ced1d 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -88,6 +88,11 @@ obj-$(CONFIG_ARCH_OMAP2420)		+= omap_hwmod_2420_data.o
>  obj-$(CONFIG_ARCH_OMAP2430)		+= omap_hwmod_2430_data.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
>  
> +#powerdomain framework
> +obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx.o
> +obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx.o
> +
>  # EMU peripherals
>  obj-$(CONFIG_OMAP3_EMU)			+= emu.o
>  
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 6cb5a39..b7c1ca1 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -315,7 +315,10 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  {
>  	u8 skip_setup_idle = 0;
>  
> -	pwrdm_init(powerdomains_omap, NULL);
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> +		pwrdm_init(powerdomains_omap, &omap2_pwrdm_functions);
> +	else if (cpu_is_omap44xx())
> +		pwrdm_init(powerdomains_omap, &omap4_pwrdm_functions);
>  	clkdm_init(clockdomains_omap, clkdm_autodeps);
>  	if (cpu_is_omap242x())
>  		omap2420_hwmod_init();
> diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
> index 105cbca..b25b989 100644
> --- a/arch/arm/mach-omap2/powerdomains.h
> +++ b/arch/arm/mach-omap2/powerdomains.h
> @@ -88,8 +88,16 @@ static struct powerdomain wkup_omap2_pwrdm = {
>  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
>  };
>  
> +extern struct pwrdm_functions omap2_pwrdm_functions;
> +#else
> +static struct pwrdm_functions omap2_pwrdm_functions;
>  #endif
>  
> +#ifdef CONFIG_ARCH_OMAP4
> +extern struct pwrdm_functions omap4_pwrdm_functions;
> +#else
> +static struct pwrdm_functions omap4_pwrdm_functions;
> +#endif
>  
>  /* As powerdomains are added or removed above, this list must also be changed */
>  static struct powerdomain *powerdomains_omap[] __initdata = {
> diff --git a/arch/arm/mach-omap2/powerdomains2xxx.c b/arch/arm/mach-omap2/powerdomains2xxx.c
> new file mode 100644
> index 0000000..b0c4550
> --- /dev/null
> +++ b/arch/arm/mach-omap2/powerdomains2xxx.c
> @@ -0,0 +1,58 @@
> +/*
> + * OMAP2 and OMAP3 powerdomain control
> + *
> + * Copyright (C) 2009-2010 Texas Instruments, Inc.
> + * Copyright (C) 2007-2009 Nokia Corporation

Don't forget your name.

> + *
> + * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <plat/cpu.h>
> +#include <plat/powerdomain.h>
> +#include <plat/clockdomain.h>
> +#include <plat/prcm.h>
> +
> +#include "pm.h"
> +#include "cm.h"
> +#include "cm-regbits-34xx.h"
> +#include "cm-regbits-44xx.h"
> +#include "prm.h"
> +#include "prm-regbits-34xx.h"
> +#include "prm-regbits-44xx.h"
> +
> +int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)

seems like this should be static?

> +{
> +	return prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> +				(pwrst << OMAP_POWERSTATE_SHIFT),
> +				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
> +}
> +
> +int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)

as above

> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +				OMAP2_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
> +}
> +
> +int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)

as above

> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +				OMAP2_PM_PWSTST, OMAP_POWERSTATEST_MASK);
> +}
> +
> +int omap2_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)

as above

> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
> +				OMAP3430_LASTPOWERSTATEENTERED_MASK);
> +}
> +
> +struct pwrdm_functions omap2_pwrdm_functions = {
> +	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
> +	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
> +	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
> +	.pwrdm_read_prev_pwrst	= omap2_pwrdm_read_prev_pwrst,
> +};
> diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
> new file mode 100644
> index 0000000..aba2219
> --- /dev/null
> +++ b/arch/arm/mach-omap2/powerdomains44xx.c
> @@ -0,0 +1,59 @@
> +/*
> + * OMAP4 powerdomain control
> + *
> + * Copyright (C) 2009-2010 Texas Instruments, Inc.
> + * Copyright (C) 2007-2009 Nokia Corporation
> + *
> + * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/io.h>
> +#include <plat/cpu.h>
> +#include <plat/powerdomain.h>
> +#include <plat/clockdomain.h>
> +#include <plat/prcm.h>
> +
> +#include "pm.h"
> +#include "cm.h"
> +#include "cm-regbits-34xx.h"
> +#include "cm-regbits-44xx.h"
> +#include "prm.h"
> +#include "prm-regbits-34xx.h"
> +#include "prm-regbits-44xx.h"
> +
> +int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)

static 

> +{
> +	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> +				(pwrst << OMAP_POWERSTATE_SHIFT),
> +				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
> +	return 0;
> +}
> +
> +int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)

static 

> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +				OMAP4_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
> +}
> +
> +int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)

static 

> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +				OMAP4_PM_PWSTST, OMAP_POWERSTATEST_MASK);
> +}
> +
> +int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)

static 

> +{
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
> +				OMAP4430_LASTPOWERSTATEENTERED_MASK);
> +}
> +
> +struct pwrdm_functions omap4_pwrdm_functions = {
> +	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
> +	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
> +	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
> +	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
> +};
> diff --git a/arch/arm/plat-omap/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
> index f90bfd3..3a1845a 100644
> --- a/arch/arm/plat-omap/powerdomain.c
> +++ b/arch/arm/plat-omap/powerdomain.c
> @@ -224,18 +224,6 @@ void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_functions * custom
>  {
>  	struct powerdomain **p = NULL;
>  
> -	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
> -		pwrstctrl_reg_offs = OMAP2_PM_PWSTCTRL;
> -		pwrstst_reg_offs = OMAP2_PM_PWSTST;
> -	} else if (cpu_is_omap44xx()) {
> -		pwrstctrl_reg_offs = OMAP4_PM_PWSTCTRL;
> -		pwrstst_reg_offs = OMAP4_PM_PWSTST;
> -	} else {
> -		printk(KERN_ERR "Power Domain struct not supported for " \
> -							"this CPU\n");
> -		return;
> -	}
> -
>  	if (!custom_funcs) {
>  		printk(KERN_ERR "No custom pwrdm functions registered\n");
>  		BUG();
> @@ -440,6 +428,8 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
>   */
>  int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> @@ -449,11 +439,10 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
>  		 pwrdm->name, pwrst);
>  
> -	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> -			     (pwrst << OMAP_POWERSTATE_SHIFT),
> -			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
> +	if (arch_pwrdm->pwrdm_set_next_pwrst)

this probably needs to be:

if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)

...

same for the rest of these functions...

> +		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -466,11 +455,15 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>   */
>  int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -				 pwrstctrl_reg_offs, OMAP_POWERSTATE_MASK);
> +	if (arch_pwrdm->pwrdm_read_next_pwrst)
> +		ret = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -483,11 +476,15 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -				 pwrstst_reg_offs, OMAP_POWERSTATEST_MASK);
> +	if (arch_pwrdm->pwrdm_read_pwrst)
> +		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -500,11 +497,15 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
> -					OMAP3430_LASTPOWERSTATEENTERED_MASK);
> +	if (arch_pwrdm->pwrdm_read_prev_pwrst)
> +		ret = arch_pwrdm->pwrdm_read_prev_pwrst(pwrdm);
> +
> +	return ret;
>  }
>  
>  /**
> -- 
> 1.7.0.4
> 


- Paul
