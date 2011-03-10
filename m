From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices constraints APIs
Date: Wed, 9 Mar 2011 21:03:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103091943550.15132@utopia.booyaka.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com> <1299698346-2768-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45706 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab1CJEDD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 23:03:03 -0500
In-Reply-To: <1299698346-2768-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Hello Jean

Thanks for working on this stuff.  Some comments based on a quick look...

On Wed, 9 Mar 2011, Jean Pihet wrote:

> Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
> creating a unified API which calls omap_device_set_dev_constraint
> for all classes of constraints (devices wake-up latency, devices
> throughput...).
> The implementation of the constraints framework is at the omap_device
> level: management and storage of the constraints, dispatching of the
> constraints to the appropriate low level layers.
> 
> NOTE: only works for devices which have been converted to use
>       omap_device/omap_hwmod.
> 
> Longer term, we could possibly remove this API from the OMAP PM layer,
> and instead directly use the device level API.
> 
> For the devices wake-up latency constraints, the power domains get
> the next power state programmed directly in the registers via
> pwrdm_wakeuplat_update_pwrst.
> 
> Note about PM QOS: the MPU and CORE power domains get the next power
> state via cpuidle, which get the strongest wake-up latency constraint
> by querying PM QOS. The usage of PM QOS is temporary, until a generic
> solution is in place.
> 
> Based on Vibhore's original patch, adapted to omap_device, omap_hwmod
> and PM QOS frameworks.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Vibhore Vardhan <vvardhan@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   29 ++++-
>  arch/arm/mach-omap2/powerdomain.c             |   99 +++++++++++++
>  arch/arm/mach-omap2/powerdomain.h             |   24 +++-
>  arch/arm/mach-omap2/powerdomains3xxx_data.c   |   63 +++++++++
>  arch/arm/plat-omap/include/plat/omap-pm.h     |    6 +-
>  arch/arm/plat-omap/include/plat/omap_device.h |   14 ++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
>  arch/arm/plat-omap/omap-pm-constraints.c      |  161 ++++++++++------------
>  arch/arm/plat-omap/omap-pm-noop.c             |    2 +-
>  arch/arm/plat-omap/omap_device.c              |  187 +++++++++++++++++++++++++
>  10 files changed, 493 insertions(+), 93 deletions(-)

Please split this patch up into several patches:

- the powerdomain.h/powerdomain.c changes
- the powerdomains*_data.c changes
- any changes you want to make to the omap-pm.h interface, and if those
  require changes to the omap-pm-*.c files, change those here too
- omap_hwmod changes (if needed, which I don't think they are)
- omap_device changes
- omap-pm-constraints changes

> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index cf8cc9b..8caf2c5 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -142,6 +142,7 @@
>  #include "powerdomain.h"
>  #include <plat/clock.h>
>  #include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
>  #include <plat/prcm.h>
>  
>  #include "cm2xxx_3xxx.h"
> @@ -2277,11 +2278,37 @@ ohsps_unlock:
>  	return ret;
>  }
>  
> +/*
> + * omap_hwmod_update_power_state - Update the power domain power state of
> + * @oh
> + *
> + * @oh: struct omap_hwmod* to which the requesting device belongs to.
> + * @min_latency: the allowed wake-up latency for the power domain of @oh.
> + *
> + * Finds the power domain next power state that fulfills the constraint.
> + * Applies the constraint to the power domain by calling
> + * pwrdm_wakeuplat_update_pwrst.
> + *
> + * Returns 0 upon success.
> + */
> +int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_latency)
> +{
> +	struct powerdomain *pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	if (!PTR_ERR(pwrdm)) {
> +		pr_err("omap_hwmod: Error: could not find parent "
> +			"powerdomain for %s\n", oh->name);
> +		return -EINVAL;
> +	}
> +
> +	return pwrdm_wakeuplat_update_pwrst(pwrdm, min_latency);
> +}

I don't think this function is needed.  Might as well just take care of it 
in your omap_device code.

