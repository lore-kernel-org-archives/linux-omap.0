From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCHv2]OMAP PM:MPU/DMA Latency constraints
Date: Thu, 2 Dec 2010 15:56:50 +0530
Message-ID: <db311e867d656ae8bd4942f66b12de45@mail.gmail.com>
References: <1289899220-23003-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:38826 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751748Ab0LBKb6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Dec 2010 05:31:58 -0500
Received: by mail-fx0-f43.google.com with SMTP id 6so5063182fxm.30
        for <linux-omap@vger.kernel.org>; Thu, 02 Dec 2010 02:31:57 -0800 (PST)
In-Reply-To: <1289899220-23003-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

Kevin/Paul,

Do you have any comments on this patch?

Regards
Vishwa


> -----Original Message-----
> From: Vishwanath BS [mailto:vishwanath.bs@ti.com]
> Sent: Tuesday, November 16, 2010 2:50 PM
> To: linux-omap@vger.kernel.org
> Cc: Vishwanath BS; Kevin Hilman; Paul Walmsley
> Subject: [PATCHv2]OMAP PM:MPU/DMA Latency constraints
>
> The previous implementation of OMAP interrupt/DMA latency constraints
> were implemented using SRF which is obsolete now. This patch has
> implemented the same using PM QOS infeastructure. As part of this, API
> signature has been changed to take pm qos handle instead of dev pointer
> since PM QOS infrastructure takes pm_qos handle to distingush different
> latency requests.So each driver is expected to have it's own pm_qos
> handle.
> However it's an opaque handle from driver's point of view as drivers
just
> need to define a handle and this handle gets initialized automatically
> when
> they make the first mpu/dma latency request.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Paul Walmsley <paul@pwsan.com>
>
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
>
> The changes are rebased to latest kevin's origin/pm branch and tested
> on OMAP ZOOM3.
> ---
> V2: aligned the implementation with latest PM QOS APIs
> 	addressed comments from Kevin Hilman
> (https://patchwork.kernel.org/patch/113855/)
>
> V1: Initial Patch
>
>  arch/arm/plat-omap/Kconfig                |    3 +
>  arch/arm/plat-omap/Makefile               |    1 +
>  arch/arm/plat-omap/i2c.c                  |    3 +-
>  arch/arm/plat-omap/include/plat/omap-pm.h |   13 +-
>  arch/arm/plat-omap/omap-pm-noop.c         |   20 +-
>  arch/arm/plat-omap/omap-pm.c              |  316
> +++++++++++++++++++++++++++++
>  6 files changed, 341 insertions(+), 15 deletions(-)
>  create mode 100755 arch/arm/plat-omap/omap-pm.c
>
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 92c5bb7..4ff485e 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -184,6 +184,9 @@ config OMAP_PM_NONE
>  config OMAP_PM_NOOP
>  	bool "No-op/debug PM layer"
>
> +config OMAP_PM
> +	depends on PM
> +	bool "OMAP PM layer implementation"
>  endchoice
>
>  endmenu
> diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
> index 3f0a2bb..545a6a1 100644
> --- a/arch/arm/plat-omap/Makefile
> +++ b/arch/arm/plat-omap/Makefile
> @@ -38,3 +38,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
>  obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
>
>  obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
> +obj-$(CONFIG_OMAP_PM) += omap-pm.o
> diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
> index a5bff9c..eb9a7cb 100644
> --- a/arch/arm/plat-omap/i2c.c
> +++ b/arch/arm/plat-omap/i2c.c
> @@ -114,7 +114,8 @@ static inline int omap1_i2c_add_bus(int bus_id)
>   */
>  static void omap_pm_set_max_mpu_wakeup_lat_compat(struct device
> *dev, long t)
>  {
> -	omap_pm_set_max_mpu_wakeup_lat(dev, t);
> +	static struct pm_qos_request_list *qos_handle;
> +	omap_pm_set_max_mpu_wakeup_lat(&qos_handle, t);
>  }
>
>  static struct omap_device_pm_latency omap_i2c_latency[] = {
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h
> b/arch/arm/plat-omap/include/plat/omap-pm.h
> index c5b533d..6425e82
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -20,6 +20,7 @@
>
>  #include "powerdomain.h"
>  #include <plat/opp.h>
> +#include <linux/pm_qos_params.h>
>
>  /*
>   * agent_id values for use with omap_pm_set_min_bus_tput():
> @@ -75,7 +76,8 @@ void omap_pm_if_exit(void);
>
>  /**
>   * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU
> wakeup latency
> - * @dev: struct device * requesting the constraint
> + * @qos_request: handle for the constraint. The pointer should be
> + * initialized to NULL
>   * @t: maximum MPU wakeup latency in microseconds
>   *
>   * Request that the maximum interrupt latency for the MPU to be no
> @@ -107,7 +109,8 @@ void omap_pm_if_exit(void);
>   * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
>   * is not satisfiable, or 0 upon success.
>   */
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
> +int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list
> **qos_request,
> +					long t);
>
>
>  /**
> @@ -174,7 +177,8 @@ int omap_pm_set_max_dev_wakeup_lat(struct
> device *req_dev, struct device *dev,
>
>  /**
>   * omap_pm_set_max_sdma_lat - set the maximum system DMA
> transfer start latency
> - * @dev: struct device *
> + * @qos_request: handle for the constraint. The pointer should be
> + * initialized to NULL
>   * @t: maximum DMA transfer start latency in microseconds
>   *
>   * Request that the maximum system DMA transfer start latency for this
> @@ -199,7 +203,8 @@ int omap_pm_set_max_dev_wakeup_lat(struct
> device *req_dev, struct device *dev,
>   * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
>   * is not satisfiable, or 0 upon success.
>   */
> -int omap_pm_set_max_sdma_lat(struct device *dev, long t);
> +int omap_pm_set_max_sdma_lat(struct pm_qos_request_list
> **qos_request,
> +					long t);
>
>
>  /**
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-
> omap/omap-pm-noop.c
> index ca75abb..abcf9ae
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -30,19 +30,19 @@
>   * Device-driver-originated constraints (via board-*.c files)
>   */
>
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> +int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list
> **pmqos_req,
> +					long t)
>  {
> -	if (!dev || t < -1) {
> +	if (!pmqos_req || t < -1) {
>  		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
>  		return -EINVAL;
>  	};
>
>  	if (t == -1)
> -		pr_debug("OMAP PM: remove max MPU wakeup latency
> constraint: "
> -			 "dev %s\n", dev_name(dev));
> +		pr_debug("OMAP PM: remove max MPU wakeup latency
> constraint\n");
>  	else
>  		pr_debug("OMAP PM: add max MPU wakeup latency
> constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> +				"t = %ld usec\n", t);
>
>  	/*
>  	 * For current Linux, this needs to map the MPU to a
> @@ -116,19 +116,19 @@ int
> omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct
> device *dev,
>  	return 0;
>  }
>
> -int omap_pm_set_max_sdma_lat(struct device *dev, long t)
> +int omap_pm_set_max_sdma_lat(struct pm_qos_request_list
> **qos_request,
> +					long t)
>  {
> -	if (!dev || t < -1) {
> +	if (!qos_request || t < -1) {
>  		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
>  		return -EINVAL;
>  	};
>
>  	if (t == -1)
> -		pr_debug("OMAP PM: remove max DMA latency constraint:
> "
> -			 "dev %s\n", dev_name(dev));
> +		pr_debug("OMAP PM: remove max DMA latency
> constraint:\n");
>  	else
>  		pr_debug("OMAP PM: add max DMA latency constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> +				"t = %ld usec\n", t);
>
>  	/*
>  	 * For current Linux PM QOS params, this code should scan the
> diff --git a/arch/arm/plat-omap/omap-pm.c b/arch/arm/plat-
> omap/omap-pm.c
> new file mode 100755
> index 0000000..9002334
> --- /dev/null
> +++ b/arch/arm/plat-omap/omap-pm.c
> @@ -0,0 +1,316 @@
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
> + * Karthik Dasu, Tony Lindgren, Rajendra Nayak, Sakari Poussa,
> Veeramanikandan
> + * Raju, Anand Sawant, Igor Stoppa, Paul Walmsley, Richard Woodruff
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/init.h>
> +#include <linux/cpufreq.h>
> +#include <linux/device.h>
> +#include <linux/slab.h>
> +
> +/* Interface documentation is in mach/omap-pm.h */
> +#include <plat/omap-pm.h>
> +
> +#include <plat/powerdomain.h>
> +
> +/*
> + * Device-driver-originated constraints (via board-*.c files)
> + */
> +
> +int omap_pm_set_max_mpu_wakeup_lat(struct pm_qos_request_list
> +						**qos_request, long t)
> +{
> +	if (!qos_request || t < -1) {
> +		pr_warning("OMAP PM: %s: invalid parameter(s)\n",
> __func__);
> +		return -EINVAL;
> +	};
> +
> +	if (t == -1) {
> +		pm_qos_remove_request(*qos_request);
> +		kfree(*qos_request);
> +		*qos_request = NULL;
> +	} else if (*qos_request == NULL) {
> +		*qos_request = kzalloc(sizeof(struct pm_qos_request_list),
> +
GFP_KERNEL);
> +		if (!*qos_request) {
> +			pr_warning("OMAP PM: %s: kzalloc failed\n",
> __func__);
> +			return -ENOMEM;
> +		}
> +		pm_qos_add_request(*qos_request,
> PM_QOS_CPU_DMA_LATENCY, t);
> +	} else
> +		pm_qos_update_request(*qos_request, t);
> +
> +	return 0;
> +}
> +
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id,
> unsigned long r)
> +{
> +	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
> +	    agent_id != OCP_TARGET_AGENT)) {
> +		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
> +		return -EINVAL;
> +	};
> +
> +	if (r == 0)
> +		pr_debug("OMAP PM: remove min bus tput constraint: "
> +			 "dev %s for agent_id %d\n", dev_name(dev),
> agent_id);
> +	else
> +		pr_debug("OMAP PM: add min bus tput constraint: "
> +			 "dev %s for agent_id %d: rate %ld KiB\n",
> +			 dev_name(dev), agent_id, r);
> +
> +	/*
> +	 * This code should model the interconnect and compute the
> +	 * required clock frequency, convert that to a VDD2 OPP ID, then
> +	 * set the VDD2 OPP appropriately.
> +	 *
> +	 * TI CDP code can call constraint_set here on the VDD2 OPP.
> +	 */
> +
> +	return 0;
> +}
> +
> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct
> device *dev,
> +				   long t)
> +{
> +	if (!req_dev || !dev || t < -1) {
> +		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
> +		return -EINVAL;
> +	};
> +
> +	if (t == -1)
> +		pr_debug("OMAP PM: remove max device latency
> constraint: "
> +			 "dev %s\n", dev_name(dev));
> +	else
> +		pr_debug("OMAP PM: add max device latency constraint: "
> +			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> +
> +	/*
> +	 * For current Linux, this needs to map the device to a
> +	 * powerdomain, then go through the list of current max lat
> +	 * constraints on that powerdomain and find the smallest.  If
> +	 * the latency constraint has changed, the code should
> +	 * recompute the state to enter for the next powerdomain
> +	 * state.  Conceivably, this code should also determine
> +	 * whether to actually disable the device clocks or not,
> +	 * depending on how long it takes to re-enable the clocks.
> +	 *
> +	 * TI CDP code can call constraint_set here.
> +	 */
> +
> +	return 0;
> +}
> +
> +int omap_pm_set_max_sdma_lat(struct pm_qos_request_list
> **qos_request, long t)
> +{
> +	if (!qos_request || t < -1) {
> +		pr_warning("OMAP PM: %s: invalid parameter(s)\n",
> __func__);
> +		return -EINVAL;
> +	};
> +
> +	if (t == -1) {
> +		pm_qos_remove_request(*qos_request);
> +		kfree(*qos_request);
> +		*qos_request = NULL;
> +	} else if (*qos_request == NULL) {
> +		*qos_request = kzalloc(sizeof(struct pm_qos_request_list),
> +
GFP_KERNEL);
> +		if (!*qos_request) {
> +			pr_warning("OMAP PM: %s: kzalloc failed\n",
> __func__);
> +			return -ENOMEM;
> +		}
> +		pm_qos_add_request(*qos_request,
> PM_QOS_CPU_DMA_LATENCY, t);
> +	} else
> +		pm_qos_update_request(*qos_request, t);
> +
> +	return 0;
> +}
> +
> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long
> r)
> +{
> +	if (!dev || !c || r < 0) {
> +		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (r == 0)
> +		pr_debug("OMAP PM: remove min clk rate constraint: "
> +			 "dev %s\n", dev_name(dev));
> +	else
> +		pr_debug("OMAP PM: add min clk rate constraint: "
> +			 "dev %s, rate = %ld Hz\n", dev_name(dev), r);
> +
> +	/*
> +	 * Code in a real implementation should keep track of these
> +	 * constraints on the clock, and determine the highest minimum
> +	 * clock rate.  It should iterate over each OPP and determine
> +	 * whether the OPP will result in a clock rate that would
> +	 * satisfy this constraint (and any other PM constraint in effect
> +	 * at that time).  Once it finds the lowest-voltage OPP that
> +	 * meets those conditions, it should switch to it, or return
> +	 * an error if the code is not capable of doing so.
> +	 */
> +
> +	return 0;
> +}
> +
> +/*
> + * DSP Bridge-specific constraints
> + */
> +
> +const struct omap_opp *omap_pm_dsp_get_opp_table(void)
> +{
> +	pr_debug("OMAP PM: DSP request for OPP table\n");
> +
> +	/*
> +	 * Return DSP frequency table here:  The final item in the
> +	 * array should have .rate = .opp_id = 0.
> +	 */
> +
> +	return NULL;
> +}
> +
> +void omap_pm_dsp_set_min_opp(u8 opp_id)
> +{
> +	if (opp_id == 0) {
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	pr_debug("OMAP PM: DSP requests minimum VDD1 OPP to be
> %d\n", opp_id);
> +
> +	/*
> +	 *
> +	 * For l-o dev tree, our VDD1 clk is keyed on OPP ID, so we
> +	 * can just test to see which is higher, the CPU's desired OPP
> +	 * ID or the DSP's desired OPP ID, and use whichever is
> +	 * highest.
> +	 *
> +	 * In CDP12.14+, the VDD1 OPP custom clock that controls the
> DSP
> +	 * rate is keyed on MPU speed, not the OPP ID.  So we need to
> +	 * map the OPP ID to the MPU speed for use with clk_set_rate()
> +	 * if it is higher than the current OPP clock rate.
> +	 *
> +	 */
> +}
> +
> +
> +u8 omap_pm_dsp_get_opp(void)
> +{
> +	pr_debug("OMAP PM: DSP requests current DSP OPP ID\n");
> +
> +	/*
> +	 * For l-o dev tree, call clk_get_rate() on VDD1 OPP clock
> +	 *
> +	 * CDP12.14+:
> +	 * Call clk_get_rate() on the OPP custom clock, map that to an
> +	 * OPP ID using the tables defined in board-*.c/chip-*.c files.
> +	 */
> +
> +	return 0;
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
> +	pr_debug("OMAP PM: CPUFreq request for frequency table\n");
> +
> +	/*
> +	 * Return CPUFreq frequency table here: loop over
> +	 * all VDD1 clkrates, pull out the mpu_ck frequencies, build
> +	 * table
> +	 */
> +
> +	return NULL;
> +}
> +
> +void omap_pm_cpu_set_freq(unsigned long f)
> +{
> +	if (f == 0) {
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	pr_debug("OMAP PM: CPUFreq requests CPU frequency to be set
> to %lu\n",
> +		 f);
> +
> +	/*
> +	 * For l-o dev tree, determine whether MPU freq or DSP OPP id
> +	 * freq is higher.  Find the OPP ID corresponding to the
> +	 * higher frequency.  Call clk_round_rate() and clk_set_rate()
> +	 * on the OPP custom clock.
> +	 *
> +	 * CDP should just be able to set the VDD1 OPP clock rate here.
> +	 */
> +}
> +
> +unsigned long omap_pm_cpu_get_freq(void)
> +{
> +	pr_debug("OMAP PM: CPUFreq requests current CPU
> frequency\n");
> +
> +	/*
> +	 * Call clk_get_rate() on the mpu_ck.
> +	 */
> +
> +	return 0;
> +}
> +
> +/*
> + * Device context loss tracking
> + */
> +
> +int omap_pm_get_dev_context_loss_count(struct device *dev)
> +{
> +	if (!dev) {
> +		WARN_ON(1);
> +		return -EINVAL;
> +	};
> +
> +	pr_debug("OMAP PM: returning context loss count for dev %s\n",
> +		 dev_name(dev));
> +
> +	/*
> +	 * Map the device to the powerdomain.  Return the powerdomain
> +	 * off counter.
> +	 */
> +
> +	return 0;
> +}
> +
> +
> +/* Should be called before clk framework init */
> +int __init omap_pm_if_early_init(void)
> +
> +{
> +	return 0;
> +}
> +
> +/* Must be called after clock framework is initialized */
> +int __init omap_pm_if_init(void)
> +{
> +	return 0;
> +}
> +
> +void omap_pm_if_exit(void)
> +{
> +	/* Deallocate CPUFreq frequency table here */
> +}
> +
> +
> --
> 1.7.0.4
