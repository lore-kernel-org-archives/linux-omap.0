From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 01/10] ARM: OMAP3+: Implement timer workaround for errata
 i103 and i767
Date: Thu, 6 Sep 2012 09:42:10 -0500
Message-ID: <5048B642.2070200@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com> <1346871872-24413-2-git-send-email-jon-hunter@ti.com> <50482FAC.3080807@ti.com> <5048ADD0.4050804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44314 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756294Ab2IFOmP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Sep 2012 10:42:15 -0400
In-Reply-To: <5048ADD0.4050804@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 09/06/2012 09:06 AM, Jon Hunter wrote:
> 
> On 09/06/2012 12:07 AM, Vaibhav Hiremath wrote:
>>
>>
>> On 9/6/2012 12:34 AM, Jon Hunter wrote:
>>> Errata Titles:
>>> i103: Delay needed to read some GP timer, WD timer and sync timer registers
>>>       after wakeup (OMAP3/4)
>>> i767: Delay needed to read some GP timer registers after wakeup (OMAP5)
>>>
>>> Description (i103/i767):
>>> If a General Purpose Timer (GPTimer) is in posted mode (TSICR [2].POSTED=1),
>>> due to internal resynchronizations, values read in TCRR, TCAR1 and TCAR2
>>> registers right after the timer interface clock (L4) goes from stopped to
>>> active may not return the expected values. The most common event leading to
>>> this situation occurs upon wake up from idle.
>>>
>>> GPTimer non-posted synchronization mode is not impacted by this limitation.
>>>
>>> Workarounds:
>>> 1). Disable posted mode
>>> 2). Use static dependency between timer clock domain and MPUSS clock domain
>>> 3). Use no-idle mode when the timer is active
>>>
>>> Workarounds #2 and #3 are not pratical from a power standpoint and so
>>> workaround #1 has been implemented. Disabling posted mode adds some CPU overhead
>>> for configuring the timers as the CPU has to wait for the write to complete.
>>> However, disabling posted mode guarantees correct operation.
>>>
>>> Please note that it is safe to use posted mode for timers if the counter (TCRR)
>>> and capture (TCARx) registers will never be read. An example of this is the
>>> clock-event system timer. This is used by the kernel to schedule events however,
>>> the timers counter is never read and capture registers are not used. Given that
>>> the kernel configures this timer often yet never reads the counter register it
>>> is safe to enable posted mode in this case. Hence, for the timer used for kernel
>>> clock-events, posted mode is enabled by overriding the errata for devices that
>>> are impacted by this defect.
>>>
>>> Although both dmtimers and watchdogs are impacted by this defect this patch only
>>> implements the workaround for the dmtimer. Currently the watchdog driver does
>>> not read the counter register and so no workaround is necessary.
>>>
>>> Confirmed with Vaibhav Hiremath that this bug also impacts AM33xx devices.
>>>
>>
>> Thanks for pinging me on this and getting it confirmed.
>>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>> ---
>>>  arch/arm/mach-omap2/timer.c               |    9 +++++++
>>>  arch/arm/plat-omap/dmtimer.c              |    2 ++
>>>  arch/arm/plat-omap/include/plat/dmtimer.h |   39 +++++++++++++++++++++++++++++
>>>  3 files changed, 50 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>>> index 2ff6d41..5471706 100644
>>> --- a/arch/arm/mach-omap2/timer.c
>>> +++ b/arch/arm/mach-omap2/timer.c
>>> @@ -208,6 +208,13 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
>>>  {
>>>  	int res;
>>>  
>>> +	/*
>>> +	 * For clock-event timers we never read the timer counter and
>>> +	 * so we are not impacted by errata i103 and i767. Therefore,
>>> +	 * we can safely ignore this errata for clock-event timers.
>>> +	 */
>>> +	__omap_dm_timer_populate_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
>>> +
>>
>> Couple of points,
>>
>> 1. It is confusing to me, as you are passing the errata flag so i expect
>> api should set it. Why can't we do reverse way, you pass 0 here, since
>> you don't want to set and pass this flag every other places where you
>> want to enable this errata.
> 
> Per the design of the __omap_dm_timer_populate_errata function, the 2nd
> argument is called override to allow us to override an errata. I am not
> a huge fan of this, but I wanted to be explicit in the code that we are
> intentionally allowing posted mode for the clock-events timer.
> 
> I did not wish to pass the flags we want to set because if there more
> flags added in the future then we will have to keep changing the calls
> to the populate_errata function to add these.

By the way, your proposal could work nicely if we could pass errata
flags from HWMOD. However, I am not sure if Paul or Benoit would go for
this as they want HWMOD data to be auto-generated as much as possible
and so I am not sure how that would work for errata which are not
expected by design ;-)

Cheers
Jon
