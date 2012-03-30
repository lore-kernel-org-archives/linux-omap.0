From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 2/3] ARM: OMAP4: cpuidle: Use coupled cpuidle states to
 implement SMP cpuidle.
Date: Fri, 30 Mar 2012 12:43:29 -0700
Message-ID: <CAMbhsRRAQxDh_yZKayqMedvGkeSP9UGxiud9LbotWp-aMQ7cSw@mail.gmail.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
	<1333114048-26136-3-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45667 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758382Ab2C3Tna convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 15:43:30 -0400
Received: by iagz16 with SMTP id z16so1384451iag.19
        for <linux-omap@vger.kernel.org>; Fri, 30 Mar 2012 12:43:30 -0700 (PDT)
In-Reply-To: <1333114048-26136-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Fri, Mar 30, 2012 at 6:27 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> OMAP4 CPUDILE driver is converted mainly based on notes from the
> coupled cpuidle patch series.
>
> The changes include :
> - Register both CPUs and C-states to cpuidle driver.
> - Set struct cpuidle_device.coupled_cpus
> - Set struct cpuidle_device.safe_state to non coupled state.
> - Set CPUIDLE_FLAG_COUPLED in struct cpuidle_state.flags for each
> =A0state that affects multiple cpus.
> - Separate ->enter hooks for coupled & simple idle.
> - CPU0 wait loop for CPU1 power transition.
> - CPU1 wakeup mechanism for the idle exit.
> - Enabling ARCH_NEEDS_CPU_IDLE_COUPLED for OMAP4.
>
> Thanks to Kevin Hilman and Colin Cross on the suggestions/fixes
> on the intermediate version of this patch.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Kevin Hilman <khilman@ti.com>
> Cc: Colin Cross <ccross@android.com>
> ---
> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/cpuidle44xx.c | =A0167 ++++++++++++++++++++++-=
--------------
> =A02 files changed, 101 insertions(+), 67 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index e20c8ab..250786e 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -54,6 +54,7 @@ config ARCH_OMAP4
> =A0 =A0 =A0 =A0select PM_OPP if PM
> =A0 =A0 =A0 =A0select USB_ARCH_HAS_EHCI
> =A0 =A0 =A0 =A0select ARM_CPU_SUSPEND if PM
> + =A0 =A0 =A0 select ARCH_NEEDS_CPU_IDLE_COUPLED if CPU_IDLE
The "if CPU_IDLE" is not necessary, ARCH_NEEDS_CPU_IDLE_COUPLED is
designed to have no effect if CPU_IDLE is not set.

