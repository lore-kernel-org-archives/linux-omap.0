From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 2/2] OMAP: PM: implement devices wakeup latency
 constraints APIs
Date: Wed, 16 Feb 2011 16:19:11 +0530
Message-ID: <36fbce9c419f5946a3a8fccdbffaa912@mail.gmail.com>
References: <1297365807-12143-1-git-send-email-j-pihet@ti.com><1297365807-12143-3-git-send-email-j-pihet@ti.com><b34afc47bcc37fa68315718cdbcd19e1@mail.gmail.com>
 <AANLkTi=-3K0CryCYfSS1n7oPr7fdweszZY7wpt=Ci69B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:60145 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755067Ab1BPKtS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 05:49:18 -0500
Received: by fxm5 with SMTP id 5so1270542fxm.24
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 02:49:11 -0800 (PST)
In-reply-to: <AANLkTi=-3K0CryCYfSS1n7oPr7fdweszZY7wpt=Ci69B@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Kevin Hilman <khilman@ti.com>, paul@pwsan.com, Vibhore Vardhan <vvardhan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> Sent: Tuesday, February 15, 2011 7:22 PM
> To: Vishwanath Sripathy
> Cc: Kevin Hilman; paul@pwsan.com; Vibhore Vardhan; Santosh
> Shilimkar; Rajendra Nayak; linux-omap@vger.kernel.org; Jean Pihet-XID
> Subject: Re: [PATCH 2/2] OMAP: PM: implement devices wakeup latency
> constraints APIs
>
> Hi Vishwa,
>
> On Tue, Feb 15, 2011 at 10:35 AM, Vishwanath Sripathy
> <vishwanath.bs@ti.com> wrote:
> >> -----Original Message-----
> >> From: jean.pihet@newoldbits.com
> [mailto:jean.pihet@newoldbits.com]
> >> Sent: Friday, February 11, 2011 12:53 AM
> >> To: khilman@ti.com; paul@pwsan.com; Vibhore Vardhan; Santosh
> >> Shilimkar; Vishwanath BS; rnayak@ti.com
> >> Cc: linux-omap@vger.kernel.org; Jean Pihet; Vibhore Vardhan
> >> Subject: [PATCH 2/2] OMAP: PM: implement devices wakeup latency
> >> constraints APIs
> >>
> >> From: Jean Pihet <j-pihet@ti.com>
> >>
> >> Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API
> by
> >> creating similar APIs at the omap_device and omap_hwmod levels.
> The
> >> omap_hwmod level call is the layer with access to the powerdomain
> >> core, so it is the place where the powerdomain is queried to set a=
nd
> >> release the constraints.
> >>
> >> NOTE: only works for devices which have been converted to use
> >> =A0 =A0 =A0 omap_device/omap_hwmod.
> >>
> >> Longer term, we could possibly remove this API from the OMAP PM
> layer,
> >> and instead directly use the omap_device level API.
> >>
> >> Based on Vibhore's original patch , adapted to omap_device and
> >> omap_hwmod frameworks.
> >>
> >> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> >> Cc: Vibhore Vardhan <vvardhan@ti.com>
> >> ---
> >> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 62
> +++++++++-
> >> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
176
> >> ++++++++++++++++++++++++-
> >> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 31 +++++
> >> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0 | =A0 60
> >> +++++++++
> >> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A02 +
> >> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A02 +
> >> =A0arch/arm/plat-omap/omap-pm-constraints.c =A0 =A0 =A0| =A0101 ++=
++++----
> -----
> >> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 28 ++++
> >> =A08 files changed, 399 insertions(+), 63 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod.c
> b/arch/arm/mach-
> >> omap2/omap_hwmod.c
> >> index e282e35..0dc096f 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> >> @@ -142,6 +142,7 @@
> >> =A0#include "powerdomain.h"
> >> =A0#include <plat/clock.h>
> >> =A0#include <plat/omap_hwmod.h>
> >> +#include <plat/omap_device.h>
> >> =A0#include <plat/prcm.h>
> >>
> >> =A0#include "cm2xxx_3xxx.h"
> >> @@ -2198,10 +2199,69 @@ ohsps_unlock:
> >> =A0}
> >>
> >> =A0/**
> >> + * omap_hwmod_set_max_dev_wakeup_lat - set a device wake-up
> >> constraint
> >> + * @oh: struct omap_hwmod *
> >> + * @req_oh: struct omap_hwmod *
> > Need to explain what this parameters mean.
> Ok, will add a description here. Basically oh corresponds to the
> device (and so the power domain) to set a constraint on and req_oh is
> the constraint requester. oh is used to determine which power domain
> to set a constraint on, req_oh is used to record the requester for
> later update or removal of a constraint.
>
> >> + * @t: wakeup latency constraint (us). -1 removes the existing
> >> constraint
> >> + *
> >> + * Query the powerdomain of @oh to set/release the wake-up
> >> constraint
> >> + *
> >> + * Returns -EINVAL if @oh or @req_oh have no power domain, or
> the
> >> return
> >> + * code from the pwrdm function
> >> (pwrdm_wakeuplat_set/release_constraint)
> >> + * of the powerdomain assocated with @oh.
> >> + */
> >> +int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod
> >> *req_oh,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct omap_hwmod *oh, long t)
> >> +{
> >> + =A0 =A0 struct device *req_dev;
> >> + =A0 =A0 struct platform_device *pdev;
> >> + =A0 =A0 struct powerdomain *pwrdm;
> >> + =A0 =A0 int ret =3D 0;
> >> +
> >> + =A0 =A0 pwrdm =3D omap_hwmod_get_pwrdm(oh);
> >> +
> >> + =A0 =A0 /* Catch devices with undefined powerdomains */
> >> + =A0 =A0 if (!pwrdm) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: could not fin=
d parent "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "powerdomain for %s\n", =
oh->name);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 pdev =3D &(req_oh->od->pdev);
> >> + =A0 =A0 if (pdev =3D=3D NULL) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: pdev not foun=
d for oh
> %s\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 req_dev =3D &(pdev->dev);
> >> + =A0 =A0 if (req_dev =3D=3D NULL) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: device not fo=
und for oh
> >> %s\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> > If I understand correctly, req_dev is used for keeping track of
different
> > requests. If so, why can't you directly pass req_dev as an input pa=
ram
> > instead of deriving it from pdev.
> The layering in the API is as follows: caller -> omap-pm ->
> omap_device -> omap_hwmod -> powerdomain. The  parameters types
> are
> passed accordingly.
>
> Note: I will rename pdev to req_pdev to make it clear that the
> parameter relates to the requester.
>
> >> +
> >> + =A0 =A0 /* Call set/release_constraint for the given pwrdm */
> >> + =A0 =A0 if (t =3D=3D -1) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("omap_hwmod: remove max device =
latency
> >> constraint: "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"oh %s, pwrdm %s, req=
 by oh %s\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name, pwrdm->name=
, req_oh->name);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pwrdm_wakeuplat_release_constrai=
nt(pwrdm,
> >> req_dev);
> >> + =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("omap_hwmod: add max device lat=
ency
> >> constraint: "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"oh %s, t =3D %ld use=
c, pwrdm %s, req by oh
> >> %s\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name, t, pwrdm->n=
ame, req_oh->name);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pwrdm_wakeuplat_set_constraint(p=
wrdm, req_dev,
> >> t);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> +/**
> >> =A0 * omap_hwmod_get_context_loss_count - get lost context count
> >> =A0 * @oh: struct omap_hwmod *
> >> =A0 *
> >> - * Query the powerdomain of of @oh to get the context loss
> >> + * Query the powerdomain of @oh to get the context loss
> >> =A0 * count for this device.
> >> =A0 *
> >> =A0 * Returns the context loss count of the powerdomain assocated =
with
> >> @oh
> >> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
> >> omap2/powerdomain.c
> >> index eaed0df..3ed3bea 100644
> >> --- a/arch/arm/mach-omap2/powerdomain.c
> >> +++ b/arch/arm/mach-omap2/powerdomain.c
> >> @@ -19,16 +19,19 @@
> >> =A0#include <linux/list.h>
> >> =A0#include <linux/errno.h>
> >> =A0#include <linux/string.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include <plat/cpu.h>
> >> +#include <plat/prcm.h>
> >> +
> >> =A0#include "cm2xxx_3xxx.h"
> >> =A0#include "prcm44xx.h"
> >> =A0#include "cm44xx.h"
> >> =A0#include "prm2xxx_3xxx.h"
> >> =A0#include "prm44xx.h"
> >>
> >> -#include <plat/cpu.h>
> >> =A0#include "powerdomain.h"
> >> =A0#include "clockdomain.h"
> >> -#include <plat/prcm.h>
> >>
> >> =A0#include "pm.h"
> >>
> >> @@ -103,6 +106,13 @@ static int _pwrdm_register(struct
> powerdomain
> >> *pwrdm)
> >> =A0 =A0 =A0 pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
> >> =A0 =A0 =A0 pwrdm->state_counter[pwrdm->state] =3D 1;
> >>
> >> + =A0 =A0 /* Initialize priority ordered list for wakeup latency
constraint
> > */
> >> + =A0 =A0 spin_lock_init(&pwrdm->wakeuplat_lock);
> >> + =A0 =A0 plist_head_init(&pwrdm->wakeuplat_dev_list, &pwrdm-
> >> >wakeuplat_lock);
> >> +
> >> + =A0 =A0 /* res_mutex protects res_list add and del ops */
> >> + =A0 =A0 mutex_init(&pwrdm->wakeuplat_mutex);
> >> +
> >> =A0 =A0 =A0 pr_debug("powerdomain: registered %s\n", pwrdm->name);
> >>
> >> =A0 =A0 =A0 return 0;
> >> @@ -176,6 +186,62 @@ static int _pwrdm_post_transition_cb(struct
> >> powerdomain *pwrdm, void *unused)
> >> =A0 =A0 =A0 return 0;
> >> =A0}
> >>
> >> +/**
> >> + * pwrdm_wakeuplat_update_pwrst - Update power domain power
> >> state if needed
> >> + * @pwrdm: struct powerdomain * to which requesting device
> belongs
> >> to
> >> + *
> >> + * Finds minimum latency value from all entries in the list and
> >> + * the power domain power state needing the constraint. Programs
> >> + * new state if it is different from current power state.
> >> + */
> >> +static void pwrdm_wakeuplat_update_pwrst(struct powerdomain
> >> *pwrdm)
> >> +{
> >> + =A0 =A0 struct plist_node *node;
> >> + =A0 =A0 int new_state;
> >> + =A0 =A0 unsigned long min_latency =3D -1;
> >> +
> >> + =A0 =A0 if (!plist_head_empty(&pwrdm->wakeuplat_dev_list)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 node =3D plist_last(&pwrdm->wakeuplat_de=
v_list);
> > Wouldn't plist_last return the node with highest latency? I think y=
ou
> are
> > looking for lowest latency.
> Yes indeed. We need the strongest constraint, so the lowest allowed
> wake-up latency value.
Then shouldn't you use plist_first?
I suppose plist_last will return the highest latency (weakest constrain=
t).
>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 min_latency =3D node->prio;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* Find power state with wakeup latency < minimum constr=
aint.
> >> */
> >> + =A0 =A0 for (new_state =3D 0x0; new_state < PWRDM_MAX_PWRSTS;
> >> new_state++) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (min_latency =3D=3D -1 ||
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm->wakeup_lat[new_state] <=3D=
 min_latency)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 switch (new_state) {
> >> + =A0 =A0 case PWRDM_FUNC_PWRST_OFF:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_OFF;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrdm, PWRDM_POWER=
_OFF);
> >> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_RET;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 case PWRDM_FUNC_PWRST_ON:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_ON;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 default:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("powerdomain: requested latency =
constraint not
"
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "supported %s set to ON =
state\n", pwrdm->name);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_ON;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if (pwrdm_read_pwrst(pwrdm) !=3D new_state) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx())
> > Why this cpu check here?
> Only 34xx has support for the latency constraints. The other platform=
s
> have the wakeup latency values set as '0', which means that OFF mode
> will always be chosen as preferred state. Is it allowed to set the
> pwrdm_state in this case?
Then this will not work for OMAP4 right? OMAP4 also should support devi=
ce
latency constraints.

Vishwa
>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_pwrdm_state(pwr=
dm, new_state);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 pr_debug("powerdomain: %s pwrst: curr=3D %d, prev=3D %d
> next=3D
> >> %d "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"wkuplat_min=3D %lu, set_state=3D %d\=
n", pwrdm->name,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_read_pwrst(pwrdm),
> >> pwrdm_read_prev_pwrst(pwrdm),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_read_next_pwrst(pwrdm), min_lat=
ency,
> >> new_state);
> >> +}
> >> +
> >> =A0/* Public functions */
> >>
> >> =A0/**
> >> @@ -911,6 +977,112 @@ int pwrdm_post_transition(void)
> >> =A0}
> >>
> >> =A0/**
> >> + * pwrdm_wakeuplat_set_constraint - Set powerdomain wakeup
> >> latency constraint
> >> + * @pwrdm: struct powerdomain * to which requesting device
> belongs
> >> to
> >> + * @dev: struct device * of requesting device
> >> + * @t: wakeup latency constraint in microseconds
> >> + *
> >> + * Adds new entry to powerdomain's wakeup latency constraint list=
=2E
> >> + * If the requesting device already exists in the list, old value=
 is
> >> + * overwritten. Checks whether current power state is still
> adequate.
> >> + * Returns -EINVAL if the powerdomain or device pointer is NULL,
> >> + * or -ENOMEM if kmalloc fails, or returns 0 upon success.
> >> + */
> >> +int pwrdm_wakeuplat_set_constraint(struct powerdomain *pwrdm,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
truct device *req_dev, unsigned
long
> > t)
> >> +{
> >> + =A0 =A0 struct =A0wakeuplat_dev_list *user;
> >> + =A0 =A0 int found =3D 0, ret =3D 0;
> >> +
> >> + =A0 =A0 if (!pwrdm || !req_dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "powerdomain: %s: invalid parame=
ter(s)",
> >> __func__);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 mutex_lock(&pwrdm->wakeuplat_mutex);
> >> +
> >> + =A0 =A0 plist_for_each_entry(user, &pwrdm->wakeuplat_dev_list, n=
ode)
> {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (user->dev =3D=3D req_dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* Add new entry to the list or update existing request =
*/
> >> + =A0 =A0 if (found && user->constraint_us =3D=3D t) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto exit_set;
> >> + =A0 =A0 } else if (!found) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 user =3D kzalloc(sizeof(struct wakeuplat=
_dev_list),
> >> GFP_KERNEL);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("powerdomain: FAT=
AL ERROR: kzalloc
> >> failed\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_set;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 user->dev =3D req_dev;
> >> + =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, &pwrdm->wakeuplat=
_dev_list);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 plist_node_init(&user->node, t);
> >> + =A0 =A0 plist_add(&user->node, &pwrdm->wakeuplat_dev_list);
> >> + =A0 =A0 user->node.prio =3D user->constraint_us =3D t;
> >> +
> >> + =A0 =A0 pwrdm_wakeuplat_update_pwrst(pwrdm);
> >> +
> >> +exit_set:
> >> + =A0 =A0 mutex_unlock(&pwrdm->wakeuplat_mutex);
> >> +
> >> + =A0 =A0 return ret;
> >> +}
> >> +
> >> +/**
> >> + * pwrdm_wakeuplat_release_constraint - Release powerdomain
> >> wkuplat constraint
> >> + * @pwrdm: struct powerdomain * to which requesting device
> belongs
> >> to
> >> + * @req_dev: struct device * of requesting device
> >> + *
> >> + * Removes device's entry from powerdomain's wakeup latency
> >> constraint list.
> >> + * Checks whether current power state is still adequate.
> >> + * Returns -EINVAL if the powerdomain or device pointer is NULL o=
r
> >> + * no such entry exists in the list, or returns 0 upon success.
> >> + */
> >> +int pwrdm_wakeuplat_release_constraint(struct powerdomain
> *pwrdm,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct device *req_dev)
> >> +{
> >> + =A0 =A0 struct wakeuplat_dev_list *user;
> >> + =A0 =A0 int found =3D 0, ret =3D 0;
> >> +
> >> + =A0 =A0 if (!pwrdm || !req_dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "powerdomain: %s: invalid parame=
ter(s)",
> >> __func__);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 mutex_lock(&pwrdm->wakeuplat_mutex);
> >> +
> >> + =A0 =A0 plist_for_each_entry(user, &pwrdm->wakeuplat_dev_list, n=
ode)
> {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (user->dev =3D=3D req_dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if (!found) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("OMAP PM: Error: no prior constra=
int to
> > release\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto exit_rls;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 plist_del(&user->node, &pwrdm->wakeuplat_dev_list);
> >> + =A0 =A0 kfree(user);
> >> +
> >> + =A0 =A0 pwrdm_wakeuplat_update_pwrst(pwrdm);
> >> +
> >> +exit_rls:
> >> + =A0 =A0 mutex_unlock(&pwrdm->wakeuplat_mutex);
> >> +
> >> + =A0 =A0 return ret;
> >> +}
> >> +
> >> +/**
> >> =A0 * pwrdm_get_context_loss_count - get powerdomain's context los=
s
> >> count
> >> =A0 * @pwrdm: struct powerdomain * to wait for
> >> =A0 *
> >> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-
> >> omap2/powerdomain.h
> >> index c66431e..d4189d8 100644
> >> --- a/arch/arm/mach-omap2/powerdomain.h
> >> +++ b/arch/arm/mach-omap2/powerdomain.h
> >> @@ -19,6 +19,9 @@
> >>
> >> =A0#include <linux/types.h>
> >> =A0#include <linux/list.h>
> >> +#include <linux/plist.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/spinlock.h>
> >>
> >> =A0#include <linux/atomic.h>
> >>
> >> @@ -46,6 +49,15 @@
> >>
> >> =A0#define PWRSTS_OFF_RET_ON =A0 =A0(PWRSTS_OFF_RET | (1 <<
> >> PWRDM_POWER_ON))
> >>
> >> +/* Powerdomain functional power states */
> >> +#define PWRDM_FUNC_PWRST_OFF 0x0
> >> +#define PWRDM_FUNC_PWRST_OSWR =A0 =A0 =A0 =A00x1
> >> +#define PWRDM_FUNC_PWRST_CSWR =A0 =A0 =A0 =A00x2
> >> +#define PWRDM_FUNC_PWRST_ON =A00x3
> >> +
> >> +#define PWRDM_MAX_FUNC_PWRSTS =A0 =A0 =A0 =A04
> >> +
> >> +#define UNSUP_STATE =A0 =A0 =A0 =A0 =A0-1
> >>
> >> =A0/* Powerdomain flags */
> >> =A0#define PWRDM_HAS_HDWR_SAR =A0 (1 << 0) /* hardware save-
> and-
> >> restore support */
> >> @@ -96,6 +108,10 @@ struct powerdomain;
> >> =A0 * @state_counter:
> >> =A0 * @timer:
> >> =A0 * @state_timer:
> >> + * @wakeup_lat: Wakeup latencies for possible powerdomain power
> >> states
> Will add a comment about the ordering (latency values must be sorted
> in decremental order).
>
> >> + * @wakeuplat_lock: spinlock for plist
> >> + * @wakeuplat_dev_list: plist_head linking all devices placing
> >> constraint
> >> + * @wakeuplat_mutex: mutex to protect per powerdomain list ops
> >> =A0 *
> >> =A0 * @prcm_partition possible values are defined in mach-
> >> omap2/prcm44xx.h.
> >> =A0 */
> >> @@ -121,6 +137,16 @@ struct powerdomain {
> >> =A0 =A0 =A0 s64 timer;
> >> =A0 =A0 =A0 s64 state_timer[PWRDM_MAX_PWRSTS];
> >> =A0#endif
> >> + =A0 =A0 const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
> >> + =A0 =A0 spinlock_t wakeuplat_lock;
> >> + =A0 =A0 struct plist_head wakeuplat_dev_list;
> >> + =A0 =A0 struct mutex wakeuplat_mutex;
> >> +};
> >> +
> >> +struct wakeuplat_dev_list {
> >> + =A0 =A0 struct device *dev;
> >> + =A0 =A0 unsigned long constraint_us;
> >> + =A0 =A0 struct plist_node node;
> >> =A0};
> >>
> >> =A0/**
> >> @@ -211,6 +237,11 @@ int pwrdm_clkdm_state_switch(struct
> >> clockdomain *clkdm);
> >> =A0int pwrdm_pre_transition(void);
> >> =A0int pwrdm_post_transition(void);
> >> =A0int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
> >> +
> >> +int pwrdm_wakeuplat_set_constraint(struct powerdomain *pwrdm,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s=
truct device *dev, unsigned long
t);
> >> +int pwrdm_wakeuplat_release_constraint(struct powerdomain
> *pwrdm,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct device *dev);
> >> =A0u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
> >>
> >> =A0extern void omap2xxx_powerdomains_init(void);
> >> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> >> b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> >> index e1bec56..4f7e44d 100644
> >> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> >> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> >> @@ -52,6 +52,12 @@ static struct powerdomain iva2_pwrdm =3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [2] =3D PWRSTS_OFF_ON,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [3] =3D PWRDM_POWER_ON,
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 1100,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 350,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain mpu_3xxx_pwrdm =3D {
> >> @@ -68,6 +74,12 @@ static struct powerdomain mpu_3xxx_pwrdm
> =3D {
> >> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_OFF_ON,
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 95,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 45,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0/*
> >> @@ -98,6 +110,12 @@ static struct powerdomain
> >> core_3xxx_pre_es3_1_pwrdm =3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONST=
ATE */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONST=
ATE */
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 100,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 60,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
> >> @@ -121,6 +139,12 @@ static struct powerdomain
> >> core_3xxx_es3_1_pwrdm =3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONST=
ATE */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONST=
ATE */
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 100,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 60,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain dss_pwrdm =3D {
> >> @@ -136,6 +160,12 @@ static struct powerdomain dss_pwrdm =3D {
> >> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 70,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 20,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0/*
> >> @@ -157,6 +187,12 @@ static struct powerdomain sgx_pwrdm =3D {
> >> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 1000,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain cam_pwrdm =3D {
> >> @@ -172,6 +208,12 @@ static struct powerdomain cam_pwrdm =3D {
> >> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 850,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 35,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain per_pwrdm =3D {
> >> @@ -187,6 +229,12 @@ static struct powerdomain per_pwrdm =3D {
> >> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 200,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 110,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain emu_pwrdm =3D {
> >> @@ -201,6 +249,12 @@ static struct powerdomain neon_pwrdm =3D {
> >> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_O=
MAP3430),
> >> =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_OFF_RET_ON,
> >> =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRDM_POWER_RET,
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 200,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 35,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain usbhost_pwrdm =3D {
> >> @@ -223,6 +277,12 @@ static struct powerdomain usbhost_pwrdm
> =3D {
> >> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> >> =A0 =A0 =A0 },
> >> + =A0 =A0 .wakeup_lat =3D {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 800,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 150,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> >> + =A0 =A0 },
> >> =A0};
> >>
> >> =A0static struct powerdomain dpll1_pwrdm =3D {
> >> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h
> >> b/arch/arm/plat-omap/include/plat/omap_device.h
> >> index e4c349f..5da6b47 100644
> >> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> >> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> >> @@ -107,6 +107,8 @@ void __iomem
> *omap_device_get_rt_va(struct
> >> omap_device *od);
> >> =A0int omap_device_align_pm_lat(struct platform_device *pdev,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 new_wak=
eup_lat_limit);
> >> =A0struct powerdomain *omap_device_get_pwrdm(struct omap_device
> >> *od);
> >> +int omap_device_set_max_dev_wakeup_lat(struct platform_device
> >> *req_pdev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct platform_device *pdev,
long
> > t);
> >> =A0u32 omap_device_get_context_loss_count(struct platform_device
> >> *pdev);
> >>
> >> =A0/* Other */
> >> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> >> b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> >> index 1eee85a..0fbb974 100644
> >> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> >> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> >> @@ -587,6 +587,8 @@ int omap_hwmod_for_each_by_class(const
> char
> >> *classname,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0voi=
d *user);
> >>
> >> =A0int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8
> >> state);
> >> +int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod
> >> *req_oh,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct omap_hwmod *oh, long t);
> >> =A0u32 omap_hwmod_get_context_loss_count(struct omap_hwmod
> *oh);
> >>
> >> =A0/*
> >> diff --git a/arch/arm/plat-omap/omap-pm-constraints.c
> b/arch/arm/plat-
> >> omap/omap-pm-constraints.c
> >> index c8b4e4c..7ae855f 100644
> >> --- a/arch/arm/plat-omap/omap-pm-constraints.c
> >> +++ b/arch/arm/plat-omap/omap-pm-constraints.c
> >> @@ -24,6 +24,7 @@
> >> =A0/* Interface documentation is in mach/omap-pm.h */
> >> =A0#include <plat/omap-pm.h>
> >> =A0#include <plat/omap_device.h>
> >> +#include <plat/common.h>
> >>
> >> =A0static bool off_mode_enabled;
> >> =A0static u32 dummy_context_loss_counter;
> >> @@ -32,34 +33,6 @@ static u32 dummy_context_loss_counter;
> >> =A0 * Device-driver-originated constraints (via board-*.c files)
> >> =A0 */
> >>
> >> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> >> -{
> >> - =A0 =A0 if (!dev || t < -1) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter(=
s)",
> >> __func__);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> - =A0 =A0 };
> >> -
> >> - =A0 =A0 if (t =3D=3D -1)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max MPU wakeup=
 latency
> >> constraint: "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(=
dev));
> >> - =A0 =A0 else
> >> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max MPU wakeup la=
tency
> >> constraint: "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld us=
ec\n", dev_name(dev), t);
> >> -
> >> - =A0 =A0 /*
> >> - =A0 =A0 =A0* For current Linux, this needs to map the MPU to a
> >> - =A0 =A0 =A0* powerdomain, then go through the list of current ma=
x lat
> >> - =A0 =A0 =A0* constraints on the MPU and find the smallest. =A0If
> >> - =A0 =A0 =A0* the latency constraint has changed, the code should
> >> - =A0 =A0 =A0* recompute the state to enter for the next powerdoma=
in
> >> - =A0 =A0 =A0* state.
> >> - =A0 =A0 =A0*
> >> - =A0 =A0 =A0* TI CDP code can call constraint_set here.
> >> - =A0 =A0 =A0*/
> >> -
> >> - =A0 =A0 return 0;
> >> -}
> >> -
> >> =A0int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id,
> >> unsigned long r)
> >> =A0{
> >> =A0 =A0 =A0 if (!dev || (agent_id !=3D OCP_INITIATOR_AGENT &&
> >> @@ -87,62 +60,70 @@ int omap_pm_set_min_bus_tput(struct
> device
> >> *dev, u8 agent_id, unsigned long r)
> >> =A0 =A0 =A0 return 0;
> >> =A0}
> >>
> >> +/*
> >> + * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-
> up
> >> latency
> >> + * constraints
> >> + */
> >> =A0int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev,
> struct
> >> device *dev,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
long t)
> >> =A0{
> >> + =A0 =A0 struct platform_device *pdev, *req_pdev;
> >> + =A0 =A0 int ret =3D 0;
> >> +
> >> =A0 =A0 =A0 if (!req_dev || !dev || t < -1) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid paramete=
r(s)",
> >> __func__);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 /* Look for the platform devices */
> >> + =A0 =A0 pdev =3D container_of(dev, struct platform_device, dev);
> >
> > You could perhaps use macro to_platform_device instead of using
> > container_of.
> Yes that is better.
>
> >
> >> + =A0 =A0 req_pdev =3D container_of(req_dev, struct platform_devic=
e, dev);
> Same here.
>
> >> +
> >> + =A0 =A0 /* Try to catch non platform devices. */
> >> + =A0 =A0 if ((pdev->name =3D=3D NULL) || (req_pdev->name =3D=3D N=
ULL)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("OMAP-PM set_wakeup_lat: Error: p=
latform devices
> >> "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"not valid\n");
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> + =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Call the omap_device API */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_set_max_dev_wakeup_l=
at(req_pdev,
> >> pdev, t);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 return ret;
> >> +}
> >> +
> >> +int omap_pm_set_max_mpu_wakeup_lat(struct device *req_dev,
> long
> >> t)
> >> +{
> >> + =A0 =A0 if (!req_dev || t < -1) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter(=
s)",
> >> __func__);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> =A0 =A0 =A0 };
> >>
> >> =A0 =A0 =A0 if (t =3D=3D -1)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max device lat=
ency
> >> constraint: "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(=
dev));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max MPU wakeup=
 latency