> +
>  /**
>   * omap_hwmod_get_context_loss_count - get lost context count
>   * @oh: struct omap_hwmod *
>   *
> - * Query the powerdomain of of @oh to get the context loss
> + * Query the powerdomain of @oh to get the context loss
>   * count for this device.
>   *
>   * Returns the context loss count of the powerdomain assocated with @oh
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index eaed0df..496f245 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,6 +19,7 @@
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +
>  #include "cm2xxx_3xxx.h"
>  #include "prcm44xx.h"
>  #include "cm44xx.h"
> @@ -176,6 +177,104 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
>  	return 0;
>  }
>  
> +/*
> + * Test if the current powerdomain is MPU or CORE
> + *
> + * This function is only used by pwrdm_wakeuplat_update_pwrst
> + * which applies the MPU and CORE power domains constraints using PM QOS.
> + *
> + * This will disappear when all power domains will be controlled directly
> + * from the wake-up latency constraints framework
> + */
> +static inline int is_pwrdm_mpu_or_core(struct powerdomain *pwrdm)
> +{
> +	if ((strncmp(pwrdm->name, "mpu_pwrdm", 9) == 0) ||
> +	    (strncmp(pwrdm->name, "core_pwrdm", 10) == 0))
> +		return 1;
> +	else
> +		return 0;
> +}

Please add some kind of powerdomain flag instead, set in some OMAP3 
powerdomain-specific init code, rather than strncmp().

