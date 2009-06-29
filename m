From: Mike Chan <mike@android.com>
Subject: Re: [PATCH 2/2] OMAP3: PM: Configure CPUidle latencies/thresholds
	from board files
Date: Mon, 29 Jun 2009 13:18:14 -0700
Message-ID: <8bb80c380906291318u7c47e1ekaef9b991adde3c3d@mail.gmail.com>
References: <1246286113-21197-1-git-send-email-rnayak@ti.com>
	 <1246286113-21197-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.168]:49426 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbZF2USL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2009 16:18:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1031320wfd.4
        for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 13:18:14 -0700 (PDT)
In-Reply-To: <1246286113-21197-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

On Mon, Jun 29, 2009 at 7:35 AM, Rajendra Nayak<rnayak@ti.com> wrote:
> The CPUidle C state latencies and thresholds are dependent
> on various board specific details.
> Hence this patch makes it possible to configure these values from the
> respective board files.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---

I think cpufreq could probably use something similar. The transition
latency set in the policy is set in cpu-omap.c and is a hard-coded
value. I wonder if its reasonable to piggyback off these values for
the transition latencies, or extend the struct to include those?

-- Mike

> =A0arch/arm/mach-omap2/board-3430sdp.c =A0 =A0 | =A0 22 ++++++-
> =A0arch/arm/mach-omap2/board-apollon.c =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-generic.c =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-h4.c =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-ldp.c =A0 =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-omap3evm.c =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 | =A0 =A03 +-
> =A0arch/arm/mach-omap2/board-rx51.c =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/board-zoom2.c =A0 =A0 =A0 | =A0 =A02 +-
> =A0arch/arm/mach-omap2/cpuidle34xx.c =A0 =A0 =A0 | =A0105 +++++++++++=
+++++++++++++------
> =A0arch/arm/mach-omap2/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05=
 +-
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07=
 ++-
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 12 +=
++-
> =A0arch/arm/plat-omap/include/mach/io.h =A0 =A0| =A0 =A04 +-
> =A015 files changed, 136 insertions(+), 38 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap=
2/board-3430sdp.c
> index b43cf94..750d841 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -75,6 +75,24 @@ static struct prm_setup_vc omap3_setuptime_table =3D=
 {
> =A0 =A0 =A0 =A0.vdd1_off =3D 0x00,
> =A0};
>
> +/* FIXME: These values need to be updated based on more profiling on=
 3430sdp*/
