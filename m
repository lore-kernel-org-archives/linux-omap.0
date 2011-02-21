From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
Date: Mon, 21 Feb 2011 11:19:14 +0100
Message-ID: <AANLkTik-hj+-ZPnfVKLCH0h-QeyziH4H-j6EE+_QHHCU@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
	<1298112158-28469-15-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:34331 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1BUKTQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 05:19:16 -0500
Received: by qyg14 with SMTP id 14so822962qyg.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 02:19:16 -0800 (PST)
In-Reply-To: <1298112158-28469-15-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi Santosh,

I have a few comments and questions inlined.

On Sat, Feb 19, 2011 at 11:42 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> This patch adds MPUSS low power states in cpuidle.
>
> =A0 =A0 =A0 =A0C1 - CPU0 ON + CPU1 ON/OFF + MPU ON + CORE ON
> =A0 =A0 =A0 =A0C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON
> =A0 =A0 =A0 =A0C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON
> =A0 =A0 =A0 =A0C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON
>
> MPU OSWR isn't supported yet. To support OSWR, power domain context
> registers needs to be managed which are not supported yet. A patch
> to address this was submitted but it's not ready for merge yet becaus=
e
> it was not addressing all OMAP4 power domain context registers.
> More info on this issue:
> =A0 =A0 =A0 =A0http://www.mail-archive.com/linux-omap@vger.kernel.org=
/msg38667.html
>
> OMAP4 powerdomain INACTIVE support is also dropped because of inconsi=
stency
> of it with OMAP3. More information =A0on this thread.
> =A0 =A0 =A0 =A0http://www.spinics.net/lists/linux-omap/msg45370.html
>
> CORE low power states and associated latencies will be updated as par=
t
> along with chip retention support.
>
> On OMAP4 because of hardware constraints, no low power states are
> targeted when both CPUs are online and in SMP mode. The low power
> states are attempted only when secondary CPU gets offline to OFF
> through hotplug infrastructure.
>
> Thanks to Nicole Chalhoub <n-chalhoub@ti.com> for doing exhaustive
> C-state latency profiling.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> ---
> =A0arch/arm/mach-omap2/cpuidle44xx.c | =A0190 +++++++++++++++++++++++=
+++++++++++---
> =A01 files changed, 176 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/=
cpuidle44xx.c
> index 6c3c69d..aa1584e 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -3,6 +3,7 @@
> =A0*
> =A0* Copyright (C) 2011 Texas Instruments, Inc.
> =A0* Rajendra Nayak <rnayak@ti.com>
> + * Santosh Shilimkar <santosh.shilimkar@ti.com>
> =A0*
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> =A0* it under the terms of the GNU General Public License version 2 a=
s
> @@ -17,12 +18,21 @@
> =A0#include <mach/omap4-common.h>
>
> =A0#include "pm.h"
> +#include "prm.h"
>
> =A0#ifdef CONFIG_CPU_IDLE
>
> -#define OMAP4_MAX_STATES =A0 =A0 =A0 1
> -/* C1 - CPUx wfi + MPU inactive + CORE inactive */
> +#define CPUIDLE_FLAG_CHECK_BM =A00x10000 /* use omap4_enter_idle_bm(=
) */
> +#define OMAP4_MAX_STATES =A0 =A0 =A0 4
> +
> +/* C1 - CPU0 ON + CPU1 ON/OFF + MPU ON + CORE ON */
> =A0#define OMAP4_STATE_C1 =A0 =A0 =A0 =A0 0
> +/* C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON */
> +#define OMAP4_STATE_C2 =A0 =A0 =A0 =A0 1
> +/* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
> +#define OMAP4_STATE_C3 =A0 =A0 =A0 =A0 2
> +/* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
> +#define OMAP4_STATE_C4 =A0 =A0 =A0 =A0 3
>
> =A0struct omap4_processor_cx {
> =A0 =A0 =A0 =A0u8 valid;
> @@ -32,19 +42,44 @@ struct omap4_processor_cx {
> =A0 =A0 =A0 =A0u32 cpu0_state;
> =A0 =A0 =A0 =A0u32 cpu1_state;
> =A0 =A0 =A0 =A0u32 mpu_state;
> + =A0 =A0 =A0 u32 mpu_logic_state;
> =A0 =A0 =A0 =A0u32 core_state;
> + =A0 =A0 =A0 u32 core_logic_state;
> =A0 =A0 =A0 =A0u32 threshold;
> =A0 =A0 =A0 =A0u32 flags;
> + =A0 =A0 =A0 const char *desc;
> =A0};
>
> -struct omap4_processor_cx omap4_power_states[OMAP4_MAX_STATES];
> -struct omap4_processor_cx current_cx_state;
> +static struct omap4_processor_cx omap4_power_states[OMAP4_MAX_STATES=
];
> +static struct powerdomain *mpu_pd, *cpu1_pd, *core_pd;
>
> +/*
> + * FIXME: Full latenecy numbers needs to be updated as part of
Typo: 'latency'

> + * cpuidle CORE retention support.
> + * Currently only MPUSS latency numbers are added based on
> + * measurements done internally. The numbers for MPUSS are
> + * not board dependent and hence set directly here instead of
> + * passing it from board files.
> + */
> =A0static struct cpuidle_params cpuidle_params_table[] =3D {
> - =A0 =A0 =A0 /* C1 */
> - =A0 =A0 =A0 {1, 2, 2, 5},
> + =A0 =A0 =A0 /* C1 - CPU0 WFI + CPU1 ON/OFF + MPU ON =A0 + CORE ON *=
/
> + =A0 =A0 =A0 {1, =A0 =A0 2, =A0 =A0 =A02, =A0 =A0 =A05},
> + =A0 =A0 =A0 /* C2 - CPU0 ON + CPU1 OFF + MPU ON =A0+ CORE ON */
> + =A0 =A0 =A0 {1, =A0 =A0 140, =A0 =A0160, =A0 =A0300},
> + =A0 =A0 =A0 /* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
> + =A0 =A0 =A0 {1, =A0 =A0 200, =A0 =A0300, =A0 =A0700},
> + =A0 =A0 =A0 /* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
> + =A0 =A0 =A0 {1, =A0 =A0 1400, =A0 600, =A0 =A05000},
> =A0};
>
> +DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> +
> +static int omap4_idle_bm_check(void)
> +{
> + =A0 =A0 =A0 /* FIXME: Populate this with CORE retention support */
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0/**
> =A0* omap4_enter_idle - Programs OMAP4 to enter the specified state
> =A0* @dev: cpuidle device
> @@ -57,7 +92,9 @@ static struct cpuidle_params cpuidle_params_table[]=
 =3D {
> =A0static int omap4_enter_idle(struct cpuidle_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpuidle_state *=
state)
> =A0{
> + =A0 =A0 =A0 struct omap4_processor_cx *cx =3D cpuidle_get_statedata=
(state);
> =A0 =A0 =A0 =A0struct timespec ts_preidle, ts_postidle, ts_idle;
> + =A0 =A0 =A0 u32 cpu1_state;
>
> =A0 =A0 =A0 =A0/* Used to keep track of the total time in idle */
> =A0 =A0 =A0 =A0getnstimeofday(&ts_preidle);
> @@ -65,28 +102,74 @@ static int omap4_enter_idle(struct cpuidle_devic=
e *dev,
> =A0 =A0 =A0 =A0local_irq_disable();
> =A0 =A0 =A0 =A0local_fiq_disable();
>
> - =A0 =A0 =A0 cpu_do_idle();

I think the piece of code below is rather difficult to read and
understand. Based on the patch description and the comment here below
I do not see the relation with the code.

" On OMAP4 because of hardware constraints, no low power states are
 targeted when both CPUs are online and in SMP mode. The low power
 states are attempted only when secondary CPU gets offline to OFF
 through hotplug infrastructure. "
The test below does not seem to match this comment.

> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Special hardware/software considerations:
> + =A0 =A0 =A0 =A0* 1. Do only WFI for secondary CPU(non-boot - CPU1).
> + =A0 =A0 =A0 =A0* =A0 =A0Secondary cores are taken down only via hot=
plug path.
The comment looks contradictory. Which one is taken OFF using this
code, which one from hotplug?
Does this correspond to the condition '(dev->cpu)' in the test below?

> + =A0 =A0 =A0 =A0* 2. Do only a WFI as long as in SMP mode.
Does this correspond to the condition '(num_online_cpus() > 1)' in the
test below? If so it this one triggering the low power mode for cpu0?

> + =A0 =A0 =A0 =A0* 3. Continue to do only WFI till CPU1 hits OFF stat=
e.
> + =A0 =A0 =A0 =A0* =A0 =A0This is necessary to honour hardware recomm=
ondation
> + =A0 =A0 =A0 =A0* =A0 =A0of triggeing all the possible low power mod=
es once CPU1 is
> + =A0 =A0 =A0 =A0* =A0 =A0out of coherency and in OFF mode.
Does this correspond to the condition '(cpu1_state !=3D
PWRDM_POWER_OFF)' in the test below?

> + =A0 =A0 =A0 =A0* Update dev->last_state so that governor stats refl=
ects right
> + =A0 =A0 =A0 =A0* data.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 cpu1_state =3D pwrdm_read_pwrst(cpu1_pd);
> + =A0 =A0 =A0 if ((dev->cpu) || (num_online_cpus() > 1) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cpu1_state !=3D PWRDM_=
POWER_OFF)) {
Are '||' correct here?
Sorry if the code behaves correctly, the remarks are about readability
especially in the comments.

Regards,
Jean

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->last_state =3D dev->safe_state;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_do_idle();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto return_sleep_time;
> + =A0 =A0 =A0 }
>
> + =A0 =A0 =A0 pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> + =A0 =A0 =A0 omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> + =A0 =A0 =A0 pwrdm_set_logic_retst(core_pd, cx->core_logic_state);
> + =A0 =A0 =A0 omap_set_pwrdm_state(core_pd, cx->core_state);
> +
> + =A0 =A0 =A0 omap4_enter_lowpower(dev->cpu, cx->cpu0_state);
> +
> +return_sleep_time:
> =A0 =A0 =A0 =A0getnstimeofday(&ts_postidle);
> =A0 =A0 =A0 =A0ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
>
> =A0 =A0 =A0 =A0local_irq_enable();
> =A0 =A0 =A0 =A0local_fiq_enable();
>
> +
> =A0 =A0 =A0 =A0return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_se=
c * USEC_PER_SEC;
> =A0}
>
> -DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> +/**
> + * omap4_enter_idle_bm - Checks for any bus activity
> + * @dev: cpuidle device
> + * @state: The target state to be programmed
> + *
> + * Used for C states with CPUIDLE_FLAG_CHECK_BM flag set. This
> + * function checks for any pending activity and then programs the
> + * device to the specified or a safer state.
> + */
> +static int omap4_enter_idle_bm(struct cpuidle_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct c=
puidle_state *state)
> +{
> + =A0 =A0 =A0 if ((state->flags & CPUIDLE_FLAG_CHECK_BM) && omap4_idl=
e_bm_check()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG_ON(!dev->safe_state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D dev->safe_state;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev->last_state =3D state;
> + =A0 =A0 =A0 return omap4_enter_idle(dev, state);
> +}
>
> =A0/**
> =A0* omap4_init_power_states - Initialises the OMAP4 specific C state=
s.
> =A0*
> - * Below is the desciption of each C state.
> - * C1 : CPUx wfi + MPU inative + Core inactive
> =A0*/
> -void omap_init_power_states(void)
> +void omap4_init_power_states(void)
> =A0{
> - =A0 =A0 =A0 /* C1 . CPUx wfi + MPU inactive + Core inactive */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* C1 - CPU0 WFI + CPU1 OFF + MPU ON + CORE ON
> + =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0omap4_power_states[OMAP4_STATE_C1].valid =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpuidle_params_table[O=
MAP4_STATE_C1].valid;
> =A0 =A0 =A0 =A0omap4_power_states[OMAP4_STATE_C1].type =3D OMAP4_STAT=
E_C1;
> @@ -96,9 +179,80 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpuidle_params_table[O=
MAP4_STATE_C1].wake_latency;
> =A0 =A0 =A0 =A0omap4_power_states[OMAP4_STATE_C1].threshold =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpuidle_params_table[O=
MAP4_STATE_C1].threshold;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C1].cpu0_state =3D PWRDM=
_POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C1].cpu1_state =3D PWRDM=
_POWER_OFF;
> =A0 =A0 =A0 =A0omap4_power_states[OMAP4_STATE_C1].mpu_state =3D PWRDM=
_POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C1].mpu_logic_state =3D =
PWRDM_POWER_RET;
> =A0 =A0 =A0 =A0omap4_power_states[OMAP4_STATE_C1].core_state =3D PWRD=
M_POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C1].core_logic_state =3D=
 PWRDM_POWER_RET;
