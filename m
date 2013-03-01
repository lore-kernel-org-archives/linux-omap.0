From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 12/15] ARM: OMAP4+: CPUidle: Cleanup idle driver for
 OMAP5 support
Date: Fri, 1 Mar 2013 17:56:58 -0600
Message-ID: <20130301235658.GD23856@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-13-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52462 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab3CAX5E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Mar 2013 18:57:04 -0500
Content-Disposition: inline
In-Reply-To: <1362139864-9233-13-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 17:41-20130301, Santosh Shilimkar wrote:
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
> index 9de47a7..df81243 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
[...]
> @@ -234,11 +237,12 @@ int __init omap4_idle_init(void)
>  	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
>  
>  	for_each_cpu(cpu_id, cpu_online_mask) {
> -		dev = &per_cpu(omap4_idle_dev, cpu_id);
> +		dev = &per_cpu(omap_idle_dev, cpu_id);
>  		dev->cpu = cpu_id;
>  #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>  		dev->coupled_cpus = *cpu_online_mask;
>  #endif
> +		state_ptr = &omap4_idle_data[0];
minor:
why initialize it twice (cpu0 and cpu1) to the same pointer in each of
the for_each_cpu loop? you could move it maybe just before the loop?
>  		cpuidle_register_driver(&omap4_idle_driver);
>  
>  		if (cpuidle_register_device(dev)) {
Otherwise,
Acked-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
