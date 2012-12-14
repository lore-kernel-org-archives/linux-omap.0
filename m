From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/8] ARM: OMAP2+: PM QoS: control the power domains next
 state from the constraints
Date: Fri, 14 Dec 2012 16:50:17 +0100
Message-ID: <CAORVsuU47YA9Y07Vu64Fb0vpDcFeyaPJQ6cxNTPDMnKAqUeLeQ@mail.gmail.com>
References: <1347958332-2205-1-git-send-email-j-pihet@ti.com>
	<1347958332-2205-2-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1212110002020.1982@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64916 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab2LNPuS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 10:50:18 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so6084096ieb.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Dec 2012 07:50:17 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1212110002020.1982@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Jean Pihet <j-pihet@ti.com>, Djamil Elaidi <d-elaidi@ti.com>

Hi Paul,

On Tue, Dec 11, 2012 at 1:05 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Tue, 18 Sep 2012, Jean Pihet wrote:
>
>> When a PM QoS device latency constraint is requested or removed the
>> constraint is stored in the constraints list of the corresponding power
>> domain, then the aggregated constraint value is applied by programming
>> the next functional power state using pwrdm_set_fpwrst.
>>
>> The per-device PM QoS locking requires a spinlock to be used. The reasons
>> is that some drivers need to use the per-device PM QoS functionality from
>> interrupt context or spinlock protected context, as reported by Djamil.
>> An example of such a driver is the OMAP HSI (high-speed synchronous serial
>> interface) driver which needs to control the IP block idle state from
>> the FIFO empty state, from interrupt context.
>>
>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
>> wake-up latency constraints on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Djamil Elaidi <d-elaidi@ti.com>
>
> This patch has been changed here.  Details below, but the major changes
Thanks for reworking this!

> were to fix the locking and to not attempt GFP_ATOMIC allocations.
> Hopefully the reasons why are clear, but if not, feel free to ask.
This is fine.

Note about the locking and the allocations:
The locking had been changed to spinlocks because of the potential
need to call the per-device PM QoS API from interrupt or spinlock
protected context.
Unfortunately the per-device PM QoS cannot be called from such a
context, because (1) it internally uses mutexes and (2) it relies on a
blocking notification mechanism.
However after discussion with Rafael W at ELCE, the PM QoS framework
will be reworked to get rid of the overly complex notification
mechanism [1]. The generic power domain framework will be used instead
to apply the constraints to the power domains at the time the power
domain is set up to transition to a lower power state (e.g. when the
last active device of a power domain is set up to idle automatically).
The implementation on OMAP needs some thinking. This very patch is ok
but the registration mechanism to the PM QoS framework [2] will need
to change.

[1] http://marc.info/?l=linux-pm&m=134856516908683&w=2
[2] http://marc.info/?l=linux-omap&m=134795836304294&w=2

>
> The following patch has only been compile-tested, and a few more minor
> changes will probably be needed.
Reviewed only from my side.

More comments here below.

>
>
> - Paul
>
> From: Jean Pihet <jean.pihet@newoldbits.com>
> Date: Sun, 9 Dec 2012 18:38:12 -0700
> Subject: [PATCH] ARM: OMAP2+: PM QoS: control the power domains next state
>  from the constraints
>
> When a PM QoS device latency constraint is requested or removed the
> constraint is stored in the constraints list of the corresponding power
> domain, then the aggregated constraint value is applied by programming
> the next functional power state using pwrdm_set_fpwrst.
>
> The per-device PM QoS locking requires a spinlock to be used. The reasons
> is that some drivers need to use the per-device PM QoS functionality from
> interrupt context or spinlock protected context, as reported by Djamil.
> An example of such a driver is the OMAP HSI (high-speed synchronous serial
> interface) driver which needs to control the IP block idle state from
> the FIFO empty state, from interrupt context.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
> wake-up latency constraints on MPU, CORE and PER.
Has it been tested already?

> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Djamil Elaidi <d-elaidi@ti.com>
> [paul@pwsan.com: updated to apply; renamed *state to *fpwrst and
>  define as u8; use existing powerdomain spinlock; pack the struct powerdomain
>  variables; removed the GFP_ATOMIC allocation; drop expensive operations
>  from the _pwrdm_wakeuplat_update_pwrst() debug; ensure that the entire
>  wakeuplat update process takes place under the spinlock; remove
>  UNSUP_STATE; remove assumption that fpwrsts start at 0; remove
>  unnecessary plist_empty test from update path; standardize 'wakeuplat'
>  naming; add kerneldoc]
>
> XXX conform debug to other powerdomain debugging
There are a few 'XXX' comments left.