> +
> +/**
> + * pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
> + * @pwrdm: struct powerdomain * to which requesting device belongs to.
> + * @min_latency: the allowed wake-up latency for the given power domain.
> + *
> + * Finds the power domain next power state that fulfills the constraint.
> + * Programs a new target state if it is different from current power state.
> + *
> + * Returns 0 upon success.
> + */
> +int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long min_latency)
> +{
> +	int ret = 0, new_state = 0;
> +
> +	if (!pwrdm) {
> +		WARN(1, "powerdomain: %s: invalid parameter(s)", __func__);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Apply constraints to MPU and CORE via the PM QOS API.
> +	 * Every power domain struct has a pm_qos_request_list field
> +	 */
> +	if (is_pwrdm_mpu_or_core(pwrdm)) {
> +		if (pm_qos_request_active(&(pwrdm->pm_qos_request)))
> +			pm_qos_remove_request(&(pwrdm->pm_qos_request));
> +
> +		if (min_latency >= 0)
> +			pm_qos_add_request(&(pwrdm->pm_qos_request),
> +					   PM_QOS_CPU_DMA_LATENCY,
> +					   min_latency);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Apply constraints to pwrdm other than MPU and CORE by programming
> +	 * the pwrdm next power state.
> +	 */
> +
> +	/* Find power state with wakeup latency < minimum constraint */
> +	for (new_state = 0x0; new_state < PWRDM_MAX_PWRSTS; new_state++) {
> +		if (min_latency == -1 ||
> +		    pwrdm->wakeup_lat[new_state] <= min_latency)
> +			break;
> +	}
> +
> +	switch (new_state) {
> +	case PWRDM_FUNC_PWRST_OFF:
> +		new_state = PWRDM_POWER_OFF;
> +		break;
> +	case PWRDM_FUNC_PWRST_OSWR:
> +		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);
> +		new_state = PWRDM_POWER_RET;
> +		break;
> +	case PWRDM_FUNC_PWRST_CSWR:
> +		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
> +		new_state = PWRDM_POWER_RET;
> +		break;
> +	case PWRDM_FUNC_PWRST_ON:
> +		new_state = PWRDM_POWER_ON;
> +		break;
> +	default:
> +		pr_warn("powerdomain: requested latency constraint not "
> +			"supported %s set to ON state\n", pwrdm->name);
> +		new_state = PWRDM_POWER_ON;
> +		break;
> +	}
> +
> +	if (pwrdm_read_pwrst(pwrdm) != new_state) {
> +		ret = omap_set_pwrdm_state(pwrdm, new_state);
> +	}
> +
> +	pr_debug("powerdomain: %s pwrst: curr=%d, prev=%d next=%d "
> +		 "min_latency=%ld, set_state=%d\n", pwrdm->name,
> +		 pwrdm_read_pwrst(pwrdm), pwrdm_read_prev_pwrst(pwrdm),
> +		 pwrdm_read_next_pwrst(pwrdm), min_latency, new_state);
> +
> +	return ret;
> +}
> +
>  /* Public functions */
>  
>  /**
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 0b7a357..c796469 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -19,7 +19,10 @@
>  
>  #include <linux/types.h>
>  #include <linux/list.h>
> -
> +#include <linux/plist.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/pm_qos_params.h>
>  #include <linux/atomic.h>
>  
>  #include <plat/cpu.h>
> @@ -46,6 +49,15 @@
>  
>  #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 << PWRDM_POWER_ON))
>  
> +/* Powerdomain functional power states */
> +#define PWRDM_FUNC_PWRST_OFF	0x0
> +#define PWRDM_FUNC_PWRST_OSWR	0x1
> +#define PWRDM_FUNC_PWRST_CSWR	0x2

You'll also want an _INACTIVE state here, per:

   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43783.html

> +#define PWRDM_FUNC_PWRST_ON	0x3
> +
> +#define PWRDM_MAX_FUNC_PWRSTS	4
> +
> +#define UNSUP_STATE		-1
>  
>  /* Powerdomain flags */
>  #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-restore support */
> @@ -96,7 +108,11 @@ struct powerdomain;
>   * @state_counter:
>   * @timer:
>   * @state_timer:
> - *
> + * @wakeup_lat: wakeup latencies for possible powerdomain power states
> + * Note about the wakeup latencies ordering: the values must be sorted
> + *  in decremental order

Would be good to specify the unit of time here.

> + * @pm_qos_request: PM QOS handle, only used to control the MPU and CORE power
> + *  domains states; to be removed when a generic solution is in place.
>   * @prcm_partition possible values are defined in mach-omap2/prcm44xx.h.
>   */
>  struct powerdomain {
> @@ -121,6 +137,8 @@ struct powerdomain {
>  	s64 timer;
>  	s64 state_timer[PWRDM_MAX_PWRSTS];
>  #endif
> +	const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
> +	struct pm_qos_request_list pm_qos_request;
>  };
>  
>  /**
> @@ -210,6 +228,8 @@ int pwrdm_clkdm_state_switch(struct clockdomain *clkdm);
>  int pwrdm_pre_transition(void);
>  int pwrdm_post_transition(void);
>  int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
> +
> +int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long min_latency);
>  u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
>  
>  extern void omap2xxx_powerdomains_init(void);
> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> index e1bec56..64973d1 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -31,6 +31,9 @@
>  
>  /*
>   * Powerdomains
> + *
> + * The wakeup_lat values are derived from measurements on
> + * the actual target.

Which type of OMAP3 chip were these measured on?  OMAP34xx/35xx, 
OMAP36xx/37xx, AM3505/17 ?

Also it would be good to know the sys_clk rate and the VDD1/2 OPPs that 
you took these measurements at.  Do you have a sense of how much these 
measurements vary based on those three factors?  Presumably, 
12MHz/125MHz/83MHz would be the worst case, for the standard OPPs anyway.

In general, if you could elaborate further how you measured these, that 
would be good.  Some of these measurements seem to be too low (described 
below).

I'm not sure if a strictly static table is the right approach for these 
measurements.  It might be good to start with a static table that 
represents the lowest possible latencies, measured with DPLL autoidle 
disabled, and then to add or remove amounts from those numbers dynamically 
based on the state of other devices.  For example, in terms of CORE, the 
AUTOEXTCLKMODE settings and the amount of time it takes the external HF 
oscillator to restart will have a major impact on the CORE OFF->ON 
measurements, potentially several milliseconds.  Similarly, if DPLL1, 2, 
or 3 have to relock, that could take quite a bit of time, potentially 
several hundred microseconds.

>   */
>  
>  static struct powerdomain iva2_pwrdm = {
> @@ -52,6 +55,12 @@ static struct powerdomain iva2_pwrdm = {
>  		[2] = PWRSTS_OFF_ON,
>  		[3] = PWRDM_POWER_ON,
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 1100,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 350,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };

Was this measured with DPLL2 autoidle enabled or disabled?

>  
>  static struct powerdomain mpu_3xxx_pwrdm = {
> @@ -68,6 +77,12 @@ static struct powerdomain mpu_3xxx_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRSTS_OFF_ON,
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 95,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 45,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };

Was this measured with DPLL1 autoidle enabled or disabled?

That OFF->ON time looks really low to me...

>  
>  /*
> @@ -98,6 +113,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
>  		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
>  		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 100,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 60,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };
>  
>  static struct powerdomain core_3xxx_es3_1_pwrdm = {
> @@ -121,6 +142,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
>  		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
>  		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 100,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 60,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };

The figures for the CORE powerdomain look implausibly low.  Do these 
figures represent the amount of time required to transition from the low 
power state to the point at which Linux is running again?  Or do they 
represent something else?

>  static struct powerdomain dss_pwrdm = {
> @@ -136,6 +163,12 @@ static struct powerdomain dss_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 70,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 20,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };
>  
>  /*
> @@ -157,6 +190,12 @@ static struct powerdomain sgx_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 1000,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };
>  
>  static struct powerdomain cam_pwrdm = {
> @@ -172,6 +211,12 @@ static struct powerdomain cam_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 850,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 35,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };
>  
>  static struct powerdomain per_pwrdm = {
> @@ -187,6 +232,12 @@ static struct powerdomain per_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 200,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 110,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };
>  
>  static struct powerdomain emu_pwrdm = {
> @@ -201,6 +252,12 @@ static struct powerdomain neon_pwrdm = {
>  	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
>  	.pwrsts		  = PWRSTS_OFF_RET_ON,
>  	.pwrsts_logic_ret = PWRDM_POWER_RET,
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 200,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 35,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };
>  
>  static struct powerdomain usbhost_pwrdm = {
> @@ -223,6 +280,12 @@ static struct powerdomain usbhost_pwrdm = {
>  	.pwrsts_mem_on	  = {
>  		[0] = PWRDM_POWER_ON,  /* MEMONSTATE */
>  	},
> +	.wakeup_lat = {
> +		[PWRDM_FUNC_PWRST_OFF] = 800,
> +		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
> +		[PWRDM_FUNC_PWRST_CSWR] = 150,
> +		[PWRDM_FUNC_PWRST_ON] = 0,
> +	},
>  };
>  
>  static struct powerdomain dpll1_pwrdm = {
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
> index c0a7520..16f9e84 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -70,6 +70,10 @@ void omap_pm_if_exit(void);
>   * Device-driver-originated constraints (via board-*.c files, platform_data)
>   */
>  
> +enum omap_pm_constraint_class {
> +	OMAP_PM_CONSTRAINT_WKUP_LAT,
> +	OMAP_PM_CONSTRAINT_THROUGHPUT
> +};
>  
>  /**
>   * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup latency
> @@ -137,7 +141,7 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t);
>   * Returns -EINVAL for an invalid argument, -ERANGE if the constraint
>   * is not satisfiable, or 0 upon success.
>   */
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r);
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long r);