> +static struct cpuidle_params omap3_cpuidle_params_table[] =3D {
> + =A0 =A0 =A0 /* C1 */
> + =A0 =A0 =A0 {2, 2, 5},
> + =A0 =A0 =A0 /* C2 */
> + =A0 =A0 =A0 {10, 10, 30},
> + =A0 =A0 =A0 /* C3 */
> + =A0 =A0 =A0 {50, 50, 300},
> + =A0 =A0 =A0 /* C4 */
> + =A0 =A0 =A0 {1500, 1800, 4000},
> + =A0 =A0 =A0 /* C5 */
> + =A0 =A0 =A0 {2500, 7500, 12000},
> + =A0 =A0 =A0 /* C6 */
> + =A0 =A0 =A0 {3000, 8500, 15000},
> + =A0 =A0 =A0 /* C7 */
> + =A0 =A0 =A0 {10000, 30000, 300000},
> +};
> +
> =A0static int sdp3430_keymap[] =3D {
> =A0 =A0 =A0 =A0KEY(0, 0, KEY_LEFT),
> =A0 =A0 =A0 =A0KEY(0, 1, KEY_RIGHT),
> @@ -191,8 +209,8 @@ static struct platform_device *sdp3430_devices[] =
__initdata =3D {
> =A0static void __init omap_3430sdp_init_irq(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_init_common_hw(hyb18m512160af6_sdrc_params, omap=
3_mpu_rate_table,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_dsp_ra=
te_table, omap3_l3_rate_table,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&omap3_setup=
time_table);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rate_table, o=
map3_l3_rate_table,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap3_setuptime_table,=
 omap3_cpuidle_params_table);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0}
> diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap=
2/board-apollon.c
> index 293a9b2..fe625a9 100644
> --- a/arch/arm/mach-omap2/board-apollon.c
> +++ b/arch/arm/mach-omap2/board-apollon.c
> @@ -250,7 +250,7 @@ out:
>
> =A0static void __init omap_apollon_init_irq(void)
> =A0{
> - =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
> + =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL=
);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0 =A0 =A0 =A0apollon_init_smc91x();
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap=
2/board-generic.c
> index dfc1b49..ecf2c45 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -33,7 +33,7 @@
>
> =A0static void __init omap_generic_init_irq(void)
> =A0{
> - =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
> + =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL=
);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0}
>
> diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/boa=
rd-h4.c
> index af0ebaf..365bc69 100644
> --- a/arch/arm/mach-omap2/board-h4.c
> +++ b/arch/arm/mach-omap2/board-h4.c
> @@ -270,7 +270,7 @@ static void __init h4_init_flash(void)
>
> =A0static void __init omap_h4_init_irq(void)
> =A0{
> - =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
> + =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL=
);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0 =A0 =A0 =A0h4_init_flash();
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/bo=
ard-ldp.c
> index eb5e2e0..1265a12 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -270,7 +270,7 @@ static inline void __init ldp_init_smsc911x(void)
>
> =A0static void __init omap_ldp_init_irq(void)
> =A0{
> - =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
> + =A0 =A0 =A0 omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL=
);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0 =A0 =A0 =A0ldp_init_smsc911x();
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index e0be6bd..da1f3f6 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -289,7 +289,7 @@ static int __init omap3_beagle_i2c_init(void)
> =A0static void __init omap3_beagle_init_irq(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_=
mpu_rate_table,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_dsp_ra=
te_table, omap3_l3_rate_table, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rate_table, o=
map3_l3_rate_table, NULL, NULL);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0#ifdef CONFIG_OMAP_32K_TIMER
> =A0 =A0 =A0 =A0omap2_gp_clockevent_set_gptimer(12);
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index eaab39b..4a287b9 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -284,7 +284,7 @@ struct spi_board_info omap3evm_spi_board_info[] =3D=
 {
> =A0static void __init omap3_evm_init_irq(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_=
mpu_rate_table,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rate_table, o=
map3_l3_rate_table, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rate_table, o=
map3_l3_rate_table, NULL, NULL);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0 =A0 =A0 =A0omap3evm_init_smc911x();
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/=
board-overo.c
> index f159e18..a673921 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -360,7 +360,8 @@ static int __init overo_i2c_init(void)
>
> =A0static void __init overo_init_irq(void)
> =A0{
> - =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, N=
ULL, NULL, NULL);
> + =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL=
, NULL, NULL, NULL, NULL);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0}
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/b=
oard-rx51.c
> index 3629a0e..6cb8715 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -66,7 +66,7 @@ static struct omap_board_config_kernel rx51_config[=
] =3D {
> =A0static void __init rx51_init_irq(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_init_common_hw(rx51_get_sdram_timings(), omap3_m=
pu_rate_table,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_dsp_ra=
te_table, omap3_l3_rate_table, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rate_table, omap3_l3_rate_tab=
le, NULL, NULL);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0}
> diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/=
board-zoom2.c
> index e63bfa0..0fcd0ff 100644
> --- a/arch/arm/mach-omap2/board-zoom2.c
> +++ b/arch/arm/mach-omap2/board-zoom2.c
> @@ -27,7 +27,7 @@
> =A0static void __init omap_zoom2_init_irq(void)
> =A0{
> =A0 =A0 =A0 =A0omap2_init_common_hw(NULL, omap3_mpu_rate_table,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rate_table, o=
map3_l3_rate_table, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_dsp_rate_table, o=
map3_l3_rate_table, NULL, NULL);
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0 =A0 =A0 =A0omap_gpio_init();
> =A0}
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 7bbec90..3d6c55a 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -60,6 +60,30 @@ struct omap3_processor_cx omap3_power_states[OMAP3=
_MAX_STATES];
> =A0struct omap3_processor_cx current_cx_state;
> =A0struct powerdomain *mpu_pd, *core_pd, *per_pd;
>
> +/*
> + * The latencies/thresholds for various C states have
> + * to be configured from the respective board files.
> + * These are some default values (which might not provide
> + * the best power savings) used on boards which do not
> + * pass these details from the board file.
> + */
> +static struct cpuidle_params cpuidle_params_table[] =3D {
> + =A0 =A0 =A0 /* C1 */
> + =A0 =A0 =A0 {2, 2, 5},
> + =A0 =A0 =A0 /* C2 */
> + =A0 =A0 =A0 {10, 10, 30},
> + =A0 =A0 =A0 /* C3 */
> + =A0 =A0 =A0 {50, 50, 300},
> + =A0 =A0 =A0 /* C4 */
> + =A0 =A0 =A0 {1500, 1800, 4000},
> + =A0 =A0 =A0 /* C5 */
> + =A0 =A0 =A0 {2500, 7500, 12000},
> + =A0 =A0 =A0 /* C6 */
> + =A0 =A0 =A0 {3000, 8500, 15000},
> + =A0 =A0 =A0 /* C7 */
> + =A0 =A0 =A0 {10000, 30000, 300000},
> +};
> +
> =A0static int omap3_idle_bm_check(void)
> =A0{
> =A0 =A0 =A0 =A0if (!omap3_can_sleep())
> @@ -165,6 +189,24 @@ static int omap3_enter_idle_bm(struct cpuidle_de=
vice *dev,
>
> =A0DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>
> +void omap3_set_idle_params(struct cpuidle_params *cpuidle_board_para=
ms)
> +{
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 if (!cpuidle_board_params)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 for (i =3D OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[i].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cpuidle_board_params[i].sleep_latency;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[i].wake_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cpuidle_board_params[i].wake_latency;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[i].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 cpuidle_board_params[i].threshold;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return;
> +}
> +
> =A0/* omap3_init_power_states - Initialises the OMAP3 specific C stat=
es.
> =A0*
> =A0* Below is the desciption of each C state.
> @@ -181,9 +223,12 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0/* C1 . MPU WFI + Core active */
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C1].valid =3D 1;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C1].type =3D OMAP3_STAT=
E_C1;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C1].sleep_latency =3D 2;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C1].wakeup_latency =3D 2=
;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C1].threshold =3D 5;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C1].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C1].sleep_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C1].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C1].wake_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C1].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C1].threshold;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C1].mpu_state =3D PWRDM=
_POWER_ON;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C1].core_state =3D PWRD=
M_POWER_ON;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C1].flags =3D CPUIDLE_F=
LAG_TIME_VALID;
> @@ -191,9 +236,12 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0/* C2 . MPU WFI + Core inactive */
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C2].valid =3D 1;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C2].type =3D OMAP3_STAT=
E_C2;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C2].sleep_latency =3D 10=
;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C2].wakeup_latency =3D 1=
0;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C2].threshold =3D 30;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C2].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C2].sleep_latency;;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C2].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C2].wake_latency;;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C2].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C2].threshold;;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C2].mpu_state =3D PWRDM=
_POWER_ON;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C2].core_state =3D PWRD=
M_POWER_ON;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C2].flags =3D CPUIDLE_F=
LAG_TIME_VALID;
> @@ -201,9 +249,12 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0/* C3 . MPU CSWR + Core inactive */
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C3].valid =3D 1;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C3].type =3D OMAP3_STAT=
E_C3;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C3].sleep_latency =3D 50=
;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C3].wakeup_latency =3D 5=
0;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C3].threshold =3D 300;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C3].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C3].sleep_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C3].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C3].wake_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C3].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C3].threshold;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C3].mpu_state =3D PWRDM=
_POWER_RET;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C3].core_state =3D PWRD=
M_POWER_ON;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C3].flags =3D CPUIDLE_F=
LAG_TIME_VALID |
> @@ -212,9 +263,12 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0/* C4 . MPU OFF + Core inactive */
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C4].valid =3D 1;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C4].type =3D OMAP3_STAT=
E_C4;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C4].sleep_latency =3D 15=
00;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C4].wakeup_latency =3D 1=
800;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C4].threshold =3D 4000;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C4].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C4].sleep_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C4].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C4].wake_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C4].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C4].threshold;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C4].mpu_state =3D PWRDM=
_POWER_OFF;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C4].core_state =3D PWRD=
M_POWER_ON;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C4].flags =3D CPUIDLE_F=
LAG_TIME_VALID |
> @@ -223,9 +277,12 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0/* C5 . MPU CSWR + Core CSWR*/
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C5].valid =3D 1;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C5].type =3D OMAP3_STAT=
E_C5;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C5].sleep_latency =3D 25=
00;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C5].wakeup_latency =3D 7=
500;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C5].threshold =3D 12000;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C5].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C5].sleep_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C5].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C5].wake_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C5].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C5].threshold;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C5].mpu_state =3D PWRDM=
_POWER_RET;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C5].core_state =3D PWRD=
M_POWER_RET;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C5].flags =3D CPUIDLE_F=
LAG_TIME_VALID |
> @@ -234,9 +291,12 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0/* C6 . MPU OFF + Core CSWR */
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C6].valid =3D 1;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C6].type =3D OMAP3_STAT=
E_C6;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C6].sleep_latency =3D 30=
00;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C6].wakeup_latency =3D 8=
500;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C6].threshold =3D 15000;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C6].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C6].sleep_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C6].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C6].wake_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C6].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C6].threshold;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C6].mpu_state =3D PWRDM=
_POWER_OFF;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C6].core_state =3D PWRD=
M_POWER_RET;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C6].flags =3D CPUIDLE_F=
LAG_TIME_VALID |
> @@ -245,9 +305,12 @@ void omap_init_power_states(void)
> =A0 =A0 =A0 =A0/* C7 . MPU OFF + Core OFF */
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C7].valid =3D 1;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C7].type =3D OMAP3_STAT=
E_C7;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].sleep_latency =3D 10=
000;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].wakeup_latency =3D 3=
0000;
> - =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].threshold =3D 300000=
;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].sleep_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C7].sleep_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].wakeup_latency =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C7].wake_latency;
> + =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].threshold =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OM=
AP3_STATE_C7].threshold;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C7].mpu_state =3D PWRDM=
_POWER_OFF;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C7].core_state =3D PWRD=
M_POWER_OFF;
> =A0 =A0 =A0 =A0omap3_power_states[OMAP3_STATE_C7].flags =3D CPUIDLE_F=
LAG_TIME_VALID |
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 266a5a1..d8d10aa 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -283,13 +283,14 @@ void __init omap2_init_common_hw(struct omap_sd=
rc_params *sp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t omap_opp *mpu_opps,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t omap_opp *dsp_opps,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t omap_opp *l3_opps,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct prm_setup_vc *setup_times)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct prm_setup_vc *setup_times,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct cpuidle_params *idle_params)
> =A0{
> =A0 =A0 =A0 =A0omap2_mux_init();
> =A0#ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is=
 ready */
> =A0 =A0 =A0 =A0/* The OPP tables have to be registered before a clk i=
nit */
> =A0 =A0 =A0 =A0omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
> - =A0 =A0 =A0 omap_pm_early_init(setup_times);
> + =A0 =A0 =A0 omap_pm_early_init(setup_times, idle_params);
> =A0 =A0 =A0 =A0pwrdm_init(powerdomains_omap);
> =A0 =A0 =A0 =A0clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
> =A0 =A0 =A0 =A0omapdev_init(omapdevs);
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index b81ba3b..5c5c59e 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -236,10 +236,13 @@ unsigned get_last_off_on_transaction_id(struct =
device *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -void __init omap_pm_early_init(struct prm_setup_vc *setup_times)
> +void __init omap_pm_early_init(struct prm_setup_vc *setup_times,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct cpuidle_params *idle_params)
> =A0{
> - =A0 =A0 =A0 if (cpu_is_omap34xx())
> + =A0 =A0 =A0 if (cpu_is_omap34xx()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_set_prm_setup_vc(setup_times);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_set_idle_params(idle_params);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return;
> =A0}
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 0beb32d..8759053 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -31,6 +31,12 @@ struct prm_setup_vc {
> =A0 =A0 =A0 =A0u16 vdd1_off;
> =A0};
>
> +struct cpuidle_params {
> + =A0 =A0 =A0 u32 sleep_latency;
> + =A0 =A0 =A0 u32 wake_latency;
> + =A0 =A0 =A0 u32 threshold;
> +};
> +
> =A0#ifdef CONFIG_ARCH_OMAP3
> =A0extern unsigned short enable_dyn_sleep;
> =A0extern unsigned short enable_off_mode;
> @@ -43,6 +49,7 @@ extern int set_pwrdm_state(struct powerdomain *pwrd=
m, u32 state);
> =A0extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
> =A0extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, i=
nt state);
> =A0extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
> +extern void omap3_set_idle_params(struct cpuidle_params *cpuidle_boa=
rd_params);
> =A0#ifdef CONFIG_CPU_IDLE
> =A0int omap3_idle_init(void);
> =A0#else
> @@ -51,8 +58,10 @@ static inline int omap3_idle_init(void) { return 0=
; }
>
> =A0#else /* CONFIG_ARCH_OMAP3 */
> =A0#define omap3_set_prm_setup_vc(setup_vc) do {} while (0);
> +#define omap3_set_idle_params(parmas, board_params) do {} while (0);
>
> =A0#endif /* CONFIG_ARCH_OMAP3 */
> +
> =A0extern int resource_set_opp_level(int res, u32 target_level, int f=
lags);
> =A0extern int resource_access_opp_lock(int res, int delta);
> =A0#define resource_lock_opp(res) resource_access_opp_lock(res, 1)
> @@ -91,6 +100,7 @@ extern unsigned int omap34xx_suspend_sz;
> =A0extern unsigned int save_secure_ram_context_sz;
> =A0extern unsigned int omap24xx_cpu_suspend_sz;
> =A0extern unsigned int omap34xx_cpu_suspend_sz;
> -void __init omap_pm_early_init(struct prm_setup_vc *setup_times);
> +void __init omap_pm_early_init(struct prm_setup_vc *setup_times,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct cpuidle_params *idle_params);
>
> =A0#endif
> diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-oma=
p/include/mach/io.h
> index 3582bef..d143bd9 100644
> --- a/arch/arm/plat-omap/include/mach/io.h
> +++ b/arch/arm/plat-omap/include/mach/io.h
> @@ -225,6 +225,7 @@
> =A0struct omap_sdrc_params;
> =A0struct omap_opp;
> =A0struct prm_setup_vc;
> +struct cpuidle_params;
>
> =A0extern void omap1_map_common_io(void);
> =A0extern void omap1_init_common_hw(void);
> @@ -234,7 +235,8 @@ extern void omap2_init_common_hw(struct omap_sdrc=
_params *sp,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t omap_opp *mpu_opps,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t omap_opp *dsp_opps,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t omap_opp *l3_opps,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct prm_setup_vc *setup_times);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct prm_setup_vc *setup_times,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct cpuidle_params *idle_params);
>
> =A0#define __arch_ioremap(p,s,t) =A0omap_ioremap(p,s,t)
> =A0#define __arch_iounmap(v) =A0 =A0 =A0omap_iounmap(v)
> --
> 1.5.4.7
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
