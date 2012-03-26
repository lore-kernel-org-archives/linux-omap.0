From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 6/6] ARM: OMAP: fix cpufreq build
Date: Mon, 26 Mar 2012 09:32:56 +0100
Message-ID: <20120326083256.GC22608@n2100.arm.linux.org.uk>
References: <20120315102845.GB16389@n2100.arm.linux.org.uk> <E1S87xU-0000N8-6u@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1S87xU-0000N8-6u@rmk-PC.arm.linux.org.uk>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Kevin,

I only just found this via the arm-soc tree, while trying to merge the
kautobuildv2 build tree.

You changed my patch and broke it:

config ARM_OMAP2PLUS_CPUFREQ
        bool "TI OMAP2+"
        default ARCH_OMAP2PLUS
        select CPU_FREQ_TABLE

So now, OMAP2 CPUFREQ is selectable on ANYTHING but it will only build
successfully on OMAP.

If you're going to change someone elses patch, do them the favour of
re-posting it back to them for comment *BEFORE* you commit it and send
it upstream, rather than making it look like they're a total tosser for
authoring a patch which fucks up other architecture builds.

Many thanks for that.

On Thu, Mar 15, 2012 at 10:31:00AM +0000, Russell King wrote:
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
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