The documentation for this function states:

 To remove the interconnect throughput restriction for this device, call with r = 0.

So an unsigned long seems reasonable here?

>  
>  /**
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-omap/include/plat/omap_device.h
> index e4c349f..d4766c4 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -32,9 +32,11 @@
>  #define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_DEVICE_H
>  
>  #include <linux/kernel.h>
> +#include <linux/plist.h>
>  #include <linux/platform_device.h>
>  
>  #include <plat/omap_hwmod.h>
> +#include <plat/omap-pm.h>
>  
>  extern struct device omap_device_parent;
>  
> @@ -73,6 +75,15 @@ struct omap_device {
>  	s8				pm_lat_level;
>  	u8				hwmods_cnt;
>  	u8				_state;
> +
> +};
> +
> +/* Linked list for the devices constraints entries */
> +struct omap_device_constraints_entry {
> +	struct device			*req_dev;
> +	void				*target;
> +	unsigned long			constraint_value;
> +	struct plist_node		node;
>  };
>  
>  /* Device driver interface (call via platform_data fn ptrs) */
> @@ -107,6 +118,9 @@ void __iomem *omap_device_get_rt_va(struct omap_device *od);
>  int omap_device_align_pm_lat(struct platform_device *pdev,
>  			     u32 new_wakeup_lat_limit);
>  struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class class,
> +				   struct device *req_dev,
> +				   struct device *dev, long t);

