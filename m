From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] Fix cpufreq
Date: Wed, 15 Feb 2012 07:32:07 -0800
Message-ID: <87sjic3yfc.fsf@ti.com>
References: <20120215102420.GA23860@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:49529 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750907Ab2BOPcH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:32:07 -0500
Received: by mail-pw0-f44.google.com with SMTP id wz7so1340819pbc.3
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 07:32:06 -0800 (PST)
In-Reply-To: <20120215102420.GA23860@n2100.arm.linux.org.uk> (Russell King's
	message of "Wed, 15 Feb 2012 10:24:20 +0000")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> OMAPs cpufreq requires the frequency table support, but nothing ensures
> that this is selected.  This can result in configurations which fail to
> build:
>
> drivers/built-in.o:(.data+0x5238): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
> drivers/cpufreq/omap-cpufreq.c:88: undefined reference to `cpufreq_frequency_table_target'
> drivers/cpufreq/omap-cpufreq.c:60: undefined reference to `cpufreq_frequency_table_verify'
> drivers/cpufreq/omap-cpufreq.c:186: undefined reference to `cpufreq_frequency_table_cpuinfo'
> drivers/cpufreq/omap-cpufreq.c:190: undefined reference to `cpufreq_frequency_table_get_attr'
>
> Fix this by introducing a new configuration variable and having that
> select CPU_FREQ_TABLE.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Actually, we don't use cpufreq_table directly anymore in OMAP core code,
and I've removed most of it:

   http://marc.info/?l=linux-omap&m=132796096628835&w=2

but looks like I missed the plat-omap/* stuff.  I'll update that patch.

The OMAP cpufreq driver uses the OPP layer now to fill up the cpufreq
table, but it seems the OPP layer has the same dependency problem: it
depends on CONFIG_CPU_FREQ, but not CONFIG_CPU_FREQ_TABLE.  

I'll send a patch for that as well.

Kevin

> ---
>  arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
>  arch/arm/mach-omap2/clock.c                  |    2 +-
>  arch/arm/mach-omap2/clock.h                  |    2 +-
>  arch/arm/plat-omap/clock.c                   |    2 +-
>  arch/arm/plat-omap/include/plat/clock.h      |    4 ++--
>  drivers/cpufreq/Kconfig.arm                  |    5 +++++
>  drivers/cpufreq/Makefile                     |    2 +-
>  7 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> index 39f9d5a..4705b50 100644
> --- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> +++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> @@ -165,7 +165,7 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_CPU_FREQ
> +#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
>  /*
>   * Walk PRCM rate table and fillout cpufreq freq_table
>   * XXX This should be replaced by an OPP layer in the near future
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index f57ed5b..450feb0 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -536,7 +536,7 @@ struct clk_functions omap2_clk_functions = {
>  	.clk_set_rate		= omap2_clk_set_rate,
>  	.clk_set_parent		= omap2_clk_set_parent,
>  	.clk_disable_unused	= omap2_clk_disable_unused,
> -#ifdef CONFIG_CPU_FREQ
> +#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
>  	/* These will be removed when the OPP code is integrated */
>  	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
>  	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
> index b8c2a68..f331cfc 100644
> --- a/arch/arm/mach-omap2/clock.h
> +++ b/arch/arm/mach-omap2/clock.h
> @@ -146,7 +146,7 @@ extern const struct clksel_rate gpt_sys_rates[];
>  extern const struct clksel_rate gfx_l3_rates[];
>  extern const struct clksel_rate dsp_ick_rates[];
>  
> -#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_CPU_FREQ)
> +#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_ARM_OMAP2PLUS_CPUFREQ)
>  extern void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
>  extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
>  #else
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 567e4b5..2e2efb6 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -399,7 +399,7 @@ struct clk dummy_ck = {
>  	.ops	= &clkops_null,
>  };
>  
> -#ifdef CONFIG_CPU_FREQ
> +#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
>  void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
>  {
>  	unsigned long flags;
> diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
> index 240a7b9..879ba27 100644
> --- a/arch/arm/plat-omap/include/plat/clock.h
> +++ b/arch/arm/plat-omap/include/plat/clock.h
> @@ -283,7 +283,7 @@ struct clk_functions {
>  	void		(*clk_allow_idle)(struct clk *clk);
>  	void		(*clk_deny_idle)(struct clk *clk);
>  	void		(*clk_disable_unused)(struct clk *clk);
> -#ifdef CONFIG_CPU_FREQ
> +#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
>  	void		(*clk_init_cpufreq_table)(struct cpufreq_frequency_table **);
>  	void		(*clk_exit_cpufreq_table)(struct cpufreq_frequency_table **);
>  #endif
> @@ -301,7 +301,7 @@ extern void recalculate_root_clocks(void);
>  extern unsigned long followparent_recalc(struct clk *clk);
>  extern void clk_enable_init_clocks(void);
>  unsigned long omap_fixed_divisor_recalc(struct clk *clk);
> -#ifdef CONFIG_CPU_FREQ
> +#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
>  extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
>  extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
>  #endif
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c8bde43..74e8b55 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -2,6 +2,11 @@
>  # ARM CPU Frequency scaling drivers
>  #
>  
> +config ARM_OMAP2PLUS_CPUFREQ
> +	bool
> +	depends on ARCH_OMAP2PLUS
> +	select CPU_FREQ_TABLE
> +
>  config ARM_S3C64XX_CPUFREQ
>  	bool "Samsung S3C64XX"
>  	depends on CPU_S3C6410
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index ac000fa..fda94c7 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -44,7 +44,7 @@ obj-$(CONFIG_ARM_S3C64XX_CPUFREQ)	+= s3c64xx-cpufreq.o
>  obj-$(CONFIG_ARM_S5PV210_CPUFREQ)	+= s5pv210-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS_CPUFREQ)	+= exynos-cpufreq.o
>  obj-$(CONFIG_ARM_EXYNOS4210_CPUFREQ)	+= exynos4210-cpufreq.o
> -obj-$(CONFIG_ARCH_OMAP2PLUS)            += omap-cpufreq.o
> +obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)     += omap-cpufreq.o
>  
>  ##################################################################################
>  # PowerPC platform drivers
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
