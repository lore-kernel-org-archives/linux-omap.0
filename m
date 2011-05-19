From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 12/13] OMAP2+: PM: export functions and variables to PM
 modules
Date: Thu, 19 May 2011 14:02:00 +0530
Message-ID: <4DD4D580.6070005@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com> <1305739950-11695-13-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:54125 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752653Ab1ESIcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 04:32:07 -0400
Received: by gxk7 with SMTP id 7so1189513gxk.35
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 01:32:05 -0700 (PDT)
In-Reply-To: <1305739950-11695-13-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org

On 5/18/2011 11:02 PM, jean.pihet@newoldbits.com wrote:
> From: Jean Pihet<j-pihet@ti.com>
>
> Addition of EXPORT_SYMBOL for functions and variables used by
> the code in PM modules.
>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>
> ---
>   arch/arm/kernel/setup.c            |    1 +
>   arch/arm/kernel/smp_tlb.c          |    2 ++
>   arch/arm/mach-omap2/clockdomain.c  |    7 +++++++
>   arch/arm/mach-omap2/cm2xxx_3xxx.c  |    7 +++++++
>   arch/arm/mach-omap2/control.c      |   13 +++++++++++++
>   arch/arm/mach-omap2/gpmc.c         |    2 ++
>   arch/arm/mach-omap2/id.c           |    1 +
>   arch/arm/mach-omap2/irq.c          |    7 +++++++
>   arch/arm/mach-omap2/pm-debug.c     |    1 +
>   arch/arm/mach-omap2/pm.c           |    9 +++++++++
>   arch/arm/mach-omap2/pm34xx.c       |    3 +++
>   arch/arm/mach-omap2/powerdomain.c  |   16 ++++++++++++++++
>   arch/arm/mach-omap2/prm2xxx_3xxx.c |    6 ++++++
>   arch/arm/mach-omap2/sdrc.c         |    2 ++
>   arch/arm/mach-omap2/serial.c       |    5 +++++
>   arch/arm/mach-omap2/timer-gp.c     |    1 +
>   arch/arm/plat-omap/common.c        |    1 +
>   arch/arm/plat-omap/dma.c           |    3 +++
>   arch/arm/plat-omap/gpio.c          |    4 ++++
>   arch/arm/plat-omap/omap-pm-noop.c  |    2 ++
>   arch/arm/plat-omap/omap_device.c   |    1 +
>   arch/arm/plat-omap/sram.c          |    2 ++
>   22 files changed, 96 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 006c1e8..73ad7ae 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -438,6 +438,7 @@ void cpu_init(void)
>   	      PLC (PSR_F_BIT | PSR_I_BIT | SVC_MODE)
>   	    : "r14");
>   }
> +EXPORT_SYMBOL(cpu_init);
>
LAK needs to be CC'd to approve this change.


>   static struct machine_desc * __init setup_machine(unsigned int nr)
>   {
> diff --git a/arch/arm/kernel/smp_tlb.c b/arch/arm/kernel/smp_tlb.c
> index 7dcb352..2cfdefa 100644
> --- a/arch/arm/kernel/smp_tlb.c
> +++ b/arch/arm/kernel/smp_tlb.c
> @@ -9,6 +9,7 @@
>    */
>   #include<linux/preempt.h>
>   #include<linux/smp.h>
> +#include<linux/module.h>
>
>   #include<asm/smp_plat.h>
>   #include<asm/tlbflush.h>
> @@ -83,6 +84,7 @@ void flush_tlb_all(void)
>   	else
>   		local_flush_tlb_all();
>   }
> +EXPORT_SYMBOL(flush_tlb_all);
>
This one too.

[....]

>
>   /* Clockdomain-to-clock framework interface code */
> diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
> index 38830d8..6516e30 100644
> --- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
> @@ -41,11 +41,13 @@ u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
>   {
>   	return __raw_readl(cm_base + module + idx);
>   }
> +EXPORT_SYMBOL(omap2_cm_read_mod_reg);
>
>   void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
>   {
>   	__raw_writel(val, cm_base + module + idx);
>   }
> +EXPORT_SYMBOL(omap2_cm_write_mod_reg);

Above are too low level API's to be exported

>
>   /* Read-modify-write a register in a CM module. Caller must lock */
>   u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
> @@ -59,16 +61,19 @@ u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
>
>   	return v;
>   }
> +EXPORT_SYMBOL(omap2_cm_rmw_mod_reg_bits);
>
>   u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
>   {
>   	return omap2_cm_rmw_mod_reg_bits(bits, bits, module, idx);
>   }
> +EXPORT_SYMBOL(omap2_cm_set_mod_reg_bits);
>
>   u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
>   {
>   	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
>   }
> +EXPORT_SYMBOL(omap2_cm_clear_mod_reg_bits);
>
These too ..

