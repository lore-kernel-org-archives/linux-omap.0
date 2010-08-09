From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP PM: MPU/DMA Latency constraints
Date: Mon, 9 Aug 2010 10:17:20 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608703062880DC@dbde02.ent.ti.com>
References: <1279874209-7944-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58194 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781Ab0HIEr0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Aug 2010 00:47:26 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o794lNL1013653
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 8 Aug 2010 23:47:25 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o794lM5b027838
	for <linux-omap@vger.kernel.org>; Mon, 9 Aug 2010 10:17:22 +0530 (IST)
In-Reply-To: <1279874209-7944-1-git-send-email-vishwanath.bs@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
Any comments on this patch?

Thanks
Vishwa

> -----Original Message-----
> From: Sripathy, Vishwanath
> Sent: Friday, July 23, 2010 2:07 PM
> To: linux-omap@vger.kernel.org
> Cc: Sripathy, Vishwanath
> Subject: [PATCH] OMAP PM: MPU/DMA Latency constraints
>
> This patch has implementation for OMAP MPU/DMA Latency constraints using PM QOS.
>
> Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com>
> ---
>  arch/arm/plat-omap/Kconfig                |    3 +
>  arch/arm/plat-omap/Makefile               |    1 +
>  arch/arm/plat-omap/i2c.c                  |    3 +-
>  arch/arm/plat-omap/include/plat/omap-pm.h |    9 +-
>  arch/arm/plat-omap/omap-pm-noop.c         |   20 +--
>  arch/arm/plat-omap/omap-pm.c              |  309
> +++++++++++++++++++++++++++++
>  6 files changed, 328 insertions(+), 17 deletions(-)
>  create mode 100755 arch/arm/plat-omap/omap-pm.c
>
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 286b606..ce544b0 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -194,6 +194,9 @@ config OMAP_PM_NONE
>  config OMAP_PM_NOOP
>       bool "No-op/debug PM layer"
>
> +config OMAP_PM
> +     depends on PM
> +     bool "OMAP PM layer implementation"
>  endchoice
>
>  endmenu
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 2a15191..fad2475 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -32,3 +32,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
>
>  obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> +obj-$(CONFIG_OMAP_PM) += omap-pm.o
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index a5ce4f0..29dc45a
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -145,7 +145,8 @@ static inline int omap1_i2c_add_bus(struct platform_device
> *pdev, int bus_id)
>   */
>  static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device *dev, long t)
>  {
> -     omap_pm_set_max_mpu_wakeup_lat(dev, t);
> +     struct pm_qos_request_list *qos_handle = NULL;
> +     omap_pm_set_max_mpu_wakeup_lat(&qos_handle, t);
>  }
>
>  static inline int omap2_i2c_add_bus(struct platform_device *pdev, int bus_id)
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-
> omap/include/plat/omap-pm.h
> index 728fbb9..47ba9e6 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -19,6 +19,7 @@
>  #include <linux/clk.h>
>
>  #include "powerdomain.h"
> +#include <linux/pm_qos_params.h>
>
>  /**
>   * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
> @@ -86,7 +87,7 @@ void omap_pm_if_exit(void);
>
>  /**
>   * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup latency
> - * @dev: struct device * requesting the constraint
> + * @qos_request: handle for the constraint. The pointer should be initialized to NULL
>   * @t: maximum MPU wakeup latency in microseconds
>   *
>   * Request that the maximum interrupt latency for the MPU to be no
> @@ -118,7 +119,7 @@ void omap_pm_if_exit(void);
>   * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
>   * is not satisfiable, or 0 upon success.
>   */
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
> +int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list
> **qos_request, long t);
>
>
>  /**
> @@ -185,7 +186,7 @@ int omap_pm_set_max_dev_wakeup_lat(struct device
> *req_dev, struct device *dev,
>
>  /**
>   * omap_pm_set_max_sdma_lat - set the maximum system DMA transfer start
> latency
> - * @dev: struct device *
> + * @qos_request: handle for the constraint. The pointer should be initialized to NULL
>   * @t: maximum DMA transfer start latency in microseconds
>   *
>   * Request that the maximum system DMA transfer start latency for this
> @@ -210,7 +211,7 @@ int omap_pm_set_max_dev_wakeup_lat(struct device
> *req_dev, struct device *dev,
>   * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
>   * is not satisfiable, or 0 upon success.
>   */
> -int omap_pm_set_max_sdma_lat(struct device *dev, long t);
> +int omap_pm_set_max_sdma_lat(struct pm_qos_request_list **qos_request, long
> t);
>
>
>  /**
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-
> noop.c
> index e129ce8..af2fe43 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -34,19 +34,17 @@ struct omap_opp *l3_opps;
>   * Device-driver-originated constraints (via board-*.c files)
>   */
>
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> +int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list **pmqos_req,
> long t)
>  {
> -     if (!dev || t < -1) {
> +     if (!pmqos_req || t < -1) {
>               WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
>               return -EINVAL;
>       };
>
>       if (t == -1)
> -             pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
> -                      "dev %s\n", dev_name(dev));
> +             pr_debug("OMAP PM: remove max MPU wakeup latency constraint\n");
>       else
> -             pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
> -                      "dev %s, t = %ld usec\n", dev_name(dev), t);
> +             pr_debug("OMAP PM: add max MPU wakeup latency constraint: t = %ld
> usec\n", t);
>
>       /*
>        * For current Linux, this needs to map the MPU to a
> @@ -120,19 +118,17 @@ int omap_pm_set_max_dev_wakeup_lat(struct device
> *req_dev, struct device *dev,
>       return 0;
>  }
>
> -int omap_pm_set_max_sdma_lat(struct device *dev, long t)
> +int omap_pm_set_max_sdma_lat(struct pm_qos_request_list **qos_request, long t)
>  {
> -     if (!dev || t < -1) {
> +     if (!qos_request || t < -1) {
>               WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
>               return -EINVAL;
>       };
>
>       if (t == -1)
> -             pr_debug("OMAP PM: remove max DMA latency constraint: "
> -                      "dev %s\n", dev_name(dev));
> +             pr_debug("OMAP PM: remove max DMA latency constraint:\n");
>       else
> -             pr_debug("OMAP PM: add max DMA latency constraint: "
> -                      "dev %s, t = %ld usec\n", dev_name(dev), t);
> +             pr_debug("OMAP PM: add max DMA latency constraint: t = %ld
> usec\n", t);
>
>       /*
>        * For current Linux PM QOS params, this code should scan the
> diff --git a/arch/arm/plat-omap/omap-pm.c b/arch/arm/plat-omap/omap-pm.c
> new file mode 100755
> index 0000000..937196a
> --- /dev/null
> +++ b/arch/arm/plat-omap/omap-pm.c
> @@ -0,0 +1,309 @@
> +/*
> + * omap-pm.c - OMAP power management interface
> + *
> + * Copyright (C) 2008-2010 Texas Instruments, Inc.
> + * Copyright (C) 2008-2009 Nokia Corporation
> + * Vishwanath BS
> + *
> + * This code is based on plat-omap/omap-pm-noop.c.
> + *
> + * Interface developed by (in alphabetical order):
> + * Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa, Veeramanikandan
> + * Raju, Anand Sawant, Igor Stoppa, Paul Walmsley, Richard Woodruff
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/init.h>
> +#include <linux/cpufreq.h>
> +#include <linux/device.h>
> +
> +/* Interface documentation is in mach/omap-pm.h */
> +#include <plat/omap-pm.h>
> +
> +#include <plat/powerdomain.h>
> +
> +struct omap_opp *dsp_opps;
> +struct omap_opp *mpu_opps;
> +struct omap_opp *l3_opps;
> +
> +/*
> + * Device-driver-originated constraints (via board-*.c files)
> + */
> +
> +int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list
> **qos_request, long t)
> +{
> +     if (!qos_request || t < -1) {
> +             pr_warning("Warning: invalid params to
> omap_pm_set_max_mpu_wakeup_lat \n:");
> +             return -EINVAL;
> +     };
> +
> +     if (t == -1) {
> +             pm_qos_remove_request(*qos_request);
> +             *qos_request = NULL;
> +     } else if (*qos_request == NULL)
> +             *qos_request = pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY,
> t);
> +     else
> +             pm_qos_update_request(*qos_request, t);
> +
> +     return 0;
> +}
> +
> +
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
> +{
> +     if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
> +         agent_id != OCP_TARGET_AGENT)) {
> +             WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
> +             return -EINVAL;
> +     };
> +
> +     if (r == 0)
> +             pr_debug("OMAP PM: remove min bus tput constraint: "
> +                      "dev %s for agent_id %d\n", dev_name(dev), agent_id);
> +     else
> +             pr_debug("OMAP PM: add min bus tput constraint: "
> +                      "dev %s for agent_id %d: rate %ld KiB\n",
> +                      dev_name(dev), agent_id, r);
> +
> +     /*
> +      * This code should model the interconnect and compute the
> +      * required clock frequency, convert that to a VDD2 OPP ID, then
> +      * set the VDD2 OPP appropriately.
> +      *
> +      * TI CDP code can call constraint_set here on the VDD2 OPP.
> +      */
> +
> +     return 0;
> +}
> +
> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
> +                                long t)
> +{
> +     if (!req_dev || !dev || t < -1) {
> +             WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
> +             return -EINVAL;
> +     };
> +
> +     if (t == -1)
> +             pr_debug("OMAP PM: remove max device latency constraint: "
> +                      "dev %s\n", dev_name(dev));
> +     else
> +             pr_debug("OMAP PM: add max device latency constraint: "
> +                      "dev %s, t = %ld usec\n", dev_name(dev), t);
> +
> +     /*
> +      * For current Linux, this needs to map the device to a
> +      * powerdomain, then go through the list of current max lat
> +      * constraints on that powerdomain and find the smallest.  If
> +      * the latency constraint has changed, the code should
> +      * recompute the state to enter for the next powerdomain
> +      * state.  Conceivably, this code should also determine
> +      * whether to actually disable the device clocks or not,
> +      * depending on how long it takes to re-enable the clocks.
> +      *
> +      * TI CDP code can call constraint_set here.
> +      */
> +
> +     return 0;
> +}
> +
> +int omap_pm_set_max_sdma_lat(struct pm_qos_request_list **qos_request, long t)
> +{
> +     if (!qos_request || t < -1) {
> +             pr_warning("Warning: invalid params to
> omap_pm_set_max_sdma_lat\n:");
> +             return -EINVAL;
> +     };
> +
> +     if (t == -1) {
> +             pm_qos_remove_request(*qos_request);
> +             *qos_request = NULL;
> +     } else if (*qos_request == NULL)
> +             *qos_request = pm_qos_add_request(PM_QOS_CPU_DMA_LATENCY,
> t);
> +     else
> +             pm_qos_update_request(*qos_request, t);
> +
> +     return 0;
> +}
> +
> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
> +{
> +     if (!dev || !c || r < 0) {
> +             WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
> +             return -EINVAL;
> +     }
> +
> +     if (r == 0)
> +             pr_debug("OMAP PM: remove min clk rate constraint: "
> +                      "dev %s\n", dev_name(dev));
> +     else
> +             pr_debug("OMAP PM: add min clk rate constraint: "
> +                      "dev %s, rate = %ld Hz\n", dev_name(dev), r);
> +
> +     /*
> +      * Code in a real implementation should keep track of these
> +      * constraints on the clock, and determine the highest minimum
> +      * clock rate.  It should iterate over each OPP and determine
> +      * whether the OPP will result in a clock rate that would
> +      * satisfy this constraint (and any other PM constraint in effect
> +      * at that time).  Once it finds the lowest-voltage OPP that
> +      * meets those conditions, it should switch to it, or return
> +      * an error if the code is not capable of doing so.
> +      */
> +
> +     return 0;
> +}
> +
> +/*
> + * DSP Bridge-specific constraints
> + */
> +
> +const struct omap_opp *omap_pm_dsp_get_opp_table(void)
> +{
> +     pr_debug("OMAP PM: DSP request for OPP table\n");
> +
> +     /*
> +      * Return DSP frequency table here:  The final item in the
> +      * array should have .rate = .opp_id = 0.
> +      */
> +
> +     return NULL;
> +}
> +
> +void omap_pm_dsp_set_min_opp(u8 opp_id)
> +{
> +     if (opp_id == 0) {
> +             WARN_ON(1);
> +             return;
> +     }
> +
> +     pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be %d\n", opp_id);
> +
> +     /*
> +      *
> +      * For l-o dev tree, our VDD1 clk is keyed on OPP ID, so we
> +      * can just test to see which is higher, the CPU's desired OPP
> +      * ID or the DSP's desired OPP ID, and use whichever is
> +      * highest.
> +      *
> +      * In CDP12.14+, the VDD1 OPP custom clock that controls the DSP
> +      * rate is keyed on MPU speed, not the OPP ID.  So we need to
> +      * map the OPP ID to the MPU speed for use with clk_set_rate()
> +      * if it is higher than the current OPP clock rate.
> +      *
> +      */
> +}
> +
> +
> +u8 omap_pm_dsp_get_opp(void)
> +{
> +     pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
> +
> +     /*
> +      * For l-o dev tree, call clk_get_rate() on VDD1 OPP clock
> +      *
> +      * CDP12.14+:
> +      * Call clk_get_rate() on the OPP custom clock, map that to an
> +      * OPP ID using the tables defined in board-*.c/chip-*.c files.
> +      */
> +
> +     return 0;
> +}
> +
> +/*
> + * CPUFreq-originated constraint
> + *
> + * In the future, this should be handled by custom OPP clocktype
> + * functions.
> + */
> +
> +struct cpufreq_frequency_table **omap_pm_cpu_get_freq_table(void)
> +{
> +     pr_debug("OMAP PM: CPUFreq request for frequency table\n");
> +
> +     /*
> +      * Return CPUFreq frequency table here: loop over
> +      * all VDD1 clkrates, pull out the mpu_ck frequencies, build
> +      * table
> +      */
> +
> +     return NULL;
> +}
> +
> +void omap_pm_cpu_set_freq(unsigned long f)
> +{
> +     if (f == 0) {
> +             WARN_ON(1);
> +             return;
> +     }
> +
> +     pr_debug("OMAP PM: CPUFreq requests CPU frequency to be set to %lu\n",
> +              f);
> +
> +     /*
> +      * For l-o dev tree, determine whether MPU freq or DSP OPP id
> +      * freq is higher.  Find the OPP ID corresponding to the
> +      * higher frequency.  Call clk_round_rate() and clk_set_rate()
> +      * on the OPP custom clock.
> +      *
> +      * CDP should just be able to set the VDD1 OPP clock rate here.
> +      */
> +}
> +
> +unsigned long omap_pm_cpu_get_freq(void)
> +{
> +     pr_debug("OMAP PM: CPUFreq requests current CPU frequency\n");
> +
> +     /*
> +      * Call clk_get_rate() on the mpu_ck.
> +      */
> +
> +     return 0;
> +}
> +
> +/*
> + * Device context loss tracking
> + */
> +
> +int omap_pm_get_dev_context_loss_count(struct device *dev)
> +{
> +     if (!dev) {
> +             WARN_ON(1);
> +             return -EINVAL;
> +     };
> +
> +     pr_debug("OMAP PM: returning context loss count for dev %s\n",
> +              dev_name(dev));
> +
> +     /*
> +      * Map the device to the powerdomain.  Return the powerdomain
> +      * off counter.
> +      */
> +
> +     return 0;
> +}
> +
> +
> +/* Should be called before clk framework init */
> +int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
> +                              struct omap_opp *dsp_opp_table,
> +                              struct omap_opp *l3_opp_table)
> +{
> +     mpu_opps = mpu_opp_table;
> +     dsp_opps = dsp_opp_table;
> +     l3_opps = l3_opp_table;
> +     return 0;
> +}
> +
> +/* Must be called after clock framework is initialized */
> +int __init omap_pm_if_init(void)
> +{
> +     return 0;
> +}
> +
> +void omap_pm_if_exit(void)
> +{
> +     /* Deallocate CPUFreq frequency table here */
> +}
> +
> +
> --
> 1.5.4.7

