From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 06/12] arm: omap3: am35x: Add full PWRDM_POWER_INACTIVE support
Date: Wed, 11 Apr 2012 22:56:01 +0200
Message-ID: <CAORVsuW2Nax4h+SxEJ6dLM1AopAFPQjvK0FHa9N5mEEVCStpQw@mail.gmail.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
	<1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65364 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032Ab2DKU4B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 16:56:01 -0400
Received: by vcqp1 with SMTP id p1so908276vcq.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 13:56:01 -0700 (PDT)
In-Reply-To: <1334171147-7517-7-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

Hi Mark,

On Wed, Apr 11, 2012 at 9:05 PM, Mark A. Greer <mgreer@animalcreek.com>=
 wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> The am35x family of SoCs only support PWRDM_POWER_ON
> and PWRDM_POWER_INACTIVE power states. This causes
> an issue in some areas of the OMAP3 power-related
> code because of assumptions that PWRDM_POWER_RET
> and/or PWRDM_POWER_OFF are always valid states.
>
> To get am35x SoCs to work properly, add missing support
> for PWRDM_POWER_INACTIVE and remove assumptions that
> PWRDM_POWER_RET and PWRDM_POWER_OFF are always valid states.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

I just posted a patch set '[RFC/PATCH v2 0/6] ARM: OMAP2+: PM:
introduce the power domains functional states' [1] which I think
should be used to base your patches on. This patch set introduces
functional states for the power domains power ans logic states, and
the conversion functions between the internal power and logic states
and the functional states.

I would be glad to help on the AM35x support for the functional states.

What do you think?

[1] http://marc.info/?l=3Dlinux-omap&m=3D133417729712693&w=3D2

Regards,
Jean

> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 29 +++++++++++++++++++++++=
--
> =A0arch/arm/mach-omap2/pm-debug.c =A0 =A0| =A0 =A08 +++++--
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 43 +++++++++++++++++=
++++++--------------
> =A03 files changed, 60 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 12cf81d..187872a 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -175,12 +175,23 @@ static int next_valid_state(struct cpuidle_devi=
ce *dev,
> =A0 =A0 =A0 =A0struct cpuidle_state_usage *curr_usage =3D &dev->state=
s_usage[index];
> =A0 =A0 =A0 =A0struct cpuidle_state *curr =3D &drv->states[index];
> =A0 =A0 =A0 =A0struct omap3_idle_statedata *cx =3D cpuidle_get_stated=
ata(curr_usage);
> - =A0 =A0 =A0 u32 mpu_deepest_state =3D PWRDM_POWER_RET;
> - =A0 =A0 =A0 u32 core_deepest_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 u32 mpu_deepest_state;
> + =A0 =A0 =A0 u32 core_deepest_state;
> =A0 =A0 =A0 =A0int next_index =3D -1;
>
> + =A0 =A0 =A0 if (omap3_has_pwroff()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpu_deepest_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_deepest_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpu_deepest_state =3D PWRDM_POWER_INACT=
IVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_deepest_state =3D PWRDM_POWER_INAC=
TIVE;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (enable_off_mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(!omap3_has_pwroff());
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpu_deepest_state =3D PWRDM_POWER_OFF;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Erratum i583: valable for ES rev < =
Es1.2 on 3630.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * CORE OFF mode is not supported in a=
 stable form, restrict
> @@ -311,6 +322,9 @@ void omap3_pm_init_cpuidle(struct cpuidle_params =
*cpuidle_board_params)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpuidle_board_params[i=
].exit_latency;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpuidle_params_table[i].target_residen=
cy =3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cpuidle_board_params[i=
].target_residency;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(!omap3_has_pwroff() && (i >=3D =
2) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle=
_params_table[i].valid);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return;
> =A0}
> @@ -349,6 +363,16 @@ static inline struct omap3_idle_statedata *_fill=
_cstate_usage(
> =A0 =A0 =A0 =A0return cx;
> =A0}
>
> +/* Only C1 & C2 C states valid when RET & OFF states aren't supporte=
d */
> +static void omap3_cstate_valid_fixup(void)
> +{
> + =A0 =A0 =A0 int idx;
> +
> + =A0 =A0 =A0 if (!omap3_has_pwroff())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (idx =3D 2; idx < OMAP3_NUM_STATES;=
 idx++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[id=
x].valid =3D 0;
> +}
> +
> =A0/**
> =A0* omap3_idle_init - Init routine for OMAP3 idle
> =A0*
> @@ -366,6 +390,7 @@ int __init omap3_idle_init(void)
> =A0 =A0 =A0 =A0per_pd =3D pwrdm_lookup("per_pwrdm");
> =A0 =A0 =A0 =A0cam_pd =3D pwrdm_lookup("cam_pwrdm");
>
> + =A0 =A0 =A0 omap3_cstate_valid_fixup();
>
> =A0 =A0 =A0 =A0drv->safe_state_index =3D -1;
> =A0 =A0 =A0 =A0dev =3D &per_cpu(omap3_idle_dev, smp_processor_id());
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-=
debug.c
> index 814bcd9..339ed42 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -239,19 +239,23 @@ static int option_get(void *data, u64 *val)
> =A0static int option_set(void *data, u64 val)
> =A0{
> =A0 =A0 =A0 =A0u32 *option =3D data;
> + =A0 =A0 =A0 int ret =3D -EINVAL;
>
> =A0 =A0 =A0 =A0*option =3D val;
>
> - =A0 =A0 =A0 if (option =3D=3D &enable_off_mode) {
> + =A0 =A0 =A0 if (omap3_has_pwroff() && (option =3D=3D &enable_off_mo=
de)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (val)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_pm_enable_off_mod=
e();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_pm_disable_off_mo=
de();
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cpu_is_omap34xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_pm_off_mode_enab=
le(val);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return ret;
> =A0}
>
> =A0DEFINE_SIMPLE_ATTRIBUTE(pm_dbg_option_fops, option_get, option_set=
, "%llu\n");
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index b7bbcee..00c4abe 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -279,6 +279,7 @@ void omap_sram_idle(void)
> =A0 =A0 =A0 =A0mpu_next_state =3D pwrdm_read_next_pwrst(mpu_pwrdm);
> =A0 =A0 =A0 =A0switch (mpu_next_state) {
> =A0 =A0 =A0 =A0case PWRDM_POWER_ON:
> + =A0 =A0 =A0 case PWRDM_POWER_INACTIVE:
> =A0 =A0 =A0 =A0case PWRDM_POWER_RET:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* No need to save context */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0save_state =3D 0;
> @@ -614,6 +615,8 @@ void omap3_pm_off_mode_enable(int enable)
> =A0 =A0 =A0 =A0struct power_state *pwrst;
> =A0 =A0 =A0 =A0u32 state;
>
> + =A0 =A0 =A0 WARN_ON(!omap3_has_pwroff());
> +
> =A0 =A0 =A0 =A0if (enable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state =3D PWRDM_POWER_OFF;
> =A0 =A0 =A0 =A0else
> @@ -668,7 +671,12 @@ static int __init pwrdms_setup(struct powerdomai=
n *pwrdm, void *unused)
> =A0 =A0 =A0 =A0if (!pwrst)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0pwrst->pwrdm =3D pwrdm;
> - =A0 =A0 =A0 pwrst->next_state =3D PWRDM_POWER_RET;
> +
> + =A0 =A0 =A0 if (omap3_has_pwroff())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst->next_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst->next_state =3D PWRDM_POWER_INACT=
IVE;
> +
> =A0 =A0 =A0 =A0list_add(&pwrst->node, &pwrst_list);
>
> =A0 =A0 =A0 =A0if (pwrdm_has_hdwr_sar(pwrdm))
> @@ -781,25 +789,28 @@ static int __init omap3_pm_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3630_ctrl_disable_rta();
>
> =A0 =A0 =A0 =A0clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
> - =A0 =A0 =A0 if (omap_type() !=3D OMAP2_DEVICE_TYPE_GP) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_secure_ram_storage =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc(0x803F, GFP_KER=
NEL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!omap3_secure_ram_storage)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Memory allocati=
on failed when "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"allocat=
ing for secure sram context\n");
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq_disable();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_fiq_disable();
> + =A0 =A0 =A0 if (omap3_has_pwroff()) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_type() !=3D OMAP2_DEVICE_TYPE_=
GP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_secure_ram_storag=
e =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kmalloc=
(0x803F, GFP_KERNEL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!omap3_secure_ram_s=
torage)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"Memory allocation failed when "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"allocating for secure sram context\n");
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_global_context_save();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_save_secure_ram_context();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_global_context_restore();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq_disable();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_fiq_disable();
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq_enable();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_fiq_enable();
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_global_context=
_save();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_save_secure_ram_c=
ontext();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_dma_global_context=
_restore();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq_enable();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_fiq_enable();
>
> - =A0 =A0 =A0 omap3_save_scratchpad_contents();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_save_scratchpad_c=
ontents();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return ret;
>
> =A0err3:
> --
> 1.7.9.4
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
