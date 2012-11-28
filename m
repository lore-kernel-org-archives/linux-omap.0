From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: Fix realtime_counter_init warning in
 timer.c
Date: Wed, 28 Nov 2012 21:34:49 +0530
Message-ID: <50B63621.7010007@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com> <1354068915-3378-2-git-send-email-jon-hunter@ti.com> <50B5AAB4.9010103@ti.com> <50B631F8.8010608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39598 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab2K1QEc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 11:04:32 -0500
In-Reply-To: <50B631F8.8010608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 28 November 2012 09:17 PM, Jon Hunter wrote:
>
> On 11/28/2012 12:09 AM, Santosh Shilimkar wrote:
>> On Wednesday 28 November 2012 07:45 AM, Jon Hunter wrote:
>>> In commit fa6d79d (ARM: OMAP: Add initialisation for the real-time
>>> counter), the function realtime_counter_init() was added. However, =
if
>>> the kernel configuration option CONFIG_SOC_OMAP5 is not selected th=
en
>>> the following compiler warning is observed.
>>>
>>>     CC      arch/arm/mach-omap2/timer.o
>>>     arch/arm/mach-omap2/timer.c:489:20: warning: =91realtime_counte=
r_init=92
>>>     defined but not used [-Wunused-function]
>>>
>>> Commit fa6d79d also introduced the kernel configuration option
>>> CONFIG_SOC_HAS_REALTIME_COUNTER. If this option is not selected the=
n the
>>> a stub function for realtime_counter_init() is defined.
>>>
>>> The option CONFIG_SOC_HAS_REALTIME_COUNTER and stub function are no=
t
>>> really needed because ...
>>>
>>> 1. For non-OMAP5 devices, there is no realtime counter and so
>>>      realtime_counter_init() function is not used.
>>> 2. For OMAP5 devices, CONFIG_SOC_HAS_REALTIME_COUNTER is always sel=
ected
>>>      and cannot be disabled, so the stub function for
>>> realtime_counter_init()
>>>      is never used.
>>>
>>> Fix this warning by removing the kernel configuration option
>>> CONFIG_SOC_HAS_REALTIME_COUNTER and stub function, and only include
>>> the function realtime_counter_init() if CONFIG_SOC_OMAP5 is selecte=
d.
>>>
>>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>>
>>> Reported-by: Tony Lindgren <tony@atomide.com>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>> The #ifdef was avoided because the real-time counter can be used on
>> other future SOCs. And the those SOCs just select
>> SOC_HAS_REALTIME_COUNTER. And that stub was added because OMAP5 can
>> work without real-time counter configuration enabled using 32K count=
er.
>> But since we are any way have that SOC_HAS_REALTIME_COUNTER always
>> set for SOC which wants to use it, we can actually remove the stub
>> and hence avoid the warning. Let me know if below patch is ok
>> with you ? attached the same for mailer issues
>>
>>  From e000aa13e47e29fbe3473bfd0277cb057c3160cc Mon Sep 17 00:00:00 2=
001
>> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Date: Wed, 28 Nov 2012 11:28:57 +0530
>> Subject: [PATCH] ARM: OMAP2+: Fix realtime_counter_init warning in t=
imer.c
>> MIME-Version: 1.0
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> In commit fa6d79d (ARM: OMAP: Add initialisation for the real-time
>> counter), the function realtime_counter_init() was added. However, i=
f
>> the kernel configuration option CONFIG_SOC_OMAP5 is not selected the=
n
>> the following compiler warning is observed.
>>
>>      CC      arch/arm/mach-omap2/timer.o
>>      arch/arm/mach-omap2/timer.c:489:20: warning: =91realtime_counte=
r_init=92
>>      defined but not used [-Wunused-function]
>>
>> It is because of the stub init function which was added for the case=
s
>> where realtime_counter_init() is called with
>> !CONFIG_SOC_HAS_REALTIME_COUNTER.
>> This is actually not necessary since the SOC which need this feature
>> will explicitly select the configuration.
>>
>> So just drop the unused stub to avoid the build warning.
>>
>> Patch is made after seeing Jon's patch which was wrapping the
>> real-time counter code under needed SOC #ifdef
>>
>> Cc: Jon Hunter <jon-hunter@ti.com>
>>
>> Reported-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>   arch/arm/mach-omap2/timer.c |    3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer=
=2Ec
>> index 69e4663..79d8e6b 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -428,9 +428,6 @@ static void __init realtime_counter_init(void)
>>
>>       iounmap(base);
>>   }
>> -#else
>> -static inline void __init realtime_counter_init(void)
>> -{}
>>   #endif
>>
>>   #define OMAP_SYS_TIMER_INIT(name, clkev_nr, clkev_src,            =
\
>
> Hi Santosh,
>
> Thanks for the feedback. Unfortunately, the above is not enough. If I
> disable SOC_OMAP5 and leave SOC_HAS_REALTIME_COUNTER enabled, then I
> still see the warning message. So I could see that people could still
> hit this with randconfig.
>
Yes. For the same reason initially, the stub was added.

> Understand the desire to make this a selectable configuration, but gi=
ven
> to date only OMAP5 uses it, it was simpler and cleaner just to remove
> the option. However, we could keep the option and just do something l=
ike ...
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 813c267..500f2f6 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -26,6 +26,8 @@ config SOC_HAS_OMAP2_SDRC
>
>   config SOC_HAS_REALTIME_COUNTER
>          bool "Real time free running counter"
> +       depends on SOC_OMAP5
> +       default y
>
>   config ARCH_OMAP2
>          bool "TI OMAP2"
> @@ -79,7 +81,6 @@ config SOC_OMAP5
>          select ARM_GIC
>          select CPU_V7
>          select HAVE_SMP
> -       select SOC_HAS_REALTIME_COUNTER
>          select COMMON_CLK
>
> I have tested this and this resolves the warning.
>
Good. Am ok with above additional update.
May be you can add this change on top of my patch
which drops the stub.

Regards
Santosh

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
