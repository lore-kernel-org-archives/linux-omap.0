From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 5/8] ARM: OMAP2+: PM: introduce power domains achievable
 functional states
Date: Fri, 15 Jun 2012 13:28:30 +0200
Message-ID: <CAORVsuXbvkWHLm9mK3EgKSKFo400VoR6QSZbrS8hu1u8cV3e3A@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
	<1339685591-11177-6-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:49729 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753915Ab2FOL2c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jun 2012 07:28:32 -0400
Received: by lahd3 with SMTP id d3so1984818lah.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Jun 2012 04:28:31 -0700 (PDT)
In-Reply-To: <1339685591-11177-6-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>

Hi,

Here are some remarks I got after an internal review. I think those
points need to be discussed with a broader audience.

On Thu, Jun 14, 2012 at 4:53 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Note: the patch is in RFC state because the state machine for setting
> the next power domain states needs more discussion. Validated on OMAP=
3&4
> with cpuidle and suspend/resume, though.
>
> Power domains have varied capabilities. When attempting a low power
> state such as OFF/RET, a specific min requested state may not be
> supported on the power domain. This is because a combination
> of system power states where the parent PD's state is not in line
> with expectation can result in system instabilities.
>
> This patch provides a function that returns the achievable functional
> power state for a power domain and its use by omap_set_pwrdm_state.
> The achievable power state is first looked for in the lower power
> states in order to maximize the power savings, then if not found
> in the higher power states.
>
> Inspired from Tero's work on OMAP4 device OFF support and generalized
> to the functional power states.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/powerdomain.c | =A0156 +++++++++++++++++++++++=
++++++++------
> =A0arch/arm/mach-omap2/powerdomain.h | =A0 =A01 +
> =A02 files changed, 134 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/=
powerdomain.c
> index ce2685a..f94174b 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -554,6 +554,108 @@ int pwrdm_pwrst_to_func(struct powerdomain *pwr=
dm, u8 pwrst, u8 logic)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +/**
> + * pwrdm_get_achievable_func_pwrst() - Provide achievable functional=
 state
> + * @pwrdm: struct powerdomain * to set
> + * @func_pwrst: minimum functional state we would like to hit
> + * (one of the PWRDM_FUNC_* macros)
> + *
> + * Power domains have varied capabilities. When attempting a low pow=
er
> + * state such as OFF/RET, a specific min requested state may not be
> + * supported on the power domain. This is because a combination
> + * of system power states where the parent PD's state is not in line
> + * with expectation can result in system instabilities.
> + *
> + * The achievable power state is first looked for in the lower power
> + * states in order to maximize the power savings, then if not found
> + * in the higher power states.
> + *
> + * Returns the achievable functional power state, or -EINVAL in case=
 of
> + * invalid parameters.
> + */
> +int pwrdm_get_achievable_func_pwrst(struct powerdomain *pwrdm, u8 fu=
nc_pwrst)
> +{
> + =A0 =A0 =A0 int pwrst =3D pwrdm_func_to_pwrst(pwrdm, func_pwrst);
> + =A0 =A0 =A0 int logic =3D pwrdm_func_to_logic_pwrst(pwrdm, func_pwr=
st);
> + =A0 =A0 =A0 int new_func_pwrst, new_pwrst, new_logic;
> + =A0 =A0 =A0 int found;
> +
> + =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: invalid params: pwrdm=3D%=
p, func_pwrst=3D%0x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm, fun=
c_pwrst);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if ((pwrst < 0) || (logic < 0)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: invalid params for pwrdm =
%s, func_pwrst=3D%0x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->nam=
e, func_pwrst);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PWRDM_FUNC_PWRST_ON;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Power state: if the requested state is not support=
ed,
> + =A0 =A0 =A0 =A0* try the lower power states.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 found =3D 1;
> + =A0 =A0 =A0 new_pwrst =3D pwrst;
> + =A0 =A0 =A0 while (!(pwrdm->pwrsts & (1 << new_pwrst))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (new_pwrst =3D=3D PWRDM_POWER_OFF) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_pwrst--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If no lower power state found, fallback to the hig=
her
> + =A0 =A0 =A0 =A0* power states.
> + =A0 =A0 =A0 =A0* PWRDM_POWER_ON is always valid.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!found) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_pwrst =3D pwrst;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(pwrdm->pwrsts & (1 << new_pwrs=
t))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (new_pwrst =3D=3D PW=
RDM_POWER_ON)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_pwrst++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Logic RET state: if the requested state is not sup=
ported,
> + =A0 =A0 =A0 =A0* try the lower logic states.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 found =3D 1;
> + =A0 =A0 =A0 new_logic =3D logic;
> + =A0 =A0 =A0 while (!(pwrdm->pwrsts_logic_ret & (1 << new_logic))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (new_logic =3D=3D PWRDM_LOGIC_MEM_PW=
RST_OFF) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 found =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_logic--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If no lower logic state found, fallback to the hig=
her
> + =A0 =A0 =A0 =A0* logic states.
> + =A0 =A0 =A0 =A0* PWRDM_LOGIC_MEM_PWRST_RET is always valid.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!found) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_logic =3D logic;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(pwrdm->pwrsts_logic_ret & (1 <=
< new_logic))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (new_logic =3D=3D PW=
RDM_LOGIC_MEM_PWRST_RET)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 new_logic++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +

"
1. The while loops need optimization. - This can definitely be
simplified and made non-risky; this also needs some more error
handling
2. About the power domains state machine: you have only one power
state to move in and out of: it is called ON. If you do ON->CSWR->ON
etc. attempting to program ON->CSWR->OSWR is NOT supported in OMAP and
is an invitation for production team to sit and debug for a while
before finding the use of invalid power states
"

Point 2 is a good point. The solution would be to implement a state
machine in this function and/or omap_set_pwrdm_state, possibly using a
platform specific handling function.

Any thought?

Regards,
Jean

> + =A0 =A0 =A0 new_func_pwrst =3D pwrdm_pwrst_to_func(pwrdm, new_pwrst=
, new_logic);
> +
> + =A0 =A0 =A0 pr_debug("%s(%s, func_pwrst=3D%0x) returns %0x\n", __fu=
nc__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm->name, func_pwrst, new_func_pw=
rst);
> +
> + =A0 =A0 =A0 return new_func_pwrst;
> +}
> +
> =A0/* Types of sleep_switch used in omap_set_pwrdm_state */
> =A0#define FORCEWAKEUP_SWITCH =A0 =A0 0
> =A0#define LOWPOWERSTATE_SWITCH =A0 1
> @@ -563,36 +665,32 @@ int pwrdm_pwrst_to_func(struct powerdomain *pwr=
dm, u8 pwrst, u8 logic)
> =A0* @pwrdm: struct powerdomain * to set
> =A0* @func_pwrst: power domain functional state, one of the PWRDM_FUN=
C_* macros
> =A0*
> - * This programs the pwrdm next functional state, sets the dependenc=
ies
> - * and waits for the state to be applied.
> + * This looks for the more suited (or achievable) next functional po=
wer
> + * state, programs it, sets the dependencies and waits for the state=
 to
> + * be applied to the power domain.
> =A0*/
> =A0int omap_set_pwrdm_state(struct powerdomain *pwrdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pwrdm_func_state=
 func_pwrst)
