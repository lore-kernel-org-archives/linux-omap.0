From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 2/3] omap: cpufreq: Split omap1 and omap2plus cpufreq drivers.
Date: Fri, 25 Feb 2011 12:47:17 +0530
Message-ID: <a5de4c2875426c022dd85547c8aff31b@mail.gmail.com>
References: <1298614239-32196-1-git-send-email-santosh.shilimkar@ti.com> <1298614239-32196-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:37818 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753462Ab1BYHRU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 02:17:20 -0500
Received: by eye13 with SMTP id 13so559410eye.31
        for <linux-omap@vger.kernel.org>; Thu, 24 Feb 2011 23:17:18 -0800 (PST)
In-Reply-To: <1298614239-32196-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>

> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Friday, February 25, 2011 11:41 AM
> To: linux-omap@vger.kernel.org
> Cc: khilman@ti.com; vishwanath.bs@ti.com; Santosh Shilimkar
> Subject: [PATCH 2/3] omap: cpufreq: Split omap1 and omap2plus
> cpufreq drivers.
>
> This patch is an attempt to cleanup the #ifdeferry in the
> omap cpufreq drivers.
>
> The split betwenn omap1 and omap2plus is logical because
> 	- omap1 doesn't support opp layer.
> 	- omap1 build is seperate from omap2plus.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Vishwanath BS <vishwanath.bs@ti.com>
> ---
>  arch/arm/mach-omap1/Makefile                       |    3 +
>  .../cpu-omap.c => mach-omap1/omap1-cpufreq.c}      |   70 +++++---
> --------
>  arch/arm/mach-omap2/Makefile                       |    3 +
>  .../cpu-omap.c => mach-omap2/omap2plus-cpufreq.c}  |   87
> +++++++++-----------
>  arch/arm/plat-omap/Makefile                        |    1 -
>  5 files changed, 67 insertions(+), 97 deletions(-)
>  copy arch/arm/{plat-omap/cpu-omap.c => mach-omap1/omap1-
> cpufreq.c} (74%)
>  rename arch/arm/{plat-omap/cpu-omap.c => mach-omap2/omap2plus-
> cpufreq.c} (76%)
>
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-
> omap1/Makefile
> index 6ee1950..02b80f5 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -11,6 +11,9 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
>  obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
>
> +# CPUFREQ driver
> +obj-$(CONFIG_CPU_FREQ) += omap1-cpufreq.o
> +
>  # Power Management
>  obj-$(CONFIG_PM) += pm.o sleep.o pm_bus.o
>
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/mach-
> omap1/omap1-cpufreq.c
> similarity index 74%
> copy from arch/arm/plat-omap/cpu-omap.c
> copy to arch/arm/mach-omap1/omap1-cpufreq.c
> index 1c1b80b..64faf3f 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/mach-omap1/omap1-cpufreq.c
> @@ -1,5 +1,5 @@
>  /*
> - *  linux/arch/arm/plat-omap/cpu-omap.c
> + *  OMAP1 cpufreq driver
>   *
>   *  CPU frequency scaling for OMAP
>   *
> @@ -27,31 +27,18 @@
>  #include <linux/io.h>
>  #include <linux/opp.h>
>
> -#include <mach/hardware.h>
> -#include <plat/clock.h>
>  #include <asm/system.h>
>
> -#if defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> +#include <plat/clock.h>
>  #include <plat/omap-pm.h>
> -#include <plat/common.h>
> -#endif
> +
> +#include <mach/hardware.h>
>
>  #define VERY_HI_RATE	900000000
>
>  static struct cpufreq_frequency_table *freq_table;
> -
> -#ifdef CONFIG_ARCH_OMAP1
> -#define MPU_CLK		"mpu"
> -#elif defined(CONFIG_ARCH_OMAP3)
> -#define MPU_CLK		"arm_fck"
> -#else
> -#define MPU_CLK		"virt_prcm_set"
> -#endif
> -
>  static struct clk *mpu_clk;
>
> -/* TODO: Add support for SDRAM timing changes */
> -
>  static int omap_verify_speed(struct cpufreq_policy *policy)
>  {
>  	if (freq_table)
> @@ -85,13 +72,7 @@ static int omap_target(struct cpufreq_policy
> *policy,
>  		       unsigned int target_freq,
>  		       unsigned int relation)
>  {
> -#ifdef CONFIG_ARCH_OMAP1
>  	struct cpufreq_freqs freqs;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> -	unsigned long freq;
> -	struct device *mpu_dev = omap2_get_mpuss_device();
> -#endif
>  	int ret = 0;
>
>  	/* Ensure desired rate is within allowed range.  Some govenors
> @@ -101,25 +82,22 @@ static int omap_target(struct cpufreq_policy
> *policy,
>  	if (target_freq > policy->max)
>  		target_freq = policy->max;
>
> -#ifdef CONFIG_ARCH_OMAP1
>  	freqs.old = omap_getspeed(0);
>  	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
>  	freqs.cpu = 0;
>
>  	if (freqs.old == freqs.new)
>  		return ret;
> +
>  	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
>  #ifdef CONFIG_CPU_FREQ_DEBUG
> -	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
> -	       freqs.old, freqs.new);
> +	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old,
> freqs.new);
>  #endif
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
> -	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -#elif defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> -	freq = target_freq * 1000;
> -	if (opp_find_freq_ceil(mpu_dev, &freq))
> -		omap_pm_cpu_set_freq(freq);
> -#endif
> +	if (!ret)
> +		cpufreq_notify_transition(&freqs,
> CPUFREQ_POSTCHANGE);
> +
>  	return ret;
>  }
>
> @@ -127,7 +105,7 @@ static int __init omap_cpu_init(struct
> cpufreq_policy *policy)
>  {
>  	int result = 0;
>
> -	mpu_clk = clk_get(NULL, MPU_CLK);
> +	mpu_clk = clk_get(NULL, "mpu");
>  	if (IS_ERR(mpu_clk))
>  		return PTR_ERR(mpu_clk);
>
> @@ -136,13 +114,7 @@ static int __init omap_cpu_init(struct
> cpufreq_policy *policy)
>
>  	policy->cur = policy->min = policy->max = omap_getspeed(0);
>
> -	if (!cpu_is_omap34xx()) {
> -		clk_init_cpufreq_table(&freq_table);
> -	} else {
> -		struct device *mpu_dev = omap2_get_mpuss_device();
> -
> -		opp_init_cpufreq_table(mpu_dev, &freq_table);
> -	}
> +	clk_init_cpufreq_table(&freq_table);
>
>  	if (freq_table) {
>  		result = cpufreq_frequency_table_cpuinfo(policy,
> freq_table);
> @@ -184,7 +156,7 @@ static struct cpufreq_driver omap_driver = {
>  	.get		= omap_getspeed,
>  	.init		= omap_cpu_init,
>  	.exit		= omap_cpu_exit,
> -	.name		= "omap",
> +	.name		= "omap1",
>  	.attr		= omap_cpufreq_attr,
>  };
>
> @@ -193,12 +165,12 @@ static int __init omap_cpufreq_init(void)
>  	return cpufreq_register_driver(&omap_driver);
>  }
>
> -late_initcall(omap_cpufreq_init);
> -
> -/*
> - * if ever we want to remove this, upon cleanup call:
> - *
> - * cpufreq_unregister_driver()
> - * cpufreq_frequency_table_put_attr()
> - */
> +static void __exit omap_cpufreq_exit(void)
> +{
> +	cpufreq_unregister_driver(&omap_driver);
> +}
>
> +MODULE_DESCRIPTION("cpufreq driver for OMAP1 SOCs");
> +MODULE_LICENSE("GPL");
> +module_init(omap_cpufreq_init);
> +module_exit(omap_cpufreq_exit);
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-
> omap2/Makefile
> index 1c0c2b0..b1187f9 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -56,6 +56,9 @@ obj-$(CONFIG_ARCH_OMAP3)		+=
> opp3xxx_data.o
>  obj-$(CONFIG_ARCH_OMAP4)		+= opp4xxx_data.o
>  endif
>
> +# CPUFREQ driver
> +obj-$(CONFIG_CPU_FREQ)			+= omap2plus-cpufreq.o
> +
>  # Power Management
>  ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/mach-
> omap2/omap2plus-cpufreq.c
> similarity index 76%
> rename from arch/arm/plat-omap/cpu-omap.c
> rename to arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 1c1b80b..48da867 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -1,5 +1,5 @@
>  /*
> - *  linux/arch/arm/plat-omap/cpu-omap.c
> + *  OMAP2PLUS cpufreq driver
>   *
>   *  CPU frequency scaling for OMAP
>   *
> @@ -27,31 +27,20 @@
>  #include <linux/io.h>
>  #include <linux/opp.h>
>
> -#include <mach/hardware.h>
> -#include <plat/clock.h>
>  #include <asm/system.h>
> +#include <asm/smp_plat.h>
>
> -#if defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> +#include <plat/clock.h>
>  #include <plat/omap-pm.h>
>  #include <plat/common.h>
> -#endif
> +
> +#include <mach/hardware.h>
>
>  #define VERY_HI_RATE	900000000
>
>  static struct cpufreq_frequency_table *freq_table;
> -
> -#ifdef CONFIG_ARCH_OMAP1
> -#define MPU_CLK		"mpu"
> -#elif defined(CONFIG_ARCH_OMAP3)
> -#define MPU_CLK		"arm_fck"
> -#else
> -#define MPU_CLK		"virt_prcm_set"
> -#endif
> -
>  static struct clk *mpu_clk;
>
> -/* TODO: Add support for SDRAM timing changes */
> -
>  static int omap_verify_speed(struct cpufreq_policy *policy)
>  {
>  	if (freq_table)
> @@ -85,14 +74,8 @@ static int omap_target(struct cpufreq_policy
> *policy,
>  		       unsigned int target_freq,
>  		       unsigned int relation)
>  {
> -#ifdef CONFIG_ARCH_OMAP1
> -	struct cpufreq_freqs freqs;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> -	unsigned long freq;
> -	struct device *mpu_dev = omap2_get_mpuss_device();
> -#endif
>  	int ret = 0;
> +	struct cpufreq_freqs freqs;
>
>  	/* Ensure desired rate is within allowed range.  Some govenors
>  	 * (ondemand) will just pass target_freq=0 to get the minimum.
> */
> @@ -101,33 +84,44 @@ static int omap_target(struct cpufreq_policy
> *policy,
>  	if (target_freq > policy->max)
>  		target_freq = policy->max;
>
> -#ifdef CONFIG_ARCH_OMAP1
>  	freqs.old = omap_getspeed(0);
>  	freqs.new = clk_round_rate(mpu_clk, target_freq * 1000) / 1000;
>  	freqs.cpu = 0;
>
>  	if (freqs.old == freqs.new)
>  		return ret;
> +
>  	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> +
>  #ifdef CONFIG_CPU_FREQ_DEBUG
> -	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
> -	       freqs.old, freqs.new);
> +	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old,
> freqs.new);
>  #endif
> +
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
> +	if (ret)
> +		return ret;
Do you want to return here w/o calling post notifiers and readjusting the
jiffies? Cpufreq updates lpj as part of PRECHANGE notifier when frequency
is scaled up. So in that case returning here will end of having wrong lpj
I suppose.

Vishwa
> +
> +	/*
> +	 * Generic CPUFREQ driver jiffy update is under !SMP. So jiffies
> +	 * won't get updated when UP machine cpufreq build with
> +	 * CONFIG_SMP enabled. Below code is added only to manage
> that
> +	 * scenario
> +	 */
> +	if (!is_smp())
> +		loops_per_jiffy =
> +			 cpufreq_scale(loops_per_jiffy, freqs.old,
> freqs.new);
> +
>  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -#elif defined(CONFIG_ARCH_OMAP3) &&
> !defined(CONFIG_OMAP_PM_NONE)
> -	freq = target_freq * 1000;
> -	if (opp_find_freq_ceil(mpu_dev, &freq))
> -		omap_pm_cpu_set_freq(freq);
> -#endif
> +
>  	return ret;
>  }
>
>  static int __init omap_cpu_init(struct cpufreq_policy *policy)
>  {
>  	int result = 0;
> +	struct device *mpu_dev;
>
> -	mpu_clk = clk_get(NULL, MPU_CLK);
> +	mpu_clk = clk_get(NULL, "cpu_ck");
>  	if (IS_ERR(mpu_clk))
>  		return PTR_ERR(mpu_clk);
>
> @@ -136,13 +130,12 @@ static int __init omap_cpu_init(struct
> cpufreq_policy *policy)
>
>  	policy->cur = policy->min = policy->max = omap_getspeed(0);
>
> -	if (!cpu_is_omap34xx()) {
> -		clk_init_cpufreq_table(&freq_table);
> -	} else {
> -		struct device *mpu_dev = omap2_get_mpuss_device();
> -
> -		opp_init_cpufreq_table(mpu_dev, &freq_table);
> +	mpu_dev = omap2_get_mpuss_device();
> +	if (!mpu_dev) {
> +		pr_warning("%s: unable to get the mpu device\n",
> __func__);
> +		return -EINVAL;
>  	}
> +	opp_init_cpufreq_table(mpu_dev, &freq_table);
>
>  	if (freq_table) {
>  		result = cpufreq_frequency_table_cpuinfo(policy,
> freq_table);
> @@ -184,7 +177,7 @@ static struct cpufreq_driver omap_driver = {
>  	.get		= omap_getspeed,
>  	.init		= omap_cpu_init,
>  	.exit		= omap_cpu_exit,
> -	.name		= "omap",
> +	.name		= "omap2plus",
>  	.attr		= omap_cpufreq_attr,
>  };
>
> @@ -193,12 +186,12 @@ static int __init omap_cpufreq_init(void)
>  	return cpufreq_register_driver(&omap_driver);
>  }
>
> -late_initcall(omap_cpufreq_init);
> -
> -/*
> - * if ever we want to remove this, upon cleanup call:
> - *
> - * cpufreq_unregister_driver()
> - * cpufreq_frequency_table_put_attr()
> - */
> +static void __exit omap_cpufreq_exit(void)
> +{
> +	cpufreq_unregister_driver(&omap_driver);
> +}
>
> +MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
> +MODULE_LICENSE("GPL");
> +module_init(omap_cpufreq_init);
> +module_exit(omap_cpufreq_exit);
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index a4a1285..ec7862e 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -21,7 +21,6 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
>  obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
>  obj-$(CONFIG_OMAP_IOMMU_DEBUG) += iommu-debug.o
>
> -obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
>  obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
>  obj-$(CONFIG_OMAP_DEBUG_DEVICES) += debug-devices.o
>  obj-$(CONFIG_OMAP_DEBUG_LEDS) += debug-leds.o
> --
> 1.6.0.4
