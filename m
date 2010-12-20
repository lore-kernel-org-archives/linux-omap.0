From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v4 7/7] OMAP3630: PM: Erratum i583: disable coreoff if < ES1.2
Date: Mon, 20 Dec 2010 11:26:03 +0100
Message-ID: <AANLkTi=z-RkhnFymMn_ZLJgUoZ3y_nVSvh=vmmLjie9D@mail.gmail.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-8-git-send-email-nm@ti.com>
	<7a43d84df0170f80e31c3e3f3eb8b249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64861 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab0LTK0E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Dec 2010 05:26:04 -0500
Received: by qwa26 with SMTP id 26so2626563qwa.19
        for <linux-omap@vger.kernel.org>; Mon, 20 Dec 2010 02:26:03 -0800 (PST)
In-Reply-To: <7a43d84df0170f80e31c3e3f3eb8b249@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@deeprootsystems.com>, Tony <tony@atomide.com>

On Mon, Dec 20, 2010 at 7:51 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Nishanth Menon
>> Sent: Sunday, December 19, 2010 4:24 AM
>> To: linux-omap; linux-arm
>> Cc: Jean Pihet; Kevin; Tony
>> Subject: [PATCH v4 7/7] OMAP3630: PM: Erratum i583: disable coreoff =
if <
>> ES1.2
>>
>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
>>
>> Limitation i583: Self_Refresh Exit issue after OFF mode
>>
>> Issue:
>> When device is waking up from OFF mode, then SDRC state machine send=
s
>> inappropriate sequence violating JEDEC standards.
>>
>> Impact:
>> OMAP3630 < ES1.2 is impacted as follows depending on the platform:
>> CS0: for 38.4MHz as internal sysclk, DDR content seen to be stable,
> while
>> =A0 =A0 =A0 for all other sysclk frequencies, varied levels of insta=
bility
>> =A0 =A0 =A0 seen based on varied parameters.
>> CS1: impacted
>>
>> This patch takes option #3 as recommended by the Silicon erratum:
>> Avoid core power domain transitioning to OFF mode. Power consumption
>> impact is expected in this case.
>> To do this, we route core OFF requests to RET request on the impacte=
d
>> revisions of silicon.
>>
>> [nm@ti.com: rebased the code to 2.6.37-rc2- short circuit code chang=
ed a
>> bit]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
>> ---
>> v4: idle state control changed a bit -we wont register or enable
>> =A0 =A0 the states which cannot be enabled.
>> v3: http://marc.info/?t=3D129140247800027&r=3D1&w=3D2
>> =A0 =A0 no functional change in erratum wa implementation, just regi=
stration
>> of
>> =A0 =A0 =A0 erratum is collated to a single cpu detection and versio=
n check
>> v2: https://patchwork.kernel.org/patch/365262/
>> =A0 =A0 rebased to this patch series instead of depending on hs chan=
ges
>> =A0 =A0 fix typo for macro definition
>> v1: http://marc.info/?l=3Dlinux-omap&m=3D129013173425266&w=3D2
>> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 10 ++++++++++
>> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0arch/arm/mach-omap2/pm34xx.c =A0 =A0 =A0| =A0 24 ++++++++++++++++=
+++++---
>> =A03 files changed, 32 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-
>> omap2/cpuidle34xx.c
>> index f80d3f6..1b32e98 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -453,6 +453,16 @@ void omap_init_power_states(void)
>> =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].core_state =3D PWRDM_=
POWER_OFF;
>> =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].flags =3D CPUIDLE_FLA=
G_TIME_VALID
> |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CPUIDLE_=
=46LAG_CHECK_BM;
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Erratum i583: implementation for ES rev < Es1.2 on 36=
30. We
>> cannot
>> + =A0 =A0 =A0* enable OFF mode in a stable form for previous revisio=
ns.
>> + =A0 =A0 =A0* we disable C7 state as a result.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_power_states[OMAP3_STATE_C7].valid =3D=
 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_params_table[OMAP3_STATE_C7].valid=
 =3D 0;
> WARN_ONCE in IDLE also would be good.

Agree on the WARN_ONCE remarks.

Other than that:
Acked-by: Jean Pihet <j-pihet@ti.com>

>> + =A0 =A0 }
>> =A0}
>>
>> =A0struct cpuidle_driver omap3_idle_driver =3D {
>> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
>> index 92ef400..9032d09 100644
>> --- a/arch/arm/mach-omap2/pm.h
>> +++ b/arch/arm/mach-omap2/pm.h
>> @@ -87,6 +87,7 @@ extern unsigned int omap24xx_cpu_suspend_sz;
>> =A0extern unsigned int omap34xx_cpu_suspend_sz;
>>
>> =A0#define PM_RTA_ERRATUM_i608 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +#define PM_SDRC_WAKEUP_ERRATUM_i583 =A0(1 << 1)
>>
>> =A0#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
>> =A0extern u16 pm34xx_errata;
>> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34=
xx.c
>> index 21cd36e..7faea55 100644
>> --- a/arch/arm/mach-omap2/pm34xx.c
>> +++ b/arch/arm/mach-omap2/pm34xx.c
>> @@ -928,12 +928,28 @@ void omap3_pm_off_mode_enable(int enable)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D PWRDM_POWER_RET;
>>
>> =A0#ifdef CONFIG_CPU_IDLE
>> - =A0 =A0 omap3_cpuidle_update_states(state, state);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Erratum i583: implementation for ES rev < Es1.2 on 36=
30. We
>> cannot
>> + =A0 =A0 =A0* enable OFF mode in a stable form for previous revisio=
ns,
> restrict
>> + =A0 =A0 =A0* instead to RET
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_cpuidle_update_states(state, PWRDM_P=
OWER_RET);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap3_cpuidle_update_states(state, state);
>> =A0#endif
>>
>> =A0 =A0 =A0 list_for_each_entry(pwrst, &pwrst_list, node) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 pwrst->next_state =3D state;
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_set_pwrdm_state(pwrst->pwrdm, state);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRAT=
UM_i583) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst->pwr=
dm =3D=3D core_pwrdm &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D=3D=
 PWRDM_POWER_OFF) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst->next_state =3D PWRD=
M_POWER_RET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Core OFF disab=
led due to errata
> i583\n",
> Shoud we do this in every iteration or just WARN_ONCE do ??
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst->next_state =3D stat=
e;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_set_pwrdm_state(pwrst->pwrdm, pwrst->=
next_state);
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -1011,6 +1027,8 @@ static void __init pm_errata_configure(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm34xx_errata |=3D PM_RTA_ERRATUM_i608;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable the l2 cache toggling in sleep=
 logic */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 enable_omap3630_toggle_l2_on_restore();
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (omap_rev() < OMAP3630_REV_ES1_2)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm34xx_errata |=3D PM_SDRC=
_WAKEUP_ERRATUM_i583;
>> =A0 =A0 =A0 }
>> =A0}
>>
>> --
>> 1.6.3.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
