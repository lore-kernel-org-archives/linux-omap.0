From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH 05/13] ARM: OMAP2+: PRCM: create SoC-specific chip restart
 functions
Date: Wed, 31 Oct 2012 12:05:33 +0530
Message-ID: <5090C6B5.3080407@ti.com>
References: <20121025231818.17558.57884.stgit@dusk.lan> <20121025232116.17558.47458.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40322 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab2JaGfn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Oct 2012 02:35:43 -0400
In-Reply-To: <20121025232116.17558.47458.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org



On 10/26/2012 4:51 AM, Paul Walmsley wrote:
> Split omap_prcm_restart() from mach-omap2/prcm.c into SoC-specific
> variants.  These functions need to be able to save the reboot reason
> into the scratchpad RAM.  This implies a dependency on both the PRM
> and SCM IP blocks, so they've been moved into their own file.  This
> will eventually call functions in the PRM and SCM drivers, once those
> are created.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap2/Makefile        |    5 +++
>  arch/arm/mach-omap2/common.h        |    4 ++
>  arch/arm/mach-omap2/omap2-restart.c |   65 +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap3-restart.c |   36 +++++++++++++++++++
>  arch/arm/mach-omap2/omap4-common.c  |   16 +++++++++
>  5 files changed, 126 insertions(+)
>  create mode 100644 arch/arm/mach-omap2/omap2-restart.c
>  create mode 100644 arch/arm/mach-omap2/omap3-restart.c
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 7a628e7..aa0f59c 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -49,6 +49,11 @@ AFLAGS_sram242x.o			:=-Wa,-march=armv6
>  AFLAGS_sram243x.o			:=-Wa,-march=armv6
>  AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
>  
> +# Restart code (OMAP4/5 currently in omap4-common.c)
> +obj-$(CONFIG_SOC_OMAP2420)		+= omap2-restart.o
> +obj-$(CONFIG_SOC_OMAP2430)		+= omap2-restart.o
> +obj-$(CONFIG_ARCH_OMAP3)		+= omap3-restart.o
> +
>  # Pin multiplexing
>  obj-$(CONFIG_SOC_OMAP2420)		+= mux2420.o
>  obj-$(CONFIG_SOC_OMAP2430)		+= mux2430.o
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 320f0d7..06dff1a 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -115,6 +115,10 @@ void ti81xx_init_late(void);
>  void omap4430_init_late(void);
>  int omap2_common_pm_late_init(void);
>  void omap_prcm_restart(char, const char *);
> +void omap2xxx_restart(char, const char *);
> +void omap3xxx_restart(char, const char *);
> +void omap44xx_restart(char, const char *);
> +void omap5xxx_restart(char, const char *);
>  

Paul,

omap5xxx_restart declaration needs to be removed from here.
There is no such function implemented in code.

Thanks,
Vaibhav
>  /* This gets called from mach-omap2/io.c, do not call this */
>  void __init omap2_set_globals_tap(u32 class, void __iomem *tap);
> diff --git a/arch/arm/mach-omap2/omap2-restart.c b/arch/arm/mach-omap2/omap2-restart.c
> new file mode 100644
> index 0000000..be6bc89
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap2-restart.c
> @@ -0,0 +1,65 @@
> +/*
> + * omap2-restart.c - code common to all OMAP2xxx machines.
> + *
> + * Copyright (C) 2012 Texas Instruments
> + * Paul Walmsley
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +
> +#include "common.h"
> +#include "prm2xxx.h"
> +
> +/*
> + * reset_virt_prcm_set_ck, reset_sys_ck: pointers to the virt_prcm_set
> + * clock and the sys_ck.  Used during the reset process
> + */
> +static struct clk *reset_virt_prcm_set_ck, *reset_sys_ck;
> +
> +/* Reboot handling */
> +
> +/**
> + * omap2xxx_restart - Set DPLL to bypass mode for reboot to work
> + *
> + * Set the DPLL to bypass so that reboot completes successfully.  No
> + * return value.
> + */
> +void omap2xxx_restart(char mode, const char *cmd)
> +{
> +	u32 rate;
> +
> +	rate = clk_get_rate(reset_sys_ck);
> +	clk_set_rate(reset_virt_prcm_set_ck, rate);
> +
> +	/* XXX Should save the cmd argument for use after the reboot */
> +
> +	omap2xxx_prm_dpll_reset(); /* never returns */
> +	while (1);
> +}
> +
> +/**
> + * omap2xxx_common_look_up_clks_for_reset - look up clocks needed for restart
> + *
> + * Some clocks need to be looked up in advance for the SoC restart
> + * operation to work - see omap2xxx_restart().  Returns -EINVAL upon
> + * error or 0 upon success.
> + */
> +static int __init omap2xxx_common_look_up_clks_for_reset(void)
> +{
> +	reset_virt_prcm_set_ck = clk_get(NULL, "virt_prcm_set");
> +	if (IS_ERR(reset_virt_prcm_set_ck))
> +		return -EINVAL;
> +
> +	reset_sys_ck = clk_get(NULL, "sys_ck");
> +	if (IS_ERR(reset_sys_ck))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +core_initcall(omap2xxx_common_look_up_clks_for_reset);
> diff --git a/arch/arm/mach-omap2/omap3-restart.c b/arch/arm/mach-omap2/omap3-restart.c
> new file mode 100644
> index 0000000..923c582
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap3-restart.c
> @@ -0,0 +1,36 @@
> +/*
> + * omap3-restart.c - Code common to all OMAP3xxx machines.
> + *
> + * Copyright (C) 2009, 2012 Texas Instruments
> + * Copyright (C) 2010 Nokia Corporation
> + * Tony Lindgren <tony@atomide.com>
> + * Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +
> +#include "iomap.h"
> +#include "common.h"
> +#include "control.h"
> +#include "prm3xxx.h"
> +
> +/* Global address base setup code */
> +
> +/**
> + * omap3xxx_restart - trigger a software restart of the SoC
> + * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
> + * @cmd: passed from the userspace program rebooting the system (if provided)
> + *
> + * Resets the SoC.  For @cmd, see the 'reboot' syscall in
> + * kernel/sys.c.  No return value.
> + */
> +void omap3xxx_restart(char mode, const char *cmd)
> +{
> +	omap3_ctrl_write_boot_mode((cmd ? (u8)*cmd : 0));
> +	omap3xxx_prm_dpll3_reset(); /* never returns */
> +	while (1);
> +}
> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
> index 6560e99..5348788 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -35,6 +35,7 @@
>  #include "iomap.h"
>  #include "common.h"
>  #include "hsmmc.h"
> +#include "prminst44xx.h"
>  #include "omap4-sar-layout.h"
>  
>  #ifdef CONFIG_CACHE_L2X0
> @@ -249,6 +250,21 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
>  	return 0;
>  }
>  
> +/**
> + * omap44xx_restart - trigger a software restart of the SoC
> + * @mode: the "reboot mode", see arch/arm/kernel/{setup,process}.c
> + * @cmd: passed from the userspace program rebooting the system (if provided)
> + *
> + * Resets the SoC.  For @cmd, see the 'reboot' syscall in
> + * kernel/sys.c.  No return value.
> + */
> +void omap44xx_restart(char mode, const char *cmd)
> +{
> +	/* XXX Should save 'cmd' into scratchpad for use after reboot */
> +	omap4_prminst_global_warm_sw_reset(); /* never returns */
> +	while (1);
> +}
> +
>  static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
>  {
>  	struct omap_mmc_platform_data *pdata;
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
