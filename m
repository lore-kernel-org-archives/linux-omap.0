From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] arm: omap: Use only valid power domain states
Date: Tue, 1 May 2012 10:47:35 +0200
Message-ID: <CAORVsuUJQOL-aTaGdo6VsOGm3ZHU=nWinQYrP70Lx0kG6G34TQ@mail.gmail.com>
References: <1335821126-12994-1-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35184 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab2EAIrg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 May 2012 04:47:36 -0400
Received: by vbbff1 with SMTP id ff1so2633352vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 01:47:35 -0700 (PDT)
In-Reply-To: <1335821126-12994-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

Hi Mark,

On Mon, Apr 30, 2012 at 11:25 PM, Mark A. Greer <mgreer@animalcreek.com=
> wrote:
> From: "Mark A. Greer" <mgreer@animalcreek.com>
>
> Some parts of the OMAP code assume that all power
> domains support certain states (e.g., RET & OFF).
> This isn't always true (e.g., the am35x family of
> SoC's) so those assumptions need to be removed.
>
> Remove those assumptions by looking up the deepest
> state that a power domain can be in whereever its
> being blindly set. =A0The 'max()' of the deepest
> state and what the code formerly wanted to set it
> to, is the correct state. =A0If the code formerly
> wanted to set it to PWRDM_POWER_OFF, then the
> deepest possible state will be used (i.e., no
> need to perform the 'max()').
>
> The code still assumes that ON is a valid state.
>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> ---
>
> These patches apply on top of Kevin's patch series,
> =A0 =A0 =A0"[PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC fami=
ly detection"
>
> Tested on an am3517 evm and am37x evm.
>
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 19 +++++++++++++------
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 15 +++++++++------
> =A0arch/arm/mach-omap2/powerdomain.c | =A0 25 +++++++++++++++++++++++=
++
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 =A02 ++
> =A04 files changed, 49 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 5358664..2c91711 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -175,19 +175,25 @@ static int next_valid_state(struct cpuidle_devi=
ce *dev,
> =A0 =A0 =A0 =A0struct cpuidle_state_usage *curr_usage =3D &dev->state=
s_usage[index];
> =A0 =A0 =A0 =A0struct cpuidle_state *curr =3D &drv->states[index];
> =A0 =A0 =A0 =A0struct omap3_idle_statedata *cx =3D cpuidle_get_stated=
ata(curr_usage);
> - =A0 =A0 =A0 u32 mpu_deepest_state =3D PWRDM_POWER_RET;
> - =A0 =A0 =A0 u32 core_deepest_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 u32 mpu_deepest_state, mpu_deepest_possible;
> + =A0 =A0 =A0 u32 core_deepest_state, core_deepest_possible;
> =A0 =A0 =A0 =A0int next_index =3D -1;
>
> + =A0 =A0 =A0 mpu_deepest_possible =3D pwrdm_get_deepest_state(mpu_pd=
);
> + =A0 =A0 =A0 mpu_deepest_state =3D max_t(u32, mpu_deepest_possible, =
PWRDM_POWER_RET);
I do not think you need to change the pwrdm API and the cpuidle code fo=
r that.

Instead you should use the pwrst* fields in the power domains data
files, which allow to specify the allowed states.
After reading the rest of your patches it seems you are addressing the
issue in a subsequent patch 'arm: omap3: am35x: Set proper powerdomain
states'.

> +
> + =A0 =A0 =A0 core_deepest_possible =3D pwrdm_get_deepest_state(core_=
pd);
> + =A0 =A0 =A0 core_deepest_state =3D max_t(u32, core_deepest_possible=
, PWRDM_POWER_RET);
> +
> =A0 =A0 =A0 =A0if (enable_off_mode) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpu_deepest_state =3D PWRDM_POWER_OFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpu_deepest_state =3D mpu_deepest_possi=
ble;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Erratum i583: valable for ES rev < =
Es1.2 on 3630.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * CORE OFF mode is not supported in a=
 stable form, restrict
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * instead the CORE state to RET.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_=
ERRATUM_i583))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_deepest_state =3D =
PWRDM_POWER_OFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 core_deepest_state =3D =
core_deepest_possible;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Check if current state is valid */
> @@ -422,8 +428,9 @@ int __init omap3_idle_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warn("%s: core off state C7 disable=
d due to i583\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 cx->mpu_state =3D PWRDM_POWER_OFF;
> - =A0 =A0 =A0 cx->core_state =3D PWRDM_POWER_OFF;
> +
> + =A0 =A0 =A0 cx->mpu_state =3D pwrdm_get_deepest_state(mpu_pd);
> + =A0 =A0 =A0 cx->core_state =3D pwrdm_get_deepest_state(core_pd);
>
> =A0 =A0 =A0 =A0drv->state_count =3D OMAP3_NUM_STATES;
> =A0 =A0 =A0 =A0cpuidle_register_driver(&omap3_idle_driver);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index ec92676..40d8d07 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -614,12 +614,11 @@ void omap3_pm_off_mode_enable(int enable)
> =A0 =A0 =A0 =A0struct power_state *pwrst;
> =A0 =A0 =A0 =A0u32 state;
>
> - =A0 =A0 =A0 if (enable)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D PWRDM_POWER_OFF;
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D PWRDM_POWER_RET;
> -
> =A0 =A0 =A0 =A0list_for_each_entry(pwrst, &pwrst_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D pwrdm_get_deepest_state(pwrst=
->pwrdm);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D max_t(u32, st=
ate, PWRDM_POWER_RET);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_E=
RRATUM_i583) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrst-=
>pwrdm =3D=3D core_pwrdm &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state =
=3D=3D PWRDM_POWER_OFF) {
> @@ -660,6 +659,7 @@ int omap3_pm_set_suspend_state(struct powerdomain=
 *pwrdm, int state)
> =A0static int __init pwrdms_setup(struct powerdomain *pwrdm, void *un=
used)
> =A0{
> =A0 =A0 =A0 =A0struct power_state *pwrst;
> + =A0 =A0 =A0 u32 state;
>
> =A0 =A0 =A0 =A0if (!pwrdm->pwrsts)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> @@ -668,7 +668,10 @@ static int __init pwrdms_setup(struct powerdomai=
n *pwrdm, void *unused)
> =A0 =A0 =A0 =A0if (!pwrst)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0pwrst->pwrdm =3D pwrdm;
> - =A0 =A0 =A0 pwrst->next_state =3D PWRDM_POWER_RET;
> +
> + =A0 =A0 =A0 state =3D pwrdm_get_deepest_state(pwrdm);
> + =A0 =A0 =A0 pwrst->next_state =3D max_t(u32, state, PWRDM_POWER_RET=
);
> +
> =A0 =A0 =A0 =A0list_add(&pwrst->node, &pwrst_list);
>
> =A0 =A0 =A0 =A0if (pwrdm_has_hdwr_sar(pwrdm))
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index 96ad3dbe..9c80c19 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -1078,3 +1078,28 @@ bool pwrdm_can_ever_lose_context(struct powerd=
omain *pwrdm)
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +/**
> + * pwrdm_get_deepest_state - Get deepest valid state domain can ente=
r
> + * @pwrdm: struct powerdomain *
> + *
> + * Find and return the deepest valid state a power domain can be in.
> + * Returns the deepest state that @pwrdm can enter.
> + */
> +u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 u32 valid_states, deepest_state;
> +
> + =A0 =A0 =A0 valid_states =3D pwrdm->pwrsts;
> +
> + =A0 =A0 =A0 if (valid_states & PWRSTS_OFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_OFF;
> + =A0 =A0 =A0 else if (valid_states & PWRSTS_RET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 else if (valid_states & PWRSTS_INACTIVE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_INACTIVE;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 deepest_state =3D PWRDM_POWER_ON;
> +
> + =A0 =A0 =A0 return deepest_state;
> +}

The pwrdm API already performs those checks on pwrst*, cf.
pwrdm_set_next_pwrst for example.

So to summarize I think the code duplication should be avoided.

Regards,
Jean

> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index 0d72a8a..9688ff1 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -220,6 +220,8 @@ int pwrdm_set_lowpwrstchange(struct powerdomain *=
pwrdm);
> =A0int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
> =A0bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
>
> +u32 pwrdm_get_deepest_state(struct powerdomain *pwrdm);
> +
> =A0extern void omap242x_powerdomains_init(void);
> =A0extern void omap243x_powerdomains_init(void);
> =A0extern void omap3xxx_powerdomains_init(void);
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
