From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP: Clean-up timer posted mode support
Date: Wed, 12 Sep 2012 22:26:47 -0500
Message-ID: <50515277.9050500@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com> <1346871872-24413-9-git-send-email-jon-hunter@ti.com> <20120907222223.GQ1303@atomide.com> <504E62C8.8030100@ti.com> <20120911005802.GE1303@atomide.com> <504F661F.1020209@ti.com> <20120911163400.GD23092@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50842 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925Ab2IMD0x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Sep 2012 23:26:53 -0400
In-Reply-To: <20120911163400.GD23092@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 09/11/2012 11:34 AM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120911 09:26]:
>>
>> On 09/10/2012 07:58 PM, Tony Lindgren wrote:
>>> * Jon Hunter <jon-hunter@ti.com> [120910 15:00]:
>>>>
>>>> On 09/07/2012 05:22 PM, Tony Lindgren wrote:
>>>>> * Jon Hunter <jon-hunter@ti.com> [120905 12:05]:
>>>>>> The dmtimer functions to read and write the dmtimer registers are currently
>>>>>> defined as follows ...
>>>>>>
>>>>>> static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
>>>>>> 						int posted);
>>>>>> static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
>>>>>> 						u32 reg, u32 val, int posted);
>>>>>>
>>>>>> The posted variable indicates if the timer is configured to use the posted mode
>>>>>> when performing register accesses. The posted mode configuration of the dmtimer
>>>>>> is stored in the omap_dm_timer structure that is also being passed to the above
>>>>>> functions and therefore we do not need to pass the posted variable separately.
>>>>>> Therefore, simplify the above functions by removing the posted variable as an
>>>>>> argument as this is not necessary.
>>>>>
>>>>> I believe the reason for passing the posted flag was to optimize out some
>>>>> functions from the timer code as that's being run all the time.
>>>>>
>>>>> Care to check the assembly before and after this patch for the timer
>>>>> functions with objdump -d to make sure it does not add tons of bloat
>>>>> there?
>>>>
>>>> Hi Tony,
>>>>
>>>> Thanks for the details here. I see that makes sense and that the
>>>> compiler could take advantage of this as the functions are inlined.
>>>>
>>>> I have taken a look at the disassembled output using objdump as you
>>>> mentioned. What I see is ...
>>>>
>>>> 1. For dmtimer.c the impact appears negligible, the total number of
>>>>    lines outputted by objdump only changed by 8 with (1215 lines) and
>>>>    without (1207 lines) the patch applied.
>>>>
>>>> 2. For timer.c the impact is greater. I see that
>>>>    omap2_gp_timer_set_next_event() increased by 6 instructions from 29
>>>>    to 35. clocksource_read_cycles() increased by 2 instructions 15 to
>>>>    17 instructions. dmtimer_read_sched_clock() increased by 2
>>>>    instructions from 17 to 19. omap2_gp_timer_set_mode() increased by
>>>>    21 instructions from 102 to 123.
>>>>
>>>> I imagine that we are mainly concerned about
>>>> omap2_gp_timer_set_next_event(), clocksource_read_cycles() and
>>>> dmtimer_read_sched_clock() as these will be called often. Therefore, I
>>>> am not sure if you wish to drop this patch.
>>>
>>> Well does it at lots of new ldr to the critical code?
>>
>> For the omap2_gp_timer_set_next_event() function it adds 3 load
>> instructions, increasing the number of possible loads from 11 to 14.
>>
>> For the clocksource_read_cycles() function it adds 1 load instruction,
>> increasing the number of possible loads from 7 to 8.
>>
>> For the dmtimer_read_sched_clock() function, I don't see any additional
>> loads, but instructions added are a tst and beq instruction.
>>
>>>> By the way, if we do drop this patch, I would then need to fix the
>>>> setting of the posted variable in mach-omap2/timer.c for clock-source in
>>>> the case where a dmtimer is used. Today the code assumes that for
>>>> clock-source and clock-events posted mode is always used. However, with
>>>> the errata i103/i767 we will disable posted mode for clock-source on
>>>> omap2/3/4/5/am33xx devices.
>>>
>>> Yes I see, I guess that means just adding a new systimer entry?
>>
>> Actually, I think we can avoid that by not using posted mode for
>> clock-source timers at all. Posted mode only benefits the clock-events
>> timers that are configured often.
>>
>> The benefit of not using posted mode for clock-source timers and setting
>> the "posted" parameter to 0, will really allow the compiler to optimise
>> the clocksource_read_cycles() and dmtimer_read_sched_clock() quite a
>> bit. So this could be a nice optimisation.
> 
> OK up to you, but maybe run some benchmarks first to figure out what
> makes most sense? Updating the timer used to be a bottleneck earlier.

Ok, let me re-work this. Thanks for the inputs.

Cheers
Jon
