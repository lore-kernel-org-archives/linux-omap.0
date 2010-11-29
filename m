From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 5/6] OMAP: powerdomain: Arch specific funcs for mem
 control
Date: Sun, 28 Nov 2010 17:28:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011281718510.2515@utopia.booyaka.com>
References: <1289921886-5139-1-git-send-email-rnayak@ti.com> <1289921886-5139-2-git-send-email-rnayak@ti.com> <1289921886-5139-3-git-send-email-rnayak@ti.com> <1289921886-5139-4-git-send-email-rnayak@ti.com> <1289921886-5139-5-git-send-email-rnayak@ti.com>
 <1289921886-5139-6-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51979 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220Ab0K2A2R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 28 Nov 2010 19:28:17 -0500
In-Reply-To: <1289921886-5139-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@deeprootsystems.com

Hi Rajendra,

On Tue, 16 Nov 2010, Rajendra Nayak wrote:

> Define the following architecture specific funtions for omap2/3/4
> .pwrdm_set_mem_onst
> .pwrdm_set_mem_retst
> .pwrdm_read_mem_pwrst
> .pwrdm_read_prev_mem_pwrst
> .pwrdm_read_mem_retst
> .pwrdm_clear_all_prev_pwrst
> .pwrdm_enable_hdwr_sar
> .pwrdm_disable_hdwr_sar
> .pwrdm_wait_transition
> 
> Convert the platform-independent framework to call these functions.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/Makefile           |    2 +-
>  arch/arm/mach-omap2/powerdomains.c     |  114 ++++++++++++
>  arch/arm/mach-omap2/powerdomains.h     |    5 +
>  arch/arm/mach-omap2/powerdomains2xxx.c |  129 ++++++++++++++
>  arch/arm/mach-omap2/powerdomains44xx.c |   87 +++++++++
>  arch/arm/plat-omap/powerdomain.c       |  306 ++++++--------------------------
>  6 files changed, 391 insertions(+), 252 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/powerdomains.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 5f843fc..87a73b7 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -4,7 +4,7 @@
>  
>  # Common support
>  obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
> -	 common.o
> +	 common.o powerdomains.o

Please move this down to the newly-created "Powerdomains" section of the 
Makefile.

>  
>  omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
>  hwmod-common				= omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/powerdomains.c b/arch/arm/mach-omap2/powerdomains.c
> new file mode 100644
> index 0000000..876bebe
> --- /dev/null
> +++ b/arch/arm/mach-omap2/powerdomains.c

Maybe call this file 'powerdomain-common.c' to be similar to file names 
like prcm-common.c ?

