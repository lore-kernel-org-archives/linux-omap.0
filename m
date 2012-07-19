From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH 01/10] ARM: OMAP2+: PM QoS: control the power domains next
 state from the constraints
Date: Thu, 19 Jul 2012 04:12:14 -0500
Message-ID: <CAOMWX4f3zEar1riDYEHNXMijsVXD_yESeYLTuHSA_abJTSy2CQ@mail.gmail.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com> <1339686361-11526-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:54207 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753860Ab2GSJMp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jul 2012 05:12:45 -0400
Received: by weyx43 with SMTP id x43so3130420wey.16
        for <linux-omap@vger.kernel.org>; Thu, 19 Jul 2012 02:12:42 -0700 (PDT)
In-Reply-To: <1339686361-11526-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Jean Pihet <j-pihet@ti.com>

On Thu, Jun 14, 2012 at 10:05 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
Minor comment follows:
[...]
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
> + * Returns 0 in case of success, -EINVAL in case of invalid parameters,
> + * or the return value from omap_set_pwrdm_state.
> + */
> +static int _pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
> +                                        long min_latency)
> +{
> +       int ret = 0, state, new_state = PWRDM_FUNC_PWRST_ON;
> +
> +       if (!pwrdm) {
> +               WARN(1, "powerdomain: %s: invalid parameter(s)", __func__);
> +               return -EINVAL;
> +       }
_pwrdm_wakeuplat_update_pwrst is an helper function, we check pwrdm to
be valid here,
however,

[...]
>  /* Public functions */

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
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * Returns 0 upon success, -ENOMEM in case of memory shortage, -EINVAL in
> + * case of invalid latency value, or the return value from
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * The caller must check the validity of the parameters.
> + */
> +int pwrdm_wakeuplat_update_constraint(struct powerdomain *pwrdm, void *cookie,
> +                                     long min_latency)
> +{
> +       struct pwrdm_wkup_constraints_entry *tmp_user, *new_user, *user = NULL;
> +       long value = PM_QOS_DEV_LAT_DEFAULT_VALUE;
> +       int free_new_user = 0;
> +
> +       pr_debug("powerdomain: %s: pwrdm %s, cookie=0x%p, min_latency=%ld\n",
> +                __func__, pwrdm->name, cookie, min_latency);
here,

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
> +       mutex_lock(&pwrdm->wkup_lat_plist_lock);
here,

> +
> +       /* Check if there already is a constraint for cookie */
> +       plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_head, node) {
> +               if (tmp_user->cookie == cookie) {
> +                       user = tmp_user;
> +                       break;
> +               }
> +       }
here,

> +
> +       /* If nothing to update, job done */
> +       if (user && (user->node.prio == min_latency))
> +               goto out;
> +
> +       if (!user) {
> +               /* Add new entry to the list */
> +               user = new_user;
> +               user->cookie = cookie;
> +       } else {
> +               /* Update existing entry */
> +               plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
here
> +               free_new_user = 1;
> +       }
> +
> +       plist_node_init(&user->node, min_latency);
> +       plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
here
> +
> +       /* Find the aggregated constraint value from the list */
> +       if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
...
> +               value = plist_first(&pwrdm->wkup_lat_plist_head)->prio;
...

> +
> +       mutex_unlock(&pwrdm->wkup_lat_plist_lock);
...
> +
> +       /* Free the newly allocated entry if not in use */
> +       if (free_new_user)
> +               kfree(new_user);
> +
> +       /* Apply the constraint to the pwrdm */
> +       pr_debug("powerdomain: %s: pwrdm %s, value=%ld\n",
> +                __func__, pwrdm->name, value);
...
> +       return _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
we have already crashed before we do a WARN in helper.

> +
> +out:
> +       mutex_unlock(&pwrdm->wkup_lat_plist_lock);
> +       return 0;
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
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * Returns 0 upon success, -EINVAL in case the constraint to remove is not
> + * existing, or the return value from _pwrdm_wakeuplat_update_pwrst.
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
... same story here as well.. and so on..


Regards,
Nishanth Menon
