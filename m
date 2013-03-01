From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 09/15] ARM: OMAP4+: PM: Restore CPU power state to ON
 with clockdomain force wakeup method
Date: Fri, 1 Mar 2013 15:53:16 -0600
Message-ID: <20130301215315.GA23856@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-10-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42805 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973Ab3CAVxU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 16:53:20 -0500
Content-Disposition: inline
In-Reply-To: <1362139864-9233-10-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 17:40-20130301, Santosh Shilimkar wrote:
> While waking up CPU from off state using clock domain force wakeup, restore
> the CPU power state to ON state before putting CPU clock domain under
> hardware control. Otherwise CPU wakeup might fail. The change is recommended\
the trailing \ was unintentional I suppose.
> for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
> devices first.
> 
> So update the code accordingly.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle44xx.c |    1 +
>  arch/arm/mach-omap2/omap-smp.c    |   12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 944e64a..9de47a7 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -131,6 +131,7 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
>  	/* Wakeup CPU1 only if it is not offlined */
>  	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
>  		clkdm_wakeup(cpu_clkdm[1]);
> +		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
>  		clkdm_allow_idle(cpu_clkdm[1]);
>  	}
>  
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 9711ecd..ba63b14 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -83,6 +83,7 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
>  {
>  	static struct clockdomain *cpu1_clkdm;
>  	static bool booted;
> +	static struct powerdomain *cpu1_pwrdm;
>  	void __iomem *base = omap_get_wakeupgen_base();
>  
>  	/*
> @@ -102,8 +103,10 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
>  	else
>  		__raw_writel(0x20, base + OMAP_AUX_CORE_BOOT_0);
>  
> -	if (!cpu1_clkdm)
> +	if (!cpu1_clkdm && !cpu1_pwrdm) {
>  		cpu1_clkdm = clkdm_lookup("mpu1_clkdm");
> +		cpu1_pwrdm = pwrdm_lookup("cpu1_pwrdm");
> +	}
>  
>  	/*
>  	 * The SGI(Software Generated Interrupts) are not wakeup capable
> @@ -116,7 +119,7 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
>  	 * Section :
>  	 *	4.3.4.2 Power States of CPU0 and CPU1
>  	 */
> -	if (booted) {
> +	if (booted && cpu1_pwrdm && cpu1_clkdm) {
>  		/*
>  		 * GIC distributor control register has changed between
>  		 * CortexA9 r1pX and r2pX. The Control Register secure
> @@ -137,7 +140,12 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
>  			gic_dist_disable();
>  		}
>  
> +		/*
> +		 * Ensure that CPU power state is set to ON to avoid CPU
> +		 * powerdomain transition on wfi
> +		 */
>  		clkdm_wakeup(cpu1_clkdm);
> +		omap_set_pwrdm_state(cpu1_pwrdm, PWRDM_POWER_ON);
>  		clkdm_allow_idle(cpu1_clkdm);
>  
>  		if (IS_PM44XX_ERRATUM(PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD)) {
Otherwise:
Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
