From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 6/7] OMAP3: PM: make omap3_cpuidle_update_states
 independent of enable_off_mode
Date: Mon, 20 Dec 2010 11:28:45 +0100
Message-ID: <AANLkTi=ANt1_SeX1322g1pm0RZcRa5dyiMD2iK8bcnbG@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-7-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48437 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636Ab0LTK2q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:28:46 -0500
Received: by qwa26 with SMTP id 26so2628731qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:28:45 -0800 (PST)
In-Reply-To: <1292712817-24999-7-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

On Sat, Dec 18, 2010 at 11:53 PM, Nishanth Menon <nm@ti.com> wrote:
> Currently omap3_cpuidle_update_states makes whole sale decision
> on which C states to update based on enable_off_mode variable
> Instead, achieve the same functionality by independently providing
> mpu and core deepest states the system is allowed to achieve and
> update the idle states accordingly.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Acked-by: Jean Pihet <j-pihet@ti.com>

> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 19 ++++++++++---------
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0| =A0 =A03 ++-
> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 =A02 +-
> =A03 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/=
cpuidle34xx.c
> index 0d50b45..f80d3f6 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -293,25 +293,26 @@ select_state:
> =A0DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>
> =A0/**
> - * omap3_cpuidle_update_states - Update the cpuidle states.
> + * omap3_cpuidle_update_states() - Update the cpuidle states
> + * @mpu_deepest_state: Enable states upto and including this for mpu=
 domain
> + * @core_deepest_state: =A0 =A0 =A0 =A0Enable states upto and includ=
ing this for core domain
> =A0*
> - * Currently, this function toggles the validity of idle states base=
d upon
> - * the flag 'enable_off_mode'. When the flag is set all states are v=
alid.
> - * Else, states leading to OFF state set to be invalid.
> + * This goes through the list of states available and enables and di=
sables the
> + * validity of C states based on deepest state that can be achieved =
for the
> + * variable domain
> =A0*/
> -void omap3_cpuidle_update_states(void)
> +void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_dee=
pest_state)
> =A0{
> =A0 =A0 =A0 =A0int i;
>
> =A0 =A0 =A0 =A0for (i =3D OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) =
{
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap3_processor_cx *cx =3D &oma=
p3_power_states[i];
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (enable_off_mode) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((cx->mpu_state >=3D mpu_deepest_sta=
te) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cx->core_state >=3D core_deepe=
st_state)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cx->valid =3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((cx->mpu_state =3D=3D=
 PWRDM_POWER_OFF) ||
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cx->co=
re_state =3D=3D PWRDM_POWER_OFF))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cx->val=
id =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cx->valid =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> =A0}
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 5e0bee9..92ef400 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -58,7 +58,8 @@ extern u32 sleep_while_idle;
> =A0#endif
>
> =A0#if defined(CONFIG_CPU_IDLE)
> -extern void omap3_cpuidle_update_states(void);
> +extern void omap3_cpuidle_update_states(u32 core_deepest_state,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 core_deepest_state);
> =A0#endif
>
> =A0#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> index 4ba7a06..21cd36e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -928,7 +928,7 @@ void omap3_pm_off_mode_enable(int enable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0state =3D PWRDM_POWER_RET;
>
> =A0#ifdef CONFIG_CPU_IDLE
> - =A0 =A0 =A0 omap3_cpuidle_update_states();
> + =A0 =A0 =A0 omap3_cpuidle_update_states(state, state);
> =A0#endif
>
> =A0 =A0 =A0 =A0list_for_each_entry(pwrst, &pwrst_list, node) {
> --
> 1.6.3.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
