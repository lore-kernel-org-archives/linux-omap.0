From: Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH 2/2] ARM: omap: timers: reduce rating of gp_timer
 clocksource
Date: Mon, 5 Dec 2016 09:42:24 +0530
Message-ID: <e4a6cf51-ff9f-68ce-7486-202bae842c3d@ti.com>
References: <1479968355-18860-1-git-send-email-j-keerthy@ti.com>
 <1479968355-18860-2-git-send-email-j-keerthy@ti.com>
 <d3a71d3d-3015-bb1f-80a4-4bb9adecaa4c@ti.com>
 <20161202164714.GB4705@atomide.com>
 <14878d85-1b08-5df1-4e67-6f982ba72019@ti.com>
 <20161202183139.GF4705@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161202183139.GF4705@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: t-kristo@ti.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org



On Saturday 03 December 2016 12:01 AM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [161202 10:02]:
>>
>>
>> On 12/02/2016 10:47 AM, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [161129 08:43]:
>>>>
>>>>
>>>> On 11/24/2016 12:19 AM, Keerthy wrote:
>>>>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>>
>>>>> Now ARM Global timer (rating 300) will not be selected as clocksource,
>>>>> because it's initialized after OMAP GP Timer (rating 300) and
>>>>> Timekeeping core will not allow to replace clocksource with new one if
>>>>> both of them have the same rating.
>>>>>
>>>>> Reduce rating of OMAP GP Timer (300->290) when it's used as
>>>>> clocksource device - this will allow to select ARM Global timer (300)
>>>>> as clocksource when enabled.
>>>>>
>>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>>>
>>>> Unfortunately, this patch has dependency [1] and can't be used alone as
>>>> it will cause ARM Global timer to be selected as clocksource
>>>> always on am437x and this will kill cpuidle, because ARM Global timer
>>>> is not in always_on domain.
>>>>
>>>> The intention of enabling ARM Global timer is only for non-pm aware use
>>>> cases for RT-kernel latency improvement - where deep cpuidle states are not
>>>> enabled.
>>>
>>> Yeah we need to fix up things to be able to change the clocksource
>>> in addition to clockevent. However, currently only cpuidle_coupled
>>> knows when the whole system is idle, so quite a bit of work is
>>> needed to do that in a sane way.
>>
>> Also sched_clock and timer_delay ;)
>
> Yeah sched_clock would need something to save and restore it..
> Not nice :)
>
>>> What about the first patch in this series?
>>>
>>
>> Fist one is ok. It was originally posted long time ago.
>
> OK so can you please resend that one more time with proper
> Fixes tag on it?

Tony,

I have posted a v2 with the proper Fixes tag.

- Keerthy
>
> Regards,
>
> Tony
>
