From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 04/17] omap4: pm: Add CPUx OFF mode support
Date: Wed, 02 Mar 2011 14:12:47 -0800
Message-ID: <87wrkh5fz4.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-5-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:42301 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755863Ab1CBWMw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 17:12:52 -0500
Received: by yxh35 with SMTP id 35so181422yxh.2
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 14:12:50 -0800 (PST)
In-Reply-To: <1298112158-28469-5-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sat, 19 Feb 2011 16:12:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> This patch adds the CPU0 and CPU1 off mode support. CPUX close switch

s/CPUX/CPUx/

> retention (CSWR) is not supported by hardware design.
>
> The CPUx OFF mode isn't supported on OMAP4430 ES1.0
>
> CPUx sleep code is common for hotplug, suspend and cpuilde.

s/cpuilde/CPUidle/

> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>

> ---
>  arch/arm/mach-omap2/Makefile                    |    4 +-
>  arch/arm/mach-omap2/include/mach/omap4-common.h |   46 +++
>  arch/arm/mach-omap2/omap4-mpuss-lowpower.c      |  241 ++++++++++++++++
>  arch/arm/mach-omap2/omap4-sar-layout.h          |   14 +
>  arch/arm/mach-omap2/pm44xx.c                    |    6 +
>  arch/arm/mach-omap2/sleep44xx.S                 |  334 +++++++++++++++++++++++
>  6 files changed, 644 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/omap4-mpuss-lowpower.c
>  create mode 100644 arch/arm/mach-omap2/sleep44xx.S
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 54ff219..5d94f7e 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -63,13 +63,15 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
>  obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o voltage.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o voltage.o \
>  					   cpuidle34xx.o pm_bus.o
> -obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o
> +obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o voltage.o pm_bus.o \
> +					   omap4-mpuss-lowpower.o sleep44xx.o
>  obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
>  obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
>  
>  AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>  AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
> +AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a
>  
>  ifeq ($(CONFIG_PM_VERBOSE),y)
>  CFLAGS_pm_bus.o				+= -DDEBUG
> diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
> index 0e5edd8..74c9aa7 100644
> --- a/arch/arm/mach-omap2/include/mach/omap4-common.h
> +++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
> @@ -13,6 +13,9 @@
>  #ifndef OMAP_ARCH_OMAP4_COMMON_H
>  #define OMAP_ARCH_OMAP4_COMMON_H
>  
> +#include <asm/proc-fns.h>
> +
> +#ifndef __ASSEMBLER__
>  /*
>   * wfi used in low power code. Directly opcode is used instead
>   * of instruction to avoid mulit-omap build break
> @@ -33,4 +36,47 @@ extern void __iomem *scu_base;
>  extern void __init gic_init_irq(void);
>  extern void omap_smc1(u32 fn, u32 arg);
>  
> +/*
> + * Read MPIDR: Multiprocessor affinity register
> + */
> +static inline unsigned int hard_smp_processor_id(void)
> +{
> +	unsigned int cpunum;
> +
> +	asm volatile (
> +	"mrc	 p15, 0, %0, c0, c0, 5\n"
> +		: "=r" (cpunum));
> +	return cpunum &= 0x0F;

minor: lower-case hex numbers are preferred

> +}
> +
> +#if defined(CONFIG_SMP)	&& defined(CONFIG_PM)

s/CONFIG_PM/CONFIG_SUSPEND/