> @@ -0,0 +1,114 @@
> +/*
> + *  linux/arch/arm/mach-omap2/powerdomains.c
> + *  Contains common powerdomain framework functions
> + *
> + *  Copyright (C) 2010 Texas Instruments, Inc.
> + *  Copyright (C) 2010 Nokia Corporation
> + *
> + * Derived from mach-omap2/powerdomain.c written by Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include "pm.h"
> +#include "cm.h"
> +#include "cm-regbits-34xx.h"
> +#include "cm-regbits-44xx.h"
> +#include "prm-regbits-34xx.h"
> +#include "prm-regbits-44xx.h"
> +
> +/*
> + * OMAP3 and OMAP4 specific register bit initialisations
> + * Notice that the names here are not according to each power
> + * domain but the bit mapping used applies to all of them
> + */
> +/* OMAP3 and OMAP4 Memory Onstate Masks (common across all power domains) */
> +#define OMAP_MEM0_ONSTATE_MASK OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK
> +#define OMAP_MEM1_ONSTATE_MASK OMAP3430_L1FLATMEMONSTATE_MASK
> +#define OMAP_MEM2_ONSTATE_MASK OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK
> +#define OMAP_MEM3_ONSTATE_MASK OMAP3430_L2FLATMEMONSTATE_MASK
> +#define OMAP_MEM4_ONSTATE_MASK OMAP4430_OCP_NRET_BANK_ONSTATE_MASK
> +
> +/* OMAP3 and OMAP4 Memory Retstate Masks (common across all power domains) */
> +#define OMAP_MEM0_RETSTATE_MASK OMAP3430_SHAREDL1CACHEFLATRETSTATE_MASK
> +#define OMAP_MEM1_RETSTATE_MASK OMAP3430_L1FLATMEMRETSTATE_MASK
> +#define OMAP_MEM2_RETSTATE_MASK OMAP3430_SHAREDL2CACHEFLATRETSTATE_MASK
> +#define OMAP_MEM3_RETSTATE_MASK OMAP3430_L2FLATMEMRETSTATE_MASK
> +#define OMAP_MEM4_RETSTATE_MASK OMAP4430_OCP_NRET_BANK_RETSTATE_MASK
> +
> +/* OMAP3 and OMAP4 Memory Status bits */
> +#define OMAP_MEM0_STATEST_MASK OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK
> +#define OMAP_MEM1_STATEST_MASK OMAP3430_L1FLATMEMSTATEST_MASK
> +#define OMAP_MEM2_STATEST_MASK OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK
> +#define OMAP_MEM3_STATEST_MASK OMAP3430_L2FLATMEMSTATEST_MASK
> +#define OMAP_MEM4_STATEST_MASK OMAP4430_OCP_NRET_BANK_STATEST_MASK
> +
> +int _get_mem_bank_onstate_mask(u8 bank);
> +int _get_mem_bank_retst_mask(u8 bank);
> +int _get_mem_bank_stst_mask(u8 bank);
> +
> +/* Common Internal functions used across OMAP rev's*/
> +int _get_mem_bank_onstate_mask(u8 bank)
> +{
> +	switch (bank) {
> +	case 0:
> +		return OMAP_MEM0_ONSTATE_MASK;
> +	case 1:
> +		return OMAP_MEM1_ONSTATE_MASK;
> +	case 2:
> +		return OMAP_MEM2_ONSTATE_MASK;
> +	case 3:
> +		return OMAP_MEM3_ONSTATE_MASK;
> +	case 4:
> +		return OMAP_MEM4_ONSTATE_MASK;
> +	default:
> +		WARN_ON(1); /* should never happen */
> +		return -EEXIST;
> +	}
> +	return 0;
> +}
> +
> +int _get_mem_bank_retst_mask(u8 bank)
> +{
> +	switch (bank) {
> +	case 0:
> +		return OMAP_MEM0_RETSTATE_MASK;
> +	case 1:
> +		return OMAP_MEM1_RETSTATE_MASK;
> +	case 2:
> +		return OMAP_MEM2_RETSTATE_MASK;
> +	case 3:
> +		return OMAP_MEM3_RETSTATE_MASK;
> +	case 4:
> +		return OMAP_MEM4_RETSTATE_MASK;
> +	default:
> +		WARN_ON(1); /* should never happen */
> +		return -EEXIST;
> +	}
> +	return 0;
> +}
> +
> +int _get_mem_bank_stst_mask(u8 bank)
> +{
> +	switch (bank) {
> +	case 0:
> +		return OMAP_MEM0_STATEST_MASK;
> +	case 1:
> +		return OMAP_MEM1_STATEST_MASK;
> +	case 2:
> +		return OMAP_MEM2_STATEST_MASK;
> +	case 3:
> +		return OMAP_MEM3_STATEST_MASK;
> +	case 4:
> +		return OMAP_MEM4_STATEST_MASK;
> +	default:
> +		WARN_ON(1); /* should never happen */
> +		return -EEXIST;
> +	}
> +	return 0;
> +}
> +
> diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
> index b25b989..e6d0d5b 100644
> --- a/arch/arm/mach-omap2/powerdomains.h
> +++ b/arch/arm/mach-omap2/powerdomains.h
> @@ -99,6 +99,11 @@ extern struct pwrdm_functions omap4_pwrdm_functions;
>  static struct pwrdm_functions omap4_pwrdm_functions;
>  #endif
>  
> +int _get_mem_bank_onstate_mask(u8 bank);
> +int _get_mem_bank_retst_mask(u8 bank);
> +int _get_mem_bank_stst_mask(u8 bank);
> +int _get_mem_bank_lastmemst_mask(u8 bank);
> +
>  /* As powerdomains are added or removed above, this list must also be changed */
>  static struct powerdomain *powerdomains_omap[] __initdata = {
>  
> diff --git a/arch/arm/mach-omap2/powerdomains2xxx.c b/arch/arm/mach-omap2/powerdomains2xxx.c
> index 779529d..903701f 100644
> --- a/arch/arm/mach-omap2/powerdomains2xxx.c
> +++ b/arch/arm/mach-omap2/powerdomains2xxx.c
> @@ -19,6 +19,24 @@
>  #include <plat/prcm.h>
>  #include "powerdomains.h"
>  
> +static int omap2_get_mem_bank_lastmemst_mask(u8 bank)
> +{
> +	switch (bank) {
> +	case 0:
> +		return OMAP3430_LASTMEM1STATEENTERED_MASK;
> +	case 1:
> +		return OMAP3430_LASTMEM2STATEENTERED_MASK;
> +	case 2:
> +		return OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK;
> +	case 3:
> +		return OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;

Since this file name is marked as being OMAP2xxx only (i.e., 
"powerdomains2xxx.c"), these should all be OMAP2* defines.

> +	default:
> +		WARN_ON(1); /* should never happen */
> +		return -EEXIST;
> +	}
> +	return 0;
> +}
> +
>  static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  {
>  	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> @@ -56,6 +74,32 @@ static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
>  	return 0;
>  }
>  
> +static int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
> +								u8 pwrst)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_onstate_mask(bank);
> +
> +	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
> +				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
> +
> +	return 0;
> +}
> +
> +static int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
> +								u8 pwrst)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_retst_mask(bank);
> +
> +	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
> +					OMAP2_PM_PWSTCTRL);

