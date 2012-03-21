From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC][PATCH 0/7] OMAP4 cpuidle cleanup
Date: Wed, 21 Mar 2012 11:43:29 +0100
Message-ID: <4F69B0D1.6020608@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org> <CAMQu2gxit11dSbruPLCGx37TRwo9mwNCN9JXn0fZLDTVGu2GcA@mail.gmail.com> <4F69A4A5.5020208@linaro.org> <4F69A5BA.1080804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64635 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232Ab2CUKnd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Mar 2012 06:43:33 -0400
Received: by bkcik5 with SMTP id ik5so766328bkc.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 03:43:31 -0700 (PDT)
In-Reply-To: <4F69A5BA.1080804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

On 03/21/2012 10:56 AM, Santosh Shilimkar wrote:
> On Wednesday 21 March 2012 03:21 PM, Daniel Lezcano wrote:
>> On 03/21/2012 10:36 AM, Shilimkar, Santosh wrote:
>>> On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org>   wrote:
>>>> This patchset is a proposition to improve a bit the code.
>>>> The changes are code cleanup and does not change the behavior of t=
he
>>>> driver itself.
>>>>
>>> Thanks. Will have a look at your series.
>>
>> Cool, thanks.
>>
>>>> A couple a things call my intention. Why the cpuidle device is set
>>>> for cpu0 only
>>> Because the mainline code CPUIDLE is supported along with CPUhotplu=
g.
>>> This is going to change though with Couple CPUIDLE and correspondin=
g
>>> OMAP updates.
>>
>> Ok, thanks for the information. I will look deeper. What happens to =
cpu1
>> when it is online and has nothing to do ?
>>
>>>> and why the WFI is not used ?
>>>>
>>> I didn't get this question. Do you mean the generic WFI?
>>
> I execute default idle loop.

So is it not possible to add a cpuidle device for cpu1 and define only=20
one state for the 'wfi-for-omap' ?

>> yes.
>>
>>> If yes, then, it's mainly because OMAP need additional
>>> custom barriers.
>>
>> Ah, ok. I am not sure if it is possible but that may be cool if we c=
an
>> call cpu_do_idle instead with additional barrier.
>>
> There is no need. Since code around WFI is customised, it make no sen=
se
> to call cpu_do_idle(0 ofr only that instruction sake.

=46or my personal information, why the WFI is customised for omap4 ?

Thanks
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
