From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices wakeup latency constraints APIs
Date: Tue, 08 Mar 2011 09:33:45 -0800
Message-ID: <87ipvttt3a.fsf@ti.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299250375-26134-3-git-send-email-j-pihet@ti.com>
	<87aah6xsqk.fsf@ti.com>
	<AANLkTinKmQztha_tKM0zB7CWMqbCLtsaYxZrdX3RVvW+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42225 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750909Ab1CHRdx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 12:33:53 -0500
Received: by pvg2 with SMTP id 2so1092698pvg.39
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 09:33:48 -0800 (PST)
In-Reply-To: <AANLkTinKmQztha_tKM0zB7CWMqbCLtsaYxZrdX3RVvW+@mail.gmail.com>
	(Jean Pihet's message of "Tue, 8 Mar 2011 16:54:48 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> On Tue, Mar 8, 2011 at 3:15 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Jean Pihet <jean.pihet@newoldbits.com> writes:
>>
>>> Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
>>> creating similar APIs at the omap_device and omap_hwmod levels. The
>>> omap_hwmod level call is the layer with access to the powerdomain
>>> core, so it is the place where the powerdomain is queried to set an=
d
>>> release the constraints.
>>>
>>> NOTE: only works for devices which have been converted to use
>>> =C2=A0 =C2=A0 =C2=A0 omap_device/omap_hwmod.
>>>
>>> Longer term, we could possibly remove this API from the OMAP PM lay=
er,
>>> and instead directly use the device level API.
>>>
>>> The power domains get the next power state programmed directly in
>>> the registers via pwrdm_wakeuplat_update_pwrst.
>>>
>>> Note about PM QOS: the MPU and CORE power domains get the next powe=
r
>>> state via cpuidle, which get the strongest wake-up latency constrai=
nt
>>> by querying PM QOS. The usage of PM QOS is temporary, until a gener=
ic
>>> solution is in place.
>>>
>>> Based on Vibhore's original patch, adapted to omap_device, omap_hwm=
od
>>> and PM QOS frameworks.
>>
>> I haven't got to a detailed review of this code yet, but did do some
>> experiements and have some general comments on the code/design to ge=
t
>> started.
>>
>> Also, I had a problem doing a real dumb test until I figured out the
>> problem with the init sequence. =C2=A0I tried setting a constraint i=
n the
>> device init code for UART (mach-omap2/serial.c:omap_serial_init_port=
()),
>> and then I realized that that runs before
>> mach-omap2/pm34xx.c:pwrdms_setup() which also calls
>> omap_set_pwrdm_state() for each powerdomain to initialize.
>
> Do we need to change the behavior at init?
>

I think so. =20

At a minimum, it should be documented somewhere that the constraints AP=
I
cannot be used before pwrdms_setup().  But since that happens much late=
r
in the boot process than device init code, that might be too strict.

>> Also, for debug purposes, it might be useful to have a per-device sy=
sfs
>> interface to setting this wakeup latency constraint. =C2=A0Something=
 like
>>
>> =C2=A0 /sys/devices/platform/omap/.../power/wakeup_latency
> I do not see this as a debug interface but rather an API to the user =
space.
> If that is the case there are some issues to deal with, cf. below.

By debug, I was thinking under '#ifdef CONFIG_PM_DEBUG'.  Even if you
did this as a separate patch that we did not try to get upstream, it
would be extremely valuable for testing this framework.

>> I'm not sure exactly what to set the requesting device to though.
> And also, how to track the requesters? PM QOS is using a /dev node
> that must be kept open as long as the constraints remains valid.

A dummy device could be created for all sysfs requesters since you woul=
d
want subsequent writes to override  previous ones.

>> As far as implementation goes, you've so far implemented only wakeup
>> latencies, but not througput. =C2=A0When you implement throughput yo=
u will
>> have to duplicate large parts of this code and data structures for
>> throughput, and if ever add some other constraint (frequency, voltag=
e)
>> it would need to be duplicated again.
>>
>> Maybe now is the time to consider an interface to add a generic
>> per-device constraint, with a type (latency, throughput, etc.), or
>> "class" as it's called in PM QoS. =C2=A0For now the type/class does =
not need
>> to be exposed externally, but will make implementing new constraint
>> types much easer.
> Ok that makes sense.
> In the current patch the constraints plist is stored inside the
> powerdomain structure. This does not apply to throughput, frequency
> and voltage constraints.
> Should the list constraint be managed in the OMAP PM layer instead of
> in the power domain code? If so where to store the constraints?

I was thinking at the omap_device layer, where there would be a
constraint plist managed for each class of constraint.

>> Some other comments below...
>>
>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>> Cc: Vibhore Vardhan <vvardhan@ti.com>
>>> ---
>>> Based on khilman's pm-core branch
>>>
>>> =C2=A0arch/arm/mach-omap2/omap_hwmod.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 62 ++++++++-
>>> =C2=A0arch/arm/mach-omap2/powerdomain.c =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0197 +++++++++++++++++++++++++
>>> =C2=A0arch/arm/mach-omap2/powerdomain.h =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 39 +++++-
>>> =C2=A0arch/arm/mach-omap2/powerdomains3xxx_data.c =C2=A0 | =C2=A0 6=
0 ++++++++
>>> =C2=A0arch/arm/plat-omap/include/plat/omap_device.h | =C2=A0 =C2=A0=
2 +
>>> =C2=A0arch/arm/plat-omap/include/plat/omap_hwmod.h =C2=A0| =C2=A0 =C2=
=A02 +
>>> =C2=A0arch/arm/plat-omap/omap-pm-constraints.c =C2=A0 =C2=A0 =C2=A0=
| =C2=A0121 +++++++--------
>>> =C2=A0arch/arm/plat-omap/omap_device.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| =C2=A0 28 ++++
>>> =C2=A08 files changed, 446 insertions(+), 65 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2=
/omap_hwmod.c
>>> index 028efda..bad8248 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>> @@ -142,6 +142,7 @@
>>> =C2=A0#include "powerdomain.h"
>>> =C2=A0#include <plat/clock.h>
>>> =C2=A0#include <plat/omap_hwmod.h>
>>> +#include <plat/omap_device.h>
>>> =C2=A0#include <plat/prcm.h>
>>>
>>> =C2=A0#include "cm2xxx_3xxx.h"
>>> @@ -2267,10 +2268,69 @@ ohsps_unlock:
>>> =C2=A0}
>>>
>>> =C2=A0/**
>>> + * omap_hwmod_set_max_dev_wakeup_lat - set a device wake-up constr=
aint
>>> + * @oh: the device of @oh to set a constraint on.
>>> + * @req_oh: the device of @req_oh is the requester of the constrai=
nt.
>>> + * @t: wakeup latency constraint (us). -1 removes the existing con=
straint.
>>> + *
>>> + * Query the powerdomain of @oh to set/release the wake-up constra=
int.
>>> + * @oh is used to determine which power domain to set a constraint=
 on.
>>> + * @req_oh is used to record the requester for later update or rem=
oval
>>> + * of a constraint.
>>> + *
>>> + * Returns -EINVAL if @oh or @req_oh have no power domain, or the =
return
>>> + * code from the pwrdm function (pwrdm_wakeuplat_set/release_const=
raint)
>>> + * of the powerdomain assocated with @oh.
>>> + */
>>> +int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod *req_oh,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct omap_hwmod =
*oh, long t)
>>> +{
>>> + =C2=A0 =C2=A0 struct device *req_dev;
>>> + =C2=A0 =C2=A0 struct platform_device *req_pdev;
>>> + =C2=A0 =C2=A0 struct powerdomain *pwrdm;
>>> +
>>> + =C2=A0 =C2=A0 pwrdm =3D omap_hwmod_get_pwrdm(oh);
>>> +
>>> + =C2=A0 =C2=A0 /* Catch devices with undefined powerdomains */
>>> + =C2=A0 =C2=A0 if (!PTR_ERR(pwrdm)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("omap_hwmod: Err=
or: could not find parent "
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "powerdomain for %s\n", oh->name);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 req_pdev =3D &(req_oh->od->pdev);
>>> + =C2=A0 =C2=A0 if (!PTR_ERR(req_pdev)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("omap_hwmod: Err=
or: pdev not found for oh %s\n",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0oh->name);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 req_dev =3D &(req_pdev->dev);
>>> + =C2=A0 =C2=A0 if (!PTR_ERR(req_dev)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("omap_hwmod: Err=
or: device not found for oh %s\n",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0oh->name);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 /* Call set/release_constraint for the given pwrdm =
*/
>>> + =C2=A0 =C2=A0 if (t =3D=3D -1) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("omap_hwmod: r=
emove max device latency constraint: "
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0"oh %s, pwrdm %s, req by oh %s\n",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0oh->name, pwrdm->name, req_oh->name);
>>> + =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("omap_hwmod: a=
dd max device latency constraint: "
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0"oh %s, t =3D %ld usec, pwrdm %s, req by oh %s\n",
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0oh->name, t, pwrdm->name, req_oh->name);
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 return pwrdm_wakeuplat_set_constraint(pwrdm, req_de=
v, t);
>>> +}
>>> +
>>> +/**
>>> =C2=A0 * omap_hwmod_get_context_loss_count - get lost context count
>>> =C2=A0 * @oh: struct omap_hwmod *
>>> =C2=A0 *
>>> - * Query the powerdomain of of @oh to get the context loss
>>> + * Query the powerdomain of @oh to get the context loss
>>> =C2=A0 * count for this device.
>>> =C2=A0 *
>>> =C2=A0 * Returns the context loss count of the powerdomain assocate=
d with @oh
>>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap=
2/powerdomain.c
>>> index eaed0df..6fb4741 100644
>>> --- a/arch/arm/mach-omap2/powerdomain.c
>>> +++ b/arch/arm/mach-omap2/powerdomain.c
>>> @@ -19,6 +19,8 @@
>>> =C2=A0#include <linux/list.h>
>>> =C2=A0#include <linux/errno.h>
>>> =C2=A0#include <linux/string.h>
>>> +#include <linux/slab.h>
>>> +
>>> =C2=A0#include "cm2xxx_3xxx.h"
>>> =C2=A0#include "prcm44xx.h"
>>> =C2=A0#include "cm44xx.h"
>>> @@ -103,6 +105,13 @@ static int _pwrdm_register(struct powerdomain =
*pwrdm)
>>> =C2=A0 =C2=A0 =C2=A0 pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
>>> =C2=A0 =C2=A0 =C2=A0 pwrdm->state_counter[pwrdm->state] =3D 1;
>>>
>>> + =C2=A0 =C2=A0 /* Initialize priority ordered list for wakeup late=
ncy constraint */
>>> + =C2=A0 =C2=A0 spin_lock_init(&pwrdm->wakeuplat_lock);
>>> + =C2=A0 =C2=A0 plist_head_init(&pwrdm->wakeuplat_dev_list, &pwrdm-=
>wakeuplat_lock);
>>> +
>>> + =C2=A0 =C2=A0 /* res_mutex protects res_list add and del ops */
>>> + =C2=A0 =C2=A0 mutex_init(&pwrdm->wakeuplat_mutex);
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 pr_debug("powerdomain: registered %s\n", pwrdm=
->name);
>>>
>>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>> @@ -176,6 +185,74 @@ static int _pwrdm_post_transition_cb(struct po=
werdomain *pwrdm, void *unused)
>>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>> =C2=A0}
>>>
>>> +/**
>>> + * pwrdm_wakeuplat_update_pwrst - Update power domain power state =
if needed
>>> + * @pwrdm: struct powerdomain * to which requesting device belongs=
 to.
>>> + *
>>> + * Finds the minimum allowed wake-up latency value from all entrie=
s
>>> + * in the list and the power domain power state needing the constr=
aint.
>>> + * Programs a new target state if it is different from current pow=
er state.
>>> + *
>>> + * Only OMAP3xxx is supported for now
>>> + *
>>> + * Returns 0 upon success.
>>> + */
>>> +static int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm)
>>> +{
>>> + =C2=A0 =C2=A0 struct plist_node *node;
>>> + =C2=A0 =C2=A0 int ret =3D 0, new_state;
>>> + =C2=A0 =C2=A0 long min_latency =3D -1;
>>> +
>>> + =C2=A0 =C2=A0 /* Find the strongest constraint from the plist */
>>> + =C2=A0 =C2=A0 if (!plist_head_empty(&pwrdm->wakeuplat_dev_list)) =
{
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D plist_first(&p=
wrdm->wakeuplat_dev_list);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 min_latency =3D node->p=
rio;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 /* Find power state with wakeup latency < minimum c=
onstraint. */
>>> + =C2=A0 =C2=A0 for (new_state =3D 0x0; new_state < PWRDM_MAX_PWRST=
S; new_state++) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (min_latency =3D=3D =
-1 ||
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwrdm->wa=
keup_lat[new_state] <=3D min_latency)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 switch (new_state) {
>>> + =C2=A0 =C2=A0 case PWRDM_FUNC_PWRST_OFF:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_state =3D PWRDM_POW=
ER_OFF;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>> + =C2=A0 =C2=A0 case PWRDM_FUNC_PWRST_OSWR:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap34xx())
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);
>>
>> cpu_is_* checks here aren't right.
>>
>> You should use SoC specific function pointers as are done for many o=
f the
>> other powerdomain calls after Rajendra's splitup series.
> The cpu_is_* tests are not related to the SoC specific function
> pointers but rather to the comment in the function description 'Only
> OMAP3xxx is supported for now'.
> In fact the function that are conditionally called
> (pwrdm_set_logic_retst and omap_set_pwrdm_state) are correctly using
> the SoC specific pointers.
>
> Is this test needed? If so is it the correct way to do it?

Right, I think you can just drop the cpu_is_* checks here since as you
pointed out, the called functions already handle SoC specifics.

>>
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_state =3D PWRDM_POW=
ER_RET;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>> + =C2=A0 =C2=A0 case PWRDM_FUNC_PWRST_CSWR:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap34xx())
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_state =3D PWRDM_POW=
ER_RET;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>> + =C2=A0 =C2=A0 case PWRDM_FUNC_PWRST_ON:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_state =3D PWRDM_POW=
ER_ON;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>> + =C2=A0 =C2=A0 default:
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_warn("powerdomain: r=
equested latency constraint not "
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "supported %s set to ON state\n", pwrdm->name);
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new_state =3D PWRDM_POW=
ER_ON;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 if (pwrdm_read_pwrst(pwrdm) !=3D new_state) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cpu_is_omap34xx())
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ret =3D omap_set_pwrdm_state(pwrdm, new_state);
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 pr_debug("powerdomain: %s pwrst: curr=3D%d, prev=3D=
%d next=3D%d "
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"min_latency=3D%l=
d, set_state=3D%d\n", pwrdm->name,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm_read_pwrst(=
pwrdm), pwrdm_read_prev_pwrst(pwrdm),
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pwrdm_read_next_p=
wrst(pwrdm), min_latency, new_state);
>>> +
>>> + =C2=A0 =C2=A0 return ret;
>>> +}
>>> +
>>
>> [...]
>>
>>> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm=
/mach-omap2/powerdomains3xxx_data.c
>>> index e1bec56..4f7e44d 100644
>>> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
>>> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>>> @@ -52,6 +52,12 @@ static struct powerdomain iva2_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [2] =3D PWRSTS_OFF=
_ON,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [3] =3D PWRDM_POWE=
R_ON,
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 1100,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 350,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0static struct powerdomain mpu_3xxx_pwrdm =3D {
>>> @@ -68,6 +74,12 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts_mem_on =C2=A0 =C2=A0=3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRSTS_OFF=
_ON,
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 95,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 45,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0/*
>>> @@ -98,6 +110,12 @@ static struct powerdomain core_3xxx_pre_es3_1_p=
wrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRSTS_OFF=
_RET_ON, /* MEM1ONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [1] =3D PWRSTS_OFF=
_RET_ON, /* MEM2ONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 100,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 60,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
>>> @@ -121,6 +139,12 @@ static struct powerdomain core_3xxx_es3_1_pwrd=
m =3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRSTS_OFF=
_RET_ON, /* MEM1ONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [1] =3D PWRSTS_OFF=
_RET_ON, /* MEM2ONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 100,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 60,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0static struct powerdomain dss_pwrdm =3D {
>>> @@ -136,6 +160,12 @@ static struct powerdomain dss_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts_mem_on =C2=A0 =C2=A0=3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRDM_POWE=
R_ON, =C2=A0/* MEMONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 70,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 20,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0/*
>>> @@ -157,6 +187,12 @@ static struct powerdomain sgx_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts_mem_on =C2=A0 =C2=A0=3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRDM_POWE=
R_ON, =C2=A0/* MEMONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 1000,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0static struct powerdomain cam_pwrdm =3D {
>>> @@ -172,6 +208,12 @@ static struct powerdomain cam_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts_mem_on =C2=A0 =C2=A0=3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRDM_POWE=
R_ON, =C2=A0/* MEMONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 850,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 35,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0static struct powerdomain per_pwrdm =3D {
>>> @@ -187,6 +229,12 @@ static struct powerdomain per_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts_mem_on =C2=A0 =C2=A0=3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRDM_POWE=
R_ON, =C2=A0/* MEMONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 200,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 110,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0static struct powerdomain emu_pwrdm =3D {
>>> @@ -201,6 +249,12 @@ static struct powerdomain neon_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .omap_chip =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D OMAP=
_CHIP_INIT(CHIP_IS_OMAP3430),
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 PWRSTS_OFF_RET_ON,
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts_logic_ret =3D PWRDM_POWER_RET,
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 200,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 35,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>>
>>> =C2=A0static struct powerdomain usbhost_pwrdm =3D {
>>> @@ -223,6 +277,12 @@ static struct powerdomain usbhost_pwrdm =3D {
>>> =C2=A0 =C2=A0 =C2=A0 .pwrsts_mem_on =C2=A0 =C2=A0=3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [0] =3D PWRDM_POWE=
R_ON, =C2=A0/* MEMONSTATE */
>>> =C2=A0 =C2=A0 =C2=A0 },
>>> + =C2=A0 =C2=A0 .wakeup_lat =3D {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OFF] =
=3D 800,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_OSWR]=
 =3D UNSUP_STATE,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_CSWR]=
 =3D 150,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PWRDM_FUNC_PWRST_ON] =3D=
 0,