This should be two separate functions, one for max wakeup latency and the 
other for minimum bandwidth... discussed further below.

>  u32 omap_device_get_context_loss_count(struct platform_device *pdev);
>  
>  /* Other */
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 65bcad4..f27110e 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -597,6 +597,7 @@ int omap_hwmod_for_each_by_class(const char *classname,
>  				 void *user);
>  
>  int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
> +int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_latency);
>  u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>  
>  /*
> diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat-omap/omap-pm-constraints.c
> index c8b4e4c..4709f83 100644
> --- a/arch/arm/plat-omap/omap-pm-constraints.c
> +++ b/arch/arm/plat-omap/omap-pm-constraints.c
> @@ -24,6 +24,7 @@
>  /* Interface documentation is in mach/omap-pm.h */
>  #include <plat/omap-pm.h>
>  #include <plat/omap_device.h>
> +#include <plat/common.h>
>  
>  static bool off_mode_enabled;
>  static u32 dummy_context_loss_counter;
> @@ -32,35 +33,46 @@ static u32 dummy_context_loss_counter;
>   * Device-driver-originated constraints (via board-*.c files)
>   */
>  
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> +/*
> + * Generic function to omap_device layer for the constraints API.
> + */
> +static int omap_pm_set_dev_constraint(enum omap_pm_constraint_class class,
> +				      struct device *req_dev,
> +				      struct device *dev, long t)

For static functions, I'd suggest dropping the "omap_pm" prefix from the 
names of these functions, so they begin with an underscore.

