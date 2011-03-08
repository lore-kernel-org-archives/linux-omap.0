From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices wakeup latency
 constraints APIs
Date: Tue, 8 Mar 2011 16:54:48 +0100
Message-ID: <AANLkTinKmQztha_tKM0zB7CWMqbCLtsaYxZrdX3RVvW+@mail.gmail.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299250375-26134-3-git-send-email-j-pihet@ti.com>
	<87aah6xsqk.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55105 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695Ab1CHPyt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 10:54:49 -0500
Received: by qyg14 with SMTP id 14so4774865qyg.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 07:54:48 -0800 (PST)
In-Reply-To: <87aah6xsqk.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

On Tue, Mar 8, 2011 at 3:15 AM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
>> creating similar APIs at the omap_device and omap_hwmod levels. The
>> omap_hwmod level call is the layer with access to the powerdomain
>> core, so it is the place where the powerdomain is queried to set and
>> release the constraints.
>>
>> NOTE: only works for devices which have been converted to use
>> =A0 =A0 =A0 omap_device/omap_hwmod.
>>
>> Longer term, we could possibly remove this API from the OMAP PM laye=
r,
>> and instead directly use the device level API.
>>
>> The power domains get the next power state programmed directly in
>> the registers via pwrdm_wakeuplat_update_pwrst.
>>
>> Note about PM QOS: the MPU and CORE power domains get the next power
>> state via cpuidle, which get the strongest wake-up latency constrain=
t
>> by querying PM QOS. The usage of PM QOS is temporary, until a generi=
c
>> solution is in place.
>>
>> Based on Vibhore's original patch, adapted to omap_device, omap_hwmo=
d
>> and PM QOS frameworks.
>
> I haven't got to a detailed review of this code yet, but did do some
> experiements and have some general comments on the code/design to get
> started.
>
> Also, I had a problem doing a real dumb test until I figured out the
> problem with the init sequence. =A0I tried setting a constraint in th=
e
> device init code for UART (mach-omap2/serial.c:omap_serial_init_port(=
)),
> and then I realized that that runs before
> mach-omap2/pm34xx.c:pwrdms_setup() which also calls
> omap_set_pwrdm_state() for each powerdomain to initialize.
Do we need to change the behavior at init?

> Also, for debug purposes, it might be useful to have a per-device sys=
fs
> interface to setting this wakeup latency constraint. =A0Something lik=
e
>
> =A0 /sys/devices/platform/omap/.../power/wakeup_latency
I do not see this as a debug interface but rather an API to the user sp=
ace.
If that is the case there are some issues to deal with, cf. below.

> I'm not sure exactly what to set the requesting device to though.
And also, how to track the requesters? PM QOS is using a /dev node
that must be kept open as long as the constraints remains valid.

> As far as implementation goes, you've so far implemented only wakeup
> latencies, but not througput. =A0When you implement throughput you wi=
ll
> have to duplicate large parts of this code and data structures for
> throughput, and if ever add some other constraint (frequency, voltage=
)
> it would need to be duplicated again.
>
> Maybe now is the time to consider an interface to add a generic
> per-device constraint, with a type (latency, throughput, etc.), or
> "class" as it's called in PM QoS. =A0For now the type/class does not =
need
> to be exposed externally, but will make implementing new constraint
> types much easer.
Ok that makes sense.
In the current patch the constraints plist is stored inside the
powerdomain structure. This does not apply to throughput, frequency
and voltage constraints.
Should the list constraint be managed in the OMAP PM layer instead of
in the power domain code? If so where to store the constraints?