> =A0 =A0 =A0 =A0omap4_power_states[OMAP4_STATE_C1].flags =3D CPUIDLE_F=
LAG_TIME_VALID;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C1].desc =3D "MPU ON + C=
ORE ON";
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].valid =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C2].valid;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].type =3D OMAP4_STATE=
_C2;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C2].sleep_latency;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C2].wake_latency;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C2].threshold;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].cpu0_state =3D PWRDM=
_POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].cpu1_state =3D PWRDM=
_POWER_OFF;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].mpu_state =3D PWRDM_=
POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].mpu_logic_state =3D =
PWRDM_POWER_RET;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].core_state =3D PWRDM=
_POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].core_logic_state =3D=
 PWRDM_POWER_RET;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].flags =3D CPUIDLE_FL=
AG_TIME_VALID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPUIDLE_FLAG_CHECK_BM;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C2].desc =3D "MPU ON + C=
ORE ON";
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].valid =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C3].valid;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].type =3D OMAP4_STATE=
_C3;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C3].sleep_latency;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C3].wake_latency;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C3].threshold;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].cpu0_state =3D PWRDM=
_POWER_OFF;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].cpu1_state =3D PWRDM=
_POWER_OFF;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].mpu_state =3D PWRDM_=
POWER_RET;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].mpu_logic_state =3D =
PWRDM_POWER_RET;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].core_state =3D PWRDM=
_POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].core_logic_state =3D=
 PWRDM_POWER_RET;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].flags =3D CPUIDLE_FL=
