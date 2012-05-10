From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 08/13] ARM: OMAP5: Add the WakeupGen IP updates.
Date: Thu, 10 May 2012 14:36:42 +0300
Message-ID: <4FABA84A.9000507@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com> <1336029982-31898-9-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40368 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759211Ab2EJLg5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 May 2012 07:36:57 -0400
In-Reply-To: <1336029982-31898-9-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: R Sricharan <r.sricharan@ti.com>, santosh.shilimkar@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, b-cousson@ti.com

Hi,

On 05/03/2012 10:26 AM, R Sricharan wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> OMAP4 and OMAP5 share same WakeupGen IP with below few udpates on OMAP5.
> - Additional 32 interrupt support is added w.r.t OMAP4 design.
> - The AUX CORE boot registers are now made accessible from non-secure SW.
> - SAR offset are changed and PTMSYNC* registers are removed from SAR.
> 
> Patch updates the WakeupGen code accordingly.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: R Sricharan <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    6 +
>  arch/arm/mach-omap2/omap-hotplug.c                |   24 ++++-
>  arch/arm/mach-omap2/omap-smp.c                    |   19 +++-
>  arch/arm/mach-omap2/omap-wakeupgen.c              |  110 +++++++++++++++-----
>  arch/arm/mach-omap2/omap4-sar-layout.h            |   12 ++-
>  5 files changed, 135 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> index 548de90..4d700bc 100644
> --- a/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> +++ b/arch/arm/mach-omap2/include/mach/omap-wakeupgen.h
> @@ -11,15 +11,20 @@
>  #ifndef OMAP_ARCH_WAKEUPGEN_H
>  #define OMAP_ARCH_WAKEUPGEN_H
>  
> +/* OMAP4 and OMAP5 has same base address */
> +#define OMAP_WKUPGEN_BASE			0x48281000

unnecessary change, why don't you just use OMAP44XX_WKUPGEN_BASE or
define this in the same header as OMAP44XX_WKUPGEN_BASE?

