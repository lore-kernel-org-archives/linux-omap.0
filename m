From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 01/10] ARM: OMAP2+: PM QoS: control the power domains next
 state from the constraints
Date: Fri, 15 Jun 2012 13:37:39 +0200
Message-ID: <CAORVsuXu2y58uUeNoajGst2E+jnJbXeinVnE7TJO4bDSKq01Yw@mail.gmail.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
	<1339686361-11526-2-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51810 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab2FOLhl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jun 2012 07:37:41 -0400
Received: by lbbgm6 with SMTP id gm6so2775761lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 04:37:39 -0700 (PDT)
In-Reply-To: <1339686361-11526-2-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>, Nishanth Menon <nm@ti.com>

Hi,

Here are some remarks I got after an internal review. I think those
points need to be discussed with a broader audience.

On Thu, Jun 14, 2012 at 5:05 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> When a PM QoS device latency constraint is requested or removed the
> constraint is stored in the constraints list of the corresponding pow=
er
> domain, then the aggregated constraint value is applied by programmin=
g
> the next functional power state using omap_set_pwrdm_state.
>
> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
> wake-up latency constraints on MPU, CORE and PER.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c | =A0215 +++++++++++++++++++++++=
++++++++++++++
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 18 +++
> =A02 files changed, 233 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index f6885f9..82797c2 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -17,8 +17,10 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/types.h>
> =A0#include <linux/list.h>
> +#include <linux/slab.h>
> =A0#include <linux/errno.h>
> =A0#include <linux/string.h>
> +#include <linux/pm_qos.h>
> =A0#include <trace/events/power.h>
>
> =A0#include "cm2xxx_3xxx.h"
> @@ -113,6 +115,12 @@ static int _pwrdm_register(struct powerdomain *p=
wrdm)
> =A0 =A0 =A0 =A0for (i =3D 0; i < pwrdm->banks; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->ret_mem_off_counter[i] =3D 0;
>
> + =A0 =A0 =A0 /* Initialize the per-device wake-up constraints framew=
ork data */
> + =A0 =A0 =A0 mutex_init(&pwrdm->wkup_lat_plist_lock);
> + =A0 =A0 =A0 plist_head_init(&pwrdm->wkup_lat_plist_head);
> + =A0 =A0 =A0 pwrdm->wkup_lat_next_state =3D PWRDM_FUNC_PWRST_OFF;
> +
> + =A0 =A0 =A0 /* Initialize the pwrdm state */
> =A0 =A0 =A0 =A0pwrdm_wait_transition(pwrdm);
> =A0 =A0 =A0 =A0pwrdm->state =3D pwrdm_read_func_pwrst(pwrdm);
> =A0 =A0 =A0 =A0pwrdm->state_counter[pwrdm->state] =3D 1;
> @@ -200,6 +208,58 @@ static int _pwrdm_post_transition_cb(struct powe=
rdomain *pwrdm, void *unused)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/**
> + * _pwrdm_wakeuplat_update_pwrst - Update power domain power state i=
f needed
> + * @pwrdm: struct powerdomain * to which requesting device belongs t=
o.
> + * @min_latency: the allowed wake-up latency for the given power dom=
ain. A
> + * =A0value of PM_QOS_DEV_LAT_DEFAULT_VALUE means 'no constraint' on=
 the pwrdm.
> + *
> + * Finds the power domain next power state that fulfills the constra=
int.
> + * Programs a new target state if it is different from current power=
 state.
> + * The power domains get the next power state programmed directly in=
 the
> + * registers.
> + *
> + * Returns 0 in case of success, -EINVAL in case of invalid paramete=
rs,
> + * or the return value from omap_set_pwrdm_state.
> + */
> +static int _pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0long min_latency)
> +{
> + =A0 =A0 =A0 int ret =3D 0, state, new_state =3D PWRDM_FUNC_PWRST_ON=
;
> +
> + =A0 =A0 =A0 if (!pwrdm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "powerdomain: %s: invalid param=
eter(s)", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Find the next supported power state with
> + =A0 =A0 =A0 =A0* =A0wakeup latency <=3D min_latency.
> + =A0 =A0 =A0 =A0* Pick the lower state if no constraint on the pwrdm
> + =A0 =A0 =A0 =A0* =A0(min_latency =3D=3D PM_QOS_DEV_LAT_DEFAULT_VALU=
E).
> + =A0 =A0 =A0 =A0* Skip the states marked as unsupported (UNSUP_STATE=
).
> + =A0 =A0 =A0 =A0* If no power state found, fall back to PWRDM_FUNC_P=
WRST_ON.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (state =3D 0x0; state < PWRDM_MAX_FUNC_PWRSTS; stat=
e++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((min_latency =3D=3D PM_QOS_DEV_LAT_=
DEFAULT_VALUE) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((pwrdm->wakeup_lat[state] !=3D=
 UNSUP_STATE) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(pwrdm->wakeup_lat[state] <=3D=
 min_latency))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D state;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pwrdm->wkup_lat_next_state =3D new_state;
> + =A0 =A0 =A0 ret =3D omap_set_pwrdm_state(pwrdm, new_state);
> +
> + =A0 =A0 =A0 pr_debug("%s: func pwrst for %s: curr=3D%d, next=3D%d, =
min_latency=3D%ld, new_state=3D%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, pwrdm_read_fu=
nc_pwrst(pwrdm),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_read_next_func_pwrst(pwrdm), m=
in_latency, new_state);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +
> =A0/* Public functions */
>
> =A0/**
> @@ -1317,6 +1377,161 @@ int pwrdm_post_transition(void)
> =A0}
>
> =A0/**
> + * pwrdm_wakeuplat_update_constraint - Set or update a powerdomain w=
akeup
> + * =A0latency constraint and apply it
> + * @pwrdm: struct powerdomain * which the constraint applies to
> + * @cookie: constraint identifier, used for tracking
> + * @min_latency: minimum wakeup latency constraint (in microseconds)=
 for
> + * =A0the given pwrdm
> + *
> + * Tracks the constraints by @cookie.
> + * Constraint set/update: Adds a new entry to powerdomain's wake-up =
latency
> + * constraint list. If the constraint identifier already exists in t=
he list,
> + * the old value is overwritten.
> + *
> + * Applies the aggregated constraint value for the given pwrdm by ca=
lling
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * Returns 0 upon success, -ENOMEM in case of memory shortage, -EINV=
AL in
> + * case of invalid latency value, or the return value from
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * The caller must check the validity of the parameters.
> + */
> +int pwrdm_wakeuplat_update_constraint(struct powerdomain *pwrdm, voi=
d *cookie,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 long min_latency)
> +{
> + =A0 =A0 =A0 struct pwrdm_wkup_constraints_entry *tmp_user, *new_use=
r, *user =3D NULL;
> + =A0 =A0 =A0 long value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE;
> + =A0 =A0 =A0 int free_new_user =3D 0;
> +
> + =A0 =A0 =A0 pr_debug("powerdomain: %s: pwrdm %s, cookie=3D0x%p, min=
_latency=3D%ld\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, cookie, min_l=
atency);
> +
> + =A0 =A0 =A0 if (min_latency <=3D PM_QOS_DEV_LAT_DEFAULT_VALUE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: min_latency >=3D PM_QOS_DE=
V_LAT_DEFAULT_VALUE\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Allocate a new entry for insertion in the list */
> + =A0 =A0 =A0 new_user =3D kzalloc(sizeof(struct pwrdm_wkup_constrain=
ts_entry),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
> + =A0 =A0 =A0 if (!new_user) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: FATAL ERROR: kzalloc failed=
\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }

"
- pwrdm_wakeuplat_update_constraint: please do not allocate unless you
need to!!! remove the variable free_new_user
"
This allocation mechanism is used since allocating under a lock is not
safe. The free_new_user variable is used to keep track of the
allocation usefulness. If the allocation was not needed (which is
known only after parsing the constraints list) the entry is free'd.

> +
> + =A0 =A0 =A0 mutex_lock(&pwrdm->wkup_lat_plist_lock);
> +
> + =A0 =A0 =A0 /* Check if there already is a constraint for cookie */
> + =A0 =A0 =A0 plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_h=
ead, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp_user->cookie =3D=3D cookie) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D tmp_user;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If nothing to update, job done */
> + =A0 =A0 =A0 if (user && (user->node.prio =3D=3D min_latency))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 if (!user) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Add new entry to the list */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D new_user;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->cookie =3D cookie;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Update existing entry */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, &pwrdm->wkup_lat=
_plist_head);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_new_user =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 plist_node_init(&user->node, min_latency);
> + =A0 =A0 =A0 plist_add(&user->node, &pwrdm->wkup_lat_plist_head);
> +
> + =A0 =A0 =A0 /* Find the aggregated constraint value from the list *=
/
> + =A0 =A0 =A0 if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D plist_first(&pwrdm->wkup_lat_=
plist_head)->prio;
> +
> + =A0 =A0 =A0 mutex_unlock(&pwrdm->wkup_lat_plist_lock);
> +
> + =A0 =A0 =A0 /* Free the newly allocated entry if not in use */
> + =A0 =A0 =A0 if (free_new_user)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(new_user);
> +
> + =A0 =A0 =A0 /* Apply the constraint to the pwrdm */
> + =A0 =A0 =A0 pr_debug("powerdomain: %s: pwrdm %s, value=3D%ld\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, value);
> + =A0 =A0 =A0 return _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&pwrdm->wkup_lat_plist_lock);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * pwrdm_wakeuplat_remove_constraint - Release a powerdomain wakeup =
latency
> + * =A0constraint and apply it
> + * @pwrdm: struct powerdomain * which the constraint applies to
> + * @cookie: constraint identifier, used for tracking
> + *
> + * Tracks the constraints by @cookie.
> + * Constraint removal: Removes the identifier's entry from powerdoma=
in's
> + * wakeup latency constraint list.
> + *
> + * Applies the aggregated constraint value for the given pwrdm by ca=
lling
> + * _pwrdm_wakeuplat_update_pwrst.
> + *
> + * Returns 0 upon success, -EINVAL in case the constraint to remove =
is not
> + * existing, or the return value from _pwrdm_wakeuplat_update_pwrst.
> + *
> + * The caller must check the validity of the parameters.
> + */
> +int pwrdm_wakeuplat_remove_constraint(struct powerdomain *pwrdm, voi=
d *cookie)
> +{
> + =A0 =A0 =A0 struct pwrdm_wkup_constraints_entry *tmp_user, *user =3D=
 NULL;
> + =A0 =A0 =A0 long value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE;
> +
> + =A0 =A0 =A0 pr_debug("powerdomain: %s: pwrdm %s, cookie=3D0x%p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, cookie);
> +
> + =A0 =A0 =A0 mutex_lock(&pwrdm->wkup_lat_plist_lock);
> +
> + =A0 =A0 =A0 /* Check if there is a constraint for cookie */
> + =A0 =A0 =A0 plist_for_each_entry(tmp_user, &pwrdm->wkup_lat_plist_h=
ead, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tmp_user->cookie =3D=3D cookie) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D tmp_user;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* If constraint not existing or list empty, return -EI=
NVAL */
> + =A0 =A0 =A0 if (!user)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 /* Remove the constraint from the list */
> + =A0 =A0 =A0 plist_del(&user->node, &pwrdm->wkup_lat_plist_head);
> +
> + =A0 =A0 =A0 /* Find the aggregated constraint value from the list *=
/
> + =A0 =A0 =A0 if (!plist_head_empty(&pwrdm->wkup_lat_plist_head))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D plist_first(&pwrdm->wkup_lat_=
plist_head)->prio;
> +
> + =A0 =A0 =A0 mutex_unlock(&pwrdm->wkup_lat_plist_lock);
> +
> + =A0 =A0 =A0 /* Release the constraint memory */
> + =A0 =A0 =A0 kfree(user);
> +
> + =A0 =A0 =A0 /* Apply the constraint to the pwrdm */
> + =A0 =A0 =A0 pr_debug("powerdomain: %s: pwrdm %s, value=3D%ld\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, value);
> + =A0 =A0 =A0 return _pwrdm_wakeuplat_update_pwrst(pwrdm, value);
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&pwrdm->wkup_lat_plist_lock);
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +/**
> =A0* pwrdm_get_context_loss_count - get powerdomain's context loss co=
unt
> =A0* @pwrdm: struct powerdomain * to wait for
> =A0*

"
- we need a debugfs entry to list all the constraints currently active
in the system.
"
This point is valid. Having a debug mechanism is certainly useful in
product development.
This functionality can/will be added as a separate patch after this
series is accepted.

Regards,
Jean

> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index 06fb396..fca82fc 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -16,6 +16,7 @@
>
> =A0#include <linux/types.h>
> =A0#include <linux/list.h>
> +#include <linux/plist.h>
> =A0#include <linux/mutex.h>
> =A0#include <linux/atomic.h>
>
> @@ -85,6 +86,8 @@ extern void omap44xx_powerdomains_init(void);
>
> =A0#define PWRDM_MAX_PWRSTS =A0 =A0 =A0 4
>
> +#define UNSUP_STATE =A0 =A0 =A0 =A0 =A0 =A0-1
> +
> =A0/* Powerdomain allowable state bitfields */
> =A0#define PWRSTS_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << PWRDM_POWER_ON)
> =A0#define PWRSTS_INACTIVE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << PWRDM=
_POWER_INACTIVE)
> @@ -173,6 +176,16 @@ struct powerdomain {
> =A0 =A0 =A0 =A0s64 timer;
> =A0 =A0 =A0 =A0s64 state_timer[PWRDM_MAX_FUNC_PWRSTS];
> =A0#endif
> + =A0 =A0 =A0 const s32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
> + =A0 =A0 =A0 struct plist_head wkup_lat_plist_head;
> + =A0 =A0 =A0 struct mutex wkup_lat_plist_lock;
> + =A0 =A0 =A0 int wkup_lat_next_state;
> +};
> +
> +/* Linked list for the wake-up latency constraints */
> +struct pwrdm_wkup_constraints_entry {
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*cookie;
> + =A0 =A0 =A0 struct plist_node =A0 =A0 =A0 node;
> =A0};
>
> =A0/**
> @@ -270,6 +283,11 @@ int pwrdm_state_switch(struct powerdomain *pwrdm=
);
> =A0int pwrdm_pre_transition(void);
> =A0int pwrdm_post_transition(void);
> =A0int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
> +
> +int pwrdm_wakeuplat_update_constraint(struct powerdomain *pwrdm, voi=
d *cookie,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 long min_latency);
> +int pwrdm_wakeuplat_remove_constraint(struct powerdomain *pwrdm, voi=
d *cookie);
> +
> =A0int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
> =A0bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
>
> --
> 1.7.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