>>> + =C2=A0 =C2=A0 },
>>> =C2=A0};
>>
>> A summary about where the latency numbers for each powerdomain come =
from
>> would be useful.
> Ok
>
>>
>> [...]
>>
>>> @@ -87,64 +60,86 @@ int omap_pm_set_min_bus_tput(struct device *dev=
, u8 agent_id, unsigned long r)
>>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>> =C2=A0}
>>>
>>> +/*
>>> + * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up la=
tency
>>> + * constraints
>>> + */
>>> =C2=A0int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, st=
ruct device *dev,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0long t)
>>> =C2=A0{
>>> + =C2=A0 =C2=A0 struct platform_device *pdev, *req_pdev;
>>> + =C2=A0 =C2=A0 int ret =3D 0;
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 if (!req_dev || !dev || t < -1) {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 WARN(1, "OMAP PM: =
%s: invalid parameter(s)", __func__);
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>> + =C2=A0 =C2=A0 }
>>> +
>>> + =C2=A0 =C2=A0 /* Look for the platform devices */
>>> + =C2=A0 =C2=A0 pdev =3D to_platform_device(dev);
>>> + =C2=A0 =C2=A0 req_pdev =3D to_platform_device(req_dev);
>>> +
>>> + =C2=A0 =C2=A0 /* Try to catch non platform devices. */
>>> + =C2=A0 =C2=A0 if ((pdev->name =3D=3D NULL) || (req_pdev->name =3D=
=3D NULL)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err("OMAP-PM set_wak=
eup_lat: Error: platform devices "
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0"not valid\n");
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>>> + =C2=A0 =C2=A0 } else {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Call the omap_device=
 API */
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D omap_device_set=
_max_dev_wakeup_lat(req_pdev, pdev, t);
>>> + =C2=A0 =C2=A0 }
>>
>> I don't think a NULL name check is the right sanity check here. =C2=A0=
WHat
>> you really need to know is whether the target device is an omap_devi=
ce.
>> The requesting device can be anything (I think.)
>>
>> Here's a simpler check:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (pdev->dev->parent =3D=3D &omap_device=
_parent)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D omap_=
device_set_max_dev_wakeup_lat(req_pdev, pdev, t);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...
> Ok I will use this test. Note: the dev parameter is already checked
> for NULL above.
>
> Also I think the requester parameter needs to keep the device* type
> across all layers. In any case only this type is used by the low leve=
l
> code (in powerdomain.c). This allows for any device (i.e. that does
> not necessarily have an associated omap_device) to request
> constraints.
> What do you think?

I agree that the only the target device needs to be an omap_device, the
requester can be any device.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
