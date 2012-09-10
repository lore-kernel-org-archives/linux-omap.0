From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 08/10] ARM: OMAP: Clean-up timer posted mode support
Date: Mon, 10 Sep 2012 16:59:36 -0500
Message-ID: <504E62C8.8030100@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com> <1346871872-24413-9-git-send-email-jon-hunter@ti.com> <20120907222223.GQ1303@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43799 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750886Ab2IJV7o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Sep 2012 17:59:44 -0400
In-Reply-To: <20120907222223.GQ1303@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>


On 09/07/2012 05:22 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [120905 12:05]:
>> The dmtimer functions to read and write the dmtimer registers are currently
>> defined as follows ...
>>
>> static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
>> 						int posted);
>> static inline void __omap_dm_timer_write(struct omap_dm_timer *timer,
>> 						u32 reg, u32 val, int posted);
>>
>> The posted variable indicates if the timer is configured to use the posted mode
>> when performing register accesses. The posted mode configuration of the dmtimer
>> is stored in the omap_dm_timer structure that is also being passed to the above
>> functions and therefore we do not need to pass the posted variable separately.
>> Therefore, simplify the above functions by removing the posted variable as an
>> argument as this is not necessary.
> 
> I believe the reason for passing the posted flag was to optimize out some
> functions from the timer code as that's being run all the time.
> 
> Care to check the assembly before and after this patch for the timer
> functions with objdump -d to make sure it does not add tons of bloat
> there?

Hi Tony,

Thanks for the details here. I see that makes sense and that the
compiler could take advantage of this as the functions are inlined.

I have taken a look at the disassembled output using objdump as you
mentioned. What I see is ...

1. For dmtimer.c the impact appears negligible, the total number of
   lines outputted by objdump only changed by 8 with (1215 lines) and
   without (1207 lines) the patch applied.

2. For timer.c the impact is greater. I see that
   omap2_gp_timer_set_next_event() increased by 6 instructions from 29
   to 35. clocksource_read_cycles() increased by 2 instructions 15 to
   17 instructions. dmtimer_read_sched_clock() increased by 2
   instructions from 17 to 19. omap2_gp_timer_set_mode() increased by
   21 instructions from 102 to 123.

I imagine that we are mainly concerned about
omap2_gp_timer_set_next_event(), clocksource_read_cycles() and
dmtimer_read_sched_clock() as these will be called often. Therefore, I
am not sure if you wish to drop this patch.

By the way, if we do drop this patch, I would then need to fix the
setting of the posted variable in mach-omap2/timer.c for clock-source in
the case where a dmtimer is used. Today the code assumes that for
clock-source and clock-events posted mode is always used. However, with
the errata i103/i767 we will disable posted mode for clock-source on
omap2/3/4/5/am33xx devices.

Cheers
Jon
