From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 1/6] OMAP2+: powerdomain: control power domains next state
Date: Thu, 17 Nov 2011 13:16:50 -0800
Message-ID: <87obwa30vx.fsf@ti.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39143 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533Ab1KQVRA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Nov 2011 16:17:00 -0500
Received: by iaen33 with SMTP id n33so3370427iae.40
        for <linux-omap@vger.kernel.org>; Thu, 17 Nov 2011 13:16:59 -0800 (PST)
In-Reply-To: <1319032263-22699-2-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Wed, 19 Oct 2011 15:50:58 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, magnus.damm@gmail.com, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> When a PM QoS device latency constraint is requested or removed the
> PM QoS layer notifies the underlying layer with the updated aggregated
> constraint value. The constraint is stored in the powerdomain constraints
> list and then applied to the corresponding power domain.
> The power domains get the next power state programmed directly in the
> registers via pwrdm_wakeuplat_update_pwrst.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
> wake-up latency constraints on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |  237 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h |   35 +++++-
>  2 files changed, 270 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 9af0847..351766d 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -17,8 +17,10 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <linux/pm_qos.h>
>  #include <trace/events/power.h>
>  
>  #include "cm2xxx_3xxx.h"
> @@ -104,6 +106,12 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>  	for (i = 0; i < pwrdm->banks; i++)
>  		pwrdm->ret_mem_off_counter[i] = 0;
>  
> +	/* Initialize the per-od wake-up constraints data */

This comment needs an update (they are not per-od, but per pwrdm), or
could probably be removed, since it doesn't add any value over the code.

> +	spin_lock_init(&pwrdm->wkup_lat_plist_lock);
> +	plist_head_init(&pwrdm->wkup_lat_plist_head);
> +	pwrdm->wkup_lat_next_state = PWRDM_POWER_OFF;
> +
> +	/* Initialize the pwrdm state */
>  	pwrdm_wait_transition(pwrdm);
>  	pwrdm->state = pwrdm_read_pwrst(pwrdm);
>  	pwrdm->state_counter[pwrdm->state] = 1;
> @@ -191,6 +199,158 @@ static int _pwrdm_post_transition_cb(struct powerdomain *pwrdm, void *unused)
>  	return 0;
>  }
>  
> +/**
> + * _pwrdm_wakeuplat_update_list - Set/update/remove a powerdomain wakeup
> + *  latency constraint from the pwrdm's constraint list
> + * @pwrdm: struct powerdomain * which the constraint applies to
> + * @cookie: constraint identifier, used for tracking.
> + * @min_latency: minimum wakeup latency constraint (in microseconds) for
> + *  the given pwrdm. The value of PM_QOS_DEV_LAT_DEFAULT_VALUE removes
> + *  the constraint.
> + * @user: pointer to the current list entry
> + * @new_user: allocated list entry, used for insertion of new constraints
> + *  in the list
> + * @free_new_user: set to non-zero if the newly allocated list entry
> + *  is unused and needs to be freed
> + * @free_node: set to non-zero if the current list entry is not in use
> + *  anymore and needs to be freed
> + *
> + * Tracks the constraints by @cookie.
> + * Constraint set/update: Adds a new entry to powerdomain's wake-up latency
> + * constraint list.
> + * If the constraint identifier already exists in the list, the old value is
> + * overwritten.
> + * Constraint removal: Removes the identifier's entry from powerdomain's
> + * wakeup latency constraint list.
> + *
> + * Called with the pwrdm wakeup latency spinlock held.
> + *
> + * Returns 0 upon success, -EINVAL if the constraint is not existing.
> + */
> +static inline int _pwrdm_update_wakeuplat_list(
> +			struct powerdomain *pwrdm,
> +			void *cookie,
> +			long min_latency,
> +			struct pwrdm_wkup_constraints_entry *user,
> +			struct pwrdm_wkup_constraints_entry *new_user,
> +			int *free_new_user,
> +			int *free_node)
> +{
> +	struct pwrdm_wkup_constraints_entry *tmp_user;
> +
> +	/* Check if there already is a constraint for cookie */
> +	plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head, node) {
> +		if (tmp_user->cookie == cookie) {
> +			user = tmp_user;
> +			break;
> +		}
> +	}
> +
> +	if (min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> +		/* If nothing to update, job done */
> +		if (user && (user->node.prio == min_latency))
> +			return 0;
> +
> +		if (!user) {
> +			/* Add new entry to the list */
> +			user = new_user;
> +			user->cookie = cookie;
> +			*free_new_user = 0;
> +		} else {
> +			/* Update existing entry */
> +			plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
> +		}
> +
> +		plist_node_init(&user->node, min_latency);
> +		plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
> +	} else {
> +		if (user) {
> +			/* Remove the constraint from the list */
> +			plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
> +			*free_node = 1;
> +		} else {
> +			/* Constraint not existing or list empty, do nothing */
> +			return -EINVAL;
> +		}
> +
> +	}
> +
> +	return 0;
> +}