>   /*
>    *
> @@ -431,6 +436,7 @@ void omap3_cm_save_context(void)
>   		omap2_cm_read_mod_reg(OMAP3430_CCR_MOD,
>   				      OMAP3_CM_CLKOUT_CTRL_OFFSET);
>   }
> +EXPORT_SYMBOL(omap3_cm_save_context);
>
>   void omap3_cm_restore_context(void)
>   {
> @@ -554,4 +560,5 @@ void omap3_cm_restore_context(void)
>   	omap2_cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
>   			       OMAP3_CM_CLKOUT_CTRL_OFFSET);
>   }
> +EXPORT_SYMBOL(omap3_cm_restore_context);
>   #endif
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 23b83bd..b91aded 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -93,6 +93,7 @@ struct omap3_scratchpad_sdrc_block {
>   };
>
>   void *omap3_secure_ram_storage;
> +EXPORT_SYMBOL(omap3_secure_ram_storage);
>
Instead of exporting variable, a get_*_addr() accessory
fn is better.

>   /*
>    * This is used to store ARM registers in SDRAM before attempting
> @@ -101,6 +102,7 @@ void *omap3_secure_ram_storage;
>    * during the restore path.
>    */
>   u32 omap3_arm_context[128];
> +EXPORT_SYMBOL(omap3_arm_context);
>
ditto...

>   #endif /* CONFIG_ARCH_OMAP3&&  CONFIG_PM */
[...]

>   #endif /* CONFIG_ARCH_OMAP3 */
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 4e81e8d..fd93bc3 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -157,6 +157,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
>   	for (i = 0; i<  reg_count; i++)
>   		printk(KERN_INFO "%-20s: 0x%08x\n", regs[i].name, regs[i].val);
>   }
> +EXPORT_SYMBOL(omap2_pm_dump);
>
>   #ifdef CONFIG_DEBUG_FS
>   #include<linux/debugfs.h>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index ab69c5a..323870f 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -31,6 +31,7 @@
>   static struct omap_device_pm_latency *pm_lats;
>   #if defined(CONFIG_PM)&&  defined(CONFIG_CPU_IDLE)
>   struct cpuidle_params *cpuidle_params_override_table;
> +EXPORT_SYMBOL(cpuidle_params_override_table);
>   #endif
>
>   #ifdef CONFIG_PM_DEBUG
> @@ -38,9 +39,16 @@ u32 enable_off_mode;
>   EXPORT_SYMBOL(enable_off_mode);
>
>   int omap2_pm_debug;
> +EXPORT_SYMBOL(omap2_pm_debug);
> +
>   u32 sleep_while_idle;
> +EXPORT_SYMBOL(sleep_while_idle);
> +
>   u32 wakeup_timer_seconds;
> +EXPORT_SYMBOL(wakeup_timer_seconds);
> +
>   u32 wakeup_timer_milliseconds;
> +EXPORT_SYMBOL(wakeup_timer_milliseconds);
>   #endif
>

All above can be clubbed in a structure and then
only that struct needs to be exported.

[...]

>    * pwrdm_get_context_loss_count - get powerdomain's context loss count
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> index 051213f..009f393 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -29,11 +29,13 @@ u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
>   {
>   	return __raw_readl(prm_base + module + idx);
>   }
> +EXPORT_SYMBOL(omap2_prm_read_mod_reg);
>
>   void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
>   {
>   	__raw_writel(val, prm_base + module + idx);
>   }
> +EXPORT_SYMBOL(omap2_prm_write_mod_reg);
>
>   /* Read-modify-write a register in a PRM module. Caller must lock */
>   u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
> @@ -47,6 +49,7 @@ u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
>
>   	return v;
>   }
> +EXPORT_SYMBOL(omap2_prm_rmw_mod_reg_bits);
>
>   /* Read a PRM register, AND it, and shift the result down to bit 0 */
>   u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
> @@ -59,16 +62,19 @@ u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
>
>   	return v;
>   }
> +EXPORT_SYMBOL(omap2_prm_read_mod_bits_shift);
>
>   u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
>   {
>   	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
>   }
> +EXPORT_SYMBOL(omap2_prm_set_mod_reg_bits);
>
>   u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
>   {
>   	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
>   }
> +EXPORT_SYMBOL(omap2_prm_clear_mod_reg_bits);
>
>
Too low level fn to be exported.

>   /**
> diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
> index da6f3a6..6096749 100644
> --- a/arch/arm/mach-omap2/sdrc.c
> +++ b/arch/arm/mach-omap2/sdrc.c
> @@ -33,6 +33,7 @@
>   static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs1;
>
>   void __iomem *omap2_sdrc_base;
> +EXPORT_SYMBOL(omap2_sdrc_base);
>   void __iomem *omap2_sms_base;
>
get_*_addr() instead of variable export.

Overall this patch doesn't seems to be right.
We need a better way to do this instead of
exporting every small fn used by PM code.

Regards
Santosh
