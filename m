From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Thu, 22 Mar 2012 22:45:03 +0100
Message-ID: <4F6B9D5F.9040602@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <4F69A872.50203@ti.com> <CAORVsuUeE046O7YJ_fE49NbW1OjZHZX+GuNiDkF0AnzBnSMbxA@mail.gmail.com> <4F6A04F3.6050306@linaro.org> <873991d3hs.fsf@ti.com> <4F6A5430.2090501@linaro.org> <87fwd07aaz.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45530 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083Ab2CVVpF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 17:45:05 -0400
Received: by wejx9 with SMTP id x9so2207868wej.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Mar 2012 14:45:04 -0700 (PDT)
In-Reply-To: <87fwd07aaz.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Linaro Dev <linaro-dev@lists.linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 03/22/2012 07:36 PM, Kevin Hilman wrote:
> Daniel Lezcano<daniel.lezcano@linaro.org>  writes:
>
>> On 03/21/2012 10:54 PM, Kevin Hilman wrote:
>>> Daniel Lezcano<daniel.lezcano@linaro.org>   writes:
>>>
>>>> On 03/21/2012 02:43 PM, Jean Pihet wrote:
>>>>> On Wed, Mar 21, 2012 at 11:07 AM, Santosh Shilimkar
>>>>> <santosh.shilimkar@ti.com>    wrote:
>>>>>> Daniel,
>>>>>>
>>>>>> On Wednesday 21 March 2012 02:57 PM, Daniel Lezcano wrote:
>>>>>>> This patchset is a proposition to improve a bit the code.
>>>>>>> The changes are code cleanup and does not change the behavior o=
f the
>>>>>>> driver itself.
>>>>>>>
>>>>>>> A couple a things call my intention. Why the cpuidle device is =
set for cpu0 only
>>>>>>> and why the WFI is not used ?
>>>>>>>
>>>>>>> Daniel Lezcano (7):
>>>>>>>      ARM: OMAP4: cpuidle - Remove unused valid field
>>>>>>>      ARM: OMAP4: cpuidle - Declare the states with the driver d=
eclaration
>>>>>>>      ARM: OMAP4: cpuidle - Remove the cpuidle_params_table tabl=
e
>>>>>>>      ARM: OMAP4: cpuidle - fix static omap4_idle_data declarati=
on
>>>>>>>      ARM: OMAP4: cpuidle - Initialize omap4_idle_data at compil=
e time
>>>>>>>      ARM: OMAP4: cpuidle - use the omap4_idle_data variable dir=
ectly
>>>>>>>      ARM: OMAP4: cpuidle - remove omap4_idle_data initializatio=
n at boot
>>>>>>>        time
>>>>>>>
>>>>>> The series looks fine to me in general. This clean-up is applica=
ble
>>>>>> for OMAP3 cpuidle code as well.
>>>>> Great!
>>>>> However OMAP3 has a few specific things that cannot be removed as=
 easily:
>>>>> - the 'valid' flag is used because only certain combinations of p=
ower
>>>>> domains states are possible,
>>>>
>>>> When I look the board-rx51 code I see:
>>>>
>>>> static struct cpuidle_params rx51_cpuidle_params[] =3D {
>>>> 	/* C1 */
>>>> 	{110 + 162, 5 , 1},
>>>> 	/* C2 */
>>>> 	{106 + 180, 309, 1},
>>>> 	/* C3 */
>>>> 	{107 + 410, 46057, 0},
>>>> 	/* C4 */
>>>> 	{121 + 3374, 46057, 0},
>>>> 	/* C5 */
>>>> 	{855 + 1146, 46057, 1},
>>>> 	/* C6 */
>>>> 	{7580 + 4134, 484329, 0},
>>>> 	/* C7 */
>>>> 	{7505 + 15274, 484329, 1},
>>>> };
>>>>
>>>> If C3, C4, C6 are not valid, so AFAICS never used in the cpuidle c=
ode
>>>> why the values are 'exit_latency' and 'target_residency' specified=
 ? I
