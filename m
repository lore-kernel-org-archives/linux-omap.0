From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCHv3 03/20] ARM: OMAP4: PM: add support for device off
Date: Wed, 13 Jun 2012 17:21:45 +0200
Message-ID: <CAORVsuUJOpQu1qE7qmK9PS79JZJ065egqcpfgmsWNHwnhLUdvw@mail.gmail.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
	<1339515095-9908-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49853 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753436Ab2FMPVr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:21:47 -0400
Received: by lahd3 with SMTP id d3so514733lah.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jun 2012 08:21:45 -0700 (PDT)
In-Reply-To: <1339515095-9908-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

I have a few remarks regarding the genericity of this code. I think it
is better if the code in powerdomain.c stays generic and that the
platform specific checks and operations be moved in the specific
functions (via the pwrdm_ops struct).

On Tue, Jun 12, 2012 at 5:31 PM, Tero Kristo <t-kristo@ti.com> wrote:
> On OMAP4+, device wide off-mode has its own enable mechanism in addit=
ion
> to powerdomain target states. This patch adds support for this on top
> of functional power states by overloading the OFF state for core pwrd=
m.
> On pwrdm level, the deepest power state supported by core pwrdm is OS=
WR.
> When user (e.g. suspend) programs core pwrdm target as OFF, the funct=
ional
> power state for the domain will be OSWR with the additional device of=
f
> enabled. Previous power state information will reflect this also.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0 | =A0 17 +++=
++++++
> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0 | =A0 13 +++=
++++-
> =A0arch/arm/mach-omap2/powerdomain44xx.c =A0 =A0 =A0 | =A0 48 +++++++=
++++++++++++++++++++
> =A0arch/arm/mach-omap2/powerdomains44xx_data.c | =A0 =A03 +-
> =A04 files changed, 79 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index ac63f86..78a9308 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -677,6 +677,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrd=
m, u32 func_pwrst)
> =A0 =A0 =A0 =A0int sleep_switch =3D -1, ret =3D 0, hwsup =3D 0;
> =A0 =A0 =A0 =A0int new_func_pwrst, next_func_pwrst, pwrst, logic;
> =A0 =A0 =A0 =A0u8 curr_pwrst;
> + =A0 =A0 =A0 bool extra_off_enable =3D false;
> + =A0 =A0 =A0 bool has_extra_off =3D false;
>
> =A0 =A0 =A0 =A0if (!pwrdm || IS_ERR(pwrdm)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("%s: invalid params: pwrdm=3D=
%p\n", __func__, pwrdm);
> @@ -687,6 +689,13 @@ int omap_set_pwrdm_state(struct powerdomain *pwr=
dm, u32 func_pwrst)
>
> =A0 =A0 =A0 =A0mutex_lock(&pwrdm->lock);
>
> + =A0 =A0 =A0 /* Check if powerdomain has extra off mode handling */
> + =A0 =A0 =A0 if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 has_extra_off =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (func_pwrst =3D=3D PWRDM_FUNC_PWRST_=
OFF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 extra_off_enable =3D tr=
ue;
> + =A0 =A0 =A0 }
Could those checks be moved in the OMAP4 specific functions, so that
the power domain code stays generic?

> +
> =A0 =A0 =A0 =A0new_func_pwrst =3D pwrdm_get_achievable_func_pwrst(pwr=
dm, func_pwrst);
> =A0 =A0 =A0 =A0pwrst =3D pwrdm_func_to_pwrst(pwrdm, new_func_pwrst);
> =A0 =A0 =A0 =A0logic =3D pwrdm_func_to_logic_pwrst(pwrdm, new_func_pw=
rst);
> @@ -741,6 +750,9 @@ int omap_set_pwrdm_state(struct powerdomain *pwrd=
m, u32 func_pwrst)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (has_extra_off && arch_pwrdm->pwrdm_enable_off)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 arch_pwrdm->pwrdm_enable_off(pwrdm, ext=
ra_off_enable);
> +
> =A0out:
> =A0 =A0 =A0 =A0mutex_unlock(&pwrdm->lock);
> =A0 =A0 =A0 =A0return ret;
> @@ -810,6 +822,11 @@ int pwrdm_read_next_func_pwrst(struct powerdomai=
n *pwrdm)
> =A0 =A0 =A0 =A0int next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);
> =A0 =A0 =A0 =A0int next_logic =3D pwrdm_read_logic_retst(pwrdm);
>
> + =A0 =A0 =A0 if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE &&
> + =A0 =A0 =A0 =A0 =A0 arch_pwrdm->pwrdm_read_next_off &&
> + =A0 =A0 =A0 =A0 =A0 arch_pwrdm->pwrdm_read_next_off(pwrdm))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PWRDM_FUNC_PWRST_OFF;
> +
Same comment here. The OMAP4 specific function for
pwrdm_read_next_pwrst could return PWRDM_FUNC_PWRST_OFF.

