From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC][PATCH 2/7] ARM: OMAP4: cpuidle - Declare the states with
 the driver declaration
Date: Wed, 21 Mar 2012 14:31:46 +0100
Message-ID: <CAORVsuV-0xQx6W0iKGO_UduESFwdD-44vsBAcVXD0Yy-VB_eGw@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
	<1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46677 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab2CUNbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 09:31:47 -0400
Received: by vcqp1 with SMTP id p1so1007075vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 06:31:46 -0700 (PDT)
In-Reply-To: <1332322070-24577-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Wed, Mar 21, 2012 at 10:27 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The cpuidle API allows to declare statically the states in the driver
> structure. Let's use it.
> We do no longer need the fill_cstate function called at runtime and
> by the way adding more instructions at boot time.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> =A0arch/arm/mach-omap2/cpuidle44xx.c | =A0 56 +++++++++++++++++++++--=
--------------
> =A01 files changed, 32 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/=
cpuidle44xx.c
> index 1210229..cd6bee7 100644
> --- a/arch/arm/mach-omap2/cpuidle44xx.c
> +++ b/arch/arm/mach-omap2/cpuidle44xx.c
> @@ -148,21 +148,38 @@ DEFINE_PER_CPU(struct cpuidle_device, omap4_idl=
e_dev);
> =A0struct cpuidle_driver omap4_idle_driver =3D {
> =A0 =A0 =A0 =A0.name =3D =A0 =A0 =A0 =A0 "omap4_idle",
> =A0 =A0 =A0 =A0.owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
> + =A0 =A0 =A0 .states =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* C1 - CPU0 ON + CPU1 =
ON + MPU ON */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =3D 2 + 2=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 5=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D CPUIDLE_FLAG=
_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =3D omap4_enter_=
idle,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "C1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =3D "MPUSS ON"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
=2E..
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .state_count =3D OMAP4_NUM_STATES,
> =A0};
>
> -static inline void _fill_cstate(struct cpuidle_driver *drv,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int idx, const char *descr)
> -{
> - =A0 =A0 =A0 struct cpuidle_state *state =3D &drv->states[idx];
> -
> - =A0 =A0 =A0 state->exit_latency =A0 =A0 =3D cpuidle_params_table[id=
x].exit_latency;
> - =A0 =A0 =A0 state->target_residency =3D cpuidle_params_table[idx].t=
arget_residency;
> - =A0 =A0 =A0 state->flags =A0 =A0 =A0 =A0 =A0 =A0=3D CPUIDLE_FLAG_TI=
ME_VALID;
> - =A0 =A0 =A0 state->enter =A0 =A0 =A0 =A0 =A0 =A0=3D omap4_enter_idl=
e;
> - =A0 =A0 =A0 sprintf(state->name, "C%d", idx + 1);
> - =A0 =A0 =A0 strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
> -}
I am OK with this change, which makes the code more readable (and so
maintainable).

> -
> =A0static inline struct omap4_idle_statedata *_fill_cstate_usage(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct cpuidle_device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0int idx)
> @@ -196,37 +213,28 @@ int __init omap4_idle_init(void)
> =A0 =A0 =A0 =A0if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> -
> - =A0 =A0 =A0 drv->safe_state_index =3D -1;
> =A0 =A0 =A0 =A0dev =3D &per_cpu(omap4_idle_dev, cpu_id);
> =A0 =A0 =A0 =A0dev->cpu =3D cpu_id;
>
> - =A0 =A0 =A0 /* C1 - CPU0 ON + CPU1 ON + MPU ON */
> - =A0 =A0 =A0 _fill_cstate(drv, 0, "MPUSS ON");
> - =A0 =A0 =A0 drv->safe_state_index =3D 0;
I would keep this or add a clear comment that C1 is the safe state.

=2E..

Thanks,
Jean

> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