Minor comment here, it would be good if the style (indentation, line 
breaks, etc) of the prm_rmw_mod_reg_bits() lines here matched the style of 
the  prm_rmw_mod_reg_bits() lines in omap2_pwrdm_set_mem_onst(), since 
they are doing the same thing.

> +
> +	return 0;
> +}
> +
>  static int omap2_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
>  {
>  	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
> @@ -75,13 +119,98 @@ static int omap2_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
>  					OMAP3430_LOGICSTATEST_MASK);
>  }
>  
> +static int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_stst_mask(bank);
> +
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +					OMAP2_PM_PWSTST, m);
> +}
> +
> +static int omap2_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
> +{
> +	u32 m;
> +
> +	m = omap2_get_mem_bank_lastmemst_mask(bank);
> +
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +					OMAP3430_PM_PREPWSTST, m);
> +}

OMAP3 only, so, does not belong here

> +
> +static int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_retst_mask(bank);
> +
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +					OMAP2_PM_PWSTCTRL, m);
> +}
> +
> +static int omap2_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
> +{
> +	prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
> +	return 0;
> +}

OMAP3 only, so, does not belong here

> +
> +static int omap2_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
> +{
> +	return prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
> +					pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
> +}

OMAP3 only, so, does not belong here

> +
> +static int omap2_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
> +{
> +	return prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
> +					pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
> +}

OMAP3 only, so, does not belong here

