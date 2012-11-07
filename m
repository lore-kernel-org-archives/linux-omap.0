From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 02/14] ARM: OMAP2+: Disable posted mode for the clocksource
 timer
Date: Wed, 7 Nov 2012 16:41:47 -0600
Message-ID: <509AE3AB.8080008@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-3-git-send-email-jon-hunter@ti.com> <509ADC5F.7020307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46872 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750845Ab2KGWly (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 17:41:54 -0500
In-Reply-To: <509ADC5F.7020307@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 11/07/2012 04:10 PM, Santosh Shilimkar wrote:
> On Wednesday 07 November 2012 01:01 PM, Jon Hunter wrote:
>> When using a DMTIMER as the clock-source timer, posted mode
>> configuration of
>> the DMTIMER is used. Posted mode is only benefical when configuring
>> timers as
>> it allows writes to be posted and does not stall the CPU until the
>> write is
>> complete. The clock-source timer is only configured once on boot and
>> so using
>> posted mode has no benefit. In fact, by using posted mode, it adds
>> overhead
>> to reading the timer. Therefore, by default disable posted mode for
>> DMTIMERs
>> used for clock-source.
>>
>> Using objdump this change reduces the function clocksource_read_cycles()
>> function from a total of 15 instructions (including 3 branches and 7
>> loads)
>> to 5 instructions (including 1 branch and 3 loads). Please note that
>> before
>> the minimum number of instructions that would be executed when calling
>> clocksource_read_cycles() would be 9 instructions (including 2
>> branches and 5
>> loads) where as now it will always be 5 instructions.
>>
>> This change also reduces the function dmtimer_read_sched_clock()
>> function from
>> a total of 17 instructions (including 4 branches and 8 loads) to 6
>> instructions
>> (including 1 branch and 4 loads). Please note that before the minimum
>> number of
>> instructions that would be executed when calling
>> dmtimer_read_sched_clock()
>> would be 11 instructions (including 2 branches and 6 loads) where as
>> now it
>> will always be 6 instructions.
>>
> This isn't right way to calculate the penalty of posted mode. Non-posted
> mode can results in 100 of cycles wait over interconnect
> and that can not be justified with few instructions savings.

Right, I see your point. Non-posted reads are going to add
re-synchronisation overhead. However, our hands are tied here because of
errata i103 we can't use posted mode for reading the counter.

So may be I should squash this change with patch #3 and just make this
part of the errata workaround. I can always re-visit later and do some
profiling to see what the optimal configuration should be.

>> This change removes the configuration of posted mode from the
>> __omap_dm_timer_reset() function and adds a new function called
>> omap_dm_timer_enable_posted() for enabling posted mode. Hence, call
>> omap_dm_timer_enable_posted() where ever we are calling
>> __omap_dm_timer_reset().
>>
>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>> ---
> But clock-source doesn't involve much into writes so patch as
> such is fine.

Yes writes are only on init.

Cheers
Jon


