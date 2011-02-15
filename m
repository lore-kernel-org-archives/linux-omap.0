From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 2/2] OMAP: PM: implement devices wakeup latency
 constraints APIs
Date: Tue, 15 Feb 2011 15:05:25 +0530
Message-ID: <b34afc47bcc37fa68315718cdbcd19e1@mail.gmail.com>
References: <1297365807-12143-1-git-send-email-j-pihet@ti.com> <1297365807-12143-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36160 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751089Ab1BOJfb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 04:35:31 -0500
Received: by mail-fx0-f44.google.com with SMTP id 9so6359842fxm.17
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 01:35:29 -0800 (PST)
In-Reply-To: <1297365807-12143-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Vibhore Vardhan <vvardhan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: jean.pihet@newoldbits.com [mailto:jean.pihet@newoldbits.com]
> Sent: Friday, February 11, 2011 12:53 AM
> To: khilman@ti.com; paul@pwsan.com; Vibhore Vardhan; Santosh
> Shilimkar; Vishwanath BS; rnayak@ti.com
> Cc: linux-omap@vger.kernel.org; Jean Pihet; Vibhore Vardhan
> Subject: [PATCH 2/2] OMAP: PM: implement devices wakeup latency
> constraints APIs
>
> From: Jean Pihet <j-pihet@ti.com>
>
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
> and instead directly use the omap_device level API.
>
> Based on Vibhore's original patch , adapted to omap_device and
> omap_hwmod frameworks.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Vibhore Vardhan <vvardhan@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   62 +++++++++-
>  arch/arm/mach-omap2/powerdomain.c             |  176
> ++++++++++++++++++++++++-
>  arch/arm/mach-omap2/powerdomain.h             |   31 +++++
>  arch/arm/mach-omap2/powerdomains3xxx_data.c   |   60
> +++++++++
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
>  arch/arm/plat-omap/omap-pm-constraints.c      |  101 ++++++---------
>  arch/arm/plat-omap/omap_device.c              |   28 ++++
>  8 files changed, 399 insertions(+), 63 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> omap2/omap_hwmod.c
> index e282e35..0dc096f 100644
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
> @@ -2198,10 +2199,69 @@ ohsps_unlock:
>  }
>
>  /**
> + * omap_hwmod_set_max_dev_wakeup_lat - set a device wake-up
> constraint
> + * @oh: struct omap_hwmod *
> + * @req_oh: struct omap_hwmod *
Need to explain what this parameters mean.
> + * @t: wakeup latency constraint (us). -1 removes the existing
> constraint
> + *
> + * Query the powerdomain of @oh to set/release the wake-up
> constraint
> + *
> + * Returns -EINVAL if @oh or @req_oh have no power domain, or the
> return
> + * code from the pwrdm function
> (pwrdm_wakeuplat_set/release_constraint)
> + * of the powerdomain assocated with @oh.
> + */
> +int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod
> *req_oh,
> +				      struct omap_hwmod *oh, long t)
> +{
> +	struct device *req_dev;
> +	struct platform_device *pdev;
> +	struct powerdomain *pwrdm;
> +	int ret = 0;
> +
> +	pwrdm = omap_hwmod_get_pwrdm(oh);
> +
> +	/* Catch devices with undefined powerdomains */
> +	if (!pwrdm) {
> +		pr_err("omap_hwmod: Error: could not find parent "
> +			"powerdomain for %s\n", oh->name);
> +		return -EINVAL;
> +	}
> +
> +	pdev = &(req_oh->od->pdev);
> +	if (pdev == NULL) {
> +		pr_err("omap_hwmod: Error: pdev not found for oh %s\n",
> +		       oh->name);
> +		return -EINVAL;
> +	}
> +
> +	req_dev = &(pdev->dev);
> +	if (req_dev == NULL) {
> +		pr_err("omap_hwmod: Error: device not found for oh
> %s\n",
> +		       oh->name);
> +		return -EINVAL;
> +	}
If I understand correctly, req_dev is used for keeping track of different
requests. If so, why can't you directly pass req_dev as an input param
instead of deriving it from pdev.
> +
> +	/* Call set/release_constraint for the given pwrdm */
> +	if (t == -1) {
> +		pr_debug("omap_hwmod: remove max device latency
> constraint: "
> +			 "oh %s, pwrdm %s, req by oh %s\n",
> +			 oh->name, pwrdm->name, req_oh->name);
> +		ret = pwrdm_wakeuplat_release_constraint(pwrdm,
> req_dev);
> +	} else {
> +		pr_debug("omap_hwmod: add max device latency
> constraint: "
> +			 "oh %s, t = %ld usec, pwrdm %s, req by oh
> %s\n",
> +			 oh->name, t, pwrdm->name, req_oh->name);
> +		ret = pwrdm_wakeuplat_set_constraint(pwrdm, req_dev,
> t);
> +	}
> +
> +	return 0;
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
>   * Returns the context loss count of the powerdomain assocated with
> @oh
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
> omap2/powerdomain.c
> index eaed0df..3ed3bea 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,16 +19,19 @@
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <linux/slab.h>
> +
> +#include <plat/cpu.h>
> +#include <plat/prcm.h>
> +
>  #include "cm2xxx_3xxx.h"
>  #include "prcm44xx.h"
>  #include "cm44xx.h"
>  #include "prm2xxx_3xxx.h"
>  #include "prm44xx.h"
>
> -#include <plat/cpu.h>
>  #include "powerdomain.h"
>  #include "clockdomain.h"
> -#include <plat/prcm.h>
>
>  #include "pm.h"
>
> @@ -103,6 +106,13 @@ static int _pwrdm_register(struct powerdomain
> *pwrdm)
>  	pwrdm->state = pwrdm_read_pwrst(pwrdm);
>  	pwrdm->state_counter[pwrdm->state] = 1;
>
> +	/* Initialize priority ordered list for wakeup latency constraint
*/
> +	spin_lock_init(&pwrdm->wakeuplat_lock);
> +	plist_head_init(&pwrdm->wakeuplat_dev_list, &pwrdm-
> >wakeuplat_lock);
> +
> +	/* res_mutex protects res_list add and del ops */
> +	mutex_init(&pwrdm->wakeuplat_mutex);
> +
>  	pr_debug("powerdomain: registered %s\n", pwrdm->name);
>
>  	return 0;
> @@ -176,6 +186,62 @@ static int _pwrdm_post_transition_cb(struct
> powerdomain *pwrdm, void *unused)
>  	return 0;
>  }
>
> +/**
> + * pwrdm_wakeuplat_update_pwrst - Update power domain power
> state if needed
> + * @pwrdm: struct powerdomain * to which requesting device belongs
> to
> + *
> + * Finds minimum latency value from all entries in the list and
> + * the power domain power state needing the constraint. Programs
> + * new state if it is different from current power state.
> + */
> +static void pwrdm_wakeuplat_update_pwrst(struct powerdomain
> *pwrdm)
> +{
> +	struct plist_node *node;
> +	int new_state;
> +	unsigned long min_latency = -1;
> +
> +	if (!plist_head_empty(&pwrdm->wakeuplat_dev_list)) {
> +		node = plist_last(&pwrdm->wakeuplat_dev_list);
Wouldn't plist_last return the node with highest latency? I think you are
looking for lowest latency.
> +		min_latency = node->prio;
> +	}
> +
> +	/* Find power state with wakeup latency < minimum constraint.
> */
> +	for (new_state = 0x0; new_state < PWRDM_MAX_PWRSTS;
> new_state++) {
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
> +	case PWRDM_FUNC_PWRST_CSWR:
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
Why this cpu check here?
> +			omap_set_pwrdm_state(pwrdm, new_state);
> +	}
> +
> +	pr_debug("powerdomain: %s pwrst: curr= %d, prev= %d next=
> %d "
> +		 "wkuplat_min= %lu, set_state= %d\n", pwrdm->name,
> +		 pwrdm_read_pwrst(pwrdm),
> pwrdm_read_prev_pwrst(pwrdm),
> +		 pwrdm_read_next_pwrst(pwrdm), min_latency,
> new_state);
> +}
> +
>  /* Public functions */
>
>  /**
> @@ -911,6 +977,112 @@ int pwrdm_post_transition(void)
>  }
>
>  /**
> + * pwrdm_wakeuplat_set_constraint - Set powerdomain wakeup
> latency constraint
> + * @pwrdm: struct powerdomain * to which requesting device belongs
> to
> + * @dev: struct device * of requesting device
> + * @t: wakeup latency constraint in microseconds
> + *
> + * Adds new entry to powerdomain's wakeup latency constraint list.
> + * If the requesting device already exists in the list, old value is
> + * overwritten. Checks whether current power state is still adequate.
> + * Returns -EINVAL if the powerdomain or device pointer is NULL,
> + * or -ENOMEM if kmalloc fails, or returns 0 upon success.
> + */
> +int pwrdm_wakeuplat_set_constraint(struct powerdomain *pwrdm,
> +				   struct device *req_dev, unsigned long
t)
> +{
> +	struct  wakeuplat_dev_list *user;
> +	int found = 0, ret = 0;
> +
> +	if (!pwrdm || !req_dev) {
> +		WARN(1, "powerdomain: %s: invalid parameter(s)",
> __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&pwrdm->wakeuplat_mutex);
> +
> +	plist_for_each_entry(user, &pwrdm->wakeuplat_dev_list, node) {
> +		if (user->dev == req_dev) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	/* Add new entry to the list or update existing request */
> +	if (found && user->constraint_us == t) {
> +		goto exit_set;
> +	} else if (!found) {
> +		user = kzalloc(sizeof(struct wakeuplat_dev_list),
> GFP_KERNEL);
> +		if (!user) {
> +			pr_err("powerdomain: FATAL ERROR: kzalloc
> failed\n");
> +			ret = -ENOMEM;
> +			goto exit_set;
> +		}
> +		user->dev = req_dev;
> +	} else {
> +		plist_del(&user->node, &pwrdm->wakeuplat_dev_list);
> +	}
> +
> +	plist_node_init(&user->node, t);
> +	plist_add(&user->node, &pwrdm->wakeuplat_dev_list);
> +	user->node.prio = user->constraint_us = t;
> +
> +	pwrdm_wakeuplat_update_pwrst(pwrdm);
> +
> +exit_set:
> +	mutex_unlock(&pwrdm->wakeuplat_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * pwrdm_wakeuplat_release_constraint - Release powerdomain
> wkuplat constraint
> + * @pwrdm: struct powerdomain * to which requesting device belongs
> to
> + * @req_dev: struct device * of requesting device
> + *
> + * Removes device's entry from powerdomain's wakeup latency
> constraint list.
> + * Checks whether current power state is still adequate.
> + * Returns -EINVAL if the powerdomain or device pointer is NULL or
> + * no such entry exists in the list, or returns 0 upon success.
> + */
> +int pwrdm_wakeuplat_release_constraint(struct powerdomain *pwrdm,
> +				       struct device *req_dev)
> +{
> +	struct wakeuplat_dev_list *user;
> +	int found = 0, ret = 0;
> +
> +	if (!pwrdm || !req_dev) {
> +		WARN(1, "powerdomain: %s: invalid parameter(s)",
> __func__);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&pwrdm->wakeuplat_mutex);
> +
> +	plist_for_each_entry(user, &pwrdm->wakeuplat_dev_list, node) {
> +		if (user->dev == req_dev) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		pr_err("OMAP PM: Error: no prior constraint to
release\n");
> +		ret = -EINVAL;
> +		goto exit_rls;
> +	}
> +
> +	plist_del(&user->node, &pwrdm->wakeuplat_dev_list);
> +	kfree(user);
> +
> +	pwrdm_wakeuplat_update_pwrst(pwrdm);
> +
> +exit_rls:
> +	mutex_unlock(&pwrdm->wakeuplat_mutex);
> +
> +	return ret;
> +}
> +
> +/**
>   * pwrdm_get_context_loss_count - get powerdomain's context loss
> count
>   * @pwrdm: struct powerdomain * to wait for
>   *
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-
> omap2/powerdomain.h
> index c66431e..d4189d8 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -19,6 +19,9 @@
>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/plist.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
>
>  #include <linux/atomic.h>
>
> @@ -46,6 +49,15 @@
>
>  #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | (1 <<
> PWRDM_POWER_ON))
>
> +/* Powerdomain functional power states */
> +#define PWRDM_FUNC_PWRST_OFF	0x0
> +#define PWRDM_FUNC_PWRST_OSWR	0x1
> +#define PWRDM_FUNC_PWRST_CSWR	0x2
> +#define PWRDM_FUNC_PWRST_ON	0x3
> +
> +#define PWRDM_MAX_FUNC_PWRSTS	4
> +
> +#define UNSUP_STATE		-1
>
>  /* Powerdomain flags */
>  #define PWRDM_HAS_HDWR_SAR	(1 << 0) /* hardware save-and-
> restore support */
> @@ -96,6 +108,10 @@ struct powerdomain;
>   * @state_counter:
>   * @timer:
>   * @state_timer:
> + * @wakeup_lat: Wakeup latencies for possible powerdomain power
> states
> + * @wakeuplat_lock: spinlock for plist
> + * @wakeuplat_dev_list: plist_head linking all devices placing
> constraint
> + * @wakeuplat_mutex: mutex to protect per powerdomain list ops
>   *
>   * @prcm_partition possible values are defined in mach-
> omap2/prcm44xx.h.
>   */
> @@ -121,6 +137,16 @@ struct powerdomain {
>  	s64 timer;
>  	s64 state_timer[PWRDM_MAX_PWRSTS];
>  #endif
> +	const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
> +	spinlock_t wakeuplat_lock;
> +	struct plist_head wakeuplat_dev_list;
> +	struct mutex wakeuplat_mutex;
> +};
> +
> +struct wakeuplat_dev_list {
> +	struct device *dev;
> +	unsigned long constraint_us;
> +	struct plist_node node;
>  };
>
>  /**
> @@ -211,6 +237,11 @@ int pwrdm_clkdm_state_switch(struct
> clockdomain *clkdm);
>  int pwrdm_pre_transition(void);
>  int pwrdm_post_transition(void);
>  int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
> +
> +int pwrdm_wakeuplat_set_constraint(struct powerdomain *pwrdm,
> +				   struct device *dev, unsigned long t);
> +int pwrdm_wakeuplat_release_constraint(struct powerdomain *pwrdm,
> +				       struct device *dev);
>  u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
>
>  extern void omap2xxx_powerdomains_init(void);
> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> b/arch/arm/mach-omap2/powerdomains3xxx_data.c
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
> @@ -98,6 +110,12 @@ static struct powerdomain
> core_3xxx_pre_es3_1_pwrdm = {
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
> @@ -121,6 +139,12 @@ static struct powerdomain
> core_3xxx_es3_1_pwrdm = {
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
>
>  static struct powerdomain dpll1_pwrdm = {
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h
> b/arch/arm/plat-omap/include/plat/omap_device.h
> index e4c349f..5da6b47 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -107,6 +107,8 @@ void __iomem *omap_device_get_rt_va(struct
> omap_device *od);
>  int omap_device_align_pm_lat(struct platform_device *pdev,
>  			     u32 new_wakeup_lat_limit);
>  struct powerdomain *omap_device_get_pwrdm(struct omap_device
> *od);
> +int omap_device_set_max_dev_wakeup_lat(struct platform_device
> *req_pdev,
> +				       struct platform_device *pdev, long
t);
>  u32 omap_device_get_context_loss_count(struct platform_device
> *pdev);
>
>  /* Other */
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> index 1eee85a..0fbb974 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -587,6 +587,8 @@ int omap_hwmod_for_each_by_class(const char
> *classname,
>  				 void *user);
>
>  int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8
> state);
> +int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod
> *req_oh,
> +				      struct omap_hwmod *oh, long t);
>  u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>
>  /*
> diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat-
> omap/omap-pm-constraints.c
> index c8b4e4c..7ae855f 100644
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
> @@ -32,34 +33,6 @@ static u32 dummy_context_loss_counter;
>   * Device-driver-originated constraints (via board-*.c files)
>   */
>
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> -{
> -	if (!dev || t < -1) {
> -		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
> -		return -EINVAL;
> -	};
> -
> -	if (t == -1)
> -		pr_debug("OMAP PM: remove max MPU wakeup latency
> constraint: "
> -			 "dev %s\n", dev_name(dev));
> -	else
> -		pr_debug("OMAP PM: add max MPU wakeup latency
> constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> -
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
> -
> -	return 0;
> -}
> -
>  int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id,
> unsigned long r)
>  {
>  	if (!dev || (agent_id != OCP_INITIATOR_AGENT &&
> @@ -87,62 +60,70 @@ int omap_pm_set_min_bus_tput(struct device
> *dev, u8 agent_id, unsigned long r)
>  	return 0;
>  }
>
> +/*
> + * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up
> latency
> + * constraints
> + */
>  int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct
> device *dev,
>  				   long t)
>  {
> +	struct platform_device *pdev, *req_pdev;
> +	int ret = 0;
> +
>  	if (!req_dev || !dev || t < -1) {
>  		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
>  		return -EINVAL;
> +	}
> +
> +	/* Look for the platform devices */
> +	pdev = container_of(dev, struct platform_device, dev);

You could perhaps use macro to_platform_device instead of using
container_of.

> +	req_pdev = container_of(req_dev, struct platform_device, dev);
> +
> +	/* Try to catch non platform devices. */
> +	if ((pdev->name == NULL) || (req_pdev->name == NULL)) {
> +		pr_err("OMAP-PM set_wakeup_lat: Error: platform devices
> "
> +		       "not valid\n");
> +		return -EINVAL;
> +	} else {
> +		/* Call the omap_device API */
> +		ret = omap_device_set_max_dev_wakeup_lat(req_pdev,
> pdev, t);
> +	}
> +
> +	return ret;
> +}
> +
> +int omap_pm_set_max_mpu_wakeup_lat(struct device *req_dev, long
> t)
> +{
> +	if (!req_dev || t < -1) {
> +		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
> +		return -EINVAL;
>  	};
>
>  	if (t == -1)
> -		pr_debug("OMAP PM: remove max device latency
> constraint: "
> -			 "dev %s\n", dev_name(dev));
> +		pr_debug("OMAP PM: remove max MPU wakeup latency
> constraint: "
> +			 "dev %s\n", dev_name(req_dev));
>  	else
> -		pr_debug("OMAP PM: add max device latency constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> +		pr_debug("OMAP PM: add max MPU wakeup latency
> constraint: "
> +			 "dev %s, t = %ld usec\n", dev_name(req_dev), t);
>
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
> +	omap_pm_set_max_dev_wakeup_lat(req_dev,
> omap2_get_mpuss_device(), t);
>
>  	return 0;
>  }
>
> -int omap_pm_set_max_sdma_lat(struct device *dev, long t)
> +int omap_pm_set_max_sdma_lat(struct device *req_dev, long t)
>  {
> -	if (!dev || t < -1) {
> +	if (!req_dev || t < -1) {
>  		WARN(1, "OMAP PM: %s: invalid parameter(s)",
> __func__);
>  		return -EINVAL;
>  	};
>
>  	if (t == -1)
>  		pr_debug("OMAP PM: remove max DMA latency constraint:
> "
> -			 "dev %s\n", dev_name(dev));
> +			 "dev %s\n", dev_name(req_dev));
>  	else
>  		pr_debug("OMAP PM: add max DMA latency constraint: "
> -			 "dev %s, t = %ld usec\n", dev_name(dev), t);
> -
> -	/*
> -	 * For current Linux PM QOS params, this code should scan the
> -	 * list of maximum CPU and DMA latencies and select the
> -	 * smallest, then set cpu_dma_latency pm_qos_param
> -	 * accordingly.
> -	 *
> -	 * For future Linux PM QOS params, with separate CPU and DMA
> -	 * latency params, this code should just set the dma_latency
> param.
> -	 *
> -	 * TI CDP code can call constraint_set here.
> -	 */
> +			 "dev %s, t = %ld usec\n", dev_name(req_dev), t);
>
>  	return 0;
>  }
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-
> omap/omap_device.c
> index 57adb27..1fe93d3 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -280,6 +280,34 @@ static void _add_optional_clock_alias(struct
> omap_device *od,
>  /* Public functions for use by core code */
>
>  /**
> + * omap_device_set_max_dev_wakeup_lat - set/release a device
> constraint
> + * @od: struct omap_device *
> + * @req_od: struct omap_device *
> + *
> + * Using the primary hwmod, set/release a device constraint for the
> pdev
> + * device, requested by the req_pdev device.
> + *
> + * If any hwmods exist for the omap_device assoiated with @pdev and
> @req_pdev,
> + * set/release the constraint for the corresponding hwmods, otherwise
> return
> + * -EINVAL.
> + */
> +int omap_device_set_max_dev_wakeup_lat(struct platform_device
> *req_pdev,
> +				       struct platform_device *pdev, long
t)
> +{
> +	struct omap_device *od, *req_od;
> +	u32 ret = -EINVAL;
> +
> +	od = _find_by_pdev(pdev);
> +	req_od = _find_by_pdev(req_pdev);
> +
> +	if ((od->hwmods_cnt) && (req_od->hwmods_cnt))
> +		ret = omap_hwmod_set_max_dev_wakeup_lat(req_od-
> >hwmods[0],
> +							od->hwmods[0], t);
> +
> +	return ret;
> +}
> +
> +/**
>   * omap_device_get_context_loss_count - get lost context count
>   * @od: struct omap_device *
>   *
Vishwa
> --
> 1.7.2.3