> +extern int omap4_mpuss_init(void);
> +extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
> +extern void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state);
> +extern void omap4_cpu_resume(void);
> +
> +#else
> +
> +static inline int omap4_enter_lowpower(unsigned int cpu,
> +					unsigned int power_state)
> +{
> +	cpu_do_idle();
> +	return 0;
> +}
> +
> +static inline int omap4_mpuss_init(void)
> +{
> +	return 0;
> +}
> +
> +static inline void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state)
> +{
> +}
> +
> +static inline void omap4_cpu_resume(void)
> +{
> +}
> +
>  #endif
> +#endif /* __ASSEMBLER__ */
> +#endif /* OMAP_ARCH_OMAP4_COMMON_H */
> diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> new file mode 100644
> index 0000000..c0f358d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> @@ -0,0 +1,241 @@
> +/*
> + * OMAP4 MPUSS low power code
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * OMAP4430 MPUSS mainly consists of dual Cortex-A9 with per-CPU
> + * Local timer and Watchdog, GIC, SCU, PL310 L2 cache controller,
> + * CPU0 and CPU1 LPRM modules.
> + * CPU0, CPU1 and MPUSS each have there own power domain and
> + * hence multiple low power combinations of MPUSS are possible.
> + *
> + * The CPU0 and CPU1 can't support Closed switch Retention (CSWR)
> + * because the mode is not supported by hw constraints of dormant
> + * mode. While waking up from the dormant mode, a reset  signal
> + * to the Cortex-A9 processor must be asserted by the external
> + * power controller.
> + *
> + * With architectural inputs and hardware recommendations, only
> + * below modes are supported from power gain vs latency point of view.
> + *
> + *	CPU0		CPU1		MPUSS
> + *	----------------------------------------------
> + *	ON		ON		ON
> + *	ON(Inactive)	OFF		ON(Inactive)
> + *	OFF		OFF		CSWR
> + *	OFF		OFF		OSWR (*TBD)
> + *	OFF		OFF		OFF* (*TBD)
> + *	----------------------------------------------
> + *
> + * Note: CPU0 is the master core and it is the last CPU to go down
> + * and first to wake-up when MPUSS low power states are excercised
> + *
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/errno.h>
> +#include <linux/linkage.h>
> +#include <linux/smp.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/tlbflush.h>
> +#include <asm/smp_scu.h>
> +#include <asm/system.h>
> +
> +#include <plat/omap44xx.h>
> +#include <mach/omap4-common.h>
> +
> +#include "omap4-sar-layout.h"
> +#include "pm.h"
> +#include "powerdomain.h"
> +
> +#ifdef CONFIG_SMP
> +
> +#define CPU0_ID				0x0
> +#define CPU1_ID				0x1

These are also defined in the wakeupgen module, and are not really
needed.  As these are only ever used in per_cpu() context, just using
the number directly is fine with me.

> +struct omap4_cpu_pm_info {
> +	struct powerdomain *pwrdm;
> +	void __iomem *scu_sar_addr;
> +};
> +
> +static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
> +
> +/*
> + * Set the CPUx powerdomain's previous power state
> + */
> +static inline void set_cpu_next_pwrst(unsigned int cpu_id,
> +				unsigned int power_state)
> +{
> +	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
> +
> +	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
> +}
> +
> +/*
> + * Read CPU's previous power state
> + */
> +static inline unsigned int read_cpu_prev_pwrst(unsigned int cpu_id)
> +{
> +	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
> +
> +	return pwrdm_read_prev_pwrst(pm_info->pwrdm);
> +}
> +
> +/*
> + * Clear the CPUx powerdomain's previous power state
> + */
> +static inline void clear_cpu_prev_pwrst(unsigned int cpu_id)
> +{
> +	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
> +
> +	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
> +}
> +
> +/*
> + * Store the SCU power status value to scratchpad memory
> + */
> +static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
> +{
> +	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
> +	u32 scu_pwr_st;
> +
> +	switch (cpu_state) {
> +	case PWRDM_POWER_RET:
> +		scu_pwr_st = SCU_PM_DORMANT;
> +		break;
> +	case PWRDM_POWER_OFF:
> +		scu_pwr_st = SCU_PM_POWEROFF;
> +		break;
> +	case PWRDM_POWER_ON:
> +	case PWRDM_POWER_INACTIVE:
> +	default:
> +		scu_pwr_st = SCU_PM_NORMAL;
> +		break;
> +	}
> +
> +	__raw_writel(scu_pwr_st, pm_info->scu_sar_addr);
> +}
> +
> +/*
> + * OMAP4 MPUSS Low Power Entry Function
> + *
> + * The purpose of this function is to manage low power programming
> + * of OMAP4 MPUSS subsystem
> + * Paramenters:
> + *	cpu : CPU ID
> + *	power_state: Targetted Low power state.
> + */
> +int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
> +{
> +	unsigned int save_state = 0;
> +	unsigned int wakeup_cpu = hard_smp_processor_id();
> +
> +	if ((cpu > NR_CPUS) || (omap_rev() == OMAP4430_REV_ES1_0))
> +		goto ret;
> +
> +	switch (power_state) {
> +	case PWRDM_POWER_ON:
> +	case PWRDM_POWER_INACTIVE:
> +		save_state = 0;
> +		break;
> +	case PWRDM_POWER_OFF:
> +		save_state = 1;
> +		break;
> +	case PWRDM_POWER_RET:
> +	default:
> +		/*
> +		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
> +		 * doesn't make much scense, since logic is lost and $L1
> +		 * needs to be cleaned because of coherency. This makes
> +		 * CPUx OSWR equivalent to CPUX OFF and hence not supported
> +		 */

a WARN() of some sort here would probably be useful to detect incorrect
programming of power state.

> +		goto ret;
> +	}
> +
> +	clear_cpu_prev_pwrst(cpu);
> +	set_cpu_next_pwrst(cpu, power_state);
> +	scu_pwrst_prepare(cpu, power_state);
> +
> +	/*
> +	 * Call low level function  with targeted CPU id
> +	 * and its low power state.
> +	 */
> +	omap4_cpu_suspend(cpu, save_state);
> +
> +	/*
> +	 * Restore the CPUx power state to ON otherwise CPUx
> +	 * power domain can transitions to programmed low power
> +	 * state while doing WFI outside the low powe code. On
> +	 * secure devices, CPUx does WFI which can result in
> +	 * domain transition
> +	 */
> +	wakeup_cpu = hard_smp_processor_id();
> +	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
> +
> +ret:
> +	return 0;
> +}
> +
> +/*
> + * Initialise OMAP4 MPUSS
> + */
> +int __init omap4_mpuss_init(void)
> +{
> +	struct omap4_cpu_pm_info *pm_info;
> +
> +	if (omap_rev() == OMAP4430_REV_ES1_0) {
> +		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
> +		return -EPERM;

-ENODEV is probably more appropriate here

> +	}
> +
> +	/* Initilaise per CPU PM information */
> +	pm_info = &per_cpu(omap4_pm_info, CPU0_ID);
> +	pm_info->scu_sar_addr = sar_ram_base + SCU_OFFSET0;
> +	pm_info->pwrdm = pwrdm_lookup("cpu0_pwrdm");
> +	if (!pm_info->pwrdm) {
> +		pr_err("Lookup failed for CPU0 pwrdm\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Clear CPU previous power domain state */
> +	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
> +
> +	/* Initialise CPU0 power domain state to ON */
> +	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
> +
> +	pm_info = &per_cpu(omap4_pm_info, CPU1_ID);
> +	pm_info->scu_sar_addr = sar_ram_base + SCU_OFFSET1;
> +	pm_info->pwrdm = pwrdm_lookup("cpu1_pwrdm");
> +	if (!pm_info->pwrdm) {
> +		pr_err("Lookup failed for CPU1 pwrdm\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Clear CPU previous power domain state */
> +	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
> +
> +	/* Initialise CPU1 power domain state to ON */
> +	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
> +
> +	/*
> +	 * Program the wakeup routine address for the CPU0 and CPU1
> +	 * used for OFF or DORMANT wakeup. Wakeup routine address
> +	 * is fixed so programit in init itself.
> +	 */
> +	__raw_writel(virt_to_phys(omap4_cpu_resume),
> +			sar_ram_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
> +	__raw_writel(virt_to_phys(omap4_cpu_resume),
> +			sar_ram_base + CPU0_WAKEUP_NS_PA_ADDR_OFFSET);
> +
> +	return 0;
> +}
> +
> +#endif
> +
> diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
> index bb66816..c4251db 100644
> --- a/arch/arm/mach-omap2/omap4-sar-layout.h
> +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> @@ -19,6 +19,20 @@
>  #define SAR_BANK3_OFFSET		0x2000
>  #define SAR_BANK4_OFFSET		0x3000
>  
> +/* Scratch pad memory offsets from SAR_BANK1 */
> +#define CPU0_SAVE_OFFSET			0xb00
> +#define CPU1_SAVE_OFFSET			0xc00
> +#define MMU_OFFSET				0xd00
> +#define SCU_OFFSET0				0xd20
> +#define SCU_OFFSET1				0xd24
> +
> +/* CPUx Wakeup Non-Secure Physical Address offsets in SAR_BANK3 */
> +#define CPU0_WAKEUP_NS_PA_ADDR_OFFSET		0xa04
> +#define CPU1_WAKEUP_NS_PA_ADDR_OFFSET		0xa08
> +
> +#ifndef __ASSEMBLER__
> +
>  extern void __iomem *sar_ram_base;
>  
>  #endif
> +#endif
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 8431d41..b142673 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -115,6 +115,12 @@ static int __init omap4_pm_init(void)
>  
>  	/* Enable autoidle for all clks which support it*/
>  	omap_clk_enable_autoidle();
> +
> +	ret = omap4_mpuss_init();
> +	if (ret) {
> +		pr_err("Failed to initialise OMAP4 MPUSS\n");
> +		goto err2;
> +	}
>  #endif
>  
>  #ifdef CONFIG_SUSPEND
> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
> new file mode 100644
> index 0000000..bb42a7a
> --- /dev/null
> +++ b/arch/arm/mach-omap2/sleep44xx.S
> @@ -0,0 +1,334 @@
> +/*
> + * OMAP44xx CPU low power powerdown and powerup code.
> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + * Written by Santosh Shilimkar <santosh.shilimkar@ti.com>
> + *
> + * This program is free software,you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/system.h>
> +#include <asm/smp_scu.h>
> +#include <asm/memory.h>
> +
> +#include <plat/omap44xx.h>
> +#include <mach/omap4-common.h>
> +#include <asm/hardware/cache-l2x0.h>
> +
> +#include "omap4-sar-layout.h"
> +
> +#ifdef CONFIG_SMP
> +
> +/* Masks used for MMU manipulation */
> +#define TTRBIT_MASK				0xffffc000
> +#define TABLE_INDEX_MASK			0xfff00000
> +#define TABLE_ENTRY				0x00000c02
> +#define CACHE_DISABLE_MASK			0xffffe7fb
> +
> +/*
> + * =============================
> + * == CPU suspend entry point ==
> + * =============================
> + *
> + * void omap4_cpu_suspend(unsigned int cpu, unsigned int save_state)
> + *
> + * This function code saves the CPU context and performs the CPU
> + * power down sequence. Calling WFI effectively changes the CPU
> + * power domains states to the desired target power state.
> + *
> + * @cpu : contains cpu id (r0)
> + * @save_state : contains context save state (r1)
> + *	0 - No context lost
> + * 	1 - CPUx L1 and logic lost: MPUSS CSWR
> + * 	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
> + *	3 - CPUx L1 and logic lost + GIC + L2 lost: MPUSS OFF
> + * @return: This function never returns for CPU OFF and DORMANT power states.
> + * It retunrs to the caller for CPU INACTIVE and ON power states or in case

typo: returns

> + * CPU failed to transition to targeted OFF/DORMANT state.

to avoid confusion, what happens for OFF/dormant should probably be
summarized too.

I didn't do a detailed review of the below assembly since you're much
more knowlegable there than me.  

However, will the assembly code here work in Thumb-2 mode?  Dave Martin
has been working on that for OMAP3, but we should make sure the OMAP4
stuff is Thumb-2 ready out of the box.

[...]

Kevin