> =A0 =A0 =A0 =A0return pwrdm_pwrst_to_func(pwrdm, next_pwrst, next_log=
ic);
> =A0}
>
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index 0729d91..cc30b94 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -75,6 +75,13 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* state without waking up the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0* powerdomain
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +/*
> + * OMAP4+ has device off feature, which must be enabled separately i=
n
> + * addition to power domain next state setup. This feature is overlo=
aded
> + * as EXTRA_OFF_ENABLE for core_pwrdm, and is implemented on top of
> + * functional power state
> + */
> +#define PWRDM_HAS_EXTRA_OFF_ENABLE =A0 =A0 (1 << 3)
>
> =A0/*
> =A0* Number of memory banks that are power-controllable. On OMAP4430,=
 the
> @@ -173,7 +180,9 @@ struct powerdomain {
> =A0* @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature f=
or a pd
> =A0* @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow =
to deep sleep
> =A0* @pwrdm_wait_transition: Wait for a pd state transition to comple=
te
> - * @pwrdm_lost_context_rff: Check if pd has lost RFF context (entere=
d off)
> + * @pwrdm_lost_context_rff: Check if pd has lost RFF context (omap4+=
 device off)
> + * @pwrdm_enable_off: Extra off mode enable for pd (omap4+ device of=
f)
> + * @pwrdm_read_next_off: Check if pd next state is off (omap4+ devic=
e off)
> =A0*/
> =A0struct pwrdm_ops {
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_func_to_pwrst)(struct powerdomain =
*pwrdm, u8 func_pwrst);
> @@ -199,6 +208,8 @@ struct pwrdm_ops {
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_set_lowpwrstchange)(struct powerdo=
main *pwrdm);
> =A0 =A0 =A0 =A0int =A0 =A0 (*pwrdm_wait_transition)(struct powerdomai=
n *pwrdm);
> =A0 =A0 =A0 =A0bool =A0 =A0(*pwrdm_lost_context_rff)(struct powerdoma=
in *pwrdm);
> + =A0 =A0 =A0 void =A0 =A0(*pwrdm_enable_off)(struct powerdomain *pwr=
dm, bool enable);
> + =A0 =A0 =A0 bool =A0 =A0(*pwrdm_read_next_off)(struct powerdomain *=
pwrdm);
> =A0};
>
> =A0int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
> diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-om=
ap2/powerdomain44xx.c
> index 562f78a..b2bdc0f 100644
> --- a/arch/arm/mach-omap2/powerdomain44xx.c
> +++ b/arch/arm/mach-omap2/powerdomain44xx.c
> @@ -358,6 +358,52 @@ bool omap4_pwrdm_lost_context_rff(struct powerdo=
main *pwrdm)
> =A0 =A0 =A0 =A0return false;
> =A0}
>
> +/**
> + * omap4_device_set_next_state_off - setup device off state
> + * @pwrdm: struct powerdomain * to target powerdomain
> + * @enable: true if off-mode should be enabled
> + *
> + * When Device OFF is enabled, Device is allowed to perform
> + * transition to off mode as soon as all power domains in MPU, IVA
> + * and CORE voltage are in OFF or OSWR state (open switch retention)
> + */
> +void omap4_device_set_next_state_off(struct powerdomain *pwrdm, bool=
 enable)
> +{
> + =A0 =A0 =A0 u8 val =3D enable ? 0x1 : 0x0;
> +
> + =A0 =A0 =A0 if (!(pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 omap4_prminst_write_inst_reg(val << OMAP4430_DEVICE_OFF=
_ENABLE_SHIFT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0OMAP4430_PRM_PARTITION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET);
> +}
> +
> +
> +/**
> + * omap4_device_read_next_state_off - read device off state
> + * @pwrdm: struct powerdomain * to target powerdomain
> + *
> + * Checks if device off is enabled or not.
> + * Returns true if enabled, false otherwise.
> + */
> +bool omap4_device_read_next_state_off(struct powerdomain *pwrdm)
> +{
> + =A0 =A0 =A0 u32 val;
> +
> + =A0 =A0 =A0 if (!(pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return false;
> +
> + =A0 =A0 =A0 val =3D omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTIT=
ION,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INST,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET);
> +
> + =A0 =A0 =A0 val &=3D OMAP4430_DEVICE_OFF_ENABLE_MASK;
> +
> + =A0 =A0 =A0 return val ? true : false;
> +}
> +
> =A0struct pwrdm_ops omap4_pwrdm_operations =3D {
> =A0 =A0 =A0 =A0.pwrdm_func_to_pwrst =A0 =A0=3D omap2_pwrdm_func_to_pw=
rst,
> =A0 =A0 =A0 =A0.pwrdm_func_to_logic_pwrst =A0 =A0 =A0=3D omap2_pwrdm_=
func_to_logic_pwrst,
> @@ -381,4 +427,6 @@ struct pwrdm_ops omap4_pwrdm_operations =3D {
> =A0 =A0 =A0 =A0.pwrdm_enable_hdwr_sar =A0=3D omap4_pwrdm_enable_hdwr_=
sar,
> =A0 =A0 =A0 =A0.pwrdm_disable_hdwr_sar =3D omap4_pwrdm_disable_hdwr_s=
ar,
> =A0 =A0 =A0 =A0.pwrdm_lost_context_rff =3D omap4_pwrdm_lost_context_r=
ff,
> + =A0 =A0 =A0 .pwrdm_enable_off =A0 =A0 =A0 =3D omap4_device_set_next=
_state_off,
> + =A0 =A0 =A0 .pwrdm_read_next_off =A0 =A0=3D omap4_device_read_next_=
state_off,
> =A0};
> diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/m=
ach-omap2/powerdomains44xx_data.c
> index c4de02f..13db876 100644
> --- a/arch/arm/mach-omap2/powerdomains44xx_data.c
> +++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
> @@ -54,7 +54,8 @@ static struct powerdomain core_44xx_pwrdm =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[3] =3D PWRSTS_ON, =A0 =A0 =A0 =A0/* d=
ucati_l2ram */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[4] =3D PWRSTS_ON, =A0 =A0 =A0 =A0/* d=
ucati_unicache */
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D PWRDM_HAS_LOWPOWERSTA=
TECHANGE,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0 =A0=3D PWRDM_HAS_LOWPOWERSTA=
TECHANGE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PWRDM_HAS_EXTRA=
_OFF_ENABLE,
> =A0};
>
> =A0/* gfx_44xx_pwrdm: 3D accelerator power domain */

Regards,
Jean

> --
> 1.7.4.1
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
