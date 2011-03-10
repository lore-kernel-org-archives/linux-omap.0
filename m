From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices constraints APIs
Date: Thu, 10 Mar 2011 11:03:37 +0100
Message-ID: <AANLkTikN=1TLGoqLE4OBNdq4DDHAimGURA9ejy7TOZm7@mail.gmail.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299698346-2768-1-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1103091943550.15132@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52724 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1CJKDi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 05:03:38 -0500
Received: by qyg14 with SMTP id 14so1258669qyg.19
        for <linux-omap@vger.kernel.org>; Thu, 10 Mar 2011 02:03:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103091943550.15132@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Hi Paul,

On Thu, Mar 10, 2011 at 5:03 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hello Jean
>
> Thanks for working on this stuff. =A0Some comments based on a quick l=
ook...
>
> On Wed, 9 Mar 2011, Jean Pihet wrote:
>
>> Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
>> creating a unified API which calls omap_device_set_dev_constraint
>> for all classes of constraints (devices wake-up latency, devices
>> throughput...).
>> The implementation of the constraints framework is at the omap_devic=
e
>> level: management and storage of the constraints, dispatching of the
>> constraints to the appropriate low level layers.
>>
>> NOTE: only works for devices which have been converted to use
>> =A0 =A0 =A0 omap_device/omap_hwmod.
>>
>> Longer term, we could possibly remove this API from the OMAP PM laye=
r,
>> and instead directly use the device level API.
>>
>> For the devices wake-up latency constraints, the power domains get
>> the next power state programmed directly in the registers via
>> pwrdm_wakeuplat_update_pwrst.
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
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Cc: Vibhore Vardhan <vvardhan@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 29 ++++-
>> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 9=
9 +++++++++++++
>> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 2=
4 +++-
>> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0 | =A0 63 ++++++++=
+
>> =A0arch/arm/plat-omap/include/plat/omap-pm.h =A0 =A0 | =A0 =A06 +-
>> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 14 ++
>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A01 +
>> =A0arch/arm/plat-omap/omap-pm-constraints.c =A0 =A0 =A0| =A0161 ++++=
++++++------------
>> =A0arch/arm/plat-omap/omap-pm-noop.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
>> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
187 +++++++++++++++++++++++++
>> =A010 files changed, 493 insertions(+), 93 deletions(-)
>
> Please split this patch up into several patches:
>
> - the powerdomain.h/powerdomain.c changes
> - the powerdomains*_data.c changes
> - any changes you want to make to the omap-pm.h interface, and if tho=
se
> =A0require changes to the omap-pm-*.c files, change those here too
> - omap_hwmod changes (if needed, which I don't think they are)
> - omap_device changes
> - omap-pm-constraints changes
Ok that will make the patch easier to read (and digest).

>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/=
omap_hwmod.c
>> index cf8cc9b..8caf2c5 100644
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
>> @@ -2277,11 +2278,37 @@ ohsps_unlock:
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> +/*
>> + * omap_hwmod_update_power_state - Update the power domain power st=
ate of
>> + * @oh
>> + *
>> + * @oh: struct omap_hwmod* to which the requesting device belongs t=
o.
>> + * @min_latency: the allowed wake-up latency for the power domain o=
f @oh.
>> + *
>> + * Finds the power domain next power state that fulfills the constr=
aint.
>> + * Applies the constraint to the power domain by calling
>> + * pwrdm_wakeuplat_update_pwrst.
>> + *
>> + * Returns 0 upon success.
>> + */
>> +int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_l=
atency)
>> +{
>> + =A0 =A0 struct powerdomain *pwrdm =3D omap_hwmod_get_pwrdm(oh);
>> +
>> + =A0 =A0 if (!PTR_ERR(pwrdm)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: could not find =
parent "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "powerdomain for %s\n", oh=
->name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return pwrdm_wakeuplat_update_pwrst(pwrdm, min_latency);
>> +}
>
> I don't think this function is needed. =A0Might as well just take car=
e of it
> in your omap_device code.
I did not have it originally but arch/arm/mach-omap2/powerdomain.h is
not included in arch/arm/plat-omap/include/plat/omap_device.c, so I
think I have to pass the call through the hwmod layer.
Please let me know if that is allowed. I do not see any pwrdm code in
omap_device.c (excepted omap_device_get_pwrdm(od)).

>
>> +
>> =A0/**
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
>> index eaed0df..496f245 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -19,6 +19,7 @@
>> =A0#include <linux/list.h>
>> =A0#include <linux/errno.h>
>> =A0#include <linux/string.h>
>> +
>> =A0#include "cm2xxx_3xxx.h"
>> =A0#include "prcm44xx.h"
>> =A0#include "cm44xx.h"
>> @@ -176,6 +177,104 @@ static int _pwrdm_post_transition_cb(struct po=
werdomain *pwrdm, void *unused)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +/*
>> + * Test if the current powerdomain is MPU or CORE
>> + *
>> + * This function is only used by pwrdm_wakeuplat_update_pwrst
>> + * which applies the MPU and CORE power domains constraints using P=
M QOS.
>> + *
>> + * This will disappear when all power domains will be controlled di=
rectly
>> + * from the wake-up latency constraints framework
>> + */
>> +static inline int is_pwrdm_mpu_or_core(struct powerdomain *pwrdm)
>> +{
>> + =A0 =A0 if ((strncmp(pwrdm->name, "mpu_pwrdm", 9) =3D=3D 0) ||
>> + =A0 =A0 =A0 =A0 (strncmp(pwrdm->name, "core_pwrdm", 10) =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +}
>
> Please add some kind of powerdomain flag instead, set in some OMAP3
> powerdomain-specific init code, rather than strncmp().
Ok I am looking at it. Note that this code is scheduled for removal,
in favor of a generic solution that uses pwrdm code only (i.e. not PM
QOS).

>
>> +
>> +/**
>> + * pwrdm_wakeuplat_update_pwrst - Update power domain power state i=
f needed
>> + * @pwrdm: struct powerdomain * to which requesting device belongs =
to.
>> + * @min_latency: the allowed wake-up latency for the given power do=
main.
>> + *
>> + * Finds the power domain next power state that fulfills the constr=
aint.
>> + * Programs a new target state if it is different from current powe=
r state.
>> + *
>> + * Returns 0 upon success.
>> + */
>> +int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long mi=
n_latency)
>> +{
>> + =A0 =A0 int ret =3D 0, new_state =3D 0;
>> +
>> + =A0 =A0 if (!pwrdm) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "powerdomain: %s: invalid paramete=
r(s)", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Apply constraints to MPU and CORE via the PM QOS API.
>> + =A0 =A0 =A0* Every power domain struct has a pm_qos_request_list f=
ield
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (is_pwrdm_mpu_or_core(pwrdm)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pm_qos_request_active(&(pwrdm->pm_qos_=
request)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_remove_request(&(pw=
rdm->pm_qos_request));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (min_latency >=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_add_request(&(pwrdm=
->pm_qos_request),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0PM_QOS_CPU_DMA_LATENCY,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0min_latency);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Apply constraints to pwrdm other than MPU and CORE by=
 programming
>> + =A0 =A0 =A0* the pwrdm next power state.
>> + =A0 =A0 =A0*/
>> +
>> + =A0 =A0 /* Find power state with wakeup latency < minimum constrai=
nt */
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_O=
=46F);
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_RET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_R=
ET);
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
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_set_pwrdm_state(pwrdm, new_st=
ate);
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
>> =A0/* Public functions */
>>
>> =A0/**
>> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2=
/powerdomain.h
>> index 0b7a357..c796469 100644
>> --- a/arch/arm/mach-omap2/powerdomain.h
>> +++ b/arch/arm/mach-omap2/powerdomain.h
>> @@ -19,7 +19,10 @@
>>
>> =A0#include <linux/types.h>
>> =A0#include <linux/list.h>
>> -
>> +#include <linux/plist.h>
>> +#include <linux/mutex.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/pm_qos_params.h>
>> =A0#include <linux/atomic.h>
>>
>> =A0#include <plat/cpu.h>
>> @@ -46,6 +49,15 @@
>>
>> =A0#define PWRSTS_OFF_RET_ON =A0 =A0(PWRSTS_OFF_RET | (1 << PWRDM_PO=
WER_ON))
>>
>> +/* Powerdomain functional power states */
>> +#define PWRDM_FUNC_PWRST_OFF 0x0
>> +#define PWRDM_FUNC_PWRST_OSWR =A0 =A0 =A0 =A00x1
>> +#define PWRDM_FUNC_PWRST_CSWR =A0 =A0 =A0 =A00x2
>
> You'll also want an _INACTIVE state here, per:
>
> =A0 http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43783.h=
tml
Is this state implemented? I do not see any code using it in the
current pm-core branch. If so can this be done later. See also the
remarks below about the latency figures.

>
>> +#define PWRDM_FUNC_PWRST_ON =A00x3
>> +
>> +#define PWRDM_MAX_FUNC_PWRSTS =A0 =A0 =A0 =A04
>> +
>> +#define UNSUP_STATE =A0 =A0 =A0 =A0 =A0-1
>>
>> =A0/* Powerdomain flags */
>> =A0#define PWRDM_HAS_HDWR_SAR =A0 (1 << 0) /* hardware save-and-rest=
ore support */
>> @@ -96,7 +108,11 @@ struct powerdomain;
>> =A0 * @state_counter:
>> =A0 * @timer:
>> =A0 * @state_timer:
>> - *
>> + * @wakeup_lat: wakeup latencies for possible powerdomain power sta=
tes
>> + * Note about the wakeup latencies ordering: the values must be sor=
ted
>> + * =A0in decremental order
>
> Would be good to specify the unit of time here.
Ok will do.

>
>> + * @pm_qos_request: PM QOS handle, only used to control the MPU and=
 CORE power
>> + * =A0domains states; to be removed when a generic solution is in p=
lace.
>> =A0 * @prcm_partition possible values are defined in mach-omap2/prcm=
44xx.h.
>> =A0 */
>> =A0struct powerdomain {
>> @@ -121,6 +137,8 @@ struct powerdomain {
>> =A0 =A0 =A0 s64 timer;
>> =A0 =A0 =A0 s64 state_timer[PWRDM_MAX_PWRSTS];
>> =A0#endif
>> + =A0 =A0 const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
>> + =A0 =A0 struct pm_qos_request_list pm_qos_request;
>> =A0};
>>
>> =A0/**
>> @@ -210,6 +228,8 @@ int pwrdm_clkdm_state_switch(struct clockdomain =
*clkdm);
>> =A0int pwrdm_pre_transition(void);
>> =A0int pwrdm_post_transition(void);
>> =A0int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
>> +
>> +int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long mi=
n_latency);
>> =A0u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
>>
>> =A0extern void omap2xxx_powerdomains_init(void);
>> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/=
mach-omap2/powerdomains3xxx_data.c
>> index e1bec56..64973d1 100644
>> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> @@ -31,6 +31,9 @@
>>
>> =A0/*
>> =A0 * Powerdomains
>> + *
>> + * The wakeup_lat values are derived from measurements on
>> + * the actual target.
>
> Which type of OMAP3 chip were these measured on? =A0OMAP34xx/35xx,
> OMAP36xx/37xx, AM3505/17 ?
Well although the comment says actual measurements have been made
(which is true!), the figures are not correct for the moment. Once the
framework is in place some more accurate measurements will be
performed.
The OMAP tracepoints implementation, the wiki information [1] and the
PMIC OFF support wiki [2] will definitely help. Also there are
measurements activities going-on at TI.

[1] http://omappedia.org/wiki/Power_Management_Device_Latencies_Measure=
ment
[2] http://omappedia.org/wiki/TWL4030_power_scripts

>
> Also it would be good to know the sys_clk rate and the VDD1/2 OPPs th=
at
> you took these measurements at. =A0Do you have a sense of how much th=
ese
> measurements vary based on those three factors? =A0Presumably,
> 12MHz/125MHz/83MHz would be the worst case, for the standard OPPs any=
way.
>
> In general, if you could elaborate further how you measured these, th=
at
> would be good. =A0Some of these measurements seem to be too low (desc=
ribed
> below).
That will be part of the measurements task.

>
> I'm not sure if a strictly static table is the right approach for the=
se
> measurements. =A0It might be good to start with a static table that
> represents the lowest possible latencies, measured with DPLL autoidle
> disabled, and then to add or remove amounts from those numbers dynami=
cally
> based on the state of other devices. =A0For example, in terms of CORE=
, the
> AUTOEXTCLKMODE settings and the amount of time it takes the external =
HF
> oscillator to restart will have a major impact on the CORE OFF->ON
> measurements, potentially several milliseconds. =A0Similarly, if DPLL=
1, 2,
> or 3 have to relock, that could take quite a bit of time, potentially
> several hundred microseconds.
The idea is to use the dynamic measurements mechanism implemented in hw=
mod.
Also I am still not sure on how to account for all the power domains
combination: should the latencies values be added together?

>
>> =A0 */
>>
>> =A0static struct powerdomain iva2_pwrdm =3D {
>> @@ -52,6 +55,12 @@ static struct powerdomain iva2_pwrdm =3D {
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
>
> Was this measured with DPLL2 autoidle enabled or disabled?
>
>>
>> =A0static struct powerdomain mpu_3xxx_pwrdm =3D {
>> @@ -68,6 +77,12 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
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
>
> Was this measured with DPLL1 autoidle enabled or disabled?
>
> That OFF->ON time looks really low to me...
>
>>
>> =A0/*
>> @@ -98,6 +113,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pw=
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
>> @@ -121,6 +142,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm=
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
>
> The figures for the CORE powerdomain look implausibly low. =A0Do thes=
e
> figures represent the amount of time required to transition from the =
low
> power state to the point at which Linux is running again? =A0Or do th=
ey
> represent something else?
>
>> =A0static struct powerdomain dss_pwrdm =3D {
>> @@ -136,6 +163,12 @@ static struct powerdomain dss_pwrdm =3D {
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
>> @@ -157,6 +190,12 @@ static struct powerdomain sgx_pwrdm =3D {
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
>> @@ -172,6 +211,12 @@ static struct powerdomain cam_pwrdm =3D {
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
>> @@ -187,6 +232,12 @@ static struct powerdomain per_pwrdm =3D {
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
>> @@ -201,6 +252,12 @@ static struct powerdomain neon_pwrdm =3D {
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
>> @@ -223,6 +280,12 @@ static struct powerdomain usbhost_pwrdm =3D {
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
>>
>> =A0static struct powerdomain dpll1_pwrdm =3D {
>> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/pl=
at-omap/include/plat/omap-pm.h
>> index c0a7520..16f9e84 100644
>> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
>> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
>> @@ -70,6 +70,10 @@ void omap_pm_if_exit(void);
>> =A0 * Device-driver-originated constraints (via board-*.c files, pla=
tform_data)
>> =A0 */
>>
>> +enum omap_pm_constraint_class {
>> + =A0 =A0 OMAP_PM_CONSTRAINT_WKUP_LAT,
>> + =A0 =A0 OMAP_PM_CONSTRAINT_THROUGHPUT
>> +};
>>
>> =A0/**
>> =A0 * omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup la=
tency
>> @@ -137,7 +141,7 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device=
 *dev, long t);
>> =A0 * Returns -EINVAL for an invalid argument, -ERANGE if the constr=
aint
>> =A0 * is not satisfiable, or 0 upon success.
>> =A0 */
>> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsig=
ned long r);
>> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long =
r);
>
> The documentation for this function states:
>
> =A0To remove the interconnect throughput restriction for this device,=
 call with r =3D 0.
>
> So an unsigned long seems reasonable here?
Hmm good catch! I changed the parameter to be inline with the
constraints API (value=3D-1 means removal of the constraint). Can the
tput API be changed (and the doc acordingly)?
BTW what is the agent_id? A requester ID or ptr is needed in order to
keep track of the constraints.

>
>>
>> =A0/**
>> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/ar=
m/plat-omap/include/plat/omap_device.h
>> index e4c349f..d4766c4 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_device.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
>> @@ -32,9 +32,11 @@
>> =A0#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_DEVICE_H
>>
>> =A0#include <linux/kernel.h>
>> +#include <linux/plist.h>
>> =A0#include <linux/platform_device.h>
>>
>> =A0#include <plat/omap_hwmod.h>
>> +#include <plat/omap-pm.h>
>>
>> =A0extern struct device omap_device_parent;
>>
>> @@ -73,6 +75,15 @@ struct omap_device {
>> =A0 =A0 =A0 s8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0pm_lat_level;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0hwmods_cnt;
>> =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0_state;
>> +
>> +};
>> +
>> +/* Linked list for the devices constraints entries */
>> +struct omap_device_constraints_entry {
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *req_dev=
;
>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*target;
>> + =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 constrai=
nt_value;
>> + =A0 =A0 struct plist_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 node;
>> =A0};
>>
>> =A0/* Device driver interface (call via platform_data fn ptrs) */
>> @@ -107,6 +118,9 @@ void __iomem *omap_device_get_rt_va(struct omap_=
device *od);
>> =A0int omap_device_align_pm_lat(struct platform_device *pdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 new_wakeu=
p_lat_limit);
>> =A0struct powerdomain *omap_device_get_pwrdm(struct omap_device *od)=
;
>> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class cl=
ass,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *req_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *dev, long t);
>
> This should be two separate functions, one for max wakeup latency and=
 the
> other for minimum bandwidth... discussed further below.
Why? The idea is to keep the code compact and not duplicated. Cf. the
function omap_device_store_constraint which is meant to manage all
constraint lists.

>
>> =A0u32 omap_device_get_context_loss_count(struct platform_device *pd=
ev);
>>
>> =A0/* Other */
>> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm=
/plat-omap/include/plat/omap_hwmod.h
>> index 65bcad4..f27110e 100644
>> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
>> @@ -597,6 +597,7 @@ int omap_hwmod_for_each_by_class(const char *cla=
ssname,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void =
*user);
>>
>> =A0int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 stat=
e);
>> +int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_l=
atency);
>> =A0u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>>
>> =A0/*
>> diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/pla=
t-omap/omap-pm-constraints.c
>> index c8b4e4c..4709f83 100644
>> --- a/arch/arm/plat-omap/omap-pm-constraints.c
>> +++ b/arch/arm/plat-omap/omap-pm-constraints.c
>> @@ -24,6 +24,7 @@
>> =A0/* Interface documentation is in mach/omap-pm.h */
>> =A0#include <plat/omap-pm.h>
>> =A0#include <plat/omap_device.h>
>> +#include <plat/common.h>
>>
>> =A0static bool off_mode_enabled;
>> =A0static u32 dummy_context_loss_counter;
>> @@ -32,35 +33,46 @@ static u32 dummy_context_loss_counter;
>> =A0 * Device-driver-originated constraints (via board-*.c files)
>> =A0 */
>>
>> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
>> +/*
>> + * Generic function to omap_device layer for the constraints API.
>> + */
>> +static int omap_pm_set_dev_constraint(enum omap_pm_constraint_class=
 class,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct device *req_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 struct device *dev, long t)
>
> For static functions, I'd suggest dropping the "omap_pm" prefix from =
the
> names of these functions, so they begin with an underscore.
Ok will do.

>
>> =A0{
>> - =A0 =A0 if (!dev || t < -1) {
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 if (!req_dev || !dev || t < -1) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter(=
s)", __func__);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 };
>> -
>> - =A0 =A0 if (t =3D=3D -1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max MPU wakeup l=
atency constraint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(de=
v));
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max MPU wakeup late=
ncy constraint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld usec=
\n", dev_name(dev), t);
>> + =A0 =A0 }
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* For current Linux, this needs to map the MPU to a
>> - =A0 =A0 =A0* powerdomain, then go through the list of current max =
lat
>> - =A0 =A0 =A0* constraints on the MPU and find the smallest. =A0If
>> - =A0 =A0 =A0* the latency constraint has changed, the code should
>> - =A0 =A0 =A0* recompute the state to enter for the next powerdomain
>> - =A0 =A0 =A0* state.
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* TI CDP code can call constraint_set here.
>> - =A0 =A0 =A0*/
>> + =A0 =A0 /* Try to catch non omap_device for dev */
>> + =A0 =A0 if (dev->parent =3D=3D &omap_device_parent) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (t =3D=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove =
constraint of class %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"from r=
eq_dev %s on dev %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0class, =
dev_name(req_dev), dev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add con=
straint of class %d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"from r=
eq_dev %s on dev %s, t =3D %ld\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0class, =
dev_name(req_dev), dev_name(dev), t);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Call the omap_device API */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_set_dev_constraint(cla=
ss, req_dev, dev, t);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("OMAP-PM set_wakeup_lat: Error: pla=
tform device "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"not valid\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>>
>> - =A0 =A0 return 0;
>> + =A0 =A0 return ret;
>> =A0}
>>
>> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsig=
ned long r)
>> +/*
>> + * omap_pm_set_min_bus_tput - set/release bus throughput constraint=
s
>> + */
>> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long =
r)
>> =A0{
>> =A0 =A0 =A0 if (!dev || (agent_id !=3D OCP_INITIATOR_AGENT &&
>> =A0 =A0 =A0 =A0 =A0 agent_id !=3D OCP_TARGET_AGENT)) {
>> @@ -68,83 +80,56 @@ int omap_pm_set_min_bus_tput(struct device *dev,=
 u8 agent_id, unsigned long r)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> =A0 =A0 =A0 };
>>
>> - =A0 =A0 if (r =3D=3D 0)
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove min bus tput con=
straint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s for agent_id %d=
\n", dev_name(dev), agent_id);
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add min bus tput constr=
aint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s for agent_id %d=
: rate %ld KiB\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(dev), agent_id=
, r);
>> -
>> =A0 =A0 =A0 /*
>> - =A0 =A0 =A0* This code should model the interconnect and compute t=
he
>> - =A0 =A0 =A0* required clock frequency, convert that to a VDD2 OPP =
ID, then
>> - =A0 =A0 =A0* set the VDD2 OPP appropriately.
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* TI CDP code can call constraint_set here on the VDD2 =
OPP.
>> + =A0 =A0 =A0* This code calls the generic omap_device API function
>> + =A0 =A0 =A0* omap_pm_set_dev_constraint with the class
>> + =A0 =A0 =A0* OMAP_PM_CONSTRAINT_THROUGHPUT. omap_pm_set_dev_constr=
aint
>> + =A0 =A0 =A0* should manage the constraints lists and call the appr=
opriate
>> + =A0 =A0 =A0* low level code that models the interconnect, computes=
 the required
>> + =A0 =A0 =A0* clock frequency, converts that to a VDD2 OPP ID and s=
ets the
>> + =A0 =A0 =A0* VDD2 OPP appropriately.
>> =A0 =A0 =A0 =A0*/
>> -
>> - =A0 =A0 return 0;
>> + =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_THROU=
GHPUT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 dev, dev, r);
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
>> - =A0 =A0 if (!req_dev || !dev || t < -1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter(s)=
", __func__);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 };
>> -
>> - =A0 =A0 if (t =3D=3D -1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max device laten=
cy constraint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(de=
v));
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max device latency =
constraint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld usec=
\n", dev_name(dev), t);
>> -
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* For current Linux, this needs to map the device to a
>> - =A0 =A0 =A0* powerdomain, then go through the list of current max =
lat
>> - =A0 =A0 =A0* constraints on that powerdomain and find the smallest=
=2E =A0If
>> - =A0 =A0 =A0* the latency constraint has changed, the code should
>> - =A0 =A0 =A0* recompute the state to enter for the next powerdomain
>> - =A0 =A0 =A0* state. =A0Conceivably, this code should also determin=
e
>> - =A0 =A0 =A0* whether to actually disable the device clocks or not,
>> - =A0 =A0 =A0* depending on how long it takes to re-enable the clock=
s.
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* TI CDP code can call constraint_set here.
>> - =A0 =A0 =A0*/
>> -
>> - =A0 =A0 return 0;
>> + =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_=
LAT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req_dev, dev, t);
>> =A0}
>>
>> -int omap_pm_set_max_sdma_lat(struct device *dev, long t)
>> +/*
>> + * omap_pm_set_max_mpu_wakeup_lat - set/release MPU wake-up latency
>> + * constraints
>> + *
>> + * Maps to omap_pm_set_dev_constraint with OMAP_PM_CONSTRAINT_WKUP_=
LAT
>> + * as constraint class and the MPU device as constraints target.
>> + */
>> +int omap_pm_set_max_mpu_wakeup_lat(struct device *req_dev, long t)
>> =A0{
>> - =A0 =A0 if (!dev || t < -1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter(s)=
", __func__);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> - =A0 =A0 };
>> -
>> - =A0 =A0 if (t =3D=3D -1)
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max DMA latency =
constraint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name(de=
v));
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max DMA latency con=
straint: "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld usec=
\n", dev_name(dev), t);
>> -
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* For current Linux PM QOS params, this code should sca=
n the
>> - =A0 =A0 =A0* list of maximum CPU and DMA latencies and select the
>> - =A0 =A0 =A0* smallest, then set cpu_dma_latency pm_qos_param
>> - =A0 =A0 =A0* accordingly.
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* For future Linux PM QOS params, with separate CPU and=
 DMA
>> - =A0 =A0 =A0* latency params, this code should just set the dma_lat=
ency param.
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* TI CDP code can call constraint_set here.
>> - =A0 =A0 =A0*/
>> + =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_=
LAT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req_dev, omap2_get_mpuss_device(),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 t);
>> +}
>>
>> - =A0 =A0 return 0;
>> +/*
>> + * omap_pm_set_max_sdma_lat - set/release SDMA start latency
>> + * constraints
>> + *
>> + * Currently maps to omap_pm_set_dev_constraint with OMAP_PM_CONSTR=
AINT_WKUP_LAT
>> + * as constraint class and the L3 device as constraints target.
>> + */
>> +int omap_pm_set_max_sdma_lat(struct device *req_dev, long t)
>> +{
>> + =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WKUP_=
LAT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req_dev, omap2_get_l3_device(),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 t);
>> =A0}
>>
>> =A0int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, l=
ong r)
>> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/=
omap-pm-noop.c
>> index b0471bb2..7868edc 100644
>> --- a/arch/arm/plat-omap/omap-pm-noop.c
>> +++ b/arch/arm/plat-omap/omap-pm-noop.c
>> @@ -61,7 +61,7 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device *=
dev, long t)
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsig=
ned long r)
>> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long =
r)
>> =A0{
>> =A0 =A0 =A0 if (!dev || (agent_id !=3D OCP_INITIATOR_AGENT &&
>> =A0 =A0 =A0 =A0 =A0 agent_id !=3D OCP_TARGET_AGENT)) {
>> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/o=
map_device.c
>> index 9bbda9a..b33b7fa 100644
>> --- a/arch/arm/plat-omap/omap_device.c
>> +++ b/arch/arm/plat-omap/omap_device.c
>> @@ -292,10 +292,189 @@ static void _add_optional_clock_clkdev(struct=
 omap_device *od,
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +/* plist that stores the devices wake-up latency constraints */
>> +static struct plist_head omap_device_wkup_lat_constraints_list;
>> +/* Spinlock that protects the constraints lists */
>> +static spinlock_t omap_device_constraints_lock;
>> +/* Mutex that protects the constraints lists ops */
>> +static struct mutex omap_device_constraints_mutex;
>> +
>> +/*
>> + * omap_device_store_constraint: add/update/remove a constraint fro=
m a plist
>> + *
>> + * @constraints_list: plist to use
>> + * @req_dev: constraint requester, used to track the requests
>> + * @target: target which the constraint applies to (e.g. power doma=
in ID or
>> + * =A0ptr for wake-up latency constraints)
>> + * @value: constraint value. The plist is sorted by the value. -1 r=
emove the
>> + * =A0constraint from the list
>> + *
>> + * Returns the strongest constraint value for the given target, 0 i=
n the
>> + * case there is no constraint on the given target or a negative va=
lue in
>> + * case of error.
>> + * The caller must check the validity of the parameters.
>> + */
>> +static long omap_device_store_constraint(struct plist_head *constra=
ints_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct device *req_dev, void *target,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0long value)
>> +{
>> + =A0 =A0 struct omap_device_constraints_entry *user;
>> + =A0 =A0 int found =3D 0, ret =3D 0;
>> +
>> + =A0 =A0 mutex_lock(&omap_device_constraints_mutex);
>> +
>> + =A0 =A0 /* Check if the constraint requester is already in the lis=
t */
>> + =A0 =A0 plist_for_each_entry(user, constraints_list, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (user->req_dev =3D=3D req_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (value >=3D 0) {
>
> This should really be split into two functions, _add_constraint() and
> _remove_constraint(). =A0You may wish to review Documentation/CodingS=
tyle
> Chapter 6.
Cf. the remark above about it.
Yes the 80-characters rule is a real PITA. I am not using my
monochrome (amber) monitor anymore those days ;p

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Add new entry to the list or update exi=
sting request */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (found &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->constraint_value =3D=3D valu=
e &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->target =3D=3D target) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ok;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (!found) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D kzalloc(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(str=
uct omap_device_constraints_entry),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s=
: FATAL ERROR: kzalloc failed\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0__func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -E=
NOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_=
error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->req_dev =3D req_dev;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, con=
straints_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_node_init(&user->node, value);
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_add(&user->node, constraints_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 user->node.prio =3D user->constraint_value=
 =3D value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 user->target =3D target;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Remove the constraint from the list */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!found) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: no prio=
r constraint to release\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_error;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, constraints_list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(user);
>> + =A0 =A0 }
>> +
>> +exit_ok:
>> + =A0 =A0 /* Find the strongest constraint for the given target */
>> + =A0 =A0 ret =3D 0;
>> + =A0 =A0 plist_for_each_entry(user, constraints_list, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (user->target =3D=3D target) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D user->constraint_v=
alue;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> +exit_error:
>> + =A0 =A0 mutex_unlock(&omap_device_constraints_mutex);
>> +
>> + =A0 =A0 return ret;
>> +}
>>
>> =A0/* Public functions for use by core code */
>>
>> =A0/**
>> + * omap_device_set_max_dev_wakeup_lat - set/release a device constr=
aint
>> + * @class: constraint class
>> + * @dev: device to apply the constraint to. Must have an associated=
 omap_device
>> + * @req_dev: constraint requester, used for tracking the constraint=
s
>> + *
>> + * Using the primary hwmod, set/release a device constraint for the=
 dev
>> + * device, requested by the req_dev device. Depending of the constr=
aint class
>> + * this code calls the appropriate low level code, e.g. power domai=
n for
>> + * the wake-up latency constraints.
>> + *
>> + * If any hwmods exist for the omap_device assoiated with @dev and =
@req_dev,
>> + * set/release the constraint for the corresponding hwmods, otherwi=
se return
>> + * -EINVAL.
>> + */
>> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class cl=
ass,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *req_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0str=
uct device *dev, long t)
>
> The name of this function doesn't match what's in the kerneldoc comme=
nt.
OK will update.

>
>> +{
>> + =A0 =A0 struct omap_device *od;
>> + =A0 =A0 struct omap_hwmod *oh;
>> + =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 struct powerdomain *pwrdm =3D NULL;
>> + =A0 =A0 u32 ret =3D -EINVAL;
>> +
>> + =A0 =A0 /* Look for the platform device for dev */
>> + =A0 =A0 pdev =3D to_platform_device(dev);
>> +
>> + =A0 =A0 /* Try to catch non platform devices. */
>> + =A0 =A0 if (pdev->name =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: platform device for dev=
ice %s not valid\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Find the associated omap_device for dev */
>> + =A0 =A0 od =3D _find_by_pdev(pdev);
>> + =A0 =A0 if (!(od->hwmods_cnt)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No hwmod for device %s\=
n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>
> Please also pr_err() and bail out if there is more than one hwmod in =
the
> omap_device.
Ok. IIUC nothing should be done in case of more than one hwmod per od?
Is that a realistic situation?

>
>> +
>> + =A0 =A0 /* Find the associated omap_hwmod for dev */
>> + =A0 =A0 oh =3D od->hwmods[0];
>> +
>> + =A0 =A0 switch (class) {
>> + =A0 =A0 case OMAP_PM_CONSTRAINT_WKUP_LAT:
>
> Please create two different functions,
> omap_device_set_max_dev_wakeup_lat() and
> omap_device_set_min_bus_tput(). =A0Documentation/CodingStyle chapter =
6.
It has been agreed (in weekly calls) to have two functions at the OMAP
PM level but only one function with a class parameter at the
omap_device level. This allows easier maintenance and clean-up later.
Kevin, is that corrcet?

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Find the pwrdm associated to dev */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pwrdm =3D omap_device_get_pwrdm(od);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pwrdm) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No pwrd=
m for device %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, d=
ev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* Store the constraint in the appropria=
te list and find the
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* strongest constraint for the given pw=
rdm
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_store_constraint(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &omap_device_wkup_lat_constraints_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 req_dev, (void *) pwrdm, t);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Apply the constraint to the correspondi=
ng pwrdm */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hwmod_update_=
power_state(oh, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error storing =
the constraint for device "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s\n", __f=
unc__, dev_name(dev));
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case OMAP_PM_CONSTRAINT_THROUGHPUT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: Bus throughput const=
raint class \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0not implemented\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid constraint c=
lass %d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, class);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> =A0 * omap_device_get_context_loss_count - get lost context count
>> =A0 * @od: struct omap_device *
>> =A0 *
>> @@ -824,6 +1003,14 @@ struct device omap_device_parent =3D {
>>
>> =A0static int __init omap_device_init(void)
>> =A0{
>> + =A0 =A0 /* Initialize priority ordered list for wakeup latency con=
straint */
>> + =A0 =A0 spin_lock_init(&omap_device_constraints_lock);
>> + =A0 =A0 plist_head_init(&omap_device_wkup_lat_constraints_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_device_constraints_l=
ock);
>> +
>> + =A0 =A0 /* res_mutex protects res_list add and del ops */
>> + =A0 =A0 mutex_init(&omap_device_constraints_mutex);
>> +
>> =A0 =A0 =A0 return device_register(&omap_device_parent);
>> =A0}
>> =A0core_initcall(omap_device_init);
>> --
>> 1.7.2.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> - Paul
>

Thanks!
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