[...]

>  /**
> + * pwrdm_set_wkup_lat_constraint - Set/update/remove a powerdomain wakeup
> + *  latency constraint and apply it
> + * @pwrdm: struct powerdomain * which the constraint applies to
> + * @cookie: constraint identifier, used for tracking.
> + * @min_latency: minimum wakeup latency constraint (in microseconds) for
> + *  the given pwrdm. The value of PM_QOS_DEV_LAT_DEFAULT_VALUE removes
> + *  the constraint.
> + *
> + * Tracks the constraints by @cookie.
> + * Constraint set/update: Adds a new entry to powerdomain's wake-up latency
> + * constraint list.
> + * If the constraint identifier already exists in the list, the old value is
> + * overwritten.
> + * Constraint removal: Removes the identifier's entry from powerdomain's
> + * wakeup latency constraint list.
> + *
> + * Applies the aggregated constraint value for the given pwrdm by calling
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * Returns 0 upon success, -ENOMEM in case of memory shortage, -EINVAL in
> + * case of invalid parameters, or the return value from
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * The caller must check the validity of the parameters.
> + */
> +int pwrdm_set_wkup_lat_constraint(struct powerdomain *pwrdm, void *cookie,
> +				  long min_latency)
> +{
> +	struct pwrdm_wkup_constraints_entry *user = NULL, *new_user = NULL;
> +	int ret = 0, free_new_user = 0, free_node = 0;
> +	long value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
> +	unsigned long flags;
> +
> +	pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p, min_latency=%ld\n",
> +		 __func__, pwrdm->name, cookie, min_latency);
> +
> +	if (min_latency != PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> +		new_user = kzalloc(sizeof(struct pwrdm_wkup_constraints_entry),
> +				   GFP_KERNEL);
> +		if (!new_user) {
> +			pr_err("%s: FATAL ERROR: kzalloc failed\n", __func__);
> +			return -ENOMEM;
> +		}
> +		free_new_user = 1;
> +	}
> +
> +	spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
> +
> +	/* Manage the constraints list */
> +	ret = _pwrdm_update_wakeuplat_list(pwrdm, cookie, min_latency,
> +					   user, new_user,
> +					   &free_new_user, &free_node);
> +
> +	/* Find the aggregated constraint value from the list */
> +	if (!ret)
> +		if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
> +			value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;
> +
> +	spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
> +
> +	if (free_node)
> +		kfree(user);
> +
> +	if (free_new_user)
> +		kfree(new_user);

The alloc/free of these buffers is not terribly obvious when reading.  I
think the code/changelog needs some comments describing the logic
behind how/when these nodes are allocated and freed.

> +	/* Apply the constraint to the pwrdm */
> +	if (!ret) {
> +		pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
> +			 __func__, pwrdm->name, value);
> +		ret = _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
> +	}
> +
> +	return ret;
> +}
> +

Kevin
