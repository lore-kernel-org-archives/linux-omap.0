From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices wakeup latency constraints APIs
Date: Mon, 07 Mar 2011 18:15:31 -0800
Message-ID: <87aah6xsqk.fsf@ti.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299250375-26134-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50137 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752008Ab1CHCPg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 21:15:36 -0500
Received: by mail-qy0-f170.google.com with SMTP id 32so2346578qyk.8
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 18:15:34 -0800 (PST)
In-Reply-To: <1299250375-26134-3-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Fri, 4 Mar 2011 15:52:55 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
> creating similar APIs at the omap_device and omap_hwmod levels. The
> omap_hwmod level call is the layer with access to the powerdomain
> core, so it is the place where the powerdomain is queried to set and
> release the constraints.
>
> NOTE: only works for devices which have been converted to use
>       omap_device/omap_hwmod.
>
> Longer term, we could possibly remove this API from the OMAP PM layer,
> and instead directly use the device level API.
>
> The power domains get the next power state programmed directly in
> the registers via pwrdm_wakeuplat_update_pwrst.
>
> Note about PM QOS: the MPU and CORE power domains get the next power
> state via cpuidle, which get the strongest wake-up latency constraint
> by querying PM QOS. The usage of PM QOS is temporary, until a generic
> solution is in place.
>
> Based on Vibhore's original patch, adapted to omap_device, omap_hwmod
> and PM QOS frameworks.

I haven't got to a detailed review of this code yet, but did do some
experiements and have some general comments on the code/design to get
started.

Also, I had a problem doing a real dumb test until I figured out the
problem with the init sequence.  I tried setting a constraint in the
device init code for UART (mach-omap2/serial.c:omap_serial_init_port()),
and then I realized that that runs before
mach-omap2/pm34xx.c:pwrdms_setup() which also calls
omap_set_pwrdm_state() for each powerdomain to initialize.

Also, for debug purposes, it might be useful to have a per-device sysfs
interface to setting this wakeup latency constraint.  Something like

   /sys/devices/platform/omap/.../power/wakeup_latency

I'm not sure exactly what to set the requesting device to though.  

As far as implementation goes, you've so far implemented only wakeup
latencies, but not througput.  When you implement throughput you will
have to duplicate large parts of this code and data structures for
throughput, and if ever add some other constraint (frequency, voltage)
it would need to be duplicated again.

Maybe now is the time to consider an interface to add a generic
per-device constraint, with a type (latency, throughput, etc.), or
"class" as it's called in PM QoS.  For now the type/class does not need
to be exposed externally, but will make implementing new constraint
types much easer.

Some other comments below...

> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Vibhore Vardhan <vvardhan@ti.com>
> ---
> Based on khilman's pm-core branch
>
>  arch/arm/mach-omap2/omap_hwmod.c              |   62 ++++++++-
>  arch/arm/mach-omap2/powerdomain.c             |  197 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h             |   39 +++++-
>  arch/arm/mach-omap2/powerdomains3xxx_data.c   |   60 ++++++++
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
>  arch/arm/plat-omap/omap-pm-constraints.c      |  121 +++++++--------
>  arch/arm/plat-omap/omap_device.c              |   28 ++++
>  8 files changed, 446 insertions(+), 65 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index 028efda..bad8248 100644
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
> @@ -2267,10 +2268,69 @@ ohsps_unlock:
>  }
>  
>  /**
> + * omap_hwmod_set_max_dev_wakeup_lat - set a device wake-up constraint
> + * @oh: the device of @oh to set a constraint on.
> + * @req_oh: the device of @req_oh is the requester of the constraint.
> + * @t: wakeup latency constraint (us). -1 removes the existing constraint.
> + *
> + * Query the powerdomain of @oh to set/release the wake-up constraint.
> + * @oh is used to determine which power domain to set a constraint on.
> + * @req_oh is used to record the requester for later update or removal
> + * of a constraint.
> + *
> + * Returns -EINVAL if @oh or @req_oh have no power domain, or the return
> + * code from the pwrdm function (pwrdm_wakeuplat_set/release_constraint)
> + * of the powerdomain assocated with @oh.
> + */
> +int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod *req_oh,
> +				      struct omap_hwmod *oh, long t)
> +{
> +	struct device *req_dev;
> +	struct platform_device *req_pdev;
> +	struct powerdomain *pwrdm;
> +
> +	pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	/* Catch devices with undefined powerdomains */
> +	if (!PTR_ERR(pwrdm)) {
> +		pr_err("omap_hwmod: Error: could not find parent "
> +			"powerdomain for %s\n", oh->name);
> +		return -EINVAL;
> +	}
> +
> +	req_pdev = &(req_oh->od->pdev);
> +	if (!PTR_ERR(req_pdev)) {
> +		pr_err("omap_hwmod: Error: pdev not found for oh %s\n",
> +		       oh->name);
> +		return -EINVAL;
> +	}
> +
> +	req_dev = &(req_pdev->dev);
> +	if (!PTR_ERR(req_dev)) {
> +		pr_err("omap_hwmod: Error: device not found for oh %s\n",
> +		       oh->name);
> +		return -EINVAL;
> +	}
> +
> +	/* Call set/release_constraint for the given pwrdm */
> +	if (t == -1) {
> +		pr_debug("omap_hwmod: remove max device latency constraint: "
> +			 "oh %s, pwrdm %s, req by oh %s\n",
> +			 oh->name, pwrdm->name, req_oh->name);
> +	} else {
> +		pr_debug("omap_hwmod: add max device latency constraint: "
> +			 "oh %s, t = %ld usec, pwrdm %s, req by oh %s\n",
> +			 oh->name, t, pwrdm->name, req_oh->name);
> +	}
> +
> +	return pwrdm_wakeuplat_set_constraint(pwrdm, req_dev, t);
> +}
> +
> +/**
>   * omap_hwmod_get_context_loss_count - get lost context count
>   * @oh: struct omap_hwmod *
>   *
> - * Query the powerdomain of of @oh to get the context loss
> + * Query the powerdomain of @oh to get the context loss
>   * count for this device.
>   *
>   * Returns the context loss count of the powerdomain assocated with @oh
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index eaed0df..6fb4741 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,6 +19,8 @@
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <linux/slab.h>
> +
>  #include "cm2xxx_3xxx.h"
>  #include "prcm44xx.h"
>  #include "cm44xx.h"
> @@ -103,6 +105,13 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  	pwrdm->state = pwrdm_read_pwrst(pwrdm);
>  	pwrdm->state_counter[pwrdm->state] = 1;
>  
> +	/* Initialize priority ordered list for wakeup latency constraint */
> +	spin_lock_init(&pwrdm->wakeuplat_lock);
> +	plist_head_init(&pwrdm->wakeuplat_dev_list, &pwrdm->wakeuplat_lock);
> +
> +	/* res_mutex protects res_list add and del ops */
> +	mutex_init(&pwrdm->wakeuplat_mutex);
> +
>  	pr_debug("powerdomain: registered %s\n", pwrdm->name);
>  
>  	return 0;
> @@ -176,6 +185,74 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
>  	return 0;
>  }
>  
> +/**
> + * pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
> + * @pwrdm: struct powerdomain * to which requesting device belongs to.
> + *
> + * Finds the minimum allowed wake-up latency value from all entries
> + * in the list and the power domain power state needing the constraint.
> + * Programs a new target state if it is different from current power state.
> + *
> + * Only OMAP3xxx is supported for now
> + *
> + * Returns 0 upon success.
> + */
> +static int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm)
> +{
> +	struct plist_node *node;
> +	int ret = 0, new_state;
> +	long min_latency = -1;
> +
> +	/* Find the strongest constraint from the plist */
> +	if (!plist_head_empty(&pwrdm->wakeuplat_dev_list)) {
> +		node = plist_first(&pwrdm->wakeuplat_dev_list);
> +		min_latency = node->prio;
> +	}
> +
> +	/* Find power state with wakeup latency < minimum constraint. */
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
> +		if (cpu_is_omap34xx())
> +			pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);

