From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional states
Date: Fri, 15 Jun 2012 13:20:36 +0200
Message-ID: <CAORVsuVwsDfXRdxyXUb-MR3w6DFcXzAmcriSfooe6855Ys8v8A@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
	<1339685591-11177-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64288 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752771Ab2FOLUi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 07:20:38 -0400
Received: by lahd3 with SMTP id d3so1980759lah.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 04:20:36 -0700 (PDT)
In-Reply-To: <1339685591-11177-3-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>, Nishanth Menon <nm@ti.com>

Hi,

Here are some remarks I got after an internal review. I think those
points need to be discussed with a broader audience.

On Thu, Jun 14, 2012 at 4:53 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Introduce functional (or logical) states for power domains and the
> API functions to read the power domains settings and to convert
> between the functional (i.e. logical) and the internal (or registers)
> values.
>
> OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine.
>
> In the new API only the function omap_set_pwrdm_state shall be used
> to change a power domain target state, along with the associated
> PWRDM_FUNC_* macros as the state parameters.
> While at it the function is moved to the power domains code.
>
> The power domain API in powerdomain.h is split in the external and th=
e
> internal parts; only the external API functions and defines shall be =
used
> by external code, the internal API is only to be used in powerdomain*=
=2E[ch]
> files.
>
> The memory and logic states are not using the functional states, this
> comes as a subsequent patch.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 66 -----------
> =A0arch/arm/mach-omap2/pm.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 -
> =A0arch/arm/mach-omap2/powerdomain-common.c =A0 | =A0 71 +++++++++++
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0| =A0174 ++++=
++++++++++++++++++++++++
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0| =A0 77 ++++=
+++++----
> =A0arch/arm/mach-omap2/powerdomain2xxx_3xxx.c | =A0 =A05 +
> =A0arch/arm/mach-omap2/powerdomain44xx.c =A0 =A0 =A0| =A0 =A02 +
> =A07 files changed, 306 insertions(+), 90 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index a05f00c..dfe702b 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -74,10 +74,6 @@ static void __init omap2_init_processor_devices(vo=
id)
> =A0 =A0 =A0 =A0}
> =A0}
>
> -/* Types of sleep_switch used in omap_set_pwrdm_state */
> -#define FORCEWAKEUP_SWITCH =A0 =A0 0
> -#define LOWPOWERSTATE_SWITCH =A0 1
> -
> =A0int __init omap_pm_clkdms_setup(struct clockdomain *clkdm, void *u=
nused)
> =A0{
> =A0 =A0 =A0 =A0if (clkdm->flags & CLKDM_CAN_ENABLE_AUTO)
> @@ -89,68 +85,6 @@ int __init omap_pm_clkdms_setup(struct clockdomain=
 *clkdm, void *unused)
> =A0}
>
> =A0/*
> - * This sets pwrdm state (other than mpu & core. Currently only ON &
> - * RET are supported.
> - */
> -int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 pwrst)
> -{
> - =A0 =A0 =A0 u8 curr_pwrst, next_pwrst;
> - =A0 =A0 =A0 int sleep_switch =3D -1, ret =3D 0, hwsup =3D 0;
> -
> - =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> -
> - =A0 =A0 =A0 mutex_lock(&pwrdm->lock);
> -
> - =A0 =A0 =A0 while (!(pwrdm->pwrsts & (1 << pwrst))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrst =3D=3D PWRDM_POWER_OFF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst--;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);
> - =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> -
> - =A0 =A0 =A0 curr_pwrst =3D pwrdm_read_pwrst(pwrdm);
> - =A0 =A0 =A0 if (curr_pwrst < PWRDM_POWER_ON) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((curr_pwrst > pwrst) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pwrdm->flags & PWRDM_H=
AS_LOWPOWERSTATECHANGE)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D LOWPOW=
ERSTATE_SWITCH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwsup =3D clkdm_in_hwsu=
p(pwrdm->pwrdm_clkdms[0]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_wakeup(pwrdm->pwr=
dm_clkdms[0]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D FORCEW=
AKEUP_SWITCH;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 ret =3D pwrdm_set_next_pwrst(pwrdm, pwrst);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to set power state o=
f powerdomain: %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name);
> -
> - =A0 =A0 =A0 switch (sleep_switch) {
> - =A0 =A0 =A0 case FORCEWAKEUP_SWITCH:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hwsup)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(pwrdm-=
>pwrdm_clkdms[0]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_sleep(pwrdm->pwrd=
m_clkdms[0]);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 case LOWPOWERSTATE_SWITCH:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_lowpwrstchange(pwrdm);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_wait_transition(pwrdm);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_state_switch(pwrdm);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 }
> -
> -out:
> - =A0 =A0 =A0 mutex_unlock(&pwrdm->lock);
> - =A0 =A0 =A0 return ret;
> -}
> -
> -
> -
> -/*
> =A0* This API is to be called during init to set the various voltage
> =A0* domains to the voltage as per the opp table. Typically we boot u=
p
> =A0* at the nominal voltage. So this function finds out the rate of
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 7856489..5bc0848 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -18,7 +18,6 @@
> =A0extern void *omap3_secure_ram_storage;
> =A0extern void omap3_pm_off_mode_enable(int);
> =A0extern void omap_sram_idle(void);
> -extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state=
);
> =A0extern int omap3_idle_init(void);
> =A0extern int omap4_idle_init(void);
> =A0extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *u=
nused);
> diff --git a/arch/arm/mach-omap2/powerdomain-common.c b/arch/arm/mach=
-omap2/powerdomain-common.c
> index c0aeabf..2973be7 100644
> --- a/arch/arm/mach-omap2/powerdomain-common.c
> +++ b/arch/arm/mach-omap2/powerdomain-common.c
> @@ -108,3 +108,74 @@ u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +/**
> + * omap2_pwrdm_func_to_pwrst - Convert functional (i.e. logical) to
> + * internal (i.e. registers) values for the power domains states.
> + * @struct powerdomain * to convert the values for
> + * @func_pwrst: functional power state
> + *
> + * Returns the internal power state value for the power domain, or
> + * -EINVAL in case of invalid parameters passed in.
> + */
> +int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwr=
st)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 switch (func_pwrst) {
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_ON:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_INACTIVE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_INACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_RET;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_FUNC_PWRST_OFF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_OFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * omap2_pwrdm_pwrst_to_func - Convert internal (i.e. registers) to
> + * functional (i.e. logical) values for the power domains states.
> + * @struct powerdomain * to convert the values for
> + * @pwrst: internal power state
> + *
> + * Returns the functional power state value for the power domain, or
> + * -EINVAL in case of invalid parameters passed in.
> + */
> +int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
> +{
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 switch (pwrst) {
> + =A0 =A0 =A0 case PWRDM_POWER_ON:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_ON;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_POWER_INACTIVE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_INACTIVE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_POWER_RET:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* XXX warning: return OSWR in case o=
f pd in RET and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* logic in OFF
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_CSWR;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case PWRDM_POWER_OFF:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_OFF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index 1641e72..e79b5ae 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -466,6 +466,135 @@ int pwrdm_get_mem_bank_count(struct powerdomain=
 *pwrdm)
> =A0}
>
> =A0/**
> + * pwrdm_func_to_pwrst - get the internal (i.e. registers) value map=
ped
> + * to the functional state
> + * @pwrdm: struct powerdomain * to query
> + * @func_pwrst: functional power state
> + *
> + * Convert the functional power state to the platform specific power
> + * domain state value.
> + * Returns the internal power domain state value or -EINVAL in case
> + * of invalid parameters passed in.
> + */
> +int pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
> +{
> + =A0 =A0 =A0 int ret =3D func_pwrst;
> +
> + =A0 =A0 =A0 if ((!pwrdm) || (func_pwrst >=3D PWRDM_MAX_FUNC_PWRSTS)=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_pwrst)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_func_to_pwrst=
(pwrdm, func_pwrst);
> +
> + =A0 =A0 =A0 pr_debug("powerdomain: convert func %0x to pwrst %0x fo=
r %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0func_pwrst, ret, pwrdm->name);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * pwrdm_pwrst_to_func - get the functional (i.e. logical) value map=
ped
> + * to the internal state
> + * @pwrdm: struct powerdomain * to query
> + * @pwrst: internal power state
> + *
> + * Convert the internal power state to the power domain functional v=
alue.
> + * Returns the functional power domain state value or -EINVAL in cas=
e
> + * of invalid parameters passed in.
> + */
> +int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
> +{
> + =A0 =A0 =A0 int ret =3D pwrst;
> +
> + =A0 =A0 =A0 if ((!pwrdm) || (pwrst >=3D PWRDM_MAX_PWRSTS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 pr_debug("powerdomain: convert %0x pwrst to func for %s=
\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrst, pwrdm->name);
> +
> + =A0 =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_pwrst_to_func=
(pwrdm, pwrst);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/* Types of sleep_switch used in omap_set_pwrdm_state */
> +#define FORCEWAKEUP_SWITCH =A0 =A0 0
> +#define LOWPOWERSTATE_SWITCH =A0 1
> +
> +/**
> + * omap_set_pwrdm_state - program next powerdomain power state
> + * @pwrdm: struct powerdomain * to set
> + * @func_pwrst: power domain functional state, one of the PWRDM_FUNC=
_* macros
> + *
> + * This programs the pwrdm next functional state, sets the dependenc=
ies
> + * and waits for the state to be applied.
> + */
> +int omap_set_pwrdm_state(struct powerdomain *pwrdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum pwrdm_func_stat=
e func_pwrst)
> +{
> + =A0 =A0 =A0 u8 curr_pwrst, next_pwrst;
> + =A0 =A0 =A0 int pwrst =3D pwrdm_func_to_pwrst(pwrdm, func_pwrst);
> + =A0 =A0 =A0 int sleep_switch =3D -1, ret =3D 0, hwsup =3D 0;
> +
> + =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: invalid params: pwrdm=3D%=
p, func_pwrst=3D%0x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm, fun=
c_pwrst);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pr_debug("%s: set func_pwrst %0x to pwrdm %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, func_pwrst, pwrdm->name);
> +
> + =A0 =A0 =A0 mutex_lock(&pwrdm->lock);
> +
> + =A0 =A0 =A0 while (!(pwrdm->pwrsts & (1 << pwrst))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrst =3D=3D PWRDM_POWER_OFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);
> + =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 curr_pwrst =3D pwrdm_read_pwrst(pwrdm);
> + =A0 =A0 =A0 if (curr_pwrst < PWRDM_POWER_ON) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((curr_pwrst > pwrst) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pwrdm->flags & PWRDM_H=
AS_LOWPOWERSTATECHANGE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D LOWPOW=
ERSTATE_SWITCH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hwsup =3D clkdm_in_hwsu=
p(pwrdm->pwrdm_clkdms[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_wakeup(pwrdm->pwr=
dm_clkdms[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep_switch =3D FORCEW=
AKEUP_SWITCH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D pwrdm_set_next_pwrst(pwrdm, pwrst);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to set power state o=
f powerdomain: %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name);
> +
> + =A0 =A0 =A0 switch (sleep_switch) {
> + =A0 =A0 =A0 case FORCEWAKEUP_SWITCH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hwsup)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_allow_idle(pwrdm-=
>pwrdm_clkdms[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clkdm_sleep(pwrdm->pwrd=
m_clkdms[0]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case LOWPOWERSTATE_SWITCH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_lowpwrstchange(pwrdm);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_wait_transition(pwrdm);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_state_switch(pwrdm);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> +out:
> + =A0 =A0 =A0 mutex_unlock(&pwrdm->lock);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> =A0* pwrdm_set_next_pwrst - set next powerdomain power state
> =A0* @pwrdm: struct powerdomain * to set
> =A0* @pwrst: one of the PWRDM_POWER_* macros
> @@ -522,6 +651,21 @@ int pwrdm_read_next_pwrst(struct powerdomain *pw=
rdm)
> =A0}
>
> =A0/**
> + * pwrdm_read_next_func_pwrst - get next powerdomain functional powe=
r state
> + * @pwrdm: struct powerdomain * to get power state
> + *
> + * Return the powerdomain @pwrdm's next functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns
> + * the next power state upon success.
> + */
> +int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 int ret =3D pwrdm_read_next_pwrst(pwrdm);
> +
> + =A0 =A0 =A0 return pwrdm_pwrst_to_func(pwrdm, ret);
> +}
> +
> +/**
> =A0* pwrdm_read_pwrst - get current powerdomain power state
> =A0* @pwrdm: struct powerdomain * to get power state
> =A0*
> @@ -543,6 +687,21 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
> =A0}
>
> =A0/**
> + * pwrdm_read_func_pwrst - get current powerdomain functional power =
state
> + * @pwrdm: struct powerdomain * to get power state
> + *
> + * Return the powerdomain @pwrdm's current functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns
> + * the current power state upon success.
> + */
> +int pwrdm_read_func_pwrst(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 int ret =3D pwrdm_read_pwrst(pwrdm);
> +
> + =A0 =A0 =A0 return pwrdm_pwrst_to_func(pwrdm, ret);
> +}
> +
> +/**
> =A0* pwrdm_read_prev_pwrst - get previous powerdomain power state
> =A0* @pwrdm: struct powerdomain * to get previous power state
> =A0*
> @@ -564,6 +723,21 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pw=
rdm)
> =A0}
>
> =A0/**
> + * pwrdm_read_prev_func_pwrst - get previous powerdomain functional =
power state
> + * @pwrdm: struct powerdomain * to get previous power state
> + *
> + * Return the powerdomain @pwrdm's previous functional power state.
> + * Returns -EINVAL if the powerdomain pointer is null or returns the
> + * previous power state upon success.
> + */
> +int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 int ret =3D pwrdm_read_prev_pwrst(pwrdm);
> +
> + =A0 =A0 =A0 return pwrdm_pwrst_to_func(pwrdm, ret);
> +}
> +
> +/**
> =A0* pwrdm_set_logic_retst - set powerdomain logic power state upon r=
etention
> =A0* @pwrdm: struct powerdomain * to set
> =A0* @pwrst: one of the PWRDM_POWER_* macros
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index bab84fc..0404f9f 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -9,9 +9,6 @@
> =A0* This program is free software; you can redistribute it and/or mo=
dify
> =A0* it under the terms of the GNU General Public License version 2 a=
s
> =A0* published by the Free Software Foundation.
> - *
> - * XXX This should be moved to the mach-omap2/ directory at the earl=
iest
> - * opportunity.
> =A0*/
>
> =A0#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_H
> @@ -26,7 +23,51 @@
>
> =A0#include "voltage.h"
>
> -/* Powerdomain basic power states */
> +/***************************************************************
> + * External API
> + ***************************************************************/
> +
> +/* Powerdomain functional power states, used by the external API fun=
ctions */
> +enum pwrdm_func_state {
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_OFF =A0 =A0 =A0 =A0 =A0 =A0=3D 0x0,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_OSWR,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_CSWR,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_INACTIVE,
> + =A0 =A0 =A0 PWRDM_FUNC_PWRST_ON,
> + =A0 =A0 =A0 PWRDM_MAX_FUNC_PWRSTS =A0 =A0 =A0 =A0 =A0 /* Last value=
, used as the max value */
> +};
"
There could be potential driver issues using wrong values etc. To be
on a safe side, those could probably define as:
/* Powerdomain functional power states, used by the external API functi=
ons */
#define PWRDM_FUNC_PWRST_OFF 0x10
#define PWRDM_FUNC_PWRST_OSWR 0x11
#define PWRDM_FUNC_PWRST_CSWR 0x12
#define PWRDM_FUNC_PWRST_INACTIVE 0x13
#define PWRDM_FUNC_PWRST_ON 0x14
This should expose any wrong handling in code and any cross
assumptions It is highly critical to ensure that PWRDM_FUNC is
different from PWRDM_POWER
"
The argument is valid regarding the API definition (internal vs
external) and its usage.
The possible options are described in the thread at
http://marc.info/?l=3Dlinux-omap&m=3D133975893730191&w=3D2

Any feedback is appreciated.

Regards,
Jean

> +
> +struct clockdomain;
> +struct powerdomain;
> +
> +struct powerdomain *pwrdm_lookup(const char *name);
> +
> +int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user);
> +int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void =
*user),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user);
> +
> +struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
> +
> +int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
> +
> +int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
> +int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
> +int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
> +extern int omap_set_pwrdm_state(struct powerdomain *pwrdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pw=
rdm_func_state func_pwrst);
> +
> +extern void omap242x_powerdomains_init(void);
> +extern void omap243x_powerdomains_init(void);
> +extern void omap3xxx_powerdomains_init(void);
> +extern void omap44xx_powerdomains_init(void);
> +
> +
> +/***************************************************************
> + * Internal code, only used in powerdomain*.[ch]
> + ***************************************************************/
> +
> +/* Powerdomain internal power states, internal use only */
> =A0#define PWRDM_POWER_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
> =A0#define PWRDM_POWER_RET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x1
> =A0#define PWRDM_POWER_INACTIVE =A0 0x2
> @@ -45,7 +86,6 @@
> =A0#define PWRSTS_RET_ON =A0 =A0 =A0 =A0 =A0(PWRSTS_RET | PWRSTS_ON)
> =A0#define PWRSTS_OFF_RET_ON =A0 =A0 =A0(PWRSTS_OFF_RET | PWRSTS_ON)
>
> -
> =A0/* Powerdomain flags */
> =A0#define PWRDM_HAS_HDWR_SAR =A0 =A0 (1 << 0) /* hardware save-and-r=
estore support */
> =A0#define PWRDM_HAS_MPU_QUIRK =A0 =A0(1 << 1) /* MPU pwr domain has =
MEM bank 0 bits
> @@ -74,9 +114,6 @@
> =A0/* XXX A completely arbitrary number. What is reasonable here? */
> =A0#define PWRDM_TRANSITION_BAILOUT 100000
>
> -struct clockdomain;
> -struct powerdomain;
> -
> =A0/**
> =A0* struct powerdomain - OMAP powerdomain
> =A0* @name: Powerdomain name
> @@ -130,6 +167,10 @@ struct powerdomain {
>
> =A0/**
> =A0* struct pwrdm_ops - Arch specific function implementations
> + * @pwrdm_func_to_pwrst: Convert the pd functional power state to
> + * =A0the internal state
> + * @pwrdm_pwrst_to_func: Convert the pd internal power state to
> + * =A0the functional state
> =A0* @pwrdm_set_next_pwrst: Set the target power state for a pd
> =A0* @pwrdm_read_next_pwrst: Read the target power state set for a pd
> =A0* @pwrdm_read_pwrst: Read the current power state of a pd
> @@ -150,6 +191,8 @@ struct powerdomain {
> =A0* @pwrdm_wait_transition: Wait for a pd state transition to comple=
te
> =A0*/
> =A0struct pwrdm_ops {
> + =A0 =A0 =A0 int =A0 =A0 (*pwrdm_func_to_pwrst)(struct powerdomain *=
pwrdm, u8 func_pwrst);
> + =A0 =A0 =A0 int =A0 =A0 (*pwrdm_pwrst_to_func)(struct powerdomain *=
pwrdm, u8 func_pwrst);
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_set_next_pwrst)(struct powerdomain=
 *pwrdm, u8 pwrst);
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_read_next_pwrst)(struct powerdomai=
n *pwrdm);
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_read_pwrst)(struct powerdomain *pw=
rdm);
> @@ -174,21 +217,11 @@ int pwrdm_register_platform_funcs(struct pwrdm_=
ops *custom_funcs);
> =A0int pwrdm_register_pwrdms(struct powerdomain **pwrdm_list);
> =A0int pwrdm_complete_init(void);
>
> -struct powerdomain *pwrdm_lookup(const char *name);
> -
> -int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user);
> -int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void =
*user),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *user);
> -
> =A0int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain =
*clkdm);
> =A0int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain =
*clkdm);
> =A0int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*fn)(struct powe=
rdomain *pwrdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct clockdomain *clkdm));
> -struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
> -
> -int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
>
> =A0int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
> =A0int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
> @@ -196,6 +229,9 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm);
> =A0int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
> =A0int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
>
> +int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwr=
st);
> +int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst);
> +
> =A0int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
> =A0int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrs=
t);
> =A0int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwr=
st);
> @@ -220,11 +256,6 @@ int pwrdm_set_lowpwrstchange(struct powerdomain =
*pwrdm);
> =A0int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
> =A0bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
>
> -extern void omap242x_powerdomains_init(void);
> -extern void omap243x_powerdomains_init(void);
> -extern void omap3xxx_powerdomains_init(void);
> -extern void omap44xx_powerdomains_init(void);
> -
> =A0extern struct pwrdm_ops omap2_pwrdm_operations;
> =A0extern struct pwrdm_ops omap3_pwrdm_operations;
> =A0extern struct pwrdm_ops omap4_pwrdm_operations;
> diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/ma=
ch-omap2/powerdomain2xxx_3xxx.c
> index 0f0a9f1..79c1293 100644
> --- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
> @@ -26,6 +26,7 @@
>
>
> =A0/* Common functions across OMAP2 and OMAP3 */
> +
> =A0static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u=
8 pwrst)
> =A0{
> =A0 =A0 =A0 =A0omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
> @@ -210,6 +211,8 @@ static int omap3_pwrdm_disable_hdwr_sar(struct po=
werdomain *pwrdm)
> =A0}
>
> =A0struct pwrdm_ops omap2_pwrdm_operations =3D {
> + =A0 =A0 =A0 .pwrdm_func_to_pwrst =A0 =A0=3D omap2_pwrdm_func_to_pwr=
st,
> + =A0 =A0 =A0 .pwrdm_pwrst_to_func =A0 =A0=3D omap2_pwrdm_pwrst_to_fu=
nc,
> =A0 =A0 =A0 =A0.pwrdm_set_next_pwrst =A0 =3D omap2_pwrdm_set_next_pwr=
st,
> =A0 =A0 =A0 =A0.pwrdm_read_next_pwrst =A0=3D omap2_pwrdm_read_next_pw=
rst,
> =A0 =A0 =A0 =A0.pwrdm_read_pwrst =A0 =A0 =A0 =3D omap2_pwrdm_read_pwr=
st,
> @@ -222,6 +225,8 @@ struct pwrdm_ops omap2_pwrdm_operations =3D {
> =A0};
>
> =A0struct pwrdm_ops omap3_pwrdm_operations =3D {
> + =A0 =A0 =A0 .pwrdm_func_to_pwrst =A0 =A0=3D omap2_pwrdm_func_to_pwr=
st,
> + =A0 =A0 =A0 .pwrdm_pwrst_to_func =A0 =A0=3D omap2_pwrdm_pwrst_to_fu=
nc,
> =A0 =A0 =A0 =A0.pwrdm_set_next_pwrst =A0 =3D omap2_pwrdm_set_next_pwr=
st,
> =A0 =A0 =A0 =A0.pwrdm_read_next_pwrst =A0=3D omap2_pwrdm_read_next_pw=
rst,
> =A0 =A0 =A0 =A0.pwrdm_read_pwrst =A0 =A0 =A0 =3D omap2_pwrdm_read_pwr=
st,
> diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-om=
ap2/powerdomain44xx.c
> index 601325b..538b528 100644
> --- a/arch/arm/mach-omap2/powerdomain44xx.c
> +++ b/arch/arm/mach-omap2/powerdomain44xx.c
> @@ -209,6 +209,8 @@ static int omap4_pwrdm_wait_transition(struct pow=
erdomain *pwrdm)
> =A0}
>
> =A0struct pwrdm_ops omap4_pwrdm_operations =3D {
> + =A0 =A0 =A0 .pwrdm_func_to_pwrst =A0 =A0=3D omap2_pwrdm_func_to_pwr=
st,
> + =A0 =A0 =A0 .pwrdm_pwrst_to_func =A0 =A0=3D omap2_pwrdm_pwrst_to_fu=
nc,
> =A0 =A0 =A0 =A0.pwrdm_set_next_pwrst =A0 =3D omap4_pwrdm_set_next_pwr=
st,
> =A0 =A0 =A0 =A0.pwrdm_read_next_pwrst =A0=3D omap4_pwrdm_read_next_pw=
rst,
> =A0 =A0 =A0 =A0.pwrdm_read_pwrst =A0 =A0 =A0 =3D omap4_pwrdm_read_pwr=
st,
> --
> 1.7.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
