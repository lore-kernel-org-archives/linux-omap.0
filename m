From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/3] ARM: AM335x: Fix warning in timer.c
Date: Wed, 28 Nov 2012 10:06:07 -0600
Message-ID: <50B6366F.9060207@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com> <1354068915-3378-4-git-send-email-jon-hunter@ti.com> <50B5AF29.4020306@ti.com> <50B5B33C.8020007@compulab.co.il> <50B5BB5A.4060200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42265 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828Ab2K1QGQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 11:06:16 -0500
In-Reply-To: <50B5BB5A.4060200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/28/2012 01:20 AM, Santosh Shilimkar wrote:
> On Wednesday 28 November 2012 12:16 PM, Igor Grinberg wrote:
>> On 11/28/12 08:28, Santosh Shilimkar wrote:
>>> On Wednesday 28 November 2012 07:45 AM, Jon Hunter wrote:
>>>> When compiling the kernel with configuration options ...
>>>>
>>>>    # CONFIG_ARCH_OMAP2 is not set
>>>>    # CONFIG_ARCH_OMAP3 is not set
>>>>    # CONFIG_ARCH_OMAP4 is not set
>>>>    # CONFIG_SOC_OMAP5 is not set
>>>>    CONFIG_SOC_AM33XX=3Dy
>>>>
>>>>    ... the following build warning is seen.
>>>>
>>>>     CC      arch/arm/mach-omap2/timer.o
>>>>     arch/arm/mach-omap2/timer.c:395:19: warning:
>>>> =E2=80=98omap2_sync32k_clocksource_init=E2=80=99
>>>>         defined but not used [-Wunused-function]
>>>>
>>>> This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: r=
emove
>>>> CONFIG_OMAP_32K_TIMER) where the omap2_sync32k_clocksource_init() =
is no
>>>> longer referenced by the timer initialisation function for the AM3=
35x
>>>> device as it has no 32k-sync timer.
>>>>
>>>> Fix this by only including the omap2_sync32k_clocksource_init()
>>>> function
>>>> if either OMAP2, OMAP3, OMAP4 or OMAP5 devices are enabled.
>>>>
>>>> Cc: Igor Grinberg <grinberg@compulab.co.il>
>>>>
>>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>>> ---
>>>>    arch/arm/mach-omap2/timer.c |    3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/tim=
er.c
>>>> index eb96712..085c7e7 100644
>>>> --- a/arch/arm/mach-omap2/timer.c
>>>> +++ b/arch/arm/mach-omap2/timer.c
>>>> @@ -386,6 +386,8 @@ static u32 notrace dmtimer_read_sched_clock(vo=
id)
>>>>        return 0;
>>>>    }
>>>>
>>>> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
>>>> +    defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
>>> #ifndef CONFIG_SOC_AM33XX ?
>>>
>>> #ifdef things are really ugly and needs constant patching and
>>> hence something like CONFIG_HAS_32K kind of feature flags are
>>> better. But that will undo certain part of f80b3b
>>> (ARM: OMAP2+: timer: remove  CONFIG_OMAP_32K_TIMER).
>>
>> Agreed on ugliness of ifdefs.
>> What about adding __maybe_unused to the function signature?
>> That will cover any future SoC also w/o the need to extend the ifdef=
s.
>>
> Sounds good to me.

Yes agree on the ugliness of this. However, my thought was these would
only remain until we migrate over to device-tree and then the detection
of the a 32k source can be determine via DT.

However, I can update to use __maybe_unused for now. We just need to
remember to remove this in the future if it becomes unnecessary :-)

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