> >> constraint: "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(=
req_dev));
> >> =A0 =A0 =A0 else
> >> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max device latenc=
y constraint: "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld us=
ec\n", dev_name(dev), t);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max MPU wakeup la=
tency
> >> constraint: "
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld us=
ec\n", dev_name(req_dev),
t);
> >>
> >> - =A0 =A0 /*
> >> - =A0 =A0 =A0* For current Linux, this needs to map the device to =
a
> >> - =A0 =A0 =A0* powerdomain, then go through the list of current ma=
x lat
> >> - =A0 =A0 =A0* constraints on that powerdomain and find the smalle=
st. =A0If
> >> - =A0 =A0 =A0* the latency constraint has changed, the code should
> >> - =A0 =A0 =A0* recompute the state to enter for the next powerdoma=
in
> >> - =A0 =A0 =A0* state. =A0Conceivably, this code should also determ=
ine
> >> - =A0 =A0 =A0* whether to actually disable the device clocks or no=
t,
> >> - =A0 =A0 =A0* depending on how long it takes to re-enable the clo=
cks.
> >> - =A0 =A0 =A0*
> >> - =A0 =A0 =A0* TI CDP code can call constraint_set here.
> >> - =A0 =A0 =A0*/
> >> + =A0 =A0 omap_pm_set_max_dev_wakeup_lat(req_dev,
> >> omap2_get_mpuss_device(), t);
> >>
> >> =A0 =A0 =A0 return 0;
> >> =A0}
> >>
> >> -int omap_pm_set_max_sdma_lat(struct device *dev, long t)
> >> +int omap_pm_set_max_sdma_lat(struct device *req_dev, long t)
> >> =A0{
> >> - =A0 =A0 if (!dev || t < -1) {
> >> + =A0 =A0 if (!req_dev || t < -1) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid paramete=
r(s)",
> >> __func__);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >> =A0 =A0 =A0 };
> >>
> >> =A0 =A0 =A0 if (t =3D=3D -1)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max DMA late=
ncy constraint:
> >> "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(=
dev));
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(=
req_dev));
> >> =A0 =A0 =A0 else
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max DMA latency=
 constraint: "
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld us=
ec\n", dev_name(dev), t);
> >> -
> >> - =A0 =A0 /*
> >> - =A0 =A0 =A0* For current Linux PM QOS params, this code should s=
can the
> >> - =A0 =A0 =A0* list of maximum CPU and DMA latencies and select th=
e
> >> - =A0 =A0 =A0* smallest, then set cpu_dma_latency pm_qos_param
> >> - =A0 =A0 =A0* accordingly.
> >> - =A0 =A0 =A0*
> >> - =A0 =A0 =A0* For future Linux PM QOS params, with separate CPU a=
nd DMA
> >> - =A0 =A0 =A0* latency params, this code should just set the dma_l=
atency
> >> param.
> >> - =A0 =A0 =A0*
> >> - =A0 =A0 =A0* TI CDP code can call constraint_set here.
> >> - =A0 =A0 =A0*/
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld us=
ec\n", dev_name(req_dev),
t);
> >>
> >> =A0 =A0 =A0 return 0;
> >> =A0}
> >> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-
> >> omap/omap_device.c
> >> index 57adb27..1fe93d3 100644
> >> --- a/arch/arm/plat-omap/omap_device.c
> >> +++ b/arch/arm/plat-omap/omap_device.c
> >> @@ -280,6 +280,34 @@ static void _add_optional_clock_alias(struct
> >> omap_device *od,
> >> =A0/* Public functions for use by core code */
> >>
> >> =A0/**
> >> + * omap_device_set_max_dev_wakeup_lat - set/release a device
> >> constraint
> >> + * @od: struct omap_device *
> >> + * @req_od: struct omap_device *
> >> + *
> >> + * Using the primary hwmod, set/release a device constraint for t=
he
> >> pdev
> >> + * device, requested by the req_pdev device.
> >> + *
> >> + * If any hwmods exist for the omap_device assoiated with @pdev
> and
> >> @req_pdev,
> >> + * set/release the constraint for the corresponding hwmods,
> otherwise
> >> return
> >> + * -EINVAL.
> >> + */
> >> +int omap_device_set_max_dev_wakeup_lat(struct platform_device
> >> *req_pdev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct platform_device *pdev,
long
> > t)
> >> +{
> >> + =A0 =A0 struct omap_device *od, *req_od;
> >> + =A0 =A0 u32 ret =3D -EINVAL;
> >> +
> >> + =A0 =A0 od =3D _find_by_pdev(pdev);
> >> + =A0 =A0 req_od =3D _find_by_pdev(req_pdev);
> >> +
> >> + =A0 =A0 if ((od->hwmods_cnt) && (req_od->hwmods_cnt))
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hwmod_set_max_dev_wakeup_la=
t(req_od-
> >> >hwmods[0],
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 od->hwmods[0],
t);
> >> +
> >> + =A0 =A0 return ret;
> >> +}
> >> +
> >> +/**
> >> =A0 * omap_device_get_context_loss_count - get lost context count
> >> =A0 * @od: struct omap_device *
> >> =A0 *
> > Vishwa
> >> --
> >> 1.7.2.3
> >
>
> Thanks for the review, I will resubmit the patch asap.
>
> Regards,
> Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
