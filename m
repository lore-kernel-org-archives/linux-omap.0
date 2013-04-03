From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2 01/18] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
Date: Wed, 03 Apr 2013 12:44:47 -0700
Message-ID: <87a9pfxuts.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1364205910-32392-2-git-send-email-santosh.shilimkar@ti.com>
 (Santosh Shilimkar's message of "Mon, 25 Mar 2013 15:34:53 +0530")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: nm@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> OMAP5 and future OMAP based SOCs has backward compatible MPUSS
> IP block with OMAP4. It's programming model is mostly similar.
> Hence consolidate the OMAP MPUSS code so that it can be re-used
> on OMAP5 and future SOCs.
>
> No functional change.
>
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |   65 ++++++++++++++++++++++++-----
>  1 file changed, 54 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> index d650f91..d9e4843 100644
> --- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> +++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
> @@ -71,10 +71,46 @@ struct omap4_cpu_pm_info {
>  	void (*secondary_startup)(void);
>  };
>  
> +/**
> + * struct cpu_pm_ops - CPU pm operations
> + * @finish_suspend:	CPU suspend finisher function pointer
> + * @resume:		CPU resume function pointer
> + * @scu_prepare:	CPU Snoop Control program function pointer
> + *
> + * Structure holds functions pointer for CPU low power operations like
> + * suspend, resume and scu programming.
> + */
> +struct cpu_pm_ops {
> +	int (*finish_suspend)(unsigned long cpu_state);
> +	void (*resume)(void);
> +	void (*scu_prepare)(unsigned int cpu_id, unsigned int cpu_state);
> +};
> +
> +extern int omap4_finish_suspend(unsigned long cpu_state);
> +extern void omap4_cpu_resume(void);

checkpatch should've yelled at you for adding externs to .c files.

Also, aren't these already defined in common.h anyways?

Otherwise, patch looks fine.

Kevin

>  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
>  static struct powerdomain *mpuss_pd;
>  static void __iomem *sar_base;
>  
> +static int default_finish_suspend(unsigned long cpu_state)
> +{
> +	omap_do_wfi();
> +	return 0;
> +}
> +
> +static void dummy_cpu_resume(void)
> +{}
> +
> +static void dummy_scu_prepare(unsigned int cpu_id, unsigned int cpu_state)
> +{}
> +
> +struct cpu_pm_ops omap_pm_ops = {
> +	.finish_suspend		= default_finish_suspend,
> +	.resume			= dummy_cpu_resume,
> +	.scu_prepare		= dummy_scu_prepare,
> +};
> +
>  /*
>   * Program the wakeup routine address for the CPU0 and CPU1
>   * used for OFF or DORMANT wakeup.
> @@ -172,11 +208,12 @@ static void save_l2x0_context(void)
>  {
>  	u32 val;
>  	void __iomem *l2x0_base = omap4_get_l2cache_base();
> -
> -	val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
> -	__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
> -	val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
> -	__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
> +	if (l2x0_base) {
> +		val = __raw_readl(l2x0_base + L2X0_AUX_CTRL);
> +		__raw_writel(val, sar_base + L2X0_AUXCTRL_OFFSET);
> +		val = __raw_readl(l2x0_base + L2X0_PREFETCH_CTRL);
> +		__raw_writel(val, sar_base + L2X0_PREFETCH_CTRL_OFFSET);
> +	}
>  }
>  #else
>  static void save_l2x0_context(void)
> @@ -239,17 +276,17 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
>  
>  	cpu_clear_prev_logic_pwrst(cpu);
>  	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
> -	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
> -	scu_pwrst_prepare(cpu, power_state);
> +	set_cpu_wakeup_addr(cpu, virt_to_phys(omap_pm_ops.resume));
> +	omap_pm_ops.scu_prepare(cpu, power_state);
>  	l2x0_pwrst_prepare(cpu, save_state);
>  
>  	/*
>  	 * Call low level function  with targeted low power state.
>  	 */
>  	if (save_state)
> -		cpu_suspend(save_state, omap4_finish_suspend);
> +		cpu_suspend(save_state, omap_pm_ops.finish_suspend);
>  	else
> -		omap4_finish_suspend(save_state);
> +		omap_pm_ops.finish_suspend(save_state);
>  
>  	/*
>  	 * Restore the CPUx power state to ON otherwise CPUx
> @@ -285,14 +322,14 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
>  	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
>  	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
>  	set_cpu_wakeup_addr(cpu, virt_to_phys(pm_info->secondary_startup));
> -	scu_pwrst_prepare(cpu, power_state);
> +	omap_pm_ops.scu_prepare(cpu, power_state);
>  
>  	/*
>  	 * CPU never retuns back if targeted power state is OFF mode.
>  	 * CPU ONLINE follows normal CPU ONLINE ptah via
>  	 * omap_secondary_startup().
>  	 */
> -	omap4_finish_suspend(cpu_state);
> +	omap_pm_ops.finish_suspend(cpu_state);
>  
>  	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
>  	return 0;
> @@ -369,6 +406,12 @@ int __init omap4_mpuss_init(void)
>  
>  	save_l2x0_context();
>  
> +	if (cpu_is_omap44xx()) {
> +		omap_pm_ops.finish_suspend = omap4_finish_suspend;
> +		omap_pm_ops.resume = omap4_cpu_resume;
> +		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
> +	}
> +
>  	return 0;
>  }