AG_TIME_VALID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPUIDLE_FLAG_CHECK_BM;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C3].desc =3D "MPU CSWR +=
 CORE ON";
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].valid =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C4].valid;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].type =3D OMAP4_STATE=
_C4;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C4].sleep_latency;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C4].wake_latency;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP4_STATE_C4].threshold;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].cpu0_state =3D PWRDM=
_POWER_OFF;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].cpu1_state =3D PWRDM=
_POWER_OFF;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].mpu_state =3D PWRDM_=
POWER_OFF;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].mpu_logic_state =3D =
PWRDM_POWER_OFF;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].core_state =3D PWRDM=
_POWER_ON;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].core_logic_state =3D=
 PWRDM_POWER_RET;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].flags =3D CPUIDLE_FL=
AG_TIME_VALID |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPUIDLE_FLAG_CHECK_BM;
> + =A0 =A0 =A0 omap4_power_states[OMAP4_STATE_C4].desc =3D "MPU OFF + =
CORE ON";
>
> =A0}
>
> @@ -120,7 +274,11 @@ int __init omap4_idle_init(void)
> =A0 =A0 =A0 =A0struct cpuidle_state *state;
> =A0 =A0 =A0 =A0struct cpuidle_device *dev;
>
> - =A0 =A0 =A0 omap_init_power_states();
> + =A0 =A0 =A0 mpu_pd =3D pwrdm_lookup("mpu_pwrdm");
> + =A0 =A0 =A0 cpu1_pd =3D pwrdm_lookup("cpu1_pwrdm");
> + =A0 =A0 =A0 core_pd =3D pwrdm_lookup("core_pwrdm");
> +
> + =A0 =A0 =A0 omap4_init_power_states();
> =A0 =A0 =A0 =A0cpuidle_register_driver(&omap4_idle_driver);
>
> =A0 =A0 =A0 =A0for_each_cpu(cpu_id, cpu_online_mask) {
> @@ -139,8 +297,12 @@ int __init omap4_idle_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cx->wakeup_latency;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state->target_residenc=
y =3D cx->threshold;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state->flags =3D cx->f=
lags;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->enter =3D omap4_=
enter_idle;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cx->type =3D=3D OMA=
P4_STATE_C1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->sa=
fe_state =3D state;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state->enter =3D (state=
->flags & CPUIDLE_FLAG_CHECK_BM) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 omap4_enter_idle_bm : omap4_enter_idle;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(state->name, "=
C%d", count+1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strncpy(state->desc, cx=
->desc, CPUIDLE_DESC_LEN);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