> Some other comments below...
>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Vibhore Vardhan <vvardhan@ti.com>
>> ---
>> Based on khilman's pm-core branch
>>
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 62 ++++++++-
>> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0 | =A019=
7 +++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 3=
9 +++++-
>> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0 | =A0 60 ++++++++
>> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 =A02 +
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A02 +
>> =A0arch/arm/plat-omap/omap-pm-constraints.c =A0 =A0 =A0| =A0121 ++++=
+++--------
>> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 28 ++++
>> =A08 files changed, 446 insertions(+), 65 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
>> index 028efda..bad8248 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>> @@ -142,6 +142,7 @@
>> =A0#include "powerdomain.h"
>> =A0#include <plat/clock.h>
>> =A0#include <plat/omap_hwmod.h>
>> +#include <plat/omap_device.h>
>> =A0#include <plat/prcm.h>
>>
>> =A0#include "cm2xxx_3xxx.h"
>> @@ -2267,10 +2268,69 @@ ohsps_unlock:
>> =A0}
>>
>> =A0/**
>> + * omap_hwmod_set_max_dev_wakeup_lat - set a device wake-up constra=
int
>> + * @oh: the device of @oh to set a constraint on.
>> + * @req_oh: the device of @req_oh is the requester of the constrain=
t.
>> + * @t: wakeup latency constraint (us). -1 removes the existing cons=
traint.
>> + *
>> + * Query the powerdomain of @oh to set/release the wake-up constrai=
nt.
>> + * @oh is used to determine which power domain to set a constraint =
on.
>> + * @req_oh is used to record the requester for later update or remo=
val
>> + * of a constraint.
>> + *
>> + * Returns -EINVAL if @oh or @req_oh have no power domain, or the r=
eturn
>> + * code from the pwrdm function (pwrdm_wakeuplat_set/release_constr=
aint)
>> + * of the powerdomain assocated with @oh.
>> + */
>> +int omap_hwmod_set_max_dev_wakeup_lat(struct omap_hwmod *req_oh,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct omap_hwmod *oh, long t)
>> +{
>> + =A0 =A0 struct device *req_dev;
>> + =A0 =A0 struct platform_device *req_pdev;
>> + =A0 =A0 struct powerdomain *pwrdm;
>> +
>> + =A0 =A0 pwrdm =3D omap_hwmod_get_pwrdm(oh);
>> +
>> + =A0 =A0 /* Catch devices with undefined powerdomains */
>> + =A0 =A0 if (!PTR_ERR(pwrdm)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: could not find =
parent "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "powerdomain for %s\n", oh=
->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 req_pdev =3D &(req_oh->od->pdev);
>> + =A0 =A0 if (!PTR_ERR(req_pdev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: pdev not found =
for oh %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 req_dev =3D &(req_pdev->dev);
>> + =A0 =A0 if (!PTR_ERR(req_dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: device not foun=
d for oh %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Call set/release_constraint for the given pwrdm */
>> + =A0 =A0 if (t =3D=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("omap_hwmod: remove max device la=
tency constraint: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"oh %s, pwrdm %s, req b=
y oh %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name, pwrdm->name, =
req_oh->name);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("omap_hwmod: add max device laten=
cy constraint: "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"oh %s, t =3D %ld usec,=
 pwrdm %s, req by oh %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0oh->name, t, pwrdm->nam=
e, req_oh->name);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return pwrdm_wakeuplat_set_constraint(pwrdm, req_dev, t);
>> +}
>> +
>> +/**
>> =A0 * omap_hwmod_get_context_loss_count - get lost context count
>> =A0 * @oh: struct omap_hwmod *
>> =A0 *
>> - * Query the powerdomain of of @oh to get the context loss
>> + * Query the powerdomain of @oh to get the context loss
>> =A0 * count for this device.
>> =A0 *
>> =A0 * Returns the context loss count of the powerdomain assocated wi=
th @oh
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2=
/powerdomain.c
>> index eaed0df..6fb4741 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -19,6 +19,8 @@
>> =A0#include <linux/list.h>
>> =A0#include <linux/errno.h>
>> =A0#include <linux/string.h>
>> +#include <linux/slab.h>
>> +
>> =A0#include "cm2xxx_3xxx.h"
>> =A0#include "prcm44xx.h"
>> =A0#include "cm44xx.h"
>> @@ -103,6 +105,13 @@ static int _pwrdm_register(struct powerdomain *=
pwrdm)
>> =A0 =A0 =A0 pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
>> =A0 =A0 =A0 pwrdm->state_counter[pwrdm->state] =3D 1;
>>
>> + =A0 =A0 /* Initialize priority ordered list for wakeup latency con=
straint */
>> + =A0 =A0 spin_lock_init(&pwrdm->wakeuplat_lock);
>> + =A0 =A0 plist_head_init(&pwrdm->wakeuplat_dev_list, &pwrdm->wakeup=
lat_lock);
>> +
>> + =A0 =A0 /* res_mutex protects res_list add and del ops */
>> + =A0 =A0 mutex_init(&pwrdm->wakeuplat_mutex);
>> +
>> =A0 =A0 =A0 pr_debug("powerdomain: registered %s\n", pwrdm->name);
>>
>> =A0 =A0 =A0 return 0;
>> @@ -176,6 +185,74 @@ static int _pwrdm_post_transition_cb(struct pow=
erdomain *pwrdm, void *unused)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +/**
>> + * pwrdm_wakeuplat_update_pwrst - Update power domain power state i=
f needed
>> + * @pwrdm: struct powerdomain * to which requesting device belongs =
to.
>> + *
>> + * Finds the minimum allowed wake-up latency value from all entries
>> + * in the list and the power domain power state needing the constra=
int.
>> + * Programs a new target state if it is different from current powe=
r state.
>> + *
>> + * Only OMAP3xxx is supported for now
>> + *
>> + * Returns 0 upon success.
>> + */
>> +static int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm)
>> +{
>> + =A0 =A0 struct plist_node *node;
>> + =A0 =A0 int ret =3D 0, new_state;
>> + =A0 =A0 long min_latency =3D -1;
>> +
>> + =A0 =A0 /* Find the strongest constraint from the plist */
>> + =A0 =A0 if (!plist_head_empty(&pwrdm->wakeuplat_dev_list)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 node =3D plist_first(&pwrdm->wakeuplat_dev=
_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 min_latency =3D node->prio;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Find power state with wakeup latency < minimum constrai=
nt. */
>> + =A0 =A0 for (new_state =3D 0x0; new_state < PWRDM_MAX_PWRSTS; new_=
state++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (min_latency =3D=3D -1 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm->wakeup_lat[new_state] <=3D =
min_latency)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 switch (new_state) {
>> + =A0 =A0 case PWRDM_FUNC_PWRST_OFF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_OFF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrd=
m, PWRDM_POWER_OFF);
>
> cpu_is_* checks here aren't right.
>
> You should use SoC specific function pointers as are done for many of=
 the
> other powerdomain calls after Rajendra's splitup series.
The cpu_is_* tests are not related to the SoC specific function
pointers but rather to the comment in the function description 'Only
OMAP3xxx is supported for now'.
In fact the function that are conditionally called
(pwrdm_set_logic_retst and omap_set_pwrdm_state) are correctly using
the SoC specific pointers.

Is this test needed? If so is it the correct way to do it?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_RET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrd=
m, PWRDM_POWER_RET);
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_RET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_FUNC_PWRST_ON:
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_ON;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("powerdomain: requested latency co=
nstraint not "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "supported %s set to ON st=
ate\n", pwrdm->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_ON;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (pwrdm_read_pwrst(pwrdm) !=3D new_state) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx())
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_set_pwrdm_sta=
te(pwrdm, new_state);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 pr_debug("powerdomain: %s pwrst: curr=3D%d, prev=3D%d next=
=3D%d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0"min_latency=3D%ld, set_state=3D%d\n", =
pwrdm->name,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_read_pwrst(pwrdm), pwrdm_read_pre=
v_pwrst(pwrdm),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_read_next_pwrst(pwrdm), min_laten=
cy, new_state);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>
> [...]
>
>> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/=
mach-omap2/powerdomains3xxx_data.c
>> index e1bec56..4f7e44d 100644
>> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> @@ -52,6 +52,12 @@ static struct powerdomain iva2_pwrdm =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [2] =3D PWRSTS_OFF_ON,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [3] =3D PWRDM_POWER_ON,
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 1100,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 350,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct powerdomain mpu_3xxx_pwrdm =3D {
>> @@ -68,6 +74,12 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
>> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_OFF_ON,
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 95,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 45,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0/*
>> @@ -98,6 +110,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pw=
rdm =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONSTAT=
E */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONSTAT=
E */
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 100,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 60,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
>> @@ -121,6 +139,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm=
 =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONSTAT=
E */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONSTAT=
E */
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 100,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 60,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct powerdomain dss_pwrdm =3D {
>> @@ -136,6 +160,12 @@ static struct powerdomain dss_pwrdm =3D {
>> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTATE=
 */
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 70,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 20,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0/*
>> @@ -157,6 +187,12 @@ static struct powerdomain sgx_pwrdm =3D {
>> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTATE=
 */
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 1000,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct powerdomain cam_pwrdm =3D {
>> @@ -172,6 +208,12 @@ static struct powerdomain cam_pwrdm =3D {
>> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTATE=
 */
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 850,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 35,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct powerdomain per_pwrdm =3D {
>> @@ -187,6 +229,12 @@ static struct powerdomain per_pwrdm =3D {
>> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTATE=
 */
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 200,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 110,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct powerdomain emu_pwrdm =3D {
>> @@ -201,6 +249,12 @@ static struct powerdomain neon_pwrdm =3D {
>> =A0 =A0 =A0 .omap_chip =A0 =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMA=
P3430),
>> =A0 =A0 =A0 .pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_OFF_RET_ON,
>> =A0 =A0 =A0 .pwrsts_logic_ret =3D PWRDM_POWER_RET,
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 200,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 35,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>>
>> =A0static struct powerdomain usbhost_pwrdm =3D {
>> @@ -223,6 +277,12 @@ static struct powerdomain usbhost_pwrdm =3D {
>> =A0 =A0 =A0 .pwrsts_mem_on =A0 =A0=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D PWRDM_POWER_ON, =A0/* MEMONSTATE=
 */
>> =A0 =A0 =A0 },
>> + =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 800,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 150,
>> + =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>> + =A0 =A0 },
>> =A0};
>
> A summary about where the latency numbers for each powerdomain come f=
rom
> would be useful.
Ok

>
> [...]
>
>> @@ -87,64 +60,86 @@ int omap_pm_set_min_bus_tput(struct device *dev,=
 u8 agent_id, unsigned long r)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +/*
>> + * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up lat=
ency
>> + * constraints
>> + */
>> =A0int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct=
 device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l=
ong t)
>> =A0{
>> + =A0 =A0 struct platform_device *pdev, *req_pdev;
>> + =A0 =A0 int ret =3D 0;
>> +
>> =A0 =A0 =A0 if (!req_dev || !dev || t < -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter(=
s)", __func__);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Look for the platform devices */
>> + =A0 =A0 pdev =3D to_platform_device(dev);
>> + =A0 =A0 req_pdev =3D to_platform_device(req_dev);
>> +
>> + =A0 =A0 /* Try to catch non platform devices. */
>> + =A0 =A0 if ((pdev->name =3D=3D NULL) || (req_pdev->name =3D=3D NUL=
L)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("OMAP-PM set_wakeup_lat: Error: pla=
tform devices "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"not valid\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Call the omap_device API */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_set_max_dev_wakeup_lat=
(req_pdev, pdev, t);
>> + =A0 =A0 }
>
> I don't think a NULL name check is the right sanity check here. =A0WH=
at
> you really need to know is whether the target device is an omap_devic=
e.
> The requesting device can be anything (I think.)
>
> Here's a simpler check:
>
> =A0 =A0 =A0 =A0if (pdev->dev->parent =3D=3D &omap_device_parent)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D omap_device_set_max_dev_wakeup=
_lat(req_pdev, pdev, t);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
Ok I will use this test. Note: the dev parameter is already checked
for NULL above.

Also I think the requester parameter needs to keep the device* type
across all layers. In any case only this type is used by the low level
code (in powerdomain.c). This allows for any device (i.e. that does
not necessarily have an associated omap_device) to request
constraints.
What do you think?

>
>
>> + =A0 =A0 return ret;
>> +}
>
> Kevin
>

Thanks for reviewing the code.

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