>>>> mean why don't we have { 0, 0, 0 } ? Is it just for information ?
>>>
>>> Yes, because getting those numbers were based on some board-specifi=
c
>>> measurements, and we don't want those values to be lost.  Also, som=
e
>>> usage patterns might want to (re)enable those states.
>>
>> When you say re-enable you mean for a custom kernel ?
>
> Yes.
>
>>>> I understand the purpose of this code but it looks a bit tricky an=
d
>>>> hard to factor out. Is it acceptable to create a new cpuidle drive=
r
>>>> for rx51 then we factor out the code between omap3, omap4 and rx51
>>>> when all the code consistent ?
>>>
>>> I don't like that idea.  All the code is the same, the only thing w=
e
>>> need is the ability to pass in board-specific latency numbers for t=
he
>>> C-states.
>>
>> Sorry I was not clear, I was not saying duplicating the code. What I
>> meant is to create a driver:
>>
>> struct cpuidle_driver rx51_idle_driver =3D {
>>   	.name =3D 	"rx51_idle",
>> 	.owner =3D 	THIS_MODULE,
>> 	.states =3D {
>> 		{
>> 			/* What is in rx51_cpuidle_params */
>> 		}
>> 	};
>>
>> We put in there only the valid fields and we keep in a comment the
>> table with the latency numbers.
>
> Ah, OK.  I misunderstood.
>
>> Assuming the valid field is for handling the table overwritting, we
>> can then remove it. By this way, we simplify the next_valid_state
>> function.
>
> probably we can remove next_valid_state all together after 3.4 since =
the
> new sysfs entry for that feature looks to be queued in linux-next.

Oh, that could be very cool. That will remove a reasonable chunk of cod=
e.

>> Depending if we have rx51 or not, we register the rx51 driver or the
>> omap3 driver in the init function. That has also the benefit to grou=
p
>> the cpuidle code in the cpuidle34xx file.
>
> yes, but with board-specific data in SoC-specific code, which is not =
a
> clean separation IMO.  How would you plan to pass which board it's
> running on?

I was thinking using the same code path than the array overriding for=20
cpuidle_data initialization. I did not looked at this initialization=20
part in details neither the order.

>>> These latency numbers are obviously quite significant when it comes=
 to
>>> the final power consumption, and these values often depend on
>>> board-specific settings.  Until there are generic frameworks for
>>> defining all the latencies involved, passing these values in from b=
oard
>>> files is absolutly needed.
>>
>> Yes but before creating the generic framework, we have to do a
>> transversal cpuidle consolidation across the SoC, factor out the cod=
e
>> when possible, and ensure the consistency between the different
>> platform and see a common pattern to emerge from this work.
>
> Agreed, but if that means ignoring platform-specific customization, a=
nd
> not putting in other mechanisms to configure platform specific detail=
s,
> it is throwing away useful infrastructure.

Yes, I agree.

> IMO, any consolidated framework needs some way to customize or pass i=
n
> latencies from platform-specific code.  Long term, I suppose this nee=
ds
> to be DT based.

A random thought here. What do you think if we can write the latencies=20
from the userspace via sysfs ? At present, the 'latency' file is=20
read-only, may be we can add the exit_latency and make them both=20
writable. That will have the benefit of letting the userspace to tweak=20
that depending of the board without recompiling a new kernel and also=20
help to debug/improve without rebooting the host, no ?

> That being said, I do want to see this consolidation happen, so...
>
> In OMAP land, we are in the middle of putting in place a better
> framework for defining/tracking the various latencies involved in PM
> transitions (using per-device PM Qos.) After that, we will likely be
> reworking and revalidating these latency numbers for all OMAPs
>
> So maybe the best approach to help in consolidation is just to drop t=
he
> board-rx51 data all together for now, as well as the ability to pass
> custom C states from board files.

Good. If this is acceptable then that will simplify the consolidation.

> The default, unoptimized OMAP3 numbers will work fine for that board,
> and anyone wanting to do optimized power work for that platform can
> still do it with a custom kernel.  (There is still lots of out of tre=
e
> work for the n900 that never made it upstream, so I doubt the mainlin=
e
> users of n900 will be affected by this level of power tweaking.)
>
> If we do that, then as part of the consolidation effort, some DT-base=
d
> customization should be defined as well to override/customize C state=
s.

Ok, I will give a try by removing the rx51 specific cpuidle data. Then =
I=20
will be able to do similar changes than OMAP4 for OMAP3.

Thanks Kevin

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
