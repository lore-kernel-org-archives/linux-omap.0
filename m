From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 11:59:21 +0100
Message-ID: <4F69B489.9070004@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <CAMQu2gxit11dSbruPLCGx37TRwo9mwNCN9JXn0fZLDTVGu2GcA@mail.gmail.com> <4F69A4A5.5020208@linaro.org> <4F69A5BA.1080804@ti.com> <4F69B0D1.6020608@linaro.org> <CAMQu2gwDtHBV=iPtxaOyyUHUVwPBTE2woY22U0SSdqruBNuo3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54302 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab2CUK7Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 06:59:24 -0400
Received: by bkcik5 with SMTP id ik5so778188bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 03:59:23 -0700 (PDT)
In-Reply-To: <CAMQu2gwDtHBV=iPtxaOyyUHUVwPBTE2woY22U0SSdqruBNuo3Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On 03/21/2012 11:49 AM, Shilimkar, Santosh wrote:
> On Wed, Mar 21, 2012 at 4:13 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org>  wrote:
>> On 03/21/2012 10:56 AM, Santosh Shilimkar wrote:
>>>
>>> On Wednesday 21 March 2012 03:21 PM, Daniel Lezcano wrote:
>>>>
>>>> On 03/21/2012 10:36 AM, Shilimkar, Santosh wrote:
>>>>>
>>>>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org>     wrote:
>>>>>>
>>>>>> This patchset is a proposition to improve a bit the code.
>>>>>> The changes are code cleanup and does not change the behavior of=
 the
>>>>>> driver itself.
>>>>>>
>>>>> Thanks. Will have a look at your series.
>>>>
>>>>
>>>> Cool, thanks.
>>>>
>>>>>> A couple a things call my intention. Why the cpuidle device is s=
et
>>>>>> for cpu0 only
>>>>>
>>>>> Because the mainline code CPUIDLE is supported along with CPUhotp=
lug.
>>>>> This is going to change though with Couple CPUIDLE and correspond=
ing
>>>>> OMAP updates.
>>>>
>>>>
>>>> Ok, thanks for the information. I will look deeper. What happens t=
o cpu1
>>>> when it is online and has nothing to do ?
>>>>
>>>>>> and why the WFI is not used ?
>>>>>>
>>>>> I didn't get this question. Do you mean the generic WFI?
>>>>
>>>>
>>> I execute default idle loop.
>>
>>
>> So is it not possible to add a cpuidle device for cpu1 and define on=
ly one
>> state for the 'wfi-for-omap' ?
>>
> That's how my post was handling it. But after the review Kevin sugges=
ted
> me to drop the CPU1 shallow state since it was same as default idle.

Ok, thanks. I am asking that because the more I am looking at the=20
different SoCs cpuidle drivers, the more I am convinced we can factor=20
out more code across SoCs.

>>>> yes.
>>>>
>>>>> If yes, then, it's mainly because OMAP need additional
>>>>> custom barriers.
>>>>
>>>>
>>>> Ah, ok. I am not sure if it is possible but that may be cool if we=
 can
>>>> call cpu_do_idle instead with additional barrier.
>>>>
>>> There is no need. Since code around WFI is customised, it make no s=
ense
>>> to call cpu_do_idle(0 ofr only that instruction sake.
>>
>>
>> For my personal information, why the WFI is customised for omap4 ?
>>
> OMAP4 silicon has couple of hardware issues around interconnect
> and needs to drain the axi buffers with strongly order writes to
> ensure that data reaches to peripherals and not get stuck. That
> lead to have custom function. Note that, the wfi instruction
> itself is same.

Thanks for the explanation.

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