> ---
>  arch/arm/mach-omap2/powerdomain.c |  208 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/powerdomain.h |   27 ++++-
>  2 files changed, 233 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index 7caceaa..bcba0af 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -21,8 +21,10 @@
>  #include <linux/kernel.h>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/slab.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <linux/pm_qos.h>
>  #include <linux/spinlock.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
> @@ -125,6 +127,9 @@ static int _pwrdm_register(struct powerdomain *pwrdm)
>         for (i = 0; i < PWRDM_FPWRSTS_COUNT; i++)
>                 pwrdm->fpwrst_counter[i] = 0;
>
> +       plist_head_init(&pwrdm->wakeuplat_plist_head);
> +       pwrdm->wakeuplat_next_fpwrst = PWRDM_FUNC_PWRST_OFF;
> +
>         arch_pwrdm->pwrdm_wait_transition(pwrdm);
>         pwrdm->fpwrst = pwrdm_read_fpwrst(pwrdm);
>         pwrdm->fpwrst_counter[pwrdm->fpwrst - PWRDM_FPWRST_OFFSET] = 1;
> @@ -765,6 +770,58 @@ static int _pwrdm_set_fpwrst(struct powerdomain *pwrdm,
>         return ret;
>  }
>
> +/**
> + * _pwrdm_wakeuplat_update_pwrst - Update power domain power state if needed
> + * @pwrdm: struct powerdomain * to which requesting device belongs to.
> + * @min_latency: the allowed wake-up latency for the given power domain. A
> + *  value of PM_QOS_DEV_LAT_DEFAULT_VALUE means 'no constraint' on the pwrdm.
> + *
> + * Finds the power domain next power state that fulfills the constraint.
> + * Programs a new target state if it is different from current power state.
> + * The power domains get the next power state programmed directly in the
> + * registers.
> + *
> + * Must be called with the powerdomain lock held.
> + *
> + * Returns 0 in case of success, -EINVAL in case of invalid parameters,
> + * or the return value from _pwrdm_set_fpwrst().
> + */
> +static int _pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
> +                                        long min_latency)
> +{
> +       int ret = 0, new_fpwrst = PWRDM_FUNC_PWRST_ON;
> +       int fpwrst, pwl_index;
> +
> +       /*
> +        * Find the next supported power state with
> +        *  wakeup latency <= min_latency.
> +        * Pick the lower state if no constraint on the pwrdm
> +        *  (min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE).
> +        * Skip unsupported functional power states.
> +        * If no power state found, fall back to PWRDM_FUNC_PWRST_ON.
> +        */
> +       for (fpwrst = PWRDM_FUNC_PWRST_OFF; fpwrst < PWRDM_MAX_FUNC_PWRSTS;
> +            fpwrst++) {
> +               if (!pwrdm_supports_fpwrst(pwrdm, fpwrst))
> +                       continue;
> +
> +               pwl_index = fpwrst - PWRDM_FPWRST_OFFSET;
> +               if ((min_latency == PM_QOS_DEV_LAT_DEFAULT_VALUE) ||
> +                   (pwrdm->wakeuplat[pwl_index] <= min_latency)) {
> +                       new_fpwrst = fpwrst;
> +                       break;
> +               }
> +       }
> +
> +       pwrdm->wakeuplat_next_fpwrst = new_fpwrst;
> +       ret = _pwrdm_set_fpwrst(pwrdm, new_fpwrst);
> +
> +       pr_debug("%s: fpwrst for %s: min_latency=%ld, new_state=%d, ret=%d\n",
> +                __func__, pwrdm->name, min_latency, new_fpwrst, ret);
> +
> +       return ret;
> +}
> +
>  /* Public functions */
>
>  /**
> @@ -1209,6 +1266,157 @@ int pwrdm_post_transition(struct powerdomain *pwrdm)
>  }
>
>  /**
> + * pwrdm_wakeuplat_update_constraint - Set or update a powerdomain wakeup
> + *  latency constraint and apply it
> + * @pwrdm: struct powerdomain * which the constraint applies to
> + * @cookie: constraint identifier, used for tracking
> + * @min_latency: minimum wakeup latency constraint (in microseconds) for
> + *  the given pwrdm
> + *
> + * Tracks the constraints by @cookie.
> + * Constraint set/update: Adds a new entry to powerdomain's wake-up latency
> + * constraint list. If the constraint identifier already exists in the list,
> + * the old value is overwritten.
> + *
> + * Applies the aggregated constraint value for the given pwrdm by calling
> + * _pwrdm_wakeuplat_update_pwrst().
> + *
> + * Returns 0 upon success, -ENOMEM in case of memory shortage, -EINVAL in
> + * case of invalid latency value, or the return value from
> + * _pwrdm_wakeuplat_update_pwrst().
> + *
> + * The caller must check the validity of the parameters.
> + */
> +int pwrdm_wakeuplat_update_constraint(struct powerdomain *pwrdm, void *cookie,
> +                                     long min_latency)
> +{
> +       struct pwrdm_wkup_constraints_entry *tmp_user, *new_user;
> +       struct pwrdm_wkup_constraints_entry *user = NULL;
> +       long value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
> +       int ret = 0;
> +       bool new_node = false;
> +
> +       pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p, min_latency=%ld\n",
> +                __func__, pwrdm->name, cookie, min_latency);
> +
> +       if (min_latency <= PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> +               pr_warn("%s: min_latency >= PM_QOS_DEV_LAT_DEFAULT_VALUE\n",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
> +       /* Allocate a new entry for insertion in the list */
> +       new_user = kzalloc(sizeof(struct pwrdm_wkup_constraints_entry),
> +                          GFP_KERNEL);
> +       if (!new_user) {
> +               pr_err("%s: FATAL ERROR: kzalloc failed\n", __func__);
> +               return -ENOMEM;
> +       }
> +
> +       pwrdm_lock(pwrdm);
> +
> +       /* Check if there already is a constraint for cookie */
> +       plist_for_each_entry(tmp_user, &pwrdm->wakeuplat_plist_head, node) {
> +               if (tmp_user->cookie == cookie) {
> +                       user = tmp_user;
> +                       break;
> +               }
> +       }
> +
> +       if (!user) {
> +               new_user->cookie = cookie;
> +               user = new_user;
> +               new_node = true;
> +       } else {
> +               /* If nothing to update, job done */
> +               if (user->node.prio == min_latency)
> +                       goto pwuc_out;
> +               /* Update existing entry */
> +               plist_del(&user->node, &pwrdm->wakeuplat_plist_head);
> +       }
> +
> +       plist_node_init(&user->node, min_latency);
> +       plist_add(&user->node, &pwrdm->wakeuplat_plist_head);
> +
> +       /* Find the aggregated constraint value from the list */
> +       value = plist_first(&pwrdm->wakeuplat_plist_head)->prio;
A check is needed for emptiness, cf. plist_first in include/linux/plist.h.
The original patch has the following:
+    /* Find the aggregated constraint value from the list */
+    if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
+        value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;

> +
> +       pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
> +                __func__, pwrdm->name, value);
> +
> +       /* Apply the constraint to the pwrdm */
> +       ret = _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
> +
> +pwuc_out:
> +       pwrdm_unlock(pwrdm);
> +       if (!new_node)
> +               kfree(new_user);
> +       return ret;
> +}
> +
> +/**
> + * pwrdm_wakeuplat_remove_constraint - Release a powerdomain wakeup latency
> + *  constraint and apply it
> + * @pwrdm: struct powerdomain * which the constraint applies to
> + * @cookie: constraint identifier, used for tracking
> + *
> + * Tracks the constraints by @cookie.
> + * Constraint removal: Removes the identifier's entry from powerdomain's
> + * wakeup latency constraint list.
> + *
> + * Applies the aggregated constraint value for the given pwrdm by calling
> + * _pwrdm_wakeuplat_update_pwrst().
> + *
> + * Returns 0 upon success, -EINVAL in case the constraint to remove is not
> + * existing, or the return value from _pwrdm_wakeuplat_update_pwrst().
> + *
> + * The caller must check the validity of the parameters.
> + */
> +int pwrdm_wakeuplat_remove_constraint(struct powerdomain *pwrdm, void *cookie)
> +{
> +       struct pwrdm_wkup_constraints_entry *tmp_user, *user = NULL;
> +       long value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
> +
> +       pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p\n",
> +                __func__, pwrdm->name, cookie);
> +
> +       pwrdm_lock(pwrdm);
> +
> +       /* Check if there is a constraint for cookie */
> +       plist_for_each_entry(tmp_user, &pwrdm->wakeuplat_plist_head, node) {
> +               if (tmp_user->cookie == cookie) {
> +                       user = tmp_user;
> +                       break;
> +               }
> +       }
> +
> +       /* If constraint not existing or list empty, return -EINVAL */
> +       if (!user)
> +               goto out;
> +
> +       /* Remove the constraint from the list */
> +       plist_del(&user->node, &pwrdm->wakeuplat_plist_head);
> +
> +       /* Find the aggregated constraint value from the list */
> +       if (!plist_head_empty(&pwrdm->wakeuplat_plist_head))
> +               value = plist_first(&pwrdm->wakeuplat_plist_head)->prio;
> +
> +       pwrdm_unlock(pwrdm);
> +
> +       /* Release the constraint memory */
> +       kfree(user);
> +
> +       /* Apply the constraint to the pwrdm */
> +       pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
> +                __func__, pwrdm->name, value);
> +       return _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
> +
> +out:
> +       pwrdm_unlock(pwrdm);
> +       return -EINVAL;
> +}
> +
> +/**
>   * pwrdm_get_context_loss_count - get powerdomain's context loss count
>   * @pwrdm: struct powerdomain * to wait for
>   *
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
> index 10941fd..3971ee8 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -19,6 +19,7 @@
>
>  #include <linux/types.h>
>  #include <linux/list.h>
> +#include <linux/plist.h>
>  #include <linux/spinlock.h>
>
>  #include "voltage.h"
> @@ -152,6 +153,9 @@ struct powerdomain;
>   * @fpwrst_counter: estimated number of times the pwrdm entered the power states
>   * @next_fpwrst: cache of the powerdomain's next-power-state
>   * @prev_fpwrst: cache of the powerdomain's previous-power-state bitfield
> + * @wakeuplat: array of powerdomain wakeup latencies at OPP50, in ns
The latency numbers and parameters in the rest of the code are in
microseconds so an alignement is needed. The choice of the unit is
arbitrary. The PM QoS units are microseconds though.

> + * @wakeuplat_plist_head: plist of active pwrdm wakeup lat constraints
> + * @wakeuplat_next_fpwrst: func power state lower bound, by wakeup lat constrs
>   * @timer: sched_clock() timestamp of last pwrdm_state_switch()
>   * @fpwrst_timer: estimated nanoseconds of residency in the various power states
>   * @_lock: spinlock used to serialize powerdomain and some clockdomain ops
> @@ -180,9 +184,12 @@ struct powerdomain {
>         const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
>         const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
>         const u8 prcm_partition;
> +       const u8 pwrstctrl_offs;
> +       const u8 pwrstst_offs;
>         u8 fpwrst;
>         u8 next_fpwrst;
>         u8 prev_fpwrst;
> +       u8 wakeuplat_next_fpwrst;
>         u8 _flags;
>         struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
>         struct list_head node;
> @@ -190,13 +197,13 @@ struct powerdomain {
>         unsigned fpwrst_counter[PWRDM_FPWRSTS_COUNT];
>         spinlock_t _lock;
>         unsigned long _lock_flags;
> -       const u8 pwrstctrl_offs;
> -       const u8 pwrstst_offs;
>         const u32 logicretstate_mask;
>         const u32 mem_on_mask[PWRDM_MAX_MEM_BANKS];
>         const u32 mem_ret_mask[PWRDM_MAX_MEM_BANKS];
>         const u32 mem_pwrst_mask[PWRDM_MAX_MEM_BANKS];
>         const u32 mem_retst_mask[PWRDM_MAX_MEM_BANKS];
> +       const s32 wakeuplat[PWRDM_MAX_FUNC_PWRSTS];
> +       struct plist_head wakeuplat_plist_head;
>
>  #ifdef CONFIG_PM_DEBUG
>         s64 timer;
> @@ -204,6 +211,18 @@ struct powerdomain {
>  #endif
>  };
>
> +
> +/**
> + * struct pwrdm_wkup_constraints_entry - Linked list for the wake-up latency
> + * constraints
> + * @cookie: constraint identifier, used for tracking
> + * @node: plist node
> + */
> +struct pwrdm_wkup_constraints_entry {
> +       void                    *cookie;
> +       struct plist_node       node;
> +};
> +
>  /**
>   * struct pwrdm_ops - Arch specific function implementations
>   * @pwrdm_set_next_pwrst: Set the target power state for a pd
> @@ -295,6 +314,10 @@ extern void omap3xxx_powerdomains_init(void);
>  extern void am33xx_powerdomains_init(void);
>  extern void omap44xx_powerdomains_init(void);
>
> +int pwrdm_wakeuplat_update_constraint(struct powerdomain *pwrdm, void *cookie,
> +                                     long min_latency);
> +int pwrdm_wakeuplat_remove_constraint(struct powerdomain *pwrdm, void *cookie);
> +
>  extern struct pwrdm_ops omap2_pwrdm_operations;
>  extern struct pwrdm_ops omap3_pwrdm_operations;
>  extern struct pwrdm_ops am33xx_pwrdm_operations;
> --
> 1.7.10.4
>

Regards,
Jean
