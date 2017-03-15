From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCHv3] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
Date: Wed, 15 Mar 2017 15:11:36 +0530
Message-ID: <3cf1a4bc-6ddf-dd5e-9fe6-a269037f26fe@ti.com>
References: <20170314180555.23597-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170314180555.23597-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org



On Tuesday 14 March 2017 11:35 PM, Tony Lindgren wrote:
> Commit 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec") started
> unconditionally resetting CPU1 because of a kexec boot issue I was seeing
> earlier on omap4 when doing kexec boot between two different kernel
> versions.
> 
> This caused issues on some systems. We should only reset CPU1 as a last
> resort option, and try to avoid it where possible. Doing an unconditional
> CPU1 reset causes issues for example when booting a bootloader configured
> secure OS running on CPU1 as reported by Andrew F. Davis <afd@ti.com>.
> 
> We can't completely remove the reset of CPU1 as it would break kexec
> booting from older kernels. But we can limit the CPU1 reset to cases
> where CPU1 is wrongly parked within the memory area used by the booting
> kernel. Then later on we can add support for parking CPU1 for kexec out
> of the SDRAM back to bootrom.
> 
> So let's first fix the regression reported by Andrew by making CPU1 reset
> conditional. To do this, we need to:
> 
> 1. Save configured AUX_CORE_BOOT_1 for later
> 
> 2. Modify AUX_CORE_BOOT_0 reading code to for HS SoCs to return
>    the whole register instead of the CPU mask
> 
> 3. Check if CPU1 is wrongly parked into the booting kernel by the
>    previous kernel and reset if needed

Tested on top of:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/thread.html#491706

kexec seems working fine with both CPUs booting HYP mode on DRA7-EVM.

Tested-by: Keerthy <j-keerthy@ti.com>