> +
> +static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
> +{
> +	u32 c = 0;
> +
> +	/*
> +	 * REVISIT: pwrdm_wait_transition() may be better implemented
> +	 * via a callback and a periodic timer check -- how long do we expect
> +	 * powerdomain transitions to take?
> +	 */
> +
> +	/* XXX Is this udelay() value meaningful? */
> +	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
> +		OMAP_INTRANSITION_MASK) &&
> +		(c++ < PWRDM_TRANSITION_BAILOUT))
> +			udelay(1);
> +
> +	if (c > PWRDM_TRANSITION_BAILOUT) {
> +		printk(KERN_ERR "powerdomain: waited too long for "
> +			"powerdomain %s to complete transition\n", pwrdm->name);
> +		return -EAGAIN;
> +	}
> +
> +	pr_debug("powerdomain: completed transition in %d loops\n", c);
> +
> +	return 0;
> +}
> +
> +
>  struct pwrdm_functions omap2_pwrdm_functions = {
>  	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
>  	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
>  	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
>  	.pwrdm_read_prev_pwrst	= omap2_pwrdm_read_prev_pwrst,
>  	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
> +	.pwrdm_set_mem_onst	= omap2_pwrdm_set_mem_onst,
> +	.pwrdm_set_mem_retst	= omap2_pwrdm_set_mem_retst,
>  	.pwrdm_read_logic_pwrst	= omap2_pwrdm_read_logic_pwrst,
>  	.pwrdm_read_prev_logic_pwrst	= omap2_pwrdm_read_prev_logic_pwrst,
>  	.pwrdm_read_logic_retst	= omap2_pwrdm_read_logic_retst,
> +	.pwrdm_read_mem_pwrst	= omap2_pwrdm_read_mem_pwrst,
> +	.pwrdm_read_prev_mem_pwrst	= omap2_pwrdm_read_prev_mem_pwrst,
> +	.pwrdm_read_mem_retst	= omap2_pwrdm_read_mem_retst,
> +	.pwrdm_clear_all_prev_pwrst	= omap2_pwrdm_clear_all_prev_pwrst,
> +	.pwrdm_enable_hdwr_sar	= omap2_pwrdm_enable_hdwr_sar,
> +	.pwrdm_disable_hdwr_sar	= omap2_pwrdm_disable_hdwr_sar,
> +	.pwrdm_wait_transition	= omap2_pwrdm_wait_transition,
>  };
> diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
> index 016a425..79be2cd 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx.c
> @@ -45,6 +45,14 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
>  				OMAP4430_LASTPOWERSTATEENTERED_MASK);
>  }
>  
> +static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
> +{
> +	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
> +				(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
> +				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
> +	return 0;
> +}
> +
>  static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
>  {
>  	u32 v;
> @@ -56,6 +64,32 @@ static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
>  	return 0;
>  }
>  
> +static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
> +								u8 pwrst)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_onstate_mask(bank);
> +
> +	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
> +				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
> +
> +	return 0;
> +}
> +
> +static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
> +								u8 pwrst)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_retst_mask(bank);
> +
> +	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
> +					OMAP4_PM_PWSTCTRL);

As above, it would be good if the style (indentation, line
breaks, etc) of the prm_rmw_mod_reg_bits() lines here matched the style of
the  prm_rmw_mod_reg_bits() lines in omap4_pwrdm_set_mem_onst(), since
they are doing the same thing.

