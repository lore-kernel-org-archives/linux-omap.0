From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP3: PM: Invoke omap3_save_scratchpad_contents() only  once at boot time
Date: Tue, 31 Mar 2009 17:14:10 -0700
Message-ID: <87d4bxtelp.fsf@deeprootsystems.com>
References: <4d34a0a70903200109j66153e9ej4f49b98a9a3d2c85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:56500 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbZDAAOO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Mar 2009 20:14:14 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3453951wff.4
        for <linux-omap@vger.kernel.org>; Tue, 31 Mar 2009 17:14:13 -0700 (PDT)
In-Reply-To: <4d34a0a70903200109j66153e9ej4f49b98a9a3d2c85@mail.gmail.com> (Kim Kyuwon's message of "Fri\, 20 Mar 2009 17\:09\:50 +0900")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kim Kyuwon <chammoru@gmail.com>
Cc: OMAP <linux-omap@vger.kernel.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>

Kim Kyuwon <chammoru@gmail.com> writes:

> If CONFIG_CPU_IDLE is y, omap3_save_scratchpad_contents() is called
> twice at boot time. This patch let it be invoked only once.
>
> Signed-off-by: Kim Kyuwon <q1.kim@samsung.com>

Thanks, pushing to PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |    2 --
>  arch/arm/mach-omap2/pm34xx.c      |    5 ++---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c
> b/arch/arm/mach-omap2/cpuidle34xx.c
> index a5eba31..056fb5f 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -271,8 +271,6 @@ int omap3_idle_init(void)
>  	struct cpuidle_state *state;
>  	struct cpuidle_device *dev;
>
> -	omap3_save_scratchpad_contents();
> -
>  	mpu_pd = pwrdm_lookup("mpu_pwrdm");
>  	core_pd = pwrdm_lookup("core_pwrdm");
>  	per_pd = pwrdm_lookup("per_pwrdm");
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index ff9f28d..001baa9 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -967,6 +967,8 @@ int __init omap3_pm_init(void)
>  #endif /* CONFIG_SUSPEND */
>
>  	pm_idle = omap3_pm_idle;
> +
> +	omap3_save_scratchpad_contents();
>  	omap3_idle_init();
>
>  	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
> @@ -984,10 +986,7 @@ int __init omap3_pm_init(void)
>  		if (!omap3_secure_ram_storage)
>  			printk(KERN_ERR "Memory allocation failed when"
>  					"allocating for secure sram context\n");
> -	}
> -	omap3_save_scratchpad_contents();
>
> -	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
>  		local_irq_disable();
>  		local_fiq_disable();
>
> -- 
> 1.5.2.5
>
>
> -- 
> Kim Kyuwon
