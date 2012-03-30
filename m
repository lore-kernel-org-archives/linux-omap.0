From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] cpufreq: OMAP: fix build errors: depends on ARCH_OMAP2PLUS
Date: Fri, 30 Mar 2012 07:24:18 -0700
Message-ID: <87limif9pp.fsf@ti.com>
References: <1332807568-638-1-git-send-email-khilman@ti.com>
	<20120330131200.GA23442@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:45597 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759558Ab2C3OYU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 10:24:20 -0400
Received: by ghbz12 with SMTP id z12so480921ghb.39
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 07:24:19 -0700 (PDT)
In-Reply-To: <20120330131200.GA23442@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri, 30 Mar 2012 14:12:00 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>
Cc: Dave Jones <davej@redhat.com>, cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Mon, Mar 26, 2012 at 05:19:28PM -0700, Kevin Hilman wrote:
>> The OMAP driver needs a 'depends on ARCH_OMAP2PLUS' since it only
>> builds for OMAP2+ platforms.
>> 
>> This 'depends on' was in the original patch from Russell King, but was
>> erroneously removed by me when making this option user-selectable in
>> commit b09db45c (cpufreq: OMAP driver depends CPUfreq tables.)  This
>> patch remedies that.
>> 
>> Apologies to Russell King for breaking his originally working patch.
>> 
>> Also, thanks to Grazvydas Ignotas for reporting the same problem.
>> 
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Grazvydas Ignotas <notasas@gmail.com>
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>> ---
>> Dave, this applies on top of your current fixes branch, and fixes a 
>> problem introduced there by me.  Please merge for v3.4-rc.  Thanks.
>
> Can you please check that you've picked up everything that's necessary,
> as I'm still seeing the below as outstanding from my original patch.

Yes, all the code you touch below is now removed, and queued by Paul,
but unfortunately, that branch didn't make it in time for v3.4. :(

Paul, maybe you can pull out my "cleanup cpufreq leftovers" patch and
submit for v3.4-rc?

Thanks,

Kevin

>
> commit e55a42528cebb8fa7408dc95abb3859639a46750
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Wed Feb 15 11:20:51 2012 +0000
>
>     ARM: OMAP: fix cpufreq build
>     
>     OMAPs cpufreq requires the frequency table support, but nothing ensures
>     that this is selected.  This can result in configurations which fail to
>     build:
>     
>     drivers/built-in.o:(.data+0x5238): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
>     drivers/cpufreq/omap-cpufreq.c:88: undefined reference to `cpufreq_frequency_table_target'
>     drivers/cpufreq/omap-cpufreq.c:60: undefined reference to `cpufreq_frequency_table_verify'
>     drivers/cpufreq/omap-cpufreq.c:186: undefined reference to `cpufreq_frequency_table_cpuinfo'
>     drivers/cpufreq/omap-cpufreq.c:190: undefined reference to `cpufreq_frequency_table_get_attr'
>     
>     Fix this by introducing a new configuration variable and having that
>     select CPU_FREQ_TABLE.
>     
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>
> diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> index 7072e0d..ad35d4e 100644
> --- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> +++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
> @@ -166,7 +166,7 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
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
> index 56b6f8b..618cf80 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -398,7 +398,7 @@ struct clk dummy_ck = {
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
> index 32d790d..587b578 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -3,8 +3,8 @@
>  #
>  
>  config ARM_OMAP2PLUS_CPUFREQ
> -	bool "TI OMAP2+"
> -	default ARCH_OMAP2PLUS
> +	def_bool y
> +	depends on ARCH_OMAP2PLUS
>  	select CPU_FREQ_TABLE
>  
>  config ARM_S3C2416_CPUFREQ
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
