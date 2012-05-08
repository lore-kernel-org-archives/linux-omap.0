From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: PM: introduce power domains functional states
Date: Tue, 8 May 2012 10:40:27 +0200
Message-ID: <CAORVsuXUbz_f54x=hoFLEQpfAGTDcZGnTQ-fBgY_j415LC0TiQ@mail.gmail.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
	<1334752782-28804-3-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:60542 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab2EHIk2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 04:40:28 -0400
Received: by vbbff1 with SMTP id ff1so1676695vbb.19
        for <linux-omap@vger.kernel.org>; Tue, 08 May 2012 01:40:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Paul,

On Mon, May 7, 2012 at 11:28 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> On Wed, 18 Apr 2012, jean.pihet@newoldbits.com wrote:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Introduce functional (or logical) states for power domains and the
>> API functions to read the power domains settings and to convert
>> between the functional (i.e. logical) and the internal (or registers=
)
>> values.
>>
>> OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine.
>>
>> In the new API the function omap_set_pwrdm_state takes the functiona=
l
>> states as parameter; while at it the function is moved to the power
>> domains code.
>>
>> The memory and logic states are not using the functional states, thi=
s
>> comes as a subsequent patch.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> This patch results in several checkpatch warnings; please resolve the=
m.
Oops. Will check and update.

>
>> ---
>> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 66 -----------
>> =A0arch/arm/mach-omap2/powerdomain-common.c =A0 | =A0 61 ++++++++++
>> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0| =A0175 +++=
+++++++++++++++++++++++++
>> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0| =A0 21 +++=
+
>> =A0arch/arm/mach-omap2/powerdomain2xxx_3xxx.c | =A0 =A05 +
>> =A0arch/arm/mach-omap2/powerdomain44xx.c =A0 =A0 =A0| =A0 =A02 +
>> =A06 files changed, 264 insertions(+), 66 deletions(-)
>>
=2E..

>> +/*
>> + * Functional (i.e. logical) to internal (i.e. registers)
>> + * values for the power domains states
>> + */
>
> Please use kerneldoc-style function comments.
Ok

>
>> +int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pw=
rst)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 switch (func_pwrst) {
>> + =A0 =A0 case PWRDM_FUNC_PWRST_ON:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_ON;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_FUNC_PWRST_INACTIVE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_INACTIVE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
>> + =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_RET;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_FUNC_PWRST_OFF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_OFF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>
> At a quick glance, I don't think that this function is appropriate fo=
r all
> OMAP2+ chips. =A0For example, off-mode is not supported in our OMAP2x=
xx
> kernels. =A0And OMAP2xxx/3xxx do not support the INACTIVE powerstate.=
 =A0So
> probably this function should differ by chip, and be located in the
> powerdomain[2-4]*xx*.c files.
I hope to make this function as generic as possible, hence the
location (powerdomain-common.c). Some states are not programmed by the
pwrdm_* functions since there forbidden by the contents of the
pwrdm->pwrst field.
Now if the need arises some platform specific function can be defined
for conversion functions since the pwrdm->ops function pointers are
used. I do not think it is needed now but it can easily be changed.

> Also, what about the logic and memory bank power states? =A0Shouldn't=
 this
> function pass those back as well?
Cf. in the description "The memory and logic states are not using the
functional states, this comes as a subsequent patch."

>
>> +
>> +/*
>> + * Internal (i.e. registers) to functional (i.e. logical) values
>> + * for the power domains states
>> + */
>
> Please use kerneldoc-style function documentation.
Ok

>
>> +int omap2_pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
>
> Probably best to use "func_pwrst" or "fpwrst" rather than simply "fun=
c"
> here.
Ok. I am for 'omap2_pwrdm_pwrst_to_fpwrst(...)'.

>
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 switch (pwrst) {
>> + =A0 =A0 case PWRDM_POWER_ON:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_ON;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_POWER_INACTIVE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_INACTIVE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_POWER_RET:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* XXX warning: return OSWR in case of p=
d in RET and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* logic in OFF
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_CSWR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PWRDM_POWER_OFF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_FUNC_PWRST_OFF;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>
> This function also needs to check the bank power states and logic pow=
er
> states to determine what the actual functional powerstate is.
Same remark as above + there is a comment about it in the code ("XXX wa=
rning").

>> +
>> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2=
/powerdomain.c
>> index 319b277..718fa43 100644
>> --- a/arch/arm/mach-omap2/powerdomain.c
>> +++ b/arch/arm/mach-omap2/powerdomain.c
>> @@ -466,6 +466,136 @@ int pwrdm_get_mem_bank_count(struct powerdomai=
n *pwrdm)
>> =A0}
>>
>> =A0/**
>> + * pwrdm_func_to_pwrst - get the internal (i.e. registers) value ma=
pped
>> + * to the functional state
>
> Probably best to use "func_pwrst" or "fpwrst" rather than simply "fun=
c"
> here.
Ok

>
>> + * @pwrdm: struct powerdomain * to query
>> + * @func_pwrst: functional power state
>> + *
>> + * Convert the functional power state to the platform specific powe=
r
>> + * domain state value.
>> + * Returns the internal power domain state value or -EINVAL in case
>> + * of invalid parameters passed in.
>> + */
>> +int pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst)
>> +{
>> + =A0 =A0 int ret =3D func_pwrst;
>> +
>> + =A0 =A0 if ((!pwrdm)|| (func_pwrst >=3D PWRDM_MAX_FUNC_PWRSTS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 pr_debug("powerdomain: convert %0x func to pwrst for %s\n"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0func_pwrst, pwrdm->name);
>> +
>> + =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_func_to_pwrst) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_func_to_pwrst(pw=
rdm, func_pwrst);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/**
>> + * pwrdm_pwrst_to_func - get the functional (i.e. logical) value ma=
pped
>> + * to the internal state
>> + * @pwrdm: struct powerdomain * to query
>> + * @pwrst: internal power state
>> + *
>> + * Convert the internal power state to the power domain functional =
value.
>> + * Returns the functional power domain state value or -EINVAL in ca=
se
>> + * of invalid parameters passed in.
>> + */
>> +int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst)
>> +{
>> + =A0 =A0 int ret =3D pwrst;
>> +
>> + =A0 =A0 if ((!pwrdm)|| (pwrst >=3D PWRDM_MAX_PWRSTS))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 pr_debug("powerdomain: convert %0x pwrst to func for %s\n"=
,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrst, pwrdm->name);
>> +
>> + =A0 =A0 if (arch_pwrdm && arch_pwrdm->pwrdm_pwrst_to_func) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D arch_pwrdm->pwrdm_pwrst_to_func(pw=
rdm, pwrst);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/* Types of sleep_switch used in omap_set_pwrdm_state */
>> +#define FORCEWAKEUP_SWITCH =A0 0
>> +#define LOWPOWERSTATE_SWITCH 1
>> +
>> +/**
>> + * omap_set_pwrdm_state - program next powerdomain power state
>> + * @pwrdm: struct powerdomain * to set
>> + * @func_pwrst: power domain functional state, one of the PWRDM_FUN=
C_* macros
>> + *
>> + * This programs the pwrdm next functional state, sets the dependen=
cies
>> + * and waits for the state to be applied.
>> + */
>> +int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
>
> This should presumably get renamed to match the other function names =
in
> this file, to be something like pwrdm_set_func_pwrst() or something
> similar.
Ok that makes sense.

=2E..

>
>
> - Paul

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