> +
> +	return 0;
> +}
> +
>  static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
>  {
>  	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
> @@ -68,12 +102,65 @@ static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
>  					OMAP4430_LOGICRETSTATE_MASK);
>  }
>  
> +static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_stst_mask(bank);
> +
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +					OMAP4_PM_PWSTST, m);
> +}
> +
> +static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
> +{
> +	u32 m;
> +
> +	m = _get_mem_bank_retst_mask(bank);
> +
> +	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> +					OMAP4_PM_PWSTCTRL, m);
> +}
> +
> +static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
> +{
> +	u32 c = 0;
> +
> +	/*
> +	 * REVISIT: pwrdm_wait_transition() may be better implemented
> +	 * via a callback and a periodic timer check -- how long do we expect
> +	 * powerdomain transitions to take?
> +	 */
> +
> +	/* XXX Is this udelay() value meaningful? */
> +	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP4_PM_PWSTST) &
> +		OMAP_INTRANSITION_MASK) &&
> +		(c++ < PWRDM_TRANSITION_BAILOUT))
> +			udelay(1);
> +
> +	if (c > PWRDM_TRANSITION_BAILOUT) {
> +		printk(KERN_ERR "powerdomain: waited too long for "
> +			"powerdomain %s to complete transition\n", pwrdm->name);
> +		return -EAGAIN;
> +	}
> +
> +	pr_debug("powerdomain: completed transition in %d loops\n", c);
> +
> +	return 0;
> +}
> +
>  struct pwrdm_functions omap4_pwrdm_functions = {
>  	.pwrdm_set_next_pwrst	= omap4_pwrdm_set_next_pwrst,
>  	.pwrdm_read_next_pwrst	= omap4_pwrdm_read_next_pwrst,
>  	.pwrdm_read_pwrst	= omap4_pwrdm_read_pwrst,
>  	.pwrdm_read_prev_pwrst	= omap4_pwrdm_read_prev_pwrst,
> +	.pwrdm_set_lowpwrstchange	= omap4_pwrdm_set_lowpwrstchange,
>  	.pwrdm_set_logic_retst	= omap4_pwrdm_set_logic_retst,
>  	.pwrdm_read_logic_pwrst	= omap4_pwrdm_read_logic_pwrst,
>  	.pwrdm_read_logic_retst	= omap4_pwrdm_read_logic_retst,
> +	.pwrdm_read_mem_pwrst	= omap4_pwrdm_read_mem_pwrst,
> +	.pwrdm_read_mem_retst	= omap4_pwrdm_read_mem_retst,
> +	.pwrdm_set_mem_onst	= omap4_pwrdm_set_mem_onst,
> +	.pwrdm_set_mem_retst	= omap4_pwrdm_set_mem_retst,
> +	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
>  };
> diff --git a/arch/arm/plat-omap/powerdomain.c b/arch/arm/plat-omap/powerdomain.c
> index 9177fbb..d8e29dc 100644
> --- a/arch/arm/plat-omap/powerdomain.c
> +++ b/arch/arm/plat-omap/powerdomain.c
> @@ -17,27 +17,9 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>

BTW, I think you can drop the above #include.

