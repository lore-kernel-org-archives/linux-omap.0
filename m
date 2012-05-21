From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/6] ARM: OMAP2+: PM: introduce power domains functional states
Date: Mon, 21 May 2012 19:55:26 +0530
Message-ID: <CAMQu2gwBYUmBLV+wByVxto_ETu6-YjHycGWnhVn-Tb9pJUngDw@mail.gmail.com>
References: <1334752782-28804-1-git-send-email-j-pihet@ti.com>
 <1334752782-28804-3-git-send-email-j-pihet@ti.com> <alpine.DEB.2.00.1205070043230.9984@utopia.booyaka.com>
 <CAORVsuXUbz_f54x=hoFLEQpfAGTDcZGnTQ-fBgY_j415LC0TiQ@mail.gmail.com>
 <4FB4CD45.4050807@ti.com> <CAORVsuWgn5Zuf9T1eVBjJJhTGL5jrY=hirTaZp8E2HprzbvHng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:50239 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757546Ab2EUOZx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 10:25:53 -0400
Received: by qabg1 with SMTP id g1so1717620qab.13
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 07:25:47 -0700 (PDT)
In-Reply-To: <CAORVsuWgn5Zuf9T1eVBjJJhTGL5jrY=hirTaZp8E2HprzbvHng@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, b-cousson@ti.com, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

Jean,

On Mon, May 21, 2012 at 7:23 PM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Hi Santosh,
>
> On Thu, May 17, 2012 at 12:04 PM, Santosh Shilimkar
> <santosh.shilimkar@ti.com> wrote:
>> Jean,
>> On Tuesday 08 May 2012 02:10 PM, Jean Pihet wrote:
>>> Paul,
>>>
>>> On Mon, May 7, 2012 at 11:28 AM, Paul Walmsley <paul@pwsan.com> wro=
te:
>>>> Hi
>>>>
>>>> On Wed, 18 Apr 2012, jean.pihet@newoldbits.com wrote:
>>>>
>>>>> From: Jean Pihet <j-pihet@ti.com>
>>>>>
>>>>> Introduce functional (or logical) states for power domains and th=
e
>>>>> API functions to read the power domains settings and to convert
>>>>> between the functional (i.e. logical) and the internal (or regist=
ers)
>>>>> values.
>>>>>
>>>>> OMAP2, OMAP3 and OMAP4 platforms are defining a conversion routin=
e.
>>>>>
>>>>> In the new API the function omap_set_pwrdm_state takes the functi=
onal
>>>>> states as parameter; while at it the function is moved to the pow=
er
>>>>> domains code.
>>>>>
>>>>> The memory and logic states are not using the functional states, =
this
>>>>> comes as a subsequent patch.
>>>>>
>>>>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>>>>
>>>> This patch results in several checkpatch warnings; please resolve =
them.
>>> Oops. Will check and update.
>>>
>>>>
>>>>> ---
>>>>> =A0arch/arm/mach-omap2/pm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 66 -----------
>>>>> =A0arch/arm/mach-omap2/powerdomain-common.c =A0 | =A0 61 ++++++++=
++
>>>>> =A0arch/arm/mach-omap2/powerdomain.c =A0 =A0 =A0 =A0 =A0| =A0175 =
++++++++++++++++++++++++++++
>>>>> =A0arch/arm/mach-omap2/powerdomain.h =A0 =A0 =A0 =A0 =A0| =A0 21 =
++++
>>>>> =A0arch/arm/mach-omap2/powerdomain2xxx_3xxx.c | =A0 =A05 +
>>>>> =A0arch/arm/mach-omap2/powerdomain44xx.c =A0 =A0 =A0| =A0 =A02 +
>>>>> =A06 files changed, 264 insertions(+), 66 deletions(-)
>>>>>
>>> ...
>>>
>>>>> +/*
>>>>> + * Functional (i.e. logical) to internal (i.e. registers)
>>>>> + * values for the power domains states
>>>>> + */
>>>>
>>>> Please use kerneldoc-style function comments.
>>> Ok
>>>
>>>>
>>>>> +int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func=
_pwrst)
>>>>> +{
>>>>> + =A0 =A0 int ret;
>>>>> +
>>>>> + =A0 =A0 switch (func_pwrst) {
>>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_ON:
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_ON;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_INACTIVE:
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_INACTIVE;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
>>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_RET;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>>> + =A0 =A0 case PWRDM_FUNC_PWRST_OFF:
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_OFF;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>>>>> + =A0 =A0 default:
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -1;
>>>>> + =A0 =A0 }
>>>>> +
>>>>> + =A0 =A0 return ret;
>>>>> +}
>>>>
>>>> At a quick glance, I don't think that this function is appropriate=
 for all