> 
> Fixes: 3251885285e1 ("ARM: OMAP4+: Reset CPU1 properly for kexec")
> Reported-by: Andrew F. Davis <afd@ti.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Keerthy <j-keerthy@ti.com>
> Cc: Russell King <rmk+kernel@armlinux.org.uk>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Changes from v2:
> 
> - Add Santosh to Cc, sorry Santosh I forgot to add earlier
> 
> - Add check for CPU1 being parked in addition to checking
>   CPU1 start-up address being within booting kernel before
>   reset
> 
> - Left out extra cpu_is to soc_is changes, those can be done
>   later
> 
> - Updated description to leave out suspend/resume issues as
>   those can be dealt with separately if they still exist after
>   fixing kexec boot, they may have been happening only after
>   a kexec boot
> 
> Changes from v1:
> 
> - We can't remove the CPU1 reset completely because it breaks
>   kexec booting all the existing kernels as CPU1 might be
>   parked into the booting kernel
> 
> ---
>  arch/arm/mach-omap2/common.h              |  1 +
>  arch/arm/mach-omap2/omap-hotplug.c        |  2 +-
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c | 22 ++++++--
>  arch/arm/mach-omap2/omap-smc.S            |  1 -
>  arch/arm/mach-omap2/omap-smp.c            | 90 ++++++++++++++++++++++++++-----
>  5 files changed, 96 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -270,6 +270,7 @@ extern const struct smp_operations omap4_smp_ops;
>  extern int omap4_mpuss_init(void);
>  extern int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state);
>  extern int omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state);
> +extern u32 omap4_get_cpu1_ns_pa_addr(void);
>  #else
>  static inline int omap4_enter_lowpower(unsigned int cpu,
>  					unsigned int power_state)
> diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
> --- a/arch/arm/mach-omap2/omap-hotplug.c
> +++ b/arch/arm/mach-omap2/omap-hotplug.c
> @@ -50,7 +50,7 @@ void omap4_cpu_die(unsigned int cpu)
>  		omap4_hotplug_cpu(cpu, PWRDM_POWER_OFF);
>  
>  		if (omap_secure_apis_support())
> -			boot_cpu = omap_read_auxcoreboot0();
> +			boot_cpu = omap_read_auxcoreboot0() >> 9;
>  		else
>  			boot_cpu =
>  				readl_relaxed(base + OMAP_AUX_CORE_BOOT_0) >> 5;
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -64,6 +64,7 @@
>  #include "prm-regbits-44xx.h"
>  
>  static void __iomem *sar_base;
> +static u32 old_cpu1_ns_pa_addr;
>  
>  #if defined(CONFIG_PM) && defined(CONFIG_SMP)
>  
> @@ -212,6 +213,11 @@ static void __init save_l2x0_context(void)
>  {}
>  #endif
>  
> +u32 omap4_get_cpu1_ns_pa_addr(void)
> +{
> +	return old_cpu1_ns_pa_addr;
> +}
> +
>  /**
>   * omap4_enter_lowpower: OMAP4 MPUSS Low Power Entry Function
>   * The purpose of this function is to manage low power programming
> @@ -460,22 +466,30 @@ int __init omap4_mpuss_init(void)
>  void __init omap4_mpuss_early_init(void)
>  {
>  	unsigned long startup_pa;
> +	void __iomem *ns_pa_addr;
>  
> -	if (!(cpu_is_omap44xx() || soc_is_omap54xx()))
> +	if (!(soc_is_omap44xx() || soc_is_omap54xx()))
>  		return;
>  
>  	sar_base = omap4_get_sar_ram_base();
>  
> -	if (cpu_is_omap443x())
> +	/* Save old NS_PA_ADDR for validity checks later on */
> +	if (soc_is_omap44xx())
> +		ns_pa_addr = sar_base + CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
> +	else
> +		ns_pa_addr = sar_base + OMAP5_CPU1_WAKEUP_NS_PA_ADDR_OFFSET;
> +	old_cpu1_ns_pa_addr = readl_relaxed(ns_pa_addr);
> +
> +	if (soc_is_omap443x())
>  		startup_pa = __pa_symbol(omap4_secondary_startup);
> -	else if (cpu_is_omap446x())
> +	else if (soc_is_omap446x())
>  		startup_pa = __pa_symbol(omap4460_secondary_startup);
>  	else if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
>  		startup_pa = __pa_symbol(omap5_secondary_hyp_startup);
>  	else
>  		startup_pa = __pa_symbol(omap5_secondary_startup);
>  
> -	if (cpu_is_omap44xx())
> +	if (soc_is_omap44xx())
>  		writel_relaxed(startup_pa, sar_base +
>  			       CPU1_WAKEUP_NS_PA_ADDR_OFFSET);
>  	else
> diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-smc.S
> --- a/arch/arm/mach-omap2/omap-smc.S
> +++ b/arch/arm/mach-omap2/omap-smc.S
> @@ -94,6 +94,5 @@ ENTRY(omap_read_auxcoreboot0)
>  	ldr	r12, =0x103
>  	dsb
>  	smc	#0
> -	mov	r0, r0, lsr #9
>  	ldmfd   sp!, {r2-r12, pc}
>  ENDPROC(omap_read_auxcoreboot0)
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/irqchip/arm-gic.h>
>  
> +#include <asm/sections.h>
>  #include <asm/smp_scu.h>
>  #include <asm/virt.h>
>  
> @@ -40,10 +41,14 @@
>  
>  #define OMAP5_CORE_COUNT	0x2
>  
> +#define AUX_CORE_BOOT0_GP_RELEASE	0x020
> +#define AUX_CORE_BOOT0_HS_RELEASE	0x200
> +
>  struct omap_smp_config {
>  	unsigned long cpu1_rstctrl_pa;
>  	void __iomem *cpu1_rstctrl_va;
>  	void __iomem *scu_base;
> +	void __iomem *wakeupgen_base;
>  	void *startup_addr;
>  };
>  
> @@ -140,7 +145,6 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	static struct clockdomain *cpu1_clkdm;
>  	static bool booted;
>  	static struct powerdomain *cpu1_pwrdm;
> -	void __iomem *base = omap_get_wakeupgen_base();
>  
>  	/*
>  	 * Set synchronisation state between this boot processor
> @@ -155,9 +159,11 @@ static int omap4_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	 * A barrier is added to ensure that write buffer is drained
>  	 */
>  	if (omap_secure_apis_support())
> -		omap_modify_auxcoreboot0(0x200, 0xfffffdff);
> +		omap_modify_auxcoreboot0(AUX_CORE_BOOT0_HS_RELEASE,
> +					 0xfffffdff);
>  	else
> -		writel_relaxed(0x20, base + OMAP_AUX_CORE_BOOT_0);
> +		writel_relaxed(AUX_CORE_BOOT0_GP_RELEASE,
> +			       cfg.wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
>  
>  	if (!cpu1_clkdm && !cpu1_pwrdm) {
>  		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
> @@ -261,9 +267,72 @@ static void __init omap4_smp_init_cpus(void)
>  		set_cpu_possible(i, true);
>  }
>  
> +/*
> + * For now, just make sure the start-up address is not within the booting
> + * kernel space as that means we just overwrote whatever secondary_startup()
> + * code there was.
> + */
> +static bool __init omap4_smp_cpu1_startup_valid(unsigned long addr)
> +{
> +	if ((addr >= __pa(PAGE_OFFSET)) && (addr <= __pa(__bss_start)))
> +		return false;
> +
> +	return true;
> +}
> +
> +/*
> + * We may need to reset CPU1 before configuring, otherwise kexec boot can end
> + * up trying to use old kernel startup address or suspend-resume will
> + * occasionally fail to bring up CPU1 on 4430 if CPU1 fails to enter deeper
> + * idle states.
> + */
> +static void __init omap4_smp_maybe_reset_cpu1(struct omap_smp_config *c)
> +{
> +	unsigned long cpu1_startup_pa, cpu1_ns_pa_addr;
> +	bool needs_reset = false;
> +	u32 released;
> +
> +	if (omap_secure_apis_support())
> +		released = omap_read_auxcoreboot0() & AUX_CORE_BOOT0_HS_RELEASE;
> +	else
> +		released = readl_relaxed(cfg.wakeupgen_base +
> +					 OMAP_AUX_CORE_BOOT_0) &
> +						AUX_CORE_BOOT0_GP_RELEASE;
> +	if (released) {
> +		pr_warn("smp: CPU1 not parked?\n");
> +
> +		return;
> +	}
> +
> +	cpu1_startup_pa = readl_relaxed(cfg.wakeupgen_base +
> +					OMAP_AUX_CORE_BOOT_1);
> +	cpu1_ns_pa_addr = omap4_get_cpu1_ns_pa_addr();
> +
> +	/* Did the configured secondary_startup() get overwritten? */
> +	if (!omap4_smp_cpu1_startup_valid(cpu1_startup_pa))
> +		needs_reset = true;
> +
> +	/*
> +	 * If omap4 or 5 has NS_PA_ADDR configured, CPU1 may be in a
> +	 * deeper idle state in WFI and will wake to an invalid address.
> +	 */
> +	if ((soc_is_omap44xx() || soc_is_omap54xx()) &&
> +	    !omap4_smp_cpu1_startup_valid(cpu1_ns_pa_addr))
> +		needs_reset = true;
> +
> +	if (!needs_reset || !c->cpu1_rstctrl_va)
> +		return;
> +
> +	pr_info("smp: CPU1 parked within kernel, needs reset (0x%lx 0x%lx)\n",
> +		cpu1_startup_pa, cpu1_ns_pa_addr);
> +
> +	writel_relaxed(1, c->cpu1_rstctrl_va);
> +	readl_relaxed(c->cpu1_rstctrl_va);
> +	writel_relaxed(0, c->cpu1_rstctrl_va);
> +}
> +
>  static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>  {
> -	void __iomem *base = omap_get_wakeupgen_base();
>  	const struct omap_smp_config *c = NULL;
>  
>  	if (soc_is_omap443x())
> @@ -281,6 +350,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>  	/* Must preserve cfg.scu_base set earlier */
>  	cfg.cpu1_rstctrl_pa = c->cpu1_rstctrl_pa;
>  	cfg.startup_addr = c->startup_addr;
> +	cfg.wakeupgen_base = omap_get_wakeupgen_base();
>  
>  	if (soc_is_dra74x() || soc_is_omap54xx()) {
>  		if ((__boot_cpu_mode & MODE_MASK) == HYP_MODE)
> @@ -299,15 +369,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>  	if (cfg.scu_base)
>  		scu_enable(cfg.scu_base);
>  
> -	/*
> -	 * Reset CPU1 before configuring, otherwise kexec will
> -	 * end up trying to use old kernel startup address.
> -	 */
> -	if (cfg.cpu1_rstctrl_va) {
> -		writel_relaxed(1, cfg.cpu1_rstctrl_va);
> -		readl_relaxed(cfg.cpu1_rstctrl_va);
> -		writel_relaxed(0, cfg.cpu1_rstctrl_va);
> -	}
> +	omap4_smp_maybe_reset_cpu1(&cfg);
>  
>  	/*
>  	 * Write the address of secondary startup routine into the
> @@ -319,7 +381,7 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>  		omap_auxcoreboot_addr(__pa_symbol(cfg.startup_addr));
>  	else
>  		writel_relaxed(__pa_symbol(cfg.startup_addr),
> -			       base + OMAP_AUX_CORE_BOOT_1);
> +			       cfg.wakeupgen_base + OMAP_AUX_CORE_BOOT_1);
>  }
>  
>  const struct smp_operations omap4_smp_ops __initconst = {
> 
