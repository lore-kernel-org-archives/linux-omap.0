From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: PM: introduce power domains functional states
Date: Mon, 21 May 2012 15:53:18 +0200
Message-ID: <CAORVsuWgn5Zuf9T1eVBjJJhTGL5jrY=hirTaZp8E2HprzbvHng@mail.gmail.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
	<1334752782-28804-3-git-send-email-j-pihet@ti.com>
	<alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com>
	<CAORVsuXUbz_f54x=hoFLEQpfAGTDcZGnTQ-fBgY_j415LC0TiQ@mail.gmail.com>
	<4FB4CD45.4050807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46924 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756686Ab2EUNxU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 09:53:20 -0400
Received: by lbbgm6 with SMTP id gm6so3454792lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 06:53:19 -0700 (PDT)
In-Reply-To: <4FB4CD45.4050807@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Hi Santosh,

On Thu, May 17, 2012 at 12:04 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Jean,
> On Tuesday 08 May 2012 02:10 PM, Jean Pihet wrote:
>> Paul,
>>
>> On Mon, May 7, 2012 at 11:28 AM, Paul Walmsley <paul@pwsan.com> wrot=
e:
>>> Hi
>>>
>>> On Wed, 18 Apr 2012, jean.pihet@newoldbits.com wrote:
>>>
>>>> From: Jean Pihet <j-pihet@ti.com>
>>>>
>>>> Introduce functional (or logical) states for power domains and the
>>>> API functions to read the power domains settings and to convert
>>>> between the functional (i.e. logical) and the internal (or registe=
rs)
>>>> values.
>>>>
>>>> OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routine=
=2E
>>>>
>>>> In the new API the function omap_set_pwrdm_state takes the functio=
nal
>>>> states as parameter; while at it the function is moved to the powe=
r
>>>> domains code.
>>>>
>>>> The memory and logic states are not using the functional states, t=
his
>>>> comes as a subsequent patch.
>>>>
>>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>>
>>> This patch results in several checkpatch warnings; please resolve t=
hem.
>> Oops. Will check and update.
>>
>>>
>>>> ---
>>>> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 66 -----------
>>>> =A0arch/arm/mach-omap2/powerdomain-common.c =A0 | =A0 61 +++++++++=
+
>>>> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0| =A0175 +=
+++++++++++++++++++++++++++
>>>> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0| =A0 21 +=
+++
>>>> =A0arch/arm/mach-omap2/powerdomain2xxx_3xxx.c | =A0 =A05 +
>>>> =A0arch/arm/mach-omap2/powerdomain44xx.c =A0 =A0 =A0| =A0 =A02 +
>>>> =A06 files changed, 264 insertions(+), 66 deletions(-)
>>>>
>> ...
>>
>>>> +/*
>>>> + * Functional (i.e. logical) to internal (i.e. registers)
>>>> + * values for the power domains states
>>>> + */
>>>
>>> Please use kerneldoc-style function comments.
>> Ok
>>
>>>
>>>> +int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_=
pwrst)
>>>> +{
>>>> + =A0 =A0 int ret;
>>>> +
>>>> + =A0 =A0 switch (func_pwrst) {
>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_ON:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_ON;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_INACTIVE:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_INACTIVE;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_RET;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_OFF:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_OFF;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>> + =A0 =A0 default:
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
>>>> + =A0 =A0 }
>>>> +
>>>> + =A0 =A0 return ret;
>>>> +}
>>>
>>> At a quick glance, I don't think that this function is appropriate =
for all
>>> OMAP2+ chips. =A0For example, off-mode is not supported in our OMAP=
2xxx
>>> kernels. =A0And OMAP2xxx/3xxx do not support the INACTIVE powerstat=
e. =A0So
>>> probably this function should differ by chip, and be located in the
>>> powerdomain[2-4]*xx*.c files.
>> I hope to make this function as generic as possible, hence the
>> location (powerdomain-common.c). Some states are not programmed by t=
he
>> pwrdm_* functions since there forbidden by the contents of the
>> pwrdm->pwrst field.
>> Now if the need arises some platform specific function can be define=
d
>> for conversion functions since the pwrdm->ops function pointers are
>> used. I do not think it is needed now but it can easily be changed.
>>
>>> Also, what about the logic and memory bank power states? =A0Shouldn=
't this
>>> function pass those back as well?
>> Cf. in the description "The memory and logic states are not using th=
e
>> functional states, this comes as a subsequent patch."
>>
> I don't see much difference between the functional power states to
> actual power states with some cases here and there.
>
> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
> + =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_RET;
The whole patch series takes the logic state into account in the
functional power state.
Cf. in the description "The memory and logic states are not using the
functional states, this comes as a subsequent patch."

> This is not true and even if you add logic/memmort etc support,
> I still think, we are just duplicating stuff between functional
> vs actual power state.
The idea is to provide a single function to program the power domains
state, including the logic state.
There is no duplication of code, just a simplification in the API. IMO
there are too much calls to set and get the power domain states (power
state, logical etc.) and most of the calls do not take the logical
state into account.
If you look the the code in pmxxxx.c and cpuidlexxxx.c you will notice
that the code is simplified.

> If the idea is to have one single interface to program the power
> domain states, so that Generic frameworks, or PM code movement to
> driver/* directories is easier, we may want think about alternative
> which is scalable.
>
> Just a wild thought...
>
> May be we can abstract all the necessary/used power domain programmin=
g
> entities inside a structure and export that. That should contain, pow=
er
> state, logic state, mem state, special quirk flags like SAR etc.
> being structure is always expandable and an API taking structure as
> a parameter need not change.
That is the goal. This patch series uses the date from the platform
specific power domain structs and abstracts those in the API.

So in summary I would say that the power domain code callers do
benefit from the API simplification and the abstraction of thr power
domains parameters:
- cpuidle: the logic state field is removed from the structs; the
power domain state checks are simplified,
- per-device PM QoS: the latency parameters are specified for every
functional power state,
- pmxxxx.c: the suspend/resume code is simplified; the power domain
state checks are simplified.

>
> Regards
> Santosh
>

What do you think?

Thanks,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
