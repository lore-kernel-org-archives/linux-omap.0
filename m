From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 4/4] OMAP clock/CPUFreq: avoid leaking the CPUFreq frequency table
Date: Wed, 06 Jan 2010 16:06:59 -0800
Message-ID: <87k4vu93rw.fsf@deeprootsystems.com>
References: <20100105173347.15485.42853.stgit@localhost.localdomain>
	<20100105173517.15485.60424.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:52707 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933165Ab0AGAHG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:07:06 -0500
Received: by pzk1 with SMTP id 1so2523003pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 16:07:05 -0800 (PST)
In-Reply-To: <20100105173517.15485.60424.stgit@localhost.localdomain> (Paul Walmsley's message of "Tue\, 05 Jan 2010 10\:35\:19 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Paul Walmsley <paul@pwsan.com> writes:

> OMAP2xxx uses a dynamically-allocated cpufreq_frequency_table array,
> so this patch ensures that it is freed if CPUFreq terminates.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

Minor nit, but shouldn't this be just folded into PATCH 3/4 since you
add the dynamic allocation there?

Kevin


> ---
>  arch/arm/mach-omap2/clock2xxx.c         |    7 +++++++
>  arch/arm/plat-omap/clock.c              |   10 ++++++++++
>  arch/arm/plat-omap/cpu-omap.c           |    1 +
>  arch/arm/plat-omap/include/plat/clock.h |    2 ++
>  4 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
> index 3bfd045..74f5586 100644
> --- a/arch/arm/mach-omap2/clock2xxx.c
> +++ b/arch/arm/mach-omap2/clock2xxx.c
> @@ -515,6 +515,12 @@ void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
>  
>  	*table = &freq_table[0];
>  }
> +
> +void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
> +{
> +	kfree(freq_table);
> +}
> +
>  #endif
>  
>  struct clk_functions omap2_clk_functions = {
> @@ -526,6 +532,7 @@ struct clk_functions omap2_clk_functions = {
>  	.clk_disable_unused	= omap2_clk_disable_unused,
>  #ifdef	CONFIG_CPU_FREQ
>  	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
> +	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
>  #endif
>  };
>  
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index a64d84c..d9f8c84 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -329,6 +329,16 @@ void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
>  		arch_clock->clk_init_cpufreq_table(table);
>  	spin_unlock_irqrestore(&clockfw_lock, flags);
>  }
> +
> +void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clockfw_lock, flags);
> +	if (arch_clock->clk_exit_cpufreq_table)
> +		arch_clock->clk_exit_cpufreq_table(table);
> +	spin_unlock_irqrestore(&clockfw_lock, flags);
> +}
>  #endif
>  
>  /*-------------------------------------------------------------------------*/
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index f8ddbdd..6d3d333 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -134,6 +134,7 @@ static int __init omap_cpu_init(struct cpufreq_policy *policy)
>  
>  static int omap_cpu_exit(struct cpufreq_policy *policy)
>  {
> +	clk_exit_cpufreq_table(&freq_table);
>  	clk_put(mpu_clk);
>  	return 0;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> index 309b6d1..94fe2a0 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -119,6 +119,7 @@ struct clk_functions {
>  	void		(*clk_disable_unused)(struct clk *clk);
>  #ifdef CONFIG_CPU_FREQ
>  	void		(*clk_init_cpufreq_table)(struct cpufreq_frequency_table **);
> +	void		(*clk_exit_cpufreq_table)(struct cpufreq_frequency_table **);
>  #endif
>  };
>  
> @@ -135,6 +136,7 @@ extern unsigned long followparent_recalc(struct clk *clk);
>  extern void clk_enable_init_clocks(void);
>  #ifdef CONFIG_CPU_FREQ
>  extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
> +extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
>  #endif
>  
>  extern const struct clkops clkops_null;
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