cpu_is_* checks here aren't right.

You should use SoC specific function pointers as are done for many of the
other powerdomain calls after Rajendra's splitup series.

> +		new_state = PWRDM_POWER_RET;
> +		break;
> +	case PWRDM_FUNC_PWRST_CSWR:
> +		if (cpu_is_omap34xx())
> +			pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
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
> +		if (cpu_is_omap34xx())
> +			ret = omap_set_pwrdm_state(pwrdm, new_state);
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

[...]

> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> index e1bec56..4f7e44d 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -52,6 +52,12 @@ static struct powerdomain iva2_pwrdm = {
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
>  
>  static struct powerdomain mpu_3xxx_pwrdm = {
> @@ -68,6 +74,12 @@ static struct powerdomain mpu_3xxx_pwrdm = {
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
>  
>  /*
> @@ -98,6 +110,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
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
> @@ -121,6 +139,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
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
>  static struct powerdomain dss_pwrdm = {
> @@ -136,6 +160,12 @@ static struct powerdomain dss_pwrdm = {
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
> @@ -157,6 +187,12 @@ static struct powerdomain sgx_pwrdm = {
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
> @@ -172,6 +208,12 @@ static struct powerdomain cam_pwrdm = {
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
> @@ -187,6 +229,12 @@ static struct powerdomain per_pwrdm = {
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
> @@ -201,6 +249,12 @@ static struct powerdomain neon_pwrdm = {
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
> @@ -223,6 +277,12 @@ static struct powerdomain usbhost_pwrdm = {
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

A summary about where the latency numbers for each powerdomain come from
would be useful.

[...]

> @@ -87,64 +60,86 @@ int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsigned long r)
>  	return 0;
>  }
>  
> +/*
> + * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up latency
> + * constraints
> + */
>  int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
>  				   long t)
>  {
> +	struct platform_device *pdev, *req_pdev;
> +	int ret = 0;
> +
>  	if (!req_dev || !dev || t < -1) {
>  		WARN(1, "OMAP PM: %s: invalid parameter(s)", __func__);
>  		return -EINVAL;
> +	}
> +
> +	/* Look for the platform devices */
> +	pdev = to_platform_device(dev);
> +	req_pdev = to_platform_device(req_dev);
> +
> +	/* Try to catch non platform devices. */
> +	if ((pdev->name == NULL) || (req_pdev->name == NULL)) {
> +		pr_err("OMAP-PM set_wakeup_lat: Error: platform devices "
> +		       "not valid\n");
> +		return -EINVAL;
> +	} else {
> +		/* Call the omap_device API */
> +		ret = omap_device_set_max_dev_wakeup_lat(req_pdev, pdev, t);
> +	}

I don't think a NULL name check is the right sanity check here.  WHat
you really need to know is whether the target device is an omap_device.
The requesting device can be anything (I think.)

Here's a simpler check:

	if (pdev->dev->parent == &omap_device_parent)
		ret = omap_device_set_max_dev_wakeup_lat(req_pdev, pdev, t);
	else
		...

                        
> +	return ret;
> +}

Kevin