>  {
> -	if (!dev || t < -1) {
> +	int ret = 0;
> +
> +	if (!req_dev || !dev || t < -1) {
>  		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
>  		return -EINVAL;
> -	};
> -
> -	if (t == -1)
> -		pr_debug("OMAP PM: remove max MPU wakeup latency constraint: "
> -			 "dev %s\n", dev_name(dev));
> -	else
> -		pr_debug("OMAP PM: add max MPU wakeup latency constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> +	}
>  
> -	/*
> -	 * For current Linux, this needs to map the MPU to a
> -	 * powerdomain, then go through the list of current max lat
> -	 * constraints on the MPU and find the smallest.  If
> -	 * the latency constraint has changed, the code should
> -	 * recompute the state to enter for the next powerdomain
> -	 * state.
> -	 *
> -	 * TI CDP code can call constraint_set here.
> -	 */
> +	/* Try to catch non omap_device for dev */
> +	if (dev->parent == &omap_device_parent) {
> +		if (t == -1)
> +			pr_debug("OMAP PM: remove constraint of class %d "
> +				 "from req_dev %s on dev %s\n",
> +				 class, dev_name(req_dev), dev_name(dev));
> +		else
> +			pr_debug("OMAP PM: add constraint of class %d "
> +				 "from req_dev %s on dev %s, t = %ld\n",
> +				 class, dev_name(req_dev), dev_name(dev), t);
> +
> +		/* Call the omap_device API */
> +		ret = omap_device_set_dev_constraint(class, req_dev, dev, t);
> +	} else {
> +		pr_err("OMAP-PM set_wakeup_lat: Error: platform device "
> +		       "not valid\n");
> +		return -EINVAL;
> +	}
>  
> -	return 0;
> +	return ret;
>  }
>  
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
> +/*
> + * omap_pm_set_min_bus_tput - set/release bus throughput constraints
> + */
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long r)
>  {
>  	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
>  	    agent_id != OCP_TARGET_AGENT)) {
> @@ -68,83 +80,56 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
>  		return -EINVAL;
>  	};
>  
> -	if (r == 0)
> -		pr_debug("OMAP PM: remove min bus tput constraint: "
> -			 "dev %s for agent_id %d\n", dev_name(dev), agent_id);
> -	else
> -		pr_debug("OMAP PM: add min bus tput constraint: "
> -			 "dev %s for agent_id %d: rate %ld KiB\n",
> -			 dev_name(dev), agent_id, r);
> -
>  	/*
> -	 * This code should model the interconnect and compute the
> -	 * required clock frequency, convert that to a VDD2 OPP ID, then
> -	 * set the VDD2 OPP appropriately.
> -	 *
> -	 * TI CDP code can call constraint_set here on the VDD2 OPP.
> +	 * This code calls the generic omap_device API function
> +	 * omap_pm_set_dev_constraint with the class
> +	 * OMAP_PM_CONSTRAINT_THROUGHPUT. omap_pm_set_dev_constraint
> +	 * should manage the constraints lists and call the appropriate
> +	 * low level code that models the interconnect, computes the required
> +	 * clock frequency, converts that to a VDD2 OPP ID and sets the
> +	 * VDD2 OPP appropriately.
>  	 */
> -
> -	return 0;
> +	return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_THROUGHPUT,
> +					  dev, dev, r);
>  }
>  
> +/*
> + * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up latency
> + * constraints
> + */
>  int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
>  				   long t)
>  {
> -	if (!req_dev || !dev || t < -1) {
> -		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
> -		return -EINVAL;
> -	};
> -
> -	if (t == -1)
> -		pr_debug("OMAP PM: remove max device latency constraint: "
> -			 "dev %s\n", dev_name(dev));
> -	else
> -		pr_debug("OMAP PM: add max device latency constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> -
> -	/*
> -	 * For current Linux, this needs to map the device to a
> -	 * powerdomain, then go through the list of current max lat
> -	 * constraints on that powerdomain and find the smallest.  If
> -	 * the latency constraint has changed, the code should
> -	 * recompute the state to enter for the next powerdomain
> -	 * state.  Conceivably, this code should also determine
> -	 * whether to actually disable the device clocks or not,
> -	 * depending on how long it takes to re-enable the clocks.
> -	 *
> -	 * TI CDP code can call constraint_set here.
> -	 */
> -
> -	return 0;
> +	return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_LAT,
> +					  req_dev, dev, t);
>  }
>  
> -int omap_pm_set_max_sdma_lat(struct device *dev, long t)
> +/*
> + * omap_pm_set_max_mpu_wakeup_lat - set/release MPU wake-up latency
> + * constraints
> + *
> + * Maps to omap_pm_set_dev_constraint with OMAP_PM_CONSTRAINT_WKUP_LAT
> + * as constraint class and the MPU device as constraints target.
> + */
> +int omap_pm_set_max_mpu_wakeup_lat(struct device *req_dev, long t)
>  {
> -	if (!dev || t < -1) {
> -		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
> -		return -EINVAL;
> -	};
> -
> -	if (t == -1)
> -		pr_debug("OMAP PM: remove max DMA latency constraint: "
> -			 "dev %s\n", dev_name(dev));
> -	else
> -		pr_debug("OMAP PM: add max DMA latency constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> -
> -	/*
> -	 * For current Linux PM QOS params, this code should scan the
> -	 * list of maximum CPU and DMA latencies and select the
> -	 * smallest, then set cpu_dma_latency pm_qos_param
> -	 * accordingly.
> -	 *
> -	 * For future Linux PM QOS params, with separate CPU and DMA
> -	 * latency params, this code should just set the dma_latency param.
> -	 *
> -	 * TI CDP code can call constraint_set here.
> -	 */
> +	return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_LAT,
> +					  req_dev, omap2_get_mpuss_device(),
> +					  t);
> +}
>  
> -	return 0;
> +/*
> + * omap_pm_set_max_sdma_lat - set/release SDMA start latency
> + * constraints
> + *
> + * Currently maps to omap_pm_set_dev_constraint with OMAP_PM_CONSTRAINT_WKUP_LAT
> + * as constraint class and the L3 device as constraints target.
> + */
> +int omap_pm_set_max_sdma_lat(struct device *req_dev, long t)
> +{
> +	return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_LAT,
> +					  req_dev, omap2_get_l3_device(),
> +					  t);
>  }
>  
>  int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
> index b0471bb2..7868edc 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -61,7 +61,7 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
>  	return 0;
>  }
>  
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long r)
>  {
>  	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
>  	    agent_id != OCP_TARGET_AGENT)) {
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 9bbda9a..b33b7fa 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -292,10 +292,189 @@ static void _add_optional_clock_clkdev(struct omap_device *od,
>  	}
>  }
>  
> +/* plist that stores the devices wake-up latency constraints */
> +static struct plist_head omap_device_wkup_lat_constraints_list;
> +/* Spinlock that protects the constraints lists */
> +static spinlock_t omap_device_constraints_lock;
> +/* Mutex that protects the constraints lists ops */
> +static struct mutex omap_device_constraints_mutex;
> +
> +/*
> + * omap_device_store_constraint: add/update/remove a constraint from a plist
> + *
> + * @constraints_list: plist to use
> + * @req_dev: constraint requester, used to track the requests
> + * @target: target which the constraint applies to (e.g. power domain ID or
> + *  ptr for wake-up latency constraints)
> + * @value: constraint value. The plist is sorted by the value. -1 remove the
> + *  constraint from the list
> + *
> + * Returns the strongest constraint value for the given target, 0 in the
> + * case there is no constraint on the given target or a negative value in
> + * case of error.
> + * The caller must check the validity of the parameters.
> + */
> +static long omap_device_store_constraint(struct plist_head *constraints_list,
> +					 struct device *req_dev, void *target,
> +					 long value)
> +{
> +	struct omap_device_constraints_entry *user;
> +	int found = 0, ret = 0;
> +
> +	mutex_lock(&omap_device_constraints_mutex);
> +
> +	/* Check if the constraint requester is already in the list */
> +	plist_for_each_entry(user, constraints_list, node) {
> +		if (user->req_dev == req_dev) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (value >= 0) {

This should really be split into two functions, _add_constraint() and 
_remove_constraint().  You may wish to review Documentation/CodingStyle 
Chapter 6.

> +		/* Add new entry to the list or update existing request */
> +		if (found &&
> +		    user->constraint_value == value &&
> +		    user->target == target) {
> +			goto exit_ok;
> +		} else if (!found) {
> +			user = kzalloc(
> +				sizeof(struct omap_device_constraints_entry),
> +				GFP_KERNEL);
> +			if (!user) {
> +				pr_err("%s: FATAL ERROR: kzalloc failed\n",
> +				       __func__);
> +				ret = -ENOMEM;
> +				goto exit_error;
> +			}
> +			user->req_dev = req_dev;
> +		} else {
> +			plist_del(&user->node, constraints_list);
> +		}
> +
> +		plist_node_init(&user->node, value);
> +		plist_add(&user->node, constraints_list);
> +		user->node.prio = user->constraint_value = value;
> +		user->target = target;
> +	} else {
> +		/* Remove the constraint from the list */
> +		if (!found) {
> +			pr_err("%s: Error: no prior constraint to release\n",
> +			       __func__);
> +			ret = -EINVAL;
> +			goto exit_error;
> +		}
> +
> +		plist_del(&user->node, constraints_list);
> +		kfree(user);
> +	}
> +
> +exit_ok:
> +	/* Find the strongest constraint for the given target */
> +	ret = 0;
> +	plist_for_each_entry(user, constraints_list, node) {
> +		if (user->target == target) {
> +			ret = user->constraint_value;
> +			break;
> +		}
> +	}
> +
> +exit_error:
> +	mutex_unlock(&omap_device_constraints_mutex);
> +
> +	return ret;
> +}
>  
>  /* Public functions for use by core code */
>  
>  /**
> + * omap_device_set_max_dev_wakeup_lat - set/release a device constraint
> + * @class: constraint class
> + * @dev: device to apply the constraint to. Must have an associated omap_device
> + * @req_dev: constraint requester, used for tracking the constraints
> + *
> + * Using the primary hwmod, set/release a device constraint for the dev
> + * device, requested by the req_dev device. Depending of the constraint class
> + * this code calls the appropriate low level code, e.g. power domain for
> + * the wake-up latency constraints.
> + *
> + * If any hwmods exist for the omap_device assoiated with @dev and @req_dev,
> + * set/release the constraint for the corresponding hwmods, otherwise return
> + * -EINVAL.
> + */
> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class class,
> +				   struct device *req_dev,
> +				   struct device *dev, long t)