>  #include <linux/types.h>
> -#include <linux/delay.h>
> -#include <linux/spinlock.h>
>  #include <linux/list.h>
> -#include <linux/errno.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -
> -#include <asm/atomic.h>
> -
> -#include "../mach-omap2/cm.h"
> -#include "../mach-omap2/cm-regbits-34xx.h"
> -#include "../mach-omap2/cm-regbits-44xx.h"
> -#include "../mach-omap2/prm.h"
> -#include "../mach-omap2/prm-regbits-34xx.h"
> -#include "../mach-omap2/prm-regbits-44xx.h"
> -
> -#include <plat/cpu.h>
>  #include <plat/powerdomain.h>
>  #include <plat/clockdomain.h>
> -#include <plat/prcm.h>
> -
>  #include "../mach-omap2/pm.h"
>  
>  enum {
> @@ -45,37 +27,6 @@ enum {
>  	PWRDM_STATE_PREV,
>  };
>  
> -/* Variable holding value of the CPU dependent PWRSTCTRL Register Offset */
> -static u16 pwrstctrl_reg_offs;
> -
> -/* Variable holding value of the CPU dependent PWRSTST Register Offset */
> -static u16 pwrstst_reg_offs;
> -
> -/* OMAP3 and OMAP4 specific register bit initialisations
> - * Notice that the names here are not according to each power
> - * domain but the bit mapping used applies to all of them
> - */
> -
> -/* OMAP3 and OMAP4 Memory Onstate Masks (common across all power domains) */
> -#define OMAP_MEM0_ONSTATE_MASK OMAP3430_SHAREDL1CACHEFLATONSTATE_MASK
> -#define OMAP_MEM1_ONSTATE_MASK OMAP3430_L1FLATMEMONSTATE_MASK
> -#define OMAP_MEM2_ONSTATE_MASK OMAP3430_SHAREDL2CACHEFLATONSTATE_MASK
> -#define OMAP_MEM3_ONSTATE_MASK OMAP3430_L2FLATMEMONSTATE_MASK
> -#define OMAP_MEM4_ONSTATE_MASK OMAP4430_OCP_NRET_BANK_ONSTATE_MASK
> -
> -/* OMAP3 and OMAP4 Memory Retstate Masks (common across all power domains) */
> -#define OMAP_MEM0_RETSTATE_MASK OMAP3430_SHAREDL1CACHEFLATRETSTATE_MASK
> -#define OMAP_MEM1_RETSTATE_MASK OMAP3430_L1FLATMEMRETSTATE_MASK
> -#define OMAP_MEM2_RETSTATE_MASK OMAP3430_SHAREDL2CACHEFLATRETSTATE_MASK
> -#define OMAP_MEM3_RETSTATE_MASK OMAP3430_L2FLATMEMRETSTATE_MASK
> -#define OMAP_MEM4_RETSTATE_MASK OMAP4430_OCP_NRET_BANK_RETSTATE_MASK
> -
> -/* OMAP3 and OMAP4 Memory Status bits */
> -#define OMAP_MEM0_STATEST_MASK OMAP3430_SHAREDL1CACHEFLATSTATEST_MASK
> -#define OMAP_MEM1_STATEST_MASK OMAP3430_L1FLATMEMSTATEST_MASK
> -#define OMAP_MEM2_STATEST_MASK OMAP3430_SHAREDL2CACHEFLATSTATEST_MASK
> -#define OMAP_MEM3_STATEST_MASK OMAP3430_L2FLATMEMSTATEST_MASK
> -#define OMAP_MEM4_STATEST_MASK OMAP4430_OCP_NRET_BANK_STATEST_MASK
>  
>  /* pwrdm_list contains all registered struct powerdomains */
>  static LIST_HEAD(pwrdm_list);
> @@ -224,18 +175,6 @@ void pwrdm_init(struct powerdomain **pwrdm_list, struct pwrdm_functions *custom_
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
>  	if (!custom_funcs)
>  		WARN(1, "No custom pwrdm functions registered\n");
>  	else
> @@ -565,7 +504,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
>   */
>  int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>  {
> -	u32 m;
> +	int ret = -EINVAL;
>  
>  	if (!pwrdm)
>  		return -EINVAL;
> @@ -579,37 +518,10 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>  	pr_debug("powerdomain: setting next memory powerstate for domain %s "
>  		 "bank %0x while pwrdm-ON to %0x\n", pwrdm->name, bank, pwrst);
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	switch (bank) {
> -	case 0:
> -		m = OMAP_MEM0_ONSTATE_MASK;
> -		break;
> -	case 1:
> -		m = OMAP_MEM1_ONSTATE_MASK;
> -		break;
> -	case 2:
> -		m = OMAP_MEM2_ONSTATE_MASK;
> -		break;
> -	case 3:
> -		m = OMAP_MEM3_ONSTATE_MASK;
> -		break;
> -	case 4:
> -		m = OMAP_MEM4_ONSTATE_MASK;
> -		break;
> -	default:
> -		WARN_ON(1); /* should never happen */
> -		return -EEXIST;
> -	}
> -
> -	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
> -			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_onst)
> +		ret = arch_pwrdm->pwrdm_set_mem_onst(pwrdm, bank, pwrst);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -630,7 +542,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>   */
>  int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>  {
> -	u32 m;
> +	int ret = -EINVAL;
>  
>  	if (!pwrdm)
>  		return -EINVAL;
> @@ -644,37 +556,10 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
>  	pr_debug("powerdomain: setting next memory powerstate for domain %s "
>  		 "bank %0x while pwrdm-RET to %0x\n", pwrdm->name, bank, pwrst);
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	switch (bank) {
> -	case 0:
> -		m = OMAP_MEM0_RETSTATE_MASK;
> -		break;
> -	case 1:
> -		m = OMAP_MEM1_RETSTATE_MASK;
> -		break;
> -	case 2:
> -		m = OMAP_MEM2_RETSTATE_MASK;
> -		break;
> -	case 3:
> -		m = OMAP_MEM3_RETSTATE_MASK;
> -		break;
> -	case 4:
> -		m = OMAP_MEM4_RETSTATE_MASK;
> -		break;
> -	default:
> -		WARN_ON(1); /* should never happen */
> -		return -EEXIST;
> -	}
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_set_mem_retst)
> +		ret = arch_pwrdm->pwrdm_set_mem_retst(pwrdm, bank, pwrst);
>  
> -	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
> -			     pwrstctrl_reg_offs);
> -
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -753,46 +638,21 @@ int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>  {
> -	u32 m;
> +	int ret = -EINVAL;
>  
>  	if (!pwrdm)
> -		return -EINVAL;
> +		return ret;
>  
>  	if (pwrdm->banks < (bank + 1))
> -		return -EEXIST;
> +		return ret;
>  
>  	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
>  		bank = 1;
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	switch (bank) {
> -	case 0:
> -		m = OMAP_MEM0_STATEST_MASK;
> -		break;
> -	case 1:
> -		m = OMAP_MEM1_STATEST_MASK;
> -		break;
> -	case 2:
> -		m = OMAP_MEM2_STATEST_MASK;
> -		break;
> -	case 3:
> -		m = OMAP_MEM3_STATEST_MASK;
> -		break;
> -	case 4:
> -		m = OMAP_MEM4_STATEST_MASK;
> -		break;
> -	default:
> -		WARN_ON(1); /* should never happen */
> -		return -EEXIST;
> -	}
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_pwrst)
> +		ret = arch_pwrdm->pwrdm_read_mem_pwrst(pwrdm, bank);
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -					 pwrstst_reg_offs, m);
> +	return ret;
>  }
>  
>  /**
> @@ -808,43 +668,21 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>   */
>  int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>  {
> -	u32 m;
> +	int ret = -EINVAL;
>  
>  	if (!pwrdm)
> -		return -EINVAL;
> +		return ret;
>  
>  	if (pwrdm->banks < (bank + 1))
> -		return -EEXIST;
> +		return ret;
>  
>  	if (pwrdm->flags & PWRDM_HAS_MPU_QUIRK)
>  		bank = 1;
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	switch (bank) {
> -	case 0:
> -		m = OMAP3430_LASTMEM1STATEENTERED_MASK;
> -		break;
> -	case 1:
> -		m = OMAP3430_LASTMEM2STATEENTERED_MASK;
> -		break;
> -	case 2:
> -		m = OMAP3430_LASTSHAREDL2CACHEFLATSTATEENTERED_MASK;
> -		break;
> -	case 3:
> -		m = OMAP3430_LASTL2FLATMEMSTATEENTERED_MASK;
> -		break;
> -	default:
> -		WARN_ON(1); /* should never happen */
> -		return -EEXIST;
> -	}
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_mem_pwrst)
> +		ret = arch_pwrdm->pwrdm_read_prev_mem_pwrst(pwrdm, bank);
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -					OMAP3430_PM_PREPWSTST, m);
> +	return ret;
>  }
>  
>  /**
> @@ -859,43 +697,18 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
>   */
>  int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
>  {
> -	u32 m;
> +	int ret = -EINVAL;
>  
>  	if (!pwrdm)
> -		return -EINVAL;
> +		return ret;
>  
>  	if (pwrdm->banks < (bank + 1))
> -		return -EEXIST;
> +		return ret;
>  
> -	/*
> -	 * The register bit names below may not correspond to the
> -	 * actual names of the bits in each powerdomain's register,
> -	 * but the type of value returned is the same for each
> -	 * powerdomain.
> -	 */
> -	switch (bank) {
> -	case 0:
> -		m = OMAP_MEM0_RETSTATE_MASK;
> -		break;
> -	case 1:
> -		m = OMAP_MEM1_RETSTATE_MASK;
> -		break;
> -	case 2:
> -		m = OMAP_MEM2_RETSTATE_MASK;
> -		break;
> -	case 3:
> -		m = OMAP_MEM3_RETSTATE_MASK;
> -		break;
> -	case 4:
> -		m = OMAP_MEM4_RETSTATE_MASK;
> -		break;
> -	default:
> -		WARN_ON(1); /* should never happen */
> -		return -EEXIST;
> -	}
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_read_mem_retst)
> +		ret = arch_pwrdm->pwrdm_read_mem_retst(pwrdm, bank);
>  
> -	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
> -					pwrstctrl_reg_offs, m);
> +	return ret;
>  }
>  
>  /**
> @@ -909,8 +722,10 @@ int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
>   */
>  int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
> -		return -EINVAL;
> +		return ret;
>  
>  	/*
>  	 * XXX should get the powerdomain's current state here;
> @@ -920,9 +735,10 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
>  	pr_debug("powerdomain: clearing previous power state reg for %s\n",
>  		 pwrdm->name);
>  
> -	prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_clear_all_prev_pwrst)
> +		ret = arch_pwrdm->pwrdm_clear_all_prev_pwrst(pwrdm);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -938,19 +754,21 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
>   */
>  int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
> -		return -EINVAL;
> +		return ret;
>  
>  	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
> -		return -EINVAL;
> +		return ret;
>  
>  	pr_debug("powerdomain: %s: setting SAVEANDRESTORE bit\n",
>  		 pwrdm->name);
>  
> -	prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
> -			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_enable_hdwr_sar)
> +		ret = arch_pwrdm->pwrdm_enable_hdwr_sar(pwrdm);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -966,19 +784,21 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
>   */
>  int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
> -		return -EINVAL;
> +		return ret;
>  
>  	if (!(pwrdm->flags & PWRDM_HAS_HDWR_SAR))
> -		return -EINVAL;
> +		return ret;
>  
>  	pr_debug("powerdomain: %s: clearing SAVEANDRESTORE bit\n",
>  		 pwrdm->name);
>  
> -	prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
> -			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_disable_hdwr_sar)
> +		ret = arch_pwrdm->pwrdm_disable_hdwr_sar(pwrdm);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -1005,6 +825,8 @@ bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm)
>   */
>  int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
>  {
> +	int ret = -EINVAL;
> +
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> @@ -1014,11 +836,10 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
>  	pr_debug("powerdomain: %s: setting LOWPOWERSTATECHANGE bit\n",
>  		 pwrdm->name);
>  
> -	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
> -			     (1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
> -			     pwrdm->prcm_offs, pwrstctrl_reg_offs);
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_set_lowpwrstchange)
> +		ret = arch_pwrdm->pwrdm_set_lowpwrstchange(pwrdm);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  /**
> @@ -1033,32 +854,15 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
>   */
>  int pwrdm_wait_transition(struct powerdomain *pwrdm)
>  {
> -	u32 c = 0;
> +	int ret = -EINVAL;
>  
>  	if (!pwrdm)
>  		return -EINVAL;
>  
> -	/*
> -	 * REVISIT: pwrdm_wait_transition() may be better implemented
> -	 * via a callback and a periodic timer check -- how long do we expect
> -	 * powerdomain transitions to take?
> -	 */
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_wait_transition)
> +		ret = arch_pwrdm->pwrdm_wait_transition(pwrdm);
>  
> -	/* XXX Is this udelay() value meaningful? */
> -	while ((prm_read_mod_reg(pwrdm->prcm_offs, pwrstst_reg_offs) &
> -		OMAP_INTRANSITION_MASK) &&
> -	       (c++ < PWRDM_TRANSITION_BAILOUT))
> -			udelay(1);
> -
> -	if (c > PWRDM_TRANSITION_BAILOUT) {
> -		printk(KERN_ERR "powerdomain: waited too long for "
> -		       "powerdomain %s to complete transition\n", pwrdm->name);
> -		return -EAGAIN;
> -	}
> -
> -	pr_debug("powerdomain: completed transition in %d loops\n", c);
> -
> -	return 0;
> +	return ret;
>  }
>  
>  int pwrdm_state_switch(struct powerdomain *pwrdm)
> -- 
> 1.7.0.4
> 


- Paul
