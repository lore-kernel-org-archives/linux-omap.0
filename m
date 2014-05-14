From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] ARM: OMAP4: Fix the boot regression with CPU_IDLE enabled
Date: Wed, 14 May 2014 21:44:14 +0200
Message-ID: <5373C78E.7040301@linaro.org>
References: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:53215 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbaENToF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2014 15:44:05 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so2455941wgg.9
        for <linux-omap@vger.kernel.org>; Wed, 14 May 2014 12:44:04 -0700 (PDT)
In-Reply-To: <1399991966-14582-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, khilman@linaro.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>

On 05/13/2014 04:39 PM, Santosh Shilimkar wrote:
> On OMAP4 panda board, there have been several bug reports about boot
> hang and lock-ups with CPU_IDLE enabled. The root cause of the issue
> is missing interrupts while in idle state. Commit cb7094e8 {cpuidle /=
 omap4 :
> use CPUIDLE_FLAG_TIMER_STOP flag} moved the broadcast notifiers to co=
mmon
> code for right reasons but on OMAP4 which suffers from a nasty ROM co=
de
> bug with GIC, commit ff999b8a {ARM: OMAP4460: Workaround for ROM bug =
=2E.},
> we loose interrupts which leads to issues like lock-up, hangs etc.
>
> Patch reverts commit cb7094 {cpuidle / omap4 : use CPUIDLE_FLAG_TIMER=
_STOP
> flag} to avoid the issue. With this change, OMAP4 panda boards, the m=
entioned
> issues are getting fixed. We no longer loose interrupts which was the=
 cause
> of the regression.
>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reported-tested-by: Roger Quadros <rogerq@ti.com>
> Reported-tested-by: Kevin Hilman <khilman@linaro.org>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>   arch/arm/mach-omap2/cpuidle44xx.c |   12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/=
cpuidle44xx.c
> index 01fc710..3e169d9 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -14,6 +14,7 @@
>   #include <linux/cpuidle.h>
>   #include <linux/cpu_pm.h>
>   #include <linux/export.h>
> +#include <linux/clockchips.h>
>
>   #include <asm/cpuidle.h>
>   #include <asm/proc-fns.h>
> @@ -83,6 +84,7 @@ static int omap_enter_idle_coupled(struct cpuidle_d=
evice *dev,
>   {
>   	struct idle_statedata *cx =3D state_ptr + index;
>   	u32 mpuss_can_lose_context =3D 0;
> +	int cpu_id =3D smp_processor_id();
>
>   	/*
>   	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
> @@ -110,6 +112,8 @@ static int omap_enter_idle_coupled(struct cpuidle=
_device *dev,
>   	mpuss_can_lose_context =3D (cx->mpu_state =3D=3D PWRDM_POWER_RET) =
&&
>   				 (cx->mpu_logic_state =3D=3D PWRDM_POWER_OFF);
>
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
> +
>   	/*
>   	 * Call idle CPU PM enter notifier chain so that
>   	 * VFP and per CPU interrupt context is saved.
> @@ -165,6 +169,8 @@ static int omap_enter_idle_coupled(struct cpuidle=
_device *dev,
>   	if (dev->cpu =3D=3D 0 && mpuss_can_lose_context)
>   		cpu_cluster_pm_exit();
>
> +	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
> +
>   fail:
>   	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
>   	cpu_done[dev->cpu] =3D false;
> @@ -189,8 +195,7 @@ static struct cpuidle_driver omap4_idle_driver =3D=
 {
>   			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
>   			.exit_latency =3D 328 + 440,
>   			.target_residency =3D 960,
> -			.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
> -			         CPUIDLE_FLAG_TIMER_STOP,
> +			.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
>   			.enter =3D omap_enter_idle_coupled,
>   			.name =3D "C2",
>   			.desc =3D "CPUx OFF, MPUSS CSWR",
> @@ -199,8 +204,7 @@ static struct cpuidle_driver omap4_idle_driver =3D=
 {
>   			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
>   			.exit_latency =3D 460 + 518,
>   			.target_residency =3D 1100,
> -			.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
> -			         CPUIDLE_FLAG_TIMER_STOP,
> +			.flags =3D CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
>   			.enter =3D omap_enter_idle_coupled,
>   			.name =3D "C3",
>   			.desc =3D "CPUx OFF, MPUSS OSWR",

Shouldn't the broadcast timer to be setup with=20
CLOCK_EVT_NOTIFY_BROADCAST_ON also ?



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
