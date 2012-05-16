From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCHv5 3/8] ARM: OMAP4460: Workaround for ROM bug because of
 CA9 r2pX gic control register change
Date: Wed, 16 May 2012 18:01:31 +0530
Message-ID: <4FB39E23.6060706@ti.com>
References: <1336989796-26594-1-git-send-email-t-kristo@ti.com> <1336989796-26594-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:45474 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757231Ab2EPMbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 08:31:39 -0400
Received: by obqv19 with SMTP id v19so1588352obq.22
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 05:31:37 -0700 (PDT)
In-Reply-To: <1336989796-26594-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero,

On Monday 14 May 2012 03:33 PM, Tero Kristo wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> GIC distributor control register has changed between CortexA9 r1pX and
> r2pX. The Control Register secure banked version is now composed of 2
> bits:
>      bit 0 == Secure Enable
>      bit 1 == Non-Secure Enable

[..]

> diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
> index deffbf1..c3eb9e8 100644
> --- a/arch/arm/mach-omap2/omap-smp.c
> +++ b/arch/arm/mach-omap2/omap-smp.c
> @@ -33,6 +33,7 @@
>  
>  /* SCU base address */
>  static void __iomem *scu_base;
> +bool omap4_smp_romcode_errata;
>  
>  static DEFINE_SPINLOCK(boot_lock);
>  
> @@ -104,6 +105,24 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	 *	4.3.4.2 Power States of CPU0 and CPU1
>  	 */
>  	if (booted) {
> +		/*
> +		 * GIC distributor control register has changed between
> +		 * CortexA9 r1pX and r2pX. The Control Register secure
> +		 * banked version is now composed of 2 bits:
> +		 * bit 0 == Secure Enable
> +		 * bit 1 == Non-Secure Enable
> +		 * The Non-Secure banked register has not changed
> +		 * Because the ROM Code is based on the r1pX GIC, the CPU1
> +		 * GIC restoration will cause a problem to CPU0 Non-Secure SW.
> +		 * The workaround must be:
> +		 * 1) Before doing the CPU1 wakeup, CPU0 must disable
> +		 * the GIC distributor
> +		 * 2) CPU1 must re-enable the GIC distributor on
> +		 * it's wakeup path.
> +		 */
> +		if (omap4_smp_romcode_errata)
For safety, disable local IRQ here.
		local_irq_disable();
> +			gic_dist_disable();
> +
And CPU0 needs to wait here till CPU1 re-enables the distributor
to avoid any random issues.

The BUG is applicable for CPUIDLE as well with MPUSS OSWR state, but
we can fix the idle in another patch to avoid dependency.
Basically above 3 lines should also be part of idle code where we
wakeup the CPU1 using force wakeup.

Regards
Santosh