> =A0{
> - =A0 =A0 =A0 u8 curr_pwrst, next_pwrst;
> - =A0 =A0 =A0 int pwrst =3D pwrdm_func_to_pwrst(pwrdm, func_pwrst);
> - =A0 =A0 =A0 int logic =3D pwrdm_func_to_logic_pwrst(pwrdm, func_pwr=
st);
> =A0 =A0 =A0 =A0int sleep_switch =3D -1, ret =3D 0, hwsup =3D 0;
> + =A0 =A0 =A0 int new_func_pwrst, next_func_pwrst, pwrst, logic;
> + =A0 =A0 =A0 u8 curr_pwrst;
>
> - =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm) || (pwrst < 0) || (logic < =
0)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: invalid params: pwrdm=3D%=
p, func_pwrst=3D%0x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm, fun=
c_pwrst);
> + =A0 =A0 =A0 if (!pwrdm || IS_ERR(pwrdm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: invalid params: pwrdm=3D%=
p\n", __func__, pwrdm);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 pr_debug("%s: set func_pwrst %0x to pwrdm %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, func_pwrst, pwrdm->name);
> + =A0 =A0 =A0 pr_debug("%s(%s, func_pwrst=3D%0x)\n", __func__, pwrdm-=
>name, func_pwrst);
>
> =A0 =A0 =A0 =A0mutex_lock(&pwrdm->lock);
>
> - =A0 =A0 =A0 while (!(pwrdm->pwrsts & (1 << pwrst))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrst =3D=3D PWRDM_POWER_OFF)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrst--;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 new_func_pwrst =3D pwrdm_get_achievable_func_pwrst(pwrd=
m, func_pwrst);
> + =A0 =A0 =A0 pwrst =3D pwrdm_func_to_pwrst(pwrdm, new_func_pwrst);
> + =A0 =A0 =A0 logic =3D pwrdm_func_to_logic_pwrst(pwrdm, new_func_pwr=
st);
>
> - =A0 =A0 =A0 next_pwrst =3D pwrdm_read_next_pwrst(pwrdm);
> - =A0 =A0 =A0 if (next_pwrst =3D=3D pwrst)
> + =A0 =A0 =A0 next_func_pwrst =3D pwrdm_read_next_func_pwrst(pwrdm);
> + =A0 =A0 =A0 if (new_func_pwrst =3D=3D next_func_pwrst)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0 =A0 =A0 =A0curr_pwrst =3D pwrdm_read_pwrst(pwrdm);
> @@ -607,13 +705,25 @@ int omap_set_pwrdm_state(struct powerdomain *pw=
rdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (logic !=3D pwrdm_read_logic_retst(pwrdm))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrdm, logic);
> + =A0 =A0 =A0 pr_debug("%s: set func_pwrst %0x (%0x,%0x) to pwrdm %s\=
n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, new_func_pwrst, pwrst, log=
ic, pwrdm->name);
> +
> + =A0 =A0 =A0 /* Trace the pwrdm desired target state */
> + =A0 =A0 =A0 trace_power_domain_target(pwrdm->name, new_func_pwrst,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp=
_processor_id());
> +
> + =A0 =A0 =A0 /* Program next power state */
> + =A0 =A0 =A0 if (pwrst !=3D pwrdm_func_to_pwrst(pwrdm, next_func_pwr=
st)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pwrdm_set_next_pwrst(pwrdm, pwr=
st);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to s=
et power state of powerdomain: %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__=
, pwrdm->name);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 ret =3D pwrdm_set_next_pwrst(pwrdm, pwrst);
> - =A0 =A0 =A0 if (ret)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: unable to set power state o=
f powerdomain: %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name);
> + =A0 =A0 =A0 /* Program RET logic state */
> + =A0 =A0 =A0 if ((pwrst =3D=3D PWRDM_POWER_RET) &&
> + =A0 =A0 =A0 =A0 =A0 (logic !=3D pwrdm_func_to_logic_pwrst(pwrdm, ne=
xt_func_pwrst)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_logic_retst(pwrdm, logic);
>
> =A0 =A0 =A0 =A0switch (sleep_switch) {
> =A0 =A0 =A0 =A0case FORCEWAKEUP_SWITCH:
> diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/=
powerdomain.h
> index d08c25d..9dd68ab 100644
> --- a/arch/arm/mach-omap2/powerdomain.h
> +++ b/arch/arm/mach-omap2/powerdomain.h
> @@ -247,6 +247,7 @@ int pwrdm_clear_all_prev_pwrst(struct powerdomain=
 *pwrdm);
> =A0int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_p=
wrst);
> =A0int omap2_pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8 =
func_pwrst);
> =A0int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst,=
 u8 logic);
> +int pwrdm_get_achievable_func_pwrst(struct powerdomain *pwrdm, u8 fu=
nc_pwrst);
>
> =A0int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
> =A0int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrs=
t);
> --
> 1.7.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
