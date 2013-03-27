From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code under smp_prepare_cpus()
Date: Wed, 27 Mar 2013 11:45:11 -0700
Message-ID: <878v587kco.fsf@linaro.org>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
	<1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:64435 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930Ab3C0SpO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 14:45:14 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so1113914pad.2
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 11:45:13 -0700 (PDT)
In-Reply-To: <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 20 Feb 2013 20:48:45 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 

Why?

> While at
> it drop the un-necessary sev() and barrier which was under prepare code.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap-smp.c |   51 ++++++++++++++++------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index 7d29a74..9711ecd 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -164,36 +164,6 @@ static int __cpuinit omap4_boot_secondary(unsigned int cpu, struct task_struct *
>  	return 0;
>  }
>  
> -static void __init wakeup_secondary(void)
> -{
> -	void *startup_addr = omap_secondary_startup;
> -	void __iomem *base = omap_get_wakeupgen_base();
> -
> -	if (cpu_is_omap446x()) {
> -		startup_addr = omap_secondary_startup_4460;
> -		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
> -	}
> -
> -	/*
> -	 * Write the address of secondary startup routine into the
> -	 * AuxCoreBoot1 where ROM code will jump and start executing
> -	 * on secondary core once out of WFE
> -	 * A barrier is added to ensure that write buffer is drained
> -	 */
> -	if (omap_secure_apis_support())
> -		omap_auxcoreboot_addr(virt_to_phys(startup_addr));
> -	else
> -		__raw_writel(virt_to_phys(omap5_secondary_startup),
> -						base + OMAP_AUX_CORE_BOOT_1);
> -
> -	/*
> -	 * Send a 'sev' to wake the secondary core from WFE.
> -	 * Drain the outstanding writes to memory
> -	 */
> -	dsb_sev();
> -	mb();
> -}
> -
>  /*
>   * Initialise the CPU possible map early - this describes the CPUs
>   * which may be present or become present in the system.
> @@ -231,6 +201,8 @@ static void __init omap4_smp_init_cpus(void)
>  
>  static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>  {
> +	void *startup_addr = omap_secondary_startup;
> +	void __iomem *base = omap_get_wakeupgen_base();
>  
>  	/*
>  	 * Initialise the SCU and wake up the secondary core using
> @@ -238,7 +210,24 @@ static void __init omap4_smp_prepare_cpus(unsigned int max_cpus)
>  	 */
>  	if (scu_base)
>  		scu_enable(scu_base);
> -	wakeup_secondary();
> +
> +	if (cpu_is_omap446x()) {
> +		startup_addr = omap_secondary_startup_4460;
> +		pm44xx_errata |= PM_OMAP4_ROM_SMP_BOOT_ERRATUM_GICD;
> +	}
> +
> +	/*
> +	 * Write the address of secondary startup routine into the
> +	 * AuxCoreBoot1 where ROM code will jump and start executing
> +	 * on secondary core once out of WFE
> +	 * A barrier is added to ensure that write buffer is drained
> +	 */
> +	if (omap_secure_apis_support())
> +		omap_auxcoreboot_addr(virt_to_phys(startup_addr));
> +	else
> +		__raw_writel(virt_to_phys(omap5_secondary_startup),
> +						base + OMAP_AUX_CORE_BOOT_1);
> +
>  }
>  
>  struct smp_operations omap4_smp_ops __initdata = {
