From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCH v2 4/5] ARM: kernel: update __cpu_disable to use
 cache LoUIS maintenance API
Date: Tue, 18 Sep 2012 14:19:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1209181419010.28681@xanadu.home>
References: <1347986135-17979-1-git-send-email-lorenzo.pieralisi@arm.com> <1347986135-17979-5-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64198 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab2IRSTX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Sep 2012 14:19:23 -0400
Received: by qcro28 with SMTP id o28so123590qcr.19
        for <linux-omap@vger.kernel.org>; Tue, 18 Sep 2012 11:19:22 -0700 (PDT)
In-Reply-To: <1347986135-17979-5-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, Colin Cross <ccross@android.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Dave Martin <dave.martin@linaro.org>, Wenzeng Chen <wzch@marvell.com>

On Tue, 18 Sep 2012, Lorenzo Pieralisi wrote:

> When a CPU is hotplugged out caches that reside in its power domain
> lose their contents and so must be cleaned to the next memory level.
> 
> Currently, __cpu_disable calls flush_cache_all() that for new generation
> processor like A15/A7 ends up cleaning and invalidating all cache levels
> up to Level of Coherency, which includes the unified L2.
> 
> This ends up being a waste of cycles since the L2 cache contents are not
> lost on power down.
> 
> This patch updates __cpu_disable to use the new LoUIS API cache operations.
> 
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/kernel/smp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index d3eb222..f44e9cd 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -136,8 +136,11 @@ int __cpu_disable(void)
>  	/*
>  	 * Flush user cache and TLB mappings, and then remove this CPU
>  	 * from the vm mask set of all processes.
> +	 *
> +	 * Caches are flushed to the Level of Unification Inner Shareable
> +	 * to write-back dirty lines to unified caches shared by all CPUs.
>  	 */
> -	flush_cache_all();
> +	flush_cache_louis();
>  	local_flush_tlb_all();
>  
>  	clear_tasks_mm_cpumask(cpu);
> -- 
> 1.7.12
> 
> 
