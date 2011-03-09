From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/2] OMAP: PM: implement devices constraints APIs
Date: Wed, 9 Mar 2011 20:37:51 +0100
Message-ID: <AANLkTikQOfsteZUAzSWjO-BbAW=ZEX22mhRUFHBMeFTR@mail.gmail.com>
References: <1299250375-26134-1-git-send-email-j-pihet@ti.com>
	<1299698346-2768-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44586 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272Ab1CIThx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 14:37:53 -0500
Received: by qyg14 with SMTP id 14so787957qyg.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 11:37:52 -0800 (PST)
In-Reply-To: <1299698346-2768-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, paul@pwsan.com
Cc: Jean Pihet <j-pihet@ti.com>, Vibhore Vardhan <vvardhan@ti.com>

Hi,

This patch is sent as en early review request, the testing is still on-=
going.
I will post the updated series (with a new revision number) as soon as =
possible.

I have some inlined comments, questions and concerns about it.
Can you please check?

On Wed, Mar 9, 2011 at 8:19 PM, Jean Pihet <jean.pihet@newoldbits.com> =
wrote:
> Implement OMAP PM layer omap_pm_set_max_dev_wakeup_lat API by
> creating a unified API which calls omap_device_set_dev_constraint
> for all classes of constraints (devices wake-up latency, devices
> throughput...).
> The implementation of the constraints framework is at the omap_device
> level: management and storage of the constraints, dispatching of the
> constraints to the appropriate low level layers.
>
> NOTE: only works for devices which have been converted to use
> =A0 =A0 =A0omap_device/omap_hwmod.
>
> Longer term, we could possibly remove this API from the OMAP PM layer=
,
> and instead directly use the device level API.
>
> For the devices wake-up latency constraints, the power domains get
> the next power state programmed directly in the registers via
> pwrdm_wakeuplat_update_pwrst.
>
> Note about PM QOS: the MPU and CORE power domains get the next power
> state via cpuidle, which get the strongest wake-up latency constraint
> by querying PM QOS. The usage of PM QOS is temporary, until a generic
> solution is in place.
>
> Based on Vibhore's original patch, adapted to omap_device, omap_hwmod
> and PM QOS frameworks.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Vibhore Vardhan <vvardhan@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_hwmod.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =
29 ++++-
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 99=
 +++++++++++++
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 24=
 +++-
> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c =A0 | =A0 63 +++++++++
> =A0arch/arm/plat-omap/include/plat/omap-pm.h =A0 =A0 | =A0 =A06 +-
> =A0arch/arm/plat-omap/include/plat/omap_device.h | =A0 14 ++
> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h =A0| =A0 =A01 +
> =A0arch/arm/plat-omap/omap-pm-constraints.c =A0 =A0 =A0| =A0161 +++++=
+++++------------
> =A0arch/arm/plat-omap/omap-pm-noop.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
> =A0arch/arm/plat-omap/omap_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A01=
87 +++++++++++++++++++++++++
> =A010 files changed, 493 insertions(+), 93 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/o=
map_hwmod.c
> index cf8cc9b..8caf2c5 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -142,6 +142,7 @@
> =A0#include "powerdomain.h"
> =A0#include <plat/clock.h>
> =A0#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> =A0#include <plat/prcm.h>
>
> =A0#include "cm2xxx_3xxx.h"
> @@ -2277,11 +2278,37 @@ ohsps_unlock:
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +/*
> + * omap_hwmod_update_power_state - Update the power domain power sta=
te of
> + * @oh
> + *
> + * @oh: struct omap_hwmod* to which the requesting device belongs to=
=2E
> + * @min_latency: the allowed wake-up latency for the power domain of=
 @oh.
> + *
> + * Finds the power domain next power state that fulfills the constra=
int.
> + * Applies the constraint to the power domain by calling
> + * pwrdm_wakeuplat_update_pwrst.
> + *
> + * Returns 0 upon success.
> + */
> +int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_la=
tency)
> +{
> + =A0 =A0 =A0 struct powerdomain *pwrdm =3D omap_hwmod_get_pwrdm(oh);
> +
> + =A0 =A0 =A0 if (!PTR_ERR(pwrdm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("omap_hwmod: Error: could not fi=
nd parent "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "powerdomain for %s\n",=
 oh->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return pwrdm_wakeuplat_update_pwrst(pwrdm, min_latency)=
;
> +}
> +
> =A0/**
> =A0* omap_hwmod_get_context_loss_count - get lost context count
> =A0* @oh: struct omap_hwmod *
> =A0*
> - * Query the powerdomain of of @oh to get the context loss
> + * Query the powerdomain of @oh to get the context loss
> =A0* count for this device.
> =A0*
> =A0* Returns the context loss count of the powerdomain assocated with=
 @oh
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index eaed0df..496f245 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,6 +19,7 @@
> =A0#include <linux/list.h>
> =A0#include <linux/errno.h>
> =A0#include <linux/string.h>
> +
> =A0#include "cm2xxx_3xxx.h"
> =A0#include "prcm44xx.h"
> =A0#include "cm44xx.h"
> @@ -176,6 +177,104 @@ static int _pwrdm_post_transition_cb(struct pow=
erdomain *pwrdm, void *unused)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/*
> + * Test if the current powerdomain is MPU or CORE
> + *
> + * This function is only used by pwrdm_wakeuplat_update_pwrst
> + * which applies the MPU and CORE power domains constraints using PM=
 QOS.
> + *
> + * This will disappear when all power domains will be controlled dir=
ectly
> + * from the wake-up latency constraints framework
> + */
> +static inline int is_pwrdm_mpu_or_core(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 if ((strncmp(pwrdm->name, "mpu_pwrdm", 9) =3D=3D 0) ||
> + =A0 =A0 =A0 =A0 =A0 (strncmp(pwrdm->name, "core_pwrdm", 10) =3D=3D =
0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * pwrdm_wakeuplat_update_pwrst - Update power domain power state if=
 needed
> + * @pwrdm: struct powerdomain * to which requesting device belongs t=
o.
> + * @min_latency: the allowed wake-up latency for the given power dom=
ain.
> + *
> + * Finds the power domain next power state that fulfills the constra=
int.
> + * Programs a new target state if it is different from current power=
 state.
> + *
> + * Returns 0 upon success.
> + */
> +int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long min=
_latency)
> +{
> + =A0 =A0 =A0 int ret =3D 0, new_state =3D 0;
> +
> + =A0 =A0 =A0 if (!pwrdm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "powerdomain: %s: invalid param=
eter(s)", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Apply constraints to MPU and CORE via the PM QOS A=
PI.
> + =A0 =A0 =A0 =A0* Every power domain struct has a pm_qos_request_lis=
t field
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (is_pwrdm_mpu_or_core(pwrdm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pm_qos_request_active(&(pwrdm->pm_q=
os_request)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_remove_request(&=
(pwrdm->pm_qos_request));
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (min_latency >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_add_request(&(pw=
rdm->pm_qos_request),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0PM_QOS_CPU_DMA_LATENCY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0min_latency);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Apply constraints to pwrdm other than MPU and CORE=
 by programming
> + =A0 =A0 =A0 =A0* the pwrdm next power state.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 /* Find power state with wakeup latency < minimum const=
raint */
> + =A0 =A0 =A0 for (new_state =3D 0x0; new_state < PWRDM_MAX_PWRSTS; n=
ew_state++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (min_latency =3D=3D -1 ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm->wakeup_lat[new_state] <=3D=
 min_latency)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 switch (new_state) {
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_OFF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_OFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrdm, PWRDM_POWE=
R_OFF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrdm, PWRDM_POWE=
R_RET);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_ON:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("powerdomain: requested latency=
 constraint not "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "supported %s set to ON=
 state\n", pwrdm->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_state =3D PWRDM_POWER_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pwrdm_read_pwrst(pwrdm) !=3D new_state) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_set_pwrdm_state(pwrdm, new=
_state);

The function pwrdms_setup (called from omap3_pm_init for every pwrdm)
runs late in the boot process and so it overwrites the registers
values programmed by omap_set_pwrdm_state with the default values.
Could the default values get written earlier in the boot process (e.g.
at hwmod init) before the devices can put constraints on the power
domains?

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("powerdomain: %s pwrst: curr=3D%d, prev=3D%d n=
ext=3D%d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"min_latency=3D%ld, set_state=3D%d\n=
", pwrdm->name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_read_pwrst(pwrdm), pwrdm_read_=
prev_pwrst(pwrdm),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_read_next_pwrst(pwrdm), min_la=
tency, new_state);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/* Public functions */
>
> =A0/**
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index 0b7a357..c796469 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -19,7 +19,10 @@
>
> =A0#include <linux/types.h>
> =A0#include <linux/list.h>
> -
> +#include <linux/plist.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/pm_qos_params.h>
> =A0#include <linux/atomic.h>
>
> =A0#include <plat/cpu.h>
> @@ -46,6 +49,15 @@
>
> =A0#define PWRSTS_OFF_RET_ON =A0 =A0 =A0(PWRSTS_OFF_RET | (1 << PWRDM=
_POWER_ON))
>
> +/* Powerdomain functional power states */
> +#define PWRDM_FUNC_PWRST_OFF =A0 0x0
> +#define PWRDM_FUNC_PWRST_OSWR =A00x1
> +#define PWRDM_FUNC_PWRST_CSWR =A00x2
> +#define PWRDM_FUNC_PWRST_ON =A0 =A00x3
> +
> +#define PWRDM_MAX_FUNC_PWRSTS =A04
> +
> +#define UNSUP_STATE =A0 =A0 =A0 =A0 =A0 =A0-1
>
> =A0/* Powerdomain flags */
> =A0#define PWRDM_HAS_HDWR_SAR =A0 =A0 (1 << 0) /* hardware save-and-r=
estore support */
> @@ -96,7 +108,11 @@ struct powerdomain;
> =A0* @state_counter:
> =A0* @timer:
> =A0* @state_timer:
> - *
> + * @wakeup_lat: wakeup latencies for possible powerdomain power stat=
es
> + * Note about the wakeup latencies ordering: the values must be sort=
ed
> + * =A0in decremental order
> + * @pm_qos_request: PM QOS handle, only used to control the MPU and =
CORE power
> + * =A0domains states; to be removed when a generic solution is in pl=
ace.
> =A0* @prcm_partition possible values are defined in mach-omap2/prcm44=
xx.h.
> =A0*/
> =A0struct powerdomain {
> @@ -121,6 +137,8 @@ struct powerdomain {
> =A0 =A0 =A0 =A0s64 timer;
> =A0 =A0 =A0 =A0s64 state_timer[PWRDM_MAX_PWRSTS];
> =A0#endif
> + =A0 =A0 =A0 const u32 wakeup_lat[PWRDM_MAX_FUNC_PWRSTS];
> + =A0 =A0 =A0 struct pm_qos_request_list pm_qos_request;
> =A0};
>
> =A0/**
> @@ -210,6 +228,8 @@ int pwrdm_clkdm_state_switch(struct clockdomain *=
clkdm);
> =A0int pwrdm_pre_transition(void);
> =A0int pwrdm_post_transition(void);
> =A0int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
> +
> +int pwrdm_wakeuplat_update_pwrst(struct powerdomain *pwrdm, long min=
_latency);
> =A0u32 pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
>
> =A0extern void omap2xxx_powerdomains_init(void);
> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/m=
ach-omap2/powerdomains3xxx_data.c
> index e1bec56..64973d1 100644
> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
> @@ -31,6 +31,9 @@
>
> =A0/*
> =A0* Powerdomains
> + *
> + * The wakeup_lat values are derived from measurements on
> + * the actual target.
> =A0*/
>
> =A0static struct powerdomain iva2_pwrdm =3D {
> @@ -52,6 +55,12 @@ static struct powerdomain iva2_pwrdm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[2] =3D PWRSTS_OFF_ON,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[3] =3D PWRDM_POWER_ON,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 1100,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 350,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain mpu_3xxx_pwrdm =3D {
> @@ -68,6 +77,12 @@ static struct powerdomain mpu_3xxx_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_OFF_ON,
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 95,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 45,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0/*
> @@ -98,6 +113,12 @@ static struct powerdomain core_3xxx_pre_es3_1_pwr=
dm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONST=
ATE */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONST=
ATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 100,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 60,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain core_3xxx_es3_1_pwrdm =3D {
> @@ -121,6 +142,12 @@ static struct powerdomain core_3xxx_es3_1_pwrdm =
=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRSTS_OFF_RET_ON, /* MEM1ONST=
ATE */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[1] =3D PWRSTS_OFF_RET_ON, /* MEM2ONST=
ATE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 100,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 60,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain dss_pwrdm =3D {
> @@ -136,6 +163,12 @@ static struct powerdomain dss_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 70,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 20,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0/*
> @@ -157,6 +190,12 @@ static struct powerdomain sgx_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 1000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain cam_pwrdm =3D {
> @@ -172,6 +211,12 @@ static struct powerdomain cam_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 850,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 35,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain per_pwrdm =3D {
> @@ -187,6 +232,12 @@ static struct powerdomain per_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 200,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 110,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain emu_pwrdm =3D {
> @@ -201,6 +252,12 @@ static struct powerdomain neon_pwrdm =3D {
> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_O=
MAP3430),
> =A0 =A0 =A0 =A0.pwrsts =A0 =A0 =A0 =A0 =A0 =3D PWRSTS_OFF_RET_ON,
> =A0 =A0 =A0 =A0.pwrsts_logic_ret =3D PWRDM_POWER_RET,
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 200,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 35,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain usbhost_pwrdm =3D {
> @@ -223,6 +280,12 @@ static struct powerdomain usbhost_pwrdm =3D {
> =A0 =A0 =A0 =A0.pwrsts_mem_on =A0 =A0=3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[0] =3D PWRDM_POWER_ON, =A0/* MEMONSTA=
TE */
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .wakeup_lat =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STATE=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 150,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> =A0static struct powerdomain dpll1_pwrdm =3D {
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/pla=
t-omap/include/plat/omap-pm.h
> index c0a7520..16f9e84 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -70,6 +70,10 @@ void omap_pm_if_exit(void);
> =A0* Device-driver-originated constraints (via board-*.c files, platf=
orm_data)
> =A0*/
>
> +enum omap_pm_constraint_class {
> + =A0 =A0 =A0 OMAP_PM_CONSTRAINT_WKUP_LAT,
> + =A0 =A0 =A0 OMAP_PM_CONSTRAINT_THROUGHPUT
> +};
>
> =A0/**
> =A0* omap_pm_set_max_mpu_wakeup_lat - set the maximum MPU wakeup late=
ncy
> @@ -137,7 +141,7 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device =
*dev, long t);
> =A0* Returns -EINVAL for an invalid argument, -ERANGE if the constrai=
nt
> =A0* is not satisfiable, or 0 upon success.
> =A0*/
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsign=
ed long r);
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long r=
);
>
>
> =A0/**
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm=
/plat-omap/include/plat/omap_device.h
> index e4c349f..d4766c4 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -32,9 +32,11 @@
> =A0#define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_DEVICE_H
>
> =A0#include <linux/kernel.h>
> +#include <linux/plist.h>
> =A0#include <linux/platform_device.h>
>
> =A0#include <plat/omap_hwmod.h>
> +#include <plat/omap-pm.h>
>
> =A0extern struct device omap_device_parent;
>
> @@ -73,6 +75,15 @@ struct omap_device {
> =A0 =A0 =A0 =A0s8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0pm_lat_level;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0hwmods_cnt;
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0_state;
> +
> +};
> +
> +/* Linked list for the devices constraints entries */
> +struct omap_device_constraints_entry {
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *req_=
dev;
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0*target;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const=
raint_value;
> + =A0 =A0 =A0 struct plist_node =A0 =A0 =A0 =A0 =A0 =A0 =A0 node;
> =A0};
>
> =A0/* Device driver interface (call via platform_data fn ptrs) */
> @@ -107,6 +118,9 @@ void __iomem *omap_device_get_rt_va(struct omap_d=
evice *od);
> =A0int omap_device_align_pm_lat(struct platform_device *pdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 new_wakeu=
p_lat_limit);
> =A0struct powerdomain *omap_device_get_pwrdm(struct omap_device *od);
> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class cla=
ss,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device *req_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device *dev, long t);
> =A0u32 omap_device_get_context_loss_count(struct platform_device *pde=
v);
>
> =A0/* Other */
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-omap/include/plat/omap_hwmod.h
> index 65bcad4..f27110e 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -597,6 +597,7 @@ int omap_hwmod_for_each_by_class(const char *clas=
sname,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void =
*user);
>
> =A0int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state=
);
> +int omap_hwmod_update_power_state(struct omap_hwmod *oh, long min_la=
tency);
> =A0u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
>
> =A0/*
> diff --git a/arch/arm/plat-omap/omap-pm-constraints.c b/arch/arm/plat=
-omap/omap-pm-constraints.c
> index c8b4e4c..4709f83 100644
> --- a/arch/arm/plat-omap/omap-pm-constraints.c
> +++ b/arch/arm/plat-omap/omap-pm-constraints.c
> @@ -24,6 +24,7 @@
> =A0/* Interface documentation is in mach/omap-pm.h */
> =A0#include <plat/omap-pm.h>
> =A0#include <plat/omap_device.h>
> +#include <plat/common.h>
>
> =A0static bool off_mode_enabled;
> =A0static u32 dummy_context_loss_counter;
> @@ -32,35 +33,46 @@ static u32 dummy_context_loss_counter;
> =A0* Device-driver-originated constraints (via board-*.c files)
> =A0*/
>
> -int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> +/*
> + * Generic function to omap_device layer for the constraints API.
> + */
> +static int omap_pm_set_dev_constraint(enum omap_pm_constraint_class =
class,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct device *req_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct device *dev, long t)
> =A0{
> - =A0 =A0 =A0 if (!dev || t < -1) {
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!req_dev || !dev || t < -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN(1, "OMAP PM: %s: invalid paramete=
r(s)", __func__);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> - =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 if (t =3D=3D -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max MPU wakeu=
p latency constraint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name=
(dev));
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max MPU wakeup l=
atency constraint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld u=
sec\n", dev_name(dev), t);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* For current Linux, this needs to map the MPU to a
> - =A0 =A0 =A0 =A0* powerdomain, then go through the list of current m=
ax lat
> - =A0 =A0 =A0 =A0* constraints on the MPU and find the smallest. =A0I=
f
> - =A0 =A0 =A0 =A0* the latency constraint has changed, the code shoul=
d
> - =A0 =A0 =A0 =A0* recompute the state to enter for the next powerdom=
ain
> - =A0 =A0 =A0 =A0* state.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* TI CDP code can call constraint_set here.
> - =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 /* Try to catch non omap_device for dev */
> + =A0 =A0 =A0 if (dev->parent =3D=3D &omap_device_parent) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t =3D=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remo=
ve constraint of class %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"fro=
m req_dev %s on dev %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clas=
s, dev_name(req_dev), dev_name(dev));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add =
constraint of class %d "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"fro=
m req_dev %s on dev %s, t =3D %ld\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clas=
s, dev_name(req_dev), dev_name(dev), t);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Call the omap_device API */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_set_dev_constraint(=
class, req_dev, dev, t);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("OMAP-PM set_wakeup_lat: Error: =
platform device "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"not valid\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return ret;
> =A0}
>
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsign=
ed long r)
> +/*
> + * omap_pm_set_min_bus_tput - set/release bus throughput constraints
> + */
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long r=
)
> =A0{
> =A0 =A0 =A0 =A0if (!dev || (agent_id !=3D OCP_INITIATOR_AGENT &&
> =A0 =A0 =A0 =A0 =A0 =A0agent_id !=3D OCP_TARGET_AGENT)) {
> @@ -68,83 +80,56 @@ int omap_pm_set_min_bus_tput(struct device *dev, =
u8 agent_id, unsigned long r)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0};
>
> - =A0 =A0 =A0 if (r =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove min bus tput =
constraint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s for agent_id=
 %d\n", dev_name(dev), agent_id);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add min bus tput con=
straint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s for agent_id=
 %d: rate %ld KiB\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(dev), agent=
_id, r);
> -
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* This code should model the interconnect and comput=
e the
> - =A0 =A0 =A0 =A0* required clock frequency, convert that to a VDD2 O=
PP ID, then
> - =A0 =A0 =A0 =A0* set the VDD2 OPP appropriately.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* TI CDP code can call constraint_set here on the VD=
D2 OPP.
> + =A0 =A0 =A0 =A0* This code calls the generic omap_device API functi=
on
> + =A0 =A0 =A0 =A0* omap_pm_set_dev_constraint with the class
> + =A0 =A0 =A0 =A0* OMAP_PM_CONSTRAINT_THROUGHPUT. omap_pm_set_dev_con=
straint
> + =A0 =A0 =A0 =A0* should manage the constraints lists and call the a=
ppropriate
> + =A0 =A0 =A0 =A0* low level code that models the interconnect, compu=
tes the required
> + =A0 =A0 =A0 =A0* clock frequency, converts that to a VDD2 OPP ID an=
d sets the
> + =A0 =A0 =A0 =A0* VDD2 OPP appropriately.
> =A0 =A0 =A0 =A0 */
> -
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_TH=
ROUGHPUT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 dev, dev, r);

The tput constraint API is not clear to me. What is the agent_id field
for? Can this be replaced by a requester device ptr?

> =A0}
>
> +/*
> + * omap_pm_set_max_dev_wakeup_lat - set/release devices wake-up late=
ncy
> + * constraints
> + */
> =A0int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct =
device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 l=
ong t)
> =A0{
> - =A0 =A0 =A0 if (!req_dev || !dev || t < -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter=
(s)", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 if (t =3D=3D -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max device la=
tency constraint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name=
(dev));
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max device laten=
cy constraint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld u=
sec\n", dev_name(dev), t);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* For current Linux, this needs to map the device to=
 a
> - =A0 =A0 =A0 =A0* powerdomain, then go through the list of current m=
ax lat
> - =A0 =A0 =A0 =A0* constraints on that powerdomain and find the small=
est. =A0If
> - =A0 =A0 =A0 =A0* the latency constraint has changed, the code shoul=
d
> - =A0 =A0 =A0 =A0* recompute the state to enter for the next powerdom=
ain
> - =A0 =A0 =A0 =A0* state. =A0Conceivably, this code should also deter=
mine
> - =A0 =A0 =A0 =A0* whether to actually disable the device clocks or n=
ot,
> - =A0 =A0 =A0 =A0* depending on how long it takes to re-enable the cl=
ocks.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* TI CDP code can call constraint_set here.
> - =A0 =A0 =A0 =A0*/
> -
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WK=
UP_LAT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 req_dev, dev, t);
> =A0}
>
> -int omap_pm_set_max_sdma_lat(struct device *dev, long t)
> +/*
> + * omap_pm_set_max_mpu_wakeup_lat - set/release MPU wake-up latency
> + * constraints
> + *
> + * Maps to omap_pm_set_dev_constraint with OMAP_PM_CONSTRAINT_WKUP_L=
AT
> + * as constraint class and the MPU device as constraints target.
> + */
> +int omap_pm_set_max_mpu_wakeup_lat(struct device *req_dev, long t)
> =A0{
> - =A0 =A0 =A0 if (!dev || t < -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid parameter=
(s)", __func__);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 };
> -
> - =A0 =A0 =A0 if (t =3D=3D -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: remove max DMA laten=
cy constraint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s\n", dev_name=
(dev));
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("OMAP PM: add max DMA latency =
constraint: "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"dev %s, t =3D %ld u=
sec\n", dev_name(dev), t);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* For current Linux PM QOS params, this code should =
scan the
> - =A0 =A0 =A0 =A0* list of maximum CPU and DMA latencies and select t=
he
> - =A0 =A0 =A0 =A0* smallest, then set cpu_dma_latency pm_qos_param
> - =A0 =A0 =A0 =A0* accordingly.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* For future Linux PM QOS params, with separate CPU =
and DMA
> - =A0 =A0 =A0 =A0* latency params, this code should just set the dma_=
latency param.
> - =A0 =A0 =A0 =A0*
> - =A0 =A0 =A0 =A0* TI CDP code can call constraint_set here.
> - =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WK=
UP_LAT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 req_dev, omap2_get_mpuss_device(),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 t);
> +}
>
> - =A0 =A0 =A0 return 0;
> +/*
> + * omap_pm_set_max_sdma_lat - set/release SDMA start latency
> + * constraints
> + *
> + * Currently maps to omap_pm_set_dev_constraint with OMAP_PM_CONSTRA=
INT_WKUP_LAT
> + * as constraint class and the L3 device as constraints target.
> + */
> +int omap_pm_set_max_sdma_lat(struct device *req_dev, long t)
> +{
> + =A0 =A0 =A0 return omap_pm_set_dev_constraint(OMAP_PM_CONSTRAINT_WK=
UP_LAT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 req_dev, omap2_get_l3_device(),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 t);
> =A0}
>
> =A0int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, lo=
ng r)
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/o=
map-pm-noop.c
> index b0471bb2..7868edc 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -61,7 +61,7 @@ int omap_pm_set_max_mpu_wakeup_lat(struct device *d=
ev, long t)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, unsign=
ed long r)
> +int omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, long r=
)
> =A0{
> =A0 =A0 =A0 =A0if (!dev || (agent_id !=3D OCP_INITIATOR_AGENT &&
> =A0 =A0 =A0 =A0 =A0 =A0agent_id !=3D OCP_TARGET_AGENT)) {
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/om=
ap_device.c
> index 9bbda9a..b33b7fa 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -292,10 +292,189 @@ static void _add_optional_clock_clkdev(struct =
omap_device *od,
> =A0 =A0 =A0 =A0}
> =A0}
>
> +/* plist that stores the devices wake-up latency constraints */
> +static struct plist_head omap_device_wkup_lat_constraints_list;
> +/* Spinlock that protects the constraints lists */
> +static spinlock_t omap_device_constraints_lock;
> +/* Mutex that protects the constraints lists ops */
> +static struct mutex omap_device_constraints_mutex;

Is that OK to do so to define the internal variables?

> +
> +/*
> + * omap_device_store_constraint: add/update/remove a constraint from=
 a plist
> + *
> + * @constraints_list: plist to use
> + * @req_dev: constraint requester, used to track the requests
> + * @target: target which the constraint applies to (e.g. power domai=
n ID or
> + * =A0ptr for wake-up latency constraints)
> + * @value: constraint value. The plist is sorted by the value. -1 re=
move the
> + * =A0constraint from the list
> + *
> + * Returns the strongest constraint value for the given target, 0 in=
 the
> + * case there is no constraint on the given target or a negative val=
ue in
> + * case of error.
> + * The caller must check the validity of the parameters.
> + */
> +static long omap_device_store_constraint(struct plist_head *constrai=
nts_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0struct device *req_dev, void *target,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0long value)
> +{
> + =A0 =A0 =A0 struct omap_device_constraints_entry *user;
> + =A0 =A0 =A0 int found =3D 0, ret =3D 0;
> +
> + =A0 =A0 =A0 mutex_lock(&omap_device_constraints_mutex);
> +
> + =A0 =A0 =A0 /* Check if the constraint requester is already in the =
list */
> + =A0 =A0 =A0 plist_for_each_entry(user, constraints_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (user->req_dev =3D=3D req_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (value >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Add new entry to the list or update =
existing request */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (found &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->constraint_value =3D=3D v=
alue &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->target =3D=3D target) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_ok;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (!found) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user =3D kzalloc(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
struct omap_device_constraints_entry),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KER=
NEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"%s: FATAL ERROR: kzalloc failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0__func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D=
 -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ex=
it_error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->req_dev =3D req_d=
ev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, =
constraints_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_node_init(&user->node, value);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_add(&user->node, constraints_list=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->node.prio =3D user->constraint_va=
lue =3D value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 user->target =3D target;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Remove the constraint from the list =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!found) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: no p=
rior constraint to release\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit_error;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&user->node, constraints_list=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(user);
> + =A0 =A0 =A0 }
> +
> +exit_ok:
> + =A0 =A0 =A0 /* Find the strongest constraint for the given target *=
/
> + =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 plist_for_each_entry(user, constraints_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (user->target =3D=3D target) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D user->constrain=
t_value;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
This is supposed to return the higher priority from the plist, and so
the lowest constraint_value.
Although it is OK for wake-up latency it could not fit all constraints
type (e.g. throughput requires the highest value).
I will correct this.

> +
> +exit_error:
> + =A0 =A0 =A0 mutex_unlock(&omap_device_constraints_mutex);
> +
> + =A0 =A0 =A0 return ret;
> +}
>
> =A0/* Public functions for use by core code */
>
> =A0/**
> + * omap_device_set_max_dev_wakeup_lat - set/release a device constra=
int
> + * @class: constraint class
> + * @dev: device to apply the constraint to. Must have an associated =
omap_device
> + * @req_dev: constraint requester, used for tracking the constraints
> + *
> + * Using the primary hwmod, set/release a device constraint for the =
dev
> + * device, requested by the req_dev device. Depending of the constra=
int class
> + * this code calls the appropriate low level code, e.g. power domain=
 for
> + * the wake-up latency constraints.
> + *
> + * If any hwmods exist for the omap_device assoiated with @dev and @=
req_dev,
> + * set/release the constraint for the corresponding hwmods, otherwis=
e return
> + * -EINVAL.
> + */
> +int omap_device_set_dev_constraint(enum omap_pm_constraint_class cla=
ss,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device *req_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device *dev, long t)
> +{
> + =A0 =A0 =A0 struct omap_device *od;
> + =A0 =A0 =A0 struct omap_hwmod *oh;
> + =A0 =A0 =A0 struct platform_device *pdev;
> + =A0 =A0 =A0 struct powerdomain *pwrdm =3D NULL;
> + =A0 =A0 =A0 u32 ret =3D -EINVAL;
> +
> + =A0 =A0 =A0 /* Look for the platform device for dev */
> + =A0 =A0 =A0 pdev =3D to_platform_device(dev);
> +
> + =A0 =A0 =A0 /* Try to catch non platform devices. */
> + =A0 =A0 =A0 if (pdev->name =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: platform device for =
device %s not valid\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev))=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Find the associated omap_device for dev */
> + =A0 =A0 =A0 od =3D _find_by_pdev(pdev);
> + =A0 =A0 =A0 if (!(od->hwmods_cnt)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No hwmod for device =
%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, dev_name(dev))=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Find the associated omap_hwmod for dev */
> + =A0 =A0 =A0 oh =3D od->hwmods[0];
> +
> + =A0 =A0 =A0 switch (class) {
> + =A0 =A0 =A0 case OMAP_PM_CONSTRAINT_WKUP_LAT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Find the pwrdm associated to dev */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm =3D omap_device_get_pwrdm(od);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pwrdm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error: No p=
wrdm for device %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__=
, dev_name(dev));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Store the constraint in the approp=
riate list and find the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* strongest constraint for the given=
 pwrdm
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_device_store_constraint(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &omap_device_wkup_lat_constraints_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 req_dev, (void *) pwrdm, t);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Apply the constraint to the correspo=
nding pwrdm */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hwmod_upda=
te_power_state(oh, ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Error stori=
ng the constraint for device "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s\n", =
__func__, dev_name(dev));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case OMAP_PM_CONSTRAINT_THROUGHPUT:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: Bus throughput co=
nstraint class \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0not implemented\n", __func__=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, "OMAP PM: %s: invalid constrain=
t class %d",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, class);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> =A0* omap_device_get_context_loss_count - get lost context count
> =A0* @od: struct omap_device *
> =A0*
> @@ -824,6 +1003,14 @@ struct device omap_device_parent =3D {
>
> =A0static int __init omap_device_init(void)
> =A0{
> + =A0 =A0 =A0 /* Initialize priority ordered list for wakeup latency =
constraint */
> + =A0 =A0 =A0 spin_lock_init(&omap_device_constraints_lock);
> + =A0 =A0 =A0 plist_head_init(&omap_device_wkup_lat_constraints_list,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_device_constraint=
s_lock);
> +
> + =A0 =A0 =A0 /* res_mutex protects res_list add and del ops */
> + =A0 =A0 =A0 mutex_init(&omap_device_constraints_mutex);
> +
> =A0 =A0 =A0 =A0return device_register(&omap_device_parent);
> =A0}
> =A0core_initcall(omap_device_init);

Is it OK to initialize the list, lock and mutex here? This code runs
very early in the boot sequence (right after hwmod init).
Same remark about pwrdms_setup that overwrites the registers values.

> --
> 1.7.2.3
>
>

Thanks for looking,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