The name of this function doesn't match what's in the kerneldoc comment.

> +{
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +	struct platform_device *pdev;
> +	struct powerdomain *pwrdm = NULL;
> +	u32 ret = -EINVAL;
> +
> +	/* Look for the platform device for dev */
> +	pdev = to_platform_device(dev);
> +
> +	/* Try to catch non platform devices. */
> +	if (pdev->name == NULL) {
> +		pr_err("%s: Error: platform device for device %s not valid\n",
> +		       __func__, dev_name(dev));
> +		return -EINVAL;
> +	}
> +
> +	/* Find the associated omap_device for dev */
> +	od = _find_by_pdev(pdev);
> +	if (!(od->hwmods_cnt)) {
> +		pr_err("%s: Error: No hwmod for device %s\n",
> +		       __func__, dev_name(dev));
> +		return -EINVAL;
> +	}

Please also pr_err() and bail out if there is more than one hwmod in the 
omap_device.

> +
> +	/* Find the associated omap_hwmod for dev */
> +	oh = od->hwmods[0];
> +
> +	switch (class) {
> +	case OMAP_PM_CONSTRAINT_WKUP_LAT:

Please create two different functions, 
omap_device_set_max_dev_wakeup_lat() and 
omap_device_set_min_bus_tput().  Documentation/CodingStyle chapter 6.

> +		/* Find the pwrdm associated to dev */
> +		pwrdm = omap_device_get_pwrdm(od);
> +		if (!pwrdm) {
> +			pr_err("%s: Error: No pwrdm for device %s\n",
> +			       __func__, dev_name(dev));
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		/*
> +		 * Store the constraint in the appropriate list and find the
> +		 * strongest constraint for the given pwrdm
> +		 */
> +		ret = omap_device_store_constraint(
> +					&omap_device_wkup_lat_constraints_list,
> +					req_dev, (void *) pwrdm, t);
> +
> +		/* Apply the constraint to the corresponding pwrdm */
> +		if (ret >= 0) {
> +			ret = omap_hwmod_update_power_state(oh, ret);
> +		} else {
> +			pr_err("%s: Error storing the constraint for device "
> +			       "%s\n", __func__, dev_name(dev));
> +		}
> +
> +		break;
> +	case OMAP_PM_CONSTRAINT_THROUGHPUT:
> +		WARN(1, "OMAP PM: %s: Bus throughput constraint class \
> +		     not implemented\n", __func__);
> +		ret = -EINVAL;
> +		break;
> +	default:
> +		WARN(1, "OMAP PM: %s: invalid constraint class %d",
> +		     __func__, class);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
>   * omap_device_get_context_loss_count - get lost context count
>   * @od: struct omap_device *
>   *
> @@ -824,6 +1003,14 @@ struct device omap_device_parent = {
>  
>  static int __init omap_device_init(void)
>  {
> +	/* Initialize priority ordered list for wakeup latency constraint */
> +	spin_lock_init(&omap_device_constraints_lock);
> +	plist_head_init(&omap_device_wkup_lat_constraints_list,
> +			&omap_device_constraints_lock);
> +
> +	/* res_mutex protects res_list add and del ops */
> +	mutex_init(&omap_device_constraints_mutex);
> +
>  	return device_register(&omap_device_parent);
>  }
>  core_initcall(omap_device_init);
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
