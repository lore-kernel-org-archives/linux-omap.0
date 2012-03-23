From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC][PATCH 4/9] ARM: OMAP3: define cpuidle statically
Date: Fri, 23 Mar 2012 13:35:12 +0100
Message-ID: <CAORVsuUZUWrwzx0hYT4YC0HhwAzTKF+q++LPvg43iy-iYbTivA@mail.gmail.com>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
	<1332494794-7810-4-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42024 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758578Ab2CWMfN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 08:35:13 -0400
Received: by vcqp1 with SMTP id p1so2750225vcq.19
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 05:35:12 -0700 (PDT)
In-Reply-To: <1332494794-7810-4-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Use the new cpuidle API and define in the driver the states.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 85 +++++++++++++++++++++++=
++-----------
> =A01 files changed, 59 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 65b4e7aa..62e3cfd 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -228,23 +228,67 @@ DEFINE_PER_CPU(struct cpuidle_device, omap3_idl=
e_dev);
> =A0struct cpuidle_driver omap3_idle_driver =3D {
> =A0 =A0 =A0 =A0.name =3D =A0 =A0 =A0 =A0 "omap3_idle",
> =A0 =A0 =A0 =A0.owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
> + =A0 =A0 =A0 .states =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =
=A0 =A0=3D omap3_enter_idle,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =3D=
 2 + 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 5=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =
=A0 =A0=3D CPUIDLE_FLAG_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "C1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "MPU ON + CORE ON",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =
=A0 =A0=3D omap3_enter_idle_bm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =3D=
 10 + 10,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 3=
0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =
=A0 =A0=3D CPUIDLE_FLAG_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "C2",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "MPU ON + CORE ON",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =
=A0 =A0=3D omap3_enter_idle_bm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =3D=
 50 + 50,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 3=
00,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =
=A0 =A0=3D CPUIDLE_FLAG_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "C3",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "MPU RET + CORE ON",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =
=A0 =A0=3D omap3_enter_idle_bm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =3D=
 1500 + 1800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 4=
000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =
=A0 =A0=3D CPUIDLE_FLAG_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "C4",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "MPU OFF + CORE ON",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =
=A0 =A0=3D omap3_enter_idle_bm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =3D=
 2500 + 7500,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 1=
2000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =
=A0 =A0=3D CPUIDLE_FLAG_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "C5",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "MPU RET + CORE RET",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =
=A0 =A0=3D omap3_enter_idle_bm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =3D=
 3000 + 8500,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 1=
5000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =
=A0 =A0=3D CPUIDLE_FLAG_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "C6",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "MPU OFF + CORE RET",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enter =A0 =A0 =A0 =A0 =
=A0 =A0=3D omap3_enter_idle_bm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .exit_latency =A0 =A0 =3D=
 10000 + 30000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .target_residency =3D 3=
0000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =
=A0 =A0=3D CPUIDLE_FLAG_TIME_VALID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "C7",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0=
 =A0 =3D "MPU OFF + CORE OFF",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
C7 is enabled depending on the errata i583, cf. below.

> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .state_count =3D OMAP3_NUM_STATES,
> =A0};
>
> -/* Helper to fill the C-state common data*/
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
> - =A0 =A0 =A0 state->enter =A0 =A0 =A0 =A0 =A0 =A0=3D omap3_enter_idl=
e_bm;
> - =A0 =A0 =A0 sprintf(state->name, "C%d", idx + 1);
> - =A0 =A0 =A0 strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
> -
> -}
> -
> =A0/* Helper to register the driver_data */
> =A0static inline struct omap3_idle_statedata *_fill_cstate_usage(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct cpuidle_device *dev,
> @@ -277,50 +321,40 @@ int __init omap3_idle_init(void)
> =A0 =A0 =A0 =A0cam_pd =3D pwrdm_lookup("cam_pwrdm");
>
>
> - =A0 =A0 =A0 drv->safe_state_index =3D -1;
> =A0 =A0 =A0 =A0dev =3D &per_cpu(omap3_idle_dev, smp_processor_id());
>
> =A0 =A0 =A0 =A0/* C1 . MPU WFI + Core active */
> - =A0 =A0 =A0 _fill_cstate(drv, 0, "MPU ON + CORE ON");
> - =A0 =A0 =A0 (&drv->states[0])->enter =3D omap3_enter_idle;
> - =A0 =A0 =A0 drv->safe_state_index =3D 0;
Same minor remark about the safe_state_index as in the previous series.

> =A0 =A0 =A0 =A0cx =3D _fill_cstate_usage(dev, 0);
> =A0 =A0 =A0 =A0cx->valid =3D 1; =A0/* C1 is always valid */
> =A0 =A0 =A0 =A0cx->mpu_state =3D PWRDM_POWER_ON;
> =A0 =A0 =A0 =A0cx->core_state =3D PWRDM_POWER_ON;
>
> =A0 =A0 =A0 =A0/* C2 . MPU WFI + Core inactive */
> - =A0 =A0 =A0 _fill_cstate(drv, 1, "MPU ON + CORE ON");
> =A0 =A0 =A0 =A0cx =3D _fill_cstate_usage(dev, 1);
> =A0 =A0 =A0 =A0cx->mpu_state =3D PWRDM_POWER_ON;
> =A0 =A0 =A0 =A0cx->core_state =3D PWRDM_POWER_ON;
>
> =A0 =A0 =A0 =A0/* C3 . MPU CSWR + Core inactive */
> - =A0 =A0 =A0 _fill_cstate(drv, 2, "MPU RET + CORE ON");
> =A0 =A0 =A0 =A0cx =3D _fill_cstate_usage(dev, 2);
> =A0 =A0 =A0 =A0cx->mpu_state =3D PWRDM_POWER_RET;
> =A0 =A0 =A0 =A0cx->core_state =3D PWRDM_POWER_ON;
>
> =A0 =A0 =A0 =A0/* C4 . MPU OFF + Core inactive */
> - =A0 =A0 =A0 _fill_cstate(drv, 3, "MPU OFF + CORE ON");
> =A0 =A0 =A0 =A0cx =3D _fill_cstate_usage(dev, 3);
> =A0 =A0 =A0 =A0cx->mpu_state =3D PWRDM_POWER_OFF;
> =A0 =A0 =A0 =A0cx->core_state =3D PWRDM_POWER_ON;
>
> =A0 =A0 =A0 =A0/* C5 . MPU RET + Core RET */
> - =A0 =A0 =A0 _fill_cstate(drv, 4, "MPU RET + CORE RET");
> =A0 =A0 =A0 =A0cx =3D _fill_cstate_usage(dev, 4);
> =A0 =A0 =A0 =A0cx->mpu_state =3D PWRDM_POWER_RET;
> =A0 =A0 =A0 =A0cx->core_state =3D PWRDM_POWER_RET;
>
> =A0 =A0 =A0 =A0/* C6 . MPU OFF + Core RET */
> - =A0 =A0 =A0 _fill_cstate(drv, 5, "MPU OFF + CORE RET");
> =A0 =A0 =A0 =A0cx =3D _fill_cstate_usage(dev, 5);
> =A0 =A0 =A0 =A0cx->mpu_state =3D PWRDM_POWER_OFF;
> =A0 =A0 =A0 =A0cx->core_state =3D PWRDM_POWER_RET;
>
> =A0 =A0 =A0 =A0/* C7 . MPU OFF + Core OFF */
> - =A0 =A0 =A0 _fill_cstate(drv, 6, "MPU OFF + CORE OFF");
> =A0 =A0 =A0 =A0cx =3D _fill_cstate_usage(dev, 6);
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Erratum i583: implementation for ES rev < Es1.2 on =
3630. We cannot
C7 is enabled only if the errata does not apply.
This causes a problem with the statically defined C-states and also
with the per C-state sysfs disable knob. A consistency check should be
performed before trying to enter a state.

> @@ -338,7 +372,6 @@ int __init omap3_idle_init(void)
> =A0 =A0 =A0 =A0drv->state_count =3D OMAP3_NUM_STATES;
> =A0 =A0 =A0 =A0cpuidle_register_driver(&omap3_idle_driver);
>
> - =A0 =A0 =A0 dev->state_count =3D OMAP3_NUM_STATES;
> =A0 =A0 =A0 =A0if (cpuidle_register_device(dev)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: CPUidle register =
device failed\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
> --
> 1.7.5.4
>

Thanks!
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