>>>> OMAP2+ chips. =A0For example, off-mode is not supported in our OMA=
P2xxx
>>>> kernels. =A0And OMAP2xxx/3xxx do not support the INACTIVE powersta=
te. =A0So
>>>> probably this function should differ by chip, and be located in th=
e
>>>> powerdomain[2-4]*xx*.c files.
>>> I hope to make this function as generic as possible, hence the
>>> location (powerdomain-common.c). Some states are not programmed by =
the
>>> pwrdm_* functions since there forbidden by the contents of the
>>> pwrdm->pwrst field.
>>> Now if the need arises some platform specific function can be defin=
ed
>>> for conversion functions since the pwrdm->ops function pointers are
>>> used. I do not think it is needed now but it can easily be changed.
>>>
>>>> Also, what about the logic and memory bank power states? =A0Should=
n't this
>>>> function pass those back as well?
>>> Cf. in the description "The memory and logic states are not using t=
he
>>> functional states, this comes as a subsequent patch."
>>>
>> I don't see much difference between the functional power states to
>> actual power states with some cases here and there.
>>
>> + =A0 =A0 case PWRDM_FUNC_PWRST_CSWR:
>> + =A0 =A0 case PWRDM_FUNC_PWRST_OSWR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PWRDM_POWER_RET;
> The whole patch series takes the logic state into account in the
> functional power state.
> Cf. in the description "The memory and logic states are not using the
> functional states, this comes as a subsequent patch."
>
Yeah. i understood that from comments.

>> This is not true and even if you add logic/memmort etc support,
>> I still think, we are just duplicating stuff between functional
>> vs actual power state.
> The idea is to provide a single function to program the power domains
> state, including the logic state.
> There is no duplication of code, just a simplification in the API. IM=
O
> there are too much calls to set and get the power domain states (powe=
r
> state, logical etc.) and most of the calls do not take the logical
> state into account.
> If you look the the code in pmxxxx.c and cpuidlexxxx.c you will notic=
e
> that the code is simplified.
>
I noticed that but thought that simplification is not substantial.

>> If the idea is to have one single interface to program the power
>> domain states, so that Generic frameworks, or PM code movement to
>> driver/* directories is easier, we may want think about alternative
>> which is scalable.
>>
>> Just a wild thought...
>>
>> May be we can abstract all the necessary/used power domain programmi=
ng
>> entities inside a structure and export that. That should contain, po=
wer
>> state, logic state, mem state, special quirk flags like SAR etc.
>> being structure is always expandable and an API taking structure as
>> a parameter need not change.
> That is the goal. This patch series uses the date from the platform
> specific power domain structs and abstracts those in the API.
>
Good to know that we are on same page.

> So in summary I would say that the power domain code callers do
> benefit from the API simplification and the abstraction of thr power
> domains parameters:
I agree. I am just worried about this 1 API because we have many used
programmable nobs. For example the API assumes all the power domain
same and while programming the powerdomain deeper state, does
clockdomain wakeup and sleep transition sequence. Such a process
is not needed for domain like CPU/MPU PD's because they are
powerdown them self.

> - cpuidle: the logic state field is removed from the structs; the
> power domain state checks are simplified,
> - per-device PM QoS: the latency parameters are specified for every
> functional power state,
> - pmxxxx.c: the suspend/resume code is simplified; the power domain
> state checks are simplified.
>
QOS does need functional power state especially since CSWR and OSWR
has such a huge difference in terms of latency.

>>
>> Regards
>> Santosh
>>
>
> What do you think?
>
I like the idea as mentioned. I just think the series should already
take care of memory state, logic state and quirk flags to see how
it looks overall. Will have one more fresh look at the series but if
you have subsequent WIP patches which can handle the other
parameters, please send that link.

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
