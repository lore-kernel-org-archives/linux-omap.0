From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 16:19:22 +0530
Message-ID: <CAMQu2gwDtHBV=iPtxaOyyUHUVwPBTE2woY22U0SSdqruBNuo3Q@mail.gmail.com>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <CAMQu2gxit11dSbruPLCGx37TRwo9mwNCN9JXn0fZLDTVGu2GcA@mail.gmail.com>
 <4F69A4A5.5020208@linaro.org> <4F69A5BA.1080804@ti.com> <4F69B0D1.6020608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:60806 "EHLO
	psmtp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754127Ab2CUKtn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 06:49:43 -0400
Received: by mail-qc0-f174.google.com with SMTP id w6so694850qcq.33
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 03:49:42 -0700 (PDT)
In-Reply-To: <4F69B0D1.6020608@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On Wed, Mar 21, 2012 at 4:13 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 03/21/2012 10:56 AM, Santosh Shilimkar wrote:
>>
>> On Wednesday 21 March 2012 03:21 PM, Daniel Lezcano wrote:
>>>
>>> On 03/21/2012 10:36 AM, Shilimkar, Santosh wrote:
>>>>
>>>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>>>> <daniel.lezcano@linaro.org> =A0 wrote:
>>>>>
>>>>> This patchset is a proposition to improve a bit the code.
>>>>> The changes are code cleanup and does not change the behavior of =
the
>>>>> driver itself.
>>>>>
>>>> Thanks. Will have a look at your series.
>>>
>>>
>>> Cool, thanks.
>>>
>>>>> A couple a things call my intention. Why the cpuidle device is se=
t
>>>>> for cpu0 only
>>>>
>>>> Because the mainline code CPUIDLE is supported along with CPUhotpl=
ug.
>>>> This is going to change though with Couple CPUIDLE and correspondi=
ng
>>>> OMAP updates.
>>>
>>>
>>> Ok, thanks for the information. I will look deeper. What happens to=
 cpu1
>>> when it is online and has nothing to do ?
>>>
>>>>> and why the WFI is not used ?
>>>>>
>>>> I didn't get this question. Do you mean the generic WFI?
>>>
>>>
>> I execute default idle loop.
>
>
> So is it not possible to add a cpuidle device for cpu1 and define onl=
y one
> state for the 'wfi-for-omap' ?
>
That's how my post was handling it. But after the review Kevin suggeste=
d
me to drop the CPU1 shallow state since it was same as default idle.

>
>>> yes.
>>>
>>>> If yes, then, it's mainly because OMAP need additional
>>>> custom barriers.
>>>
>>>
>>> Ah, ok. I am not sure if it is possible but that may be cool if we =
can
>>> call cpu_do_idle instead with additional barrier.
>>>
>> There is no need. Since code around WFI is customised, it make no se=
nse
>> to call cpu_do_idle(0 ofr only that instruction sake.
>
>
> For my personal information, why the WFI is customised for omap4 ?
>
OMAP4 silicon has couple of hardware issues around interconnect
and needs to drain the axi buffers with strongly order writes to
ensure that data reaches to peripherals and not get stuck. That
lead to have custom function. Note that, the wfi instruction
itself is same.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