> +
>  #define OMAP_WKG_CONTROL_0			0x00
>  #define OMAP_WKG_ENB_A_0			0x10
>  #define OMAP_WKG_ENB_B_0			0x14
>  #define OMAP_WKG_ENB_C_0			0x18
>  #define OMAP_WKG_ENB_D_0			0x1c
> +#define OMAP_WKG_ENB_E_0			0x20
>  #define OMAP_WKG_ENB_A_1			0x410
>  #define OMAP_WKG_ENB_B_1			0x414
>  #define OMAP_WKG_ENB_C_1			0x418
>  #define OMAP_WKG_ENB_D_1			0x41c
> +#define OMAP_WKG_ENB_E_1			0x420
>  #define OMAP_AUX_CORE_BOOT_0			0x800
>  #define OMAP_AUX_CORE_BOOT_1			0x804
>  #define OMAP_PTMSYNCREQ_MASK			0xc00
> @@ -28,4 +33,5 @@
>  #define OMAP_TIMESTAMPCYCLEHI			0xc0c
>  
>  extern int __init omap_wakeupgen_init(void);
> +extern void __iomem *omap_get_wakeupgen_base(void);
>  #endif
> diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
> index 56c345b..052303c 100644
> --- a/arch/arm/mach-omap2/omap-hotplug.c
> +++ b/arch/arm/mach-omap2/omap-hotplug.c
> @@ -17,8 +17,10 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/smp.h>
> +#include <linux/io.h>
>  
>  #include <asm/cacheflush.h>
> +#include <mach/omap-wakeupgen.h>
>  
>  #include "common.h"
>  
> @@ -35,7 +37,8 @@ int platform_cpu_kill(unsigned int cpu)
>   */
>  void __ref platform_cpu_die(unsigned int cpu)
>  {
> -	unsigned int this_cpu;
> +	unsigned int boot_cpu = 0;
> +	void __iomem *base = omap_get_wakeupgen_base();

this is unnecessary copy for omap4, move it to the place where you want
it below.

+	void __iomem *base;

>  
>  	flush_cache_all();
>  	dsb();
> @@ -43,16 +46,27 @@ void __ref platform_cpu_die(unsigned int cpu)
>  	/*
>  	 * we're ready for shutdown now, so do it
>  	 */
> -	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
> -		pr_err("Secure clear status failed\n");
> +	if (cpu_is_omap44xx()) {
> +		if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
> +			pr_err("Secure clear status failed\n");
> +	} else {

i.e. here
+		*base = omap_get_wakeupgen_base();

> +		__raw_writel(0, base + OMAP_AUX_CORE_BOOT_0);
> +	}
> +
>  
>  	for (;;) {
>  		/*
>  		 * Enter into low power state
>  		 */
>  		omap4_hotplug_cpu(cpu, PWRDM_POWER_OFF);
> -		this_cpu = smp_processor_id();
> -		if (omap_read_auxcoreboot0() == this_cpu) {
> +
> +		if (cpu_is_omap44xx())
> +			boot_cpu = omap_read_auxcoreboot0();
> +		else
> +			boot_cpu =
> +				__raw_readl(base + OMAP_AUX_CORE_BOOT_0) >> 5;
> +
> +		if (boot_cpu == smp_processor_id()) {
>  			/*
>  			 * OK, proper wakeup, we're done
>  			 */
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index deffbf1..151fd5b 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -26,6 +26,8 @@
>  
>  #include <mach/hardware.h>
>  #include <mach/omap-secure.h>
> +#include <mach/omap-wakeupgen.h>
> +#include <asm/cputype.h>
>  
>  #include "iomap.h"
>  #include "common.h"
> @@ -73,6 +75,8 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  {
>  	static struct clockdomain *cpu1_clkdm;
>  	static bool booted;
> +	void __iomem *base = omap_get_wakeupgen_base();

ditto.

> +
>  	/*
>  	 * Set synchronisation state between this boot processor
>  	 * and the secondary one
> @@ -85,7 +89,11 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	 * the AuxCoreBoot1 register is updated with cpu state
>  	 * A barrier is added to ensure that write buffer is drained
>  	 */
> -	omap_modify_auxcoreboot0(0x200, 0xfffffdff);
> +	if (cpu_is_omap44xx())
> +		omap_modify_auxcoreboot0(0x200, 0xfffffdff);
> +	else

put it here instead

+{
+		 void __iomem *base = omap_get_wakeup_base();
> +		__raw_writel(0x20, base + OMAP_AUX_CORE_BOOT_0);
+}

> +
>  	flush_cache_all();
>  	smp_wmb();
>  
> @@ -124,13 +132,20 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  
>  static void __init wakeup_secondary(void)
>  {
> +	void __iomem *base = omap_get_wakeupgen_base();
> +

ditto

>  	/*
>  	 * Write the address of secondary startup routine into the
>  	 * AuxCoreBoot1 where ROM code will jump and start executing
>  	 * on secondary core once out of WFE
>  	 * A barrier is added to ensure that write buffer is drained
>  	 */
> -	omap_auxcoreboot_addr(virt_to_phys(omap_secondary_startup));
> +	if (cpu_is_omap44xx())
> +		omap_auxcoreboot_addr(virt_to_phys(omap_secondary_startup));
> +	else
> +		__raw_writel(virt_to_phys(omap5_secondary_startup),
> +						base + OMAP_AUX_CORE_BOOT_1);
> +
>  	smp_wmb();
>  
>  	/*
> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
> index 42cd7fb..444cf12 100644
> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
> @@ -33,18 +33,22 @@
>  #include "omap4-sar-layout.h"
>  #include "common.h"
>  
> -#define NR_REG_BANKS		4
> -#define MAX_IRQS		128
> +#define MAX_NR_REG_BANKS	5
> +#define MAX_IRQS		160
>  #define WKG_MASK_ALL		0x00000000
>  #define WKG_UNMASK_ALL		0xffffffff
>  #define CPU_ENA_OFFSET		0x400
>  #define CPU0_ID			0x0
>  #define CPU1_ID			0x1
> +#define OMAP4_NR_BANKS		4
> +#define OMAP4_NR_IRQS		128
>  
>  static void __iomem *wakeupgen_base;
>  static void __iomem *sar_base;
>  static DEFINE_SPINLOCK(wakeupgen_lock);
>  static unsigned int irq_target_cpu[NR_IRQS];
> +static unsigned int irq_banks = MAX_NR_REG_BANKS;
> +static unsigned int max_irqs = MAX_IRQS;
>  
>  /*
>   * Static helper functions.
> @@ -146,13 +150,13 @@ static void wakeupgen_unmask(struct irq_data *d)
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -static DEFINE_PER_CPU(u32 [NR_REG_BANKS], irqmasks);
> +static DEFINE_PER_CPU(u32 [MAX_NR_REG_BANKS], irqmasks);
>  
>  static void _wakeupgen_save_masks(unsigned int cpu)
>  {
>  	u8 i;
>  
> -	for (i = 0; i < NR_REG_BANKS; i++)
> +	for (i = 0; i < irq_banks; i++)
>  		per_cpu(irqmasks, cpu)[i] = wakeupgen_readl(i, cpu);
>  }
>  
> @@ -160,7 +164,7 @@ static void _wakeupgen_restore_masks(unsigned int cpu)
>  {
>  	u8 i;
>  
> -	for (i = 0; i < NR_REG_BANKS; i++)
> +	for (i = 0; i < irq_banks; i++)
>  		wakeupgen_writel(per_cpu(irqmasks, cpu)[i], i, cpu);
>  }
>  
> @@ -168,7 +172,7 @@ static void _wakeupgen_set_all(unsigned int cpu, unsigned int reg)
>  {
>  	u8 i;
>  
> -	for (i = 0; i < NR_REG_BANKS; i++)
> +	for (i = 0; i < irq_banks; i++)
>  		wakeupgen_writel(reg, i, cpu);
>  }
>  
> @@ -196,25 +200,11 @@ static void wakeupgen_irqmask_all(unsigned int cpu, unsigned int set)
>  #endif
>  
>  #ifdef CONFIG_CPU_PM
> -/*
> - * Save WakeupGen interrupt context in SAR BANK3. Restore is done by
> - * ROM code. WakeupGen IP is integrated along with GIC to manage the
> - * interrupt wakeups from CPU low power states. It manages
> - * masking/unmasking of Shared peripheral interrupts(SPI). So the
> - * interrupt enable/disable control should be in sync and consistent
> - * at WakeupGen and GIC so that interrupts are not lost.
> - */
> -static void irq_save_context(void)
> +static inline void omap4_irq_save_context(void)
>  {
>  	u32 i, val;
>  
> -	if (omap_rev() == OMAP4430_REV_ES1_0)
> -		return;

you removed the above check for 4430_ES1_0 here but do not add it back
in the new irq_save_context().

> -
> -	if (!sar_base)
> -		sar_base = omap4_get_sar_ram_base();
> -
> -	for (i = 0; i < NR_REG_BANKS; i++) {
> +	for (i = 0; i < irq_banks; i++) {
>  		/* Save the CPUx interrupt mask for IRQ 0 to 127 */
>  		val = wakeupgen_readl(i, 0);
>  		sar_writel(val, WAKEUPGENENB_OFFSET_CPU0, i);
> @@ -254,6 +244,53 @@ static void irq_save_context(void)
>  	val = __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
>  	val |= SAR_BACKUP_STATUS_WAKEUPGEN;
>  	__raw_writel(val, sar_base + SAR_BACKUP_STATUS_OFFSET);
> +
> +}
> +
> +static inline void omap5_irq_save_context(void)
> +{
> +	u32 i, val;
> +
> +	for (i = 0; i < irq_banks; i++) {
> +		/* Save the CPUx interrupt mask for IRQ 0 to 159 */
> +		val = wakeupgen_readl(i, 0);
> +		sar_writel(val, OMAP5_WAKEUPGENENB_OFFSET_CPU0, i);
> +		val = wakeupgen_readl(i, 1);
> +		sar_writel(val, OMAP5_WAKEUPGENENB_OFFSET_CPU1, i);
> +		sar_writel(0x0, OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU0, i);
> +		sar_writel(0x0, OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU1, i);
> +	}
> +
> +	/* Save AuxBoot* registers */
> +	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
> +	__raw_writel(val, sar_base + OMAP5_AUXCOREBOOT0_OFFSET);
> +	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
> +	__raw_writel(val, sar_base + OMAP5_AUXCOREBOOT1_OFFSET);
> +
> +	/* Set the Backup Bit Mask status */
> +	val = __raw_readl(sar_base + OMAP5_SAR_BACKUP_STATUS_OFFSET);
> +	val |= SAR_BACKUP_STATUS_WAKEUPGEN;
> +	__raw_writel(val, sar_base + OMAP5_SAR_BACKUP_STATUS_OFFSET);
> +
> +}
> +
> +/*
> + * Save WakeupGen interrupt context in SAR BANK3. Restore is done by
> + * ROM code. WakeupGen IP is integrated along with GIC to manage the
> + * interrupt wakeups from CPU low power states. It manages
> + * masking/unmasking of Shared peripheral interrupts(SPI). So the
> + * interrupt enable/disable control should be in sync and consistent
> + * at WakeupGen and GIC so that interrupts are not lost.
> + */
> +static void irq_save_context(void)
> +{

add the 4430 ES1 check here

+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		return;

> +	if (!sar_base)
> +		sar_base = omap4_get_sar_ram_base();
> +
> +	if (cpu_is_omap54xx())
> +		omap5_irq_save_context();
> +	else
> +		omap4_irq_save_context();
>  }
>  
>  /*
> @@ -262,9 +299,14 @@ static void irq_save_context(void)
>  void irq_sar_clear(void)
>  {
>  	u32 val;
> -	val = __raw_readl(sar_base + SAR_BACKUP_STATUS_OFFSET);
> +	u32 offset = SAR_BACKUP_STATUS_OFFSET;
> +
> +	if (cpu_is_omap54xx())
> +		offset = OMAP5_SAR_BACKUP_STATUS_OFFSET;
> +
> +	val = __raw_readl(sar_base + offset);
>  	val &= ~SAR_BACKUP_STATUS_WAKEUPGEN;
> -	__raw_writel(val, sar_base + SAR_BACKUP_STATUS_OFFSET);
> +	__raw_writel(val, sar_base + offset);
>  }
>  
>  /*
> @@ -336,13 +378,20 @@ static struct notifier_block irq_notifier_block = {
>  
>  static void __init irq_pm_init(void)
>  {
> -	cpu_pm_register_notifier(&irq_notifier_block);
> +	/* FIXME: Remove this when MPU OSWR support is added */
> +	if (!cpu_is_omap54xx())
> +		cpu_pm_register_notifier(&irq_notifier_block);
>  }
>  #else
>  static void __init irq_pm_init(void)
>  {}
>  #endif
>  
> +void __iomem *omap_get_wakeupgen_base(void)
> +{
> +	return wakeupgen_base;
> +}
> +
>  /*
>   * Initialise the wakeupgen module.
>   */
> @@ -358,12 +407,17 @@ int __init omap_wakeupgen_init(void)
>  	}
>  
>  	/* Static mapping, never released */
> -	wakeupgen_base = ioremap(OMAP44XX_WKUPGEN_BASE, SZ_4K);
> +	wakeupgen_base = ioremap(OMAP_WKUPGEN_BASE, SZ_4K);

unnecessary change. I don't see why you can't continue to use
OMAP44XX_WKUPGEN_BASE

>  	if (WARN_ON(!wakeupgen_base))
>  		return -ENOMEM;
>  
> +	if (cpu_is_omap44xx()) {
> +		irq_banks = OMAP4_NR_BANKS;
> +		max_irqs = OMAP4_NR_IRQS;
> +	}
> +
>  	/* Clear all IRQ bitmasks at wakeupGen level */
> -	for (i = 0; i < NR_REG_BANKS; i++) {
> +	for (i = 0; i < irq_banks; i++) {
>  		wakeupgen_writel(0, i, CPU0_ID);
>  		wakeupgen_writel(0, i, CPU1_ID);
>  	}
> @@ -382,7 +436,7 @@ int __init omap_wakeupgen_init(void)
>  	 */
>  
>  	/* Associate all the IRQs to boot CPU like GIC init does. */
> -	for (i = 0; i < NR_IRQS; i++)
> +	for (i = 0; i < max_irqs; i++)
>  		irq_target_cpu[i] = boot_cpu;
>  
>  	irq_hotplug_init();
> diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h b/arch/arm/mach-omap2/omap4-sar-layout.h
> index fe5b545..e170fe8 100644
> --- a/arch/arm/mach-omap2/omap4-sar-layout.h
> +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> @@ -12,7 +12,7 @@
>  #define OMAP_ARCH_OMAP4_SAR_LAYOUT_H
>  
>  /*
> - * SAR BANK offsets from base address OMAP44XX_SAR_RAM_BASE
> + * SAR BANK offsets from base address OMAP44XX/54XX_SAR_RAM_BASE
>   */
>  #define SAR_BANK1_OFFSET		0x0000
>  #define SAR_BANK2_OFFSET		0x1000
> @@ -47,4 +47,14 @@
>  #define PTMSYNCREQ_EN_OFFSET			(SAR_BANK3_OFFSET + 0x6d0)
>  #define SAR_BACKUP_STATUS_WAKEUPGEN		0x10
>  
> +/* WakeUpGen save restore offset from OMAP54XX_SAR_RAM_BASE */
> +#define OMAP5_WAKEUPGENENB_OFFSET_CPU0		(SAR_BANK3_OFFSET + 0x8d4)
> +#define OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU0	(SAR_BANK3_OFFSET + 0x8e8)
> +#define OMAP5_WAKEUPGENENB_OFFSET_CPU1		(SAR_BANK3_OFFSET + 0x8fc)
> +#define OMAP5_WAKEUPGENENB_SECURE_OFFSET_CPU1	(SAR_BANK3_OFFSET + 0x910)
> +#define OMAP5_AUXCOREBOOT0_OFFSET		(SAR_BANK3_OFFSET + 0x924)
> +#define OMAP5_AUXCOREBOOT1_OFFSET		(SAR_BANK3_OFFSET + 0x928)
> +#define OMAP5_AMBA_IF_MODE_OFFSET		(SAR_BANK3_OFFSET + 0x92c)
> +#define OMAP5_SAR_BACKUP_STATUS_OFFSET		(SAR_BANK3_OFFSET + 0x800)
> +
>  #endif

regards,
-roger
