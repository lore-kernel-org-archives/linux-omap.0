From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 08/10] ARM: OMAP5/DRA7: PM: cpuidle MPU CSWR support
Date: Wed, 17 Sep 2014 11:49:33 -0700
Message-ID: <5419D7BD.30003@linaro.org>
References: <1408716154-26101-1-git-send-email-nm@ti.com> <1408716154-26101-9-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:41630 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbaIQStf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 14:49:35 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so2756049pad.6
        for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2014 11:49:34 -0700 (PDT)
In-Reply-To: <1408716154-26101-9-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?UTF-8?B?QmVu?= =?UTF-8?B?b8OudCBDb3Vzc29u?= <bcousson@baylibre.com>

On 08/22/2014 07:02 AM, Nishanth Menon wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Add OMAP5/DRA74/72 CPUIDLE support.
>
> This patch adds MPUSS low power states in cpuidle.
>
>          C1 - CPU0 WFI + CPU1 WFI + MPU ON
>          C2 - CPU0 RET + CPU1 RET + MPU CSWR
>
> Tested on DRA74/72-EVM for C1 and C2 states.
>
> NOTE: DRA7 does not do voltage scaling as part of retention transitio=
n
> and has Mercury which speeds up transition paths - Latency numbers ar=
e
> based on measurements done by toggling GPIOs.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [ j-keerthy@ti.com rework on 3.14]
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [nm@ti.com: updates based on profiling, OMAP5 squashed]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/mach-omap2/cpuidle44xx.c |   82 ++++++++++++++++++++++++++=
++++++++++-
>   arch/arm/mach-omap2/pm44xx.c      |    2 +-
>   2 files changed, 82 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/=
cpuidle44xx.c
> index 2498ab0..8ad4f44 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -22,6 +22,7 @@
>   #include "common.h"
>   #include "pm.h"
>   #include "prm.h"
> +#include "soc.h"
>   #include "clockdomain.h"
>
>   #define MAX_CPUS	2
> @@ -31,6 +32,7 @@ struct idle_statedata {
>   	u32 cpu_state;
>   	u32 mpu_logic_state;
>   	u32 mpu_state;
> +	u32 mpu_state_vote;
>   };
>
>   static struct idle_statedata omap4_idle_data[] =3D {
> @@ -51,12 +53,26 @@ static struct idle_statedata omap4_idle_data[] =3D=
 {
>   	},
>   };
>
> +static struct idle_statedata dra7_idle_data[] =3D {
> +	{
> +		.cpu_state =3D PWRDM_POWER_ON,
> +		.mpu_state =3D PWRDM_POWER_ON,
> +		.mpu_logic_state =3D PWRDM_POWER_ON,
> +	},
> +	{
> +		.cpu_state =3D PWRDM_POWER_RET,
> +		.mpu_state =3D PWRDM_POWER_RET,
> +		.mpu_logic_state =3D PWRDM_POWER_RET,
> +	},
> +};
> +
>   static struct powerdomain *mpu_pd, *cpu_pd[MAX_CPUS];
>   static struct clockdomain *cpu_clkdm[MAX_CPUS];
>
>   static atomic_t abort_barrier;
>   static bool cpu_done[MAX_CPUS];
>   static struct idle_statedata *state_ptr =3D &omap4_idle_data[0];
> +static DEFINE_RAW_SPINLOCK(mpu_lock);
>
>   /* Private functions */
>
> @@ -78,6 +94,32 @@ static int omap_enter_idle_simple(struct cpuidle_d=
evice *dev,
>   	return index;
>   }
>
> +static int omap_enter_idle_smp(struct cpuidle_device *dev,
> +			       struct cpuidle_driver *drv,
> +			       int index)
> +{
> +	struct idle_statedata *cx =3D state_ptr + index;
> +	unsigned long flag;
> +
> +	raw_spin_lock_irqsave(&mpu_lock, flag);

Why do you need this spin_lock_irqsave ? Aren't the local irqs already=20
disabled ?

> +	cx->mpu_state_vote++;
> +	if (cx->mpu_state_vote =3D=3D num_online_cpus()) {
> +		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
> +		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
> +	}
> +	raw_spin_unlock_irqrestore(&mpu_lock, flag);
> +
> +	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
> +
> +	raw_spin_lock_irqsave(&mpu_lock, flag);
> +	if (cx->mpu_state_vote =3D=3D num_online_cpus())
> +		omap_set_pwrdm_state(mpu_pd, PWRDM_POWER_ON);
> +	cx->mpu_state_vote--;
> +	raw_spin_unlock_irqrestore(&mpu_lock, flag);

I am not sure that will work. What happens if a cpu exits idle and then=
=20
re-enter idle immediately ?

Could you try a long run of this little program:

https://git.linaro.org/power/pm-qa.git/blob/HEAD:/cpuidle/cpuidle_kille=
r.c

> +	return index;
> +}
> +
>   static int omap_enter_idle_coupled(struct cpuidle_device *dev,
>   			struct cpuidle_driver *drv,
>   			int index)
> @@ -224,6 +266,34 @@ static struct cpuidle_driver omap4_idle_driver =3D=
 {
>   	.safe_state_index =3D 0,
>   };
>
> +static struct cpuidle_driver dra7_idle_driver =3D {
> +	.name				=3D "dra7_idle",
> +	.owner				=3D THIS_MODULE,
> +	.states =3D {
> +		{
> +			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
> +			.exit_latency =3D 2 + 2,
> +			.target_residency =3D 5,
> +			.flags =3D CPUIDLE_FLAG_TIME_VALID,
> +			.enter =3D omap_enter_idle_simple,
> +			.name =3D "C1",
> +			.desc =3D "CPUx WFI, MPUSS ON"
> +		},
> +		{
> +			/* C2 - CPU0 RET + CPU1 RET + MPU CSWR */
> +			.exit_latency =3D 48 + 60,
> +			.target_residency =3D 100,
> +			.flags =3D CPUIDLE_FLAG_TIME_VALID
> +					| CPUIDLE_FLAG_TIMER_STOP,
> +			.enter =3D omap_enter_idle_smp,
> +			.name =3D "C2",
> +			.desc =3D "CPUx CSWR, MPUSS CSWR",
> +		},
> +	},
> +	.state_count =3D ARRAY_SIZE(dra7_idle_data),
> +	.safe_state_index =3D 0,
> +};
> +
>   /* Public functions */
>
>   /**
> @@ -234,6 +304,16 @@ static struct cpuidle_driver omap4_idle_driver =3D=
 {
>    */
>   int __init omap4_idle_init(void)
>   {
> +	struct cpuidle_driver *idle_driver;
> +
> +	if (soc_is_dra7xx() || soc_is_omap54xx()) {
> +		state_ptr =3D &dra7_idle_data[0];
> +		idle_driver =3D &dra7_idle_driver;
> +	} else {
> +		state_ptr =3D &omap4_idle_data[0];
> +		idle_driver =3D &omap4_idle_driver;
> +	}
> +
>   	mpu_pd =3D pwrdm_lookup("mpu_pwrdm");
>   	cpu_pd[0] =3D pwrdm_lookup("cpu0_pwrdm");
>   	cpu_pd[1] =3D pwrdm_lookup("cpu1_pwrdm");
> @@ -248,5 +328,5 @@ int __init omap4_idle_init(void)
>   	/* Configure the broadcast timer on each cpu */
>   	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
>
> -	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
> +	return cpuidle_register(idle_driver, cpu_online_mask);
>   }
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44x=
x.c
> index c063833..1d22162 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -293,7 +293,7 @@ int __init omap4_pm_init(void)
>   	/* Overwrite the default cpu_do_idle() */
>   	arm_pm_idle =3D omap_default_idle;
>
> -	if (cpu_is_omap44xx())
> +	if (cpu_is_omap44xx() || soc_is_dra7xx() || soc_is_omap54xx())
>   		omap4_idle_init();
>
>   err2:
>


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