>
> =A0comment "OMAP Core Type"
> =A0 =A0 =A0 =A0depends on ARCH_OMAP2
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/=
cpuidle44xx.c
> index f386cbe..5724393 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -21,6 +21,7 @@
> =A0#include "common.h"
> =A0#include "pm.h"
> =A0#include "prm.h"
> +#include "clockdomain.h"
>
> =A0#ifdef CONFIG_CPU_IDLE
>
> @@ -44,10 +45,11 @@ static struct cpuidle_params cpuidle_params_table=
[] =3D {
> =A0#define OMAP4_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
>
> =A0struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
> -static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
> +static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
> +static struct clockdomain *cpu_clkdm[NR_CPUS];
>
> =A0/**
> - * omap4_enter_idle - Programs OMAP4 to enter the specified state
> + * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry f=
unctions
> =A0* @dev: cpuidle device
> =A0* @drv: cpuidle driver
> =A0* @index: the index of state to be entered
> @@ -56,34 +58,40 @@ static struct powerdomain *mpu_pd, *cpu0_pd, *cpu=
1_pd;
> =A0* specified low power state selected by the governor.
> =A0* Returns the amount of time spent in the low power state.
> =A0*/
> -static int omap4_enter_idle(struct cpuidle_device *dev,
> +static int omap4_enter_idle_simple(struct cpuidle_device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct cpuidle_driver *drv,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
int index)
> +{
> + =A0 =A0 =A0 local_fiq_disable();
> + =A0 =A0 =A0 omap_do_wfi();
> + =A0 =A0 =A0 local_fiq_enable();
> +
> + =A0 =A0 =A0 return index;
> +}
> +
> +static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpuidle_driver =
*drv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int index)
> =A0{
> =A0 =A0 =A0 =A0struct omap4_idle_statedata *cx =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpuidle_get_statedata(=
&dev->states_usage[index]);
> - =A0 =A0 =A0 u32 cpu1_state;
> =A0 =A0 =A0 =A0int cpu_id =3D smp_processor_id();
>
> =A0 =A0 =A0 =A0local_fiq_disable();
>
> + =A0 =A0 =A0 clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &c=
pu_id);
> +
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* CPU0 has to stay ON (i.e in C1) until CPU1 is OFF =
state.
> + =A0 =A0 =A0 =A0* CPU0 has to wait and stay ON until CPU1 is OFF sta=
te.
> =A0 =A0 =A0 =A0 * This is necessary to honour hardware recommondation
> =A0 =A0 =A0 =A0 * of triggeing all the possible low power modes once =
CPU1 is
> =A0 =A0 =A0 =A0 * out of coherency and in OFF mode.
> - =A0 =A0 =A0 =A0* Update dev->last_state so that governor stats refl=
ects right
> - =A0 =A0 =A0 =A0* data.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 cpu1_state =3D pwrdm_read_pwrst(cpu1_pd);
> - =A0 =A0 =A0 if (cpu1_state !=3D PWRDM_POWER_OFF) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 index =3D drv->safe_state_index;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cx =3D cpuidle_get_statedata(&dev->stat=
es_usage[index]);
> + =A0 =A0 =A0 if (dev->cpu =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (pwrdm_read_pwrst(cpu_pd[1]) !=3D=
 PWRDM_POWER_OFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
If something goes wrong in the core coupled code or in the cpu 1 power
state transition, this will hang forever and be hard to debug.  It
might be worth adding a timeout with a BUG_ON.

> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (index > 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clockevents_notify(CLOCK_EVT_NOTIFY_BRO=
ADCAST_ENTER, &cpu_id);
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Call idle CPU PM enter notifier chain so that
> =A0 =A0 =A0 =A0 * VFP and per CPU interrupt context is saved.
> @@ -91,25 +99,35 @@ static int omap4_enter_idle(struct cpuidle_device=
 *dev,
> =A0 =A0 =A0 =A0if (cx->cpu_state =3D=3D PWRDM_POWER_OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_pm_enter();
This should never get called without cpu_state =3D=3D PWRDM_POWER_OFF, =
and
even if it did, calling cpu_pm_enter shouldn't hurt anything.  It
would be clearer to unconditionally call cpu_pm_enter().

>
> - =A0 =A0 =A0 pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> - =A0 =A0 =A0 omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Call idle CPU cluster PM enter notifier chain
> - =A0 =A0 =A0 =A0* to save GIC and wakeupgen context.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if ((cx->mpu_state =3D=3D PWRDM_POWER_RET) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cx->mpu_logic_state =3D=3D PWRDM_POWER=
_OFF))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_cluster_pm_enter();
> + =A0 =A0 =A0 if (dev->cpu =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(mpu_pd, cx->mpu_l=
ogic_state);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_set_pwrdm_state(mpu_pd, cx->mpu_st=
ate);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Call idle CPU cluster PM enter not=
ifier chain
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to save GIC and wakeupgen context.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((cx->mpu_state =3D=3D PWRDM_POWER_R=
ET) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cx->mpu_logic_state =3D=
=3D PWRDM_POWER_OFF))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_clu=
ster_pm_enter();
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0omap4_enter_lowpower(dev->cpu, cx->cpu_state);
>
> + =A0 =A0 =A0 if (dev->cpu =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wakeup CPU1 only if it is not offlin=
ed */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpumask_test_cpu(1, cpu_online_mask=
)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_wakeup(cpu_clkdm[=
1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(cpu_cl=
kdm[1]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Call idle CPU PM exit notifier chain to restore
> =A0 =A0 =A0 =A0 * VFP and per CPU IRQ context. Only CPU0 state is
> =A0 =A0 =A0 =A0 * considered since CPU1 is managed by CPU hotplug.
> =A0 =A0 =A0 =A0 */
This comment is no longer accurate?  cpu_pm_enter is called on cpu 1 ab=
ove.

> - =A0 =A0 =A0 if (pwrdm_read_prev_pwrst(cpu0_pd) =3D=3D PWRDM_POWER_O=
=46F)
> + =A0 =A0 =A0 if (pwrdm_read_prev_pwrst(cpu_pd[dev->cpu]) =3D=3D PWRD=
M_POWER_OFF)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpu_pm_exit();
This should get called unconditionally.  It's not explicitly stated,
but the cpu_pm_* api expects cpu_pm_exit() to be called after
cpu_pm_enter(), even if the low power state was not entered.
Otherwise, a cpu_pm_enter notifier that disables the hardware will not
get a chance to re-enable it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
