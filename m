From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 02/14] ARM: OMAP2+: Disable posted mode for the clocksource
 timer
Date: Wed, 7 Nov 2012 16:10:39 -0600
Message-ID: <509ADC5F.7020307@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57890 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab2KGWKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Nov 2012 17:10:41 -0500
In-Reply-To: <1352314890-22224-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 07 November 2012 01:01 PM, Jon Hunter wrote:
> When using a DMTIMER as the clock-source timer, posted mode configuration of
> the DMTIMER is used. Posted mode is only benefical when configuring timers as
> it allows writes to be posted and does not stall the CPU until the write is
> complete. The clock-source timer is only configured once on boot and so using
> posted mode has no benefit. In fact, by using posted mode, it adds overhead
> to reading the timer. Therefore, by default disable posted mode for DMTIMERs
> used for clock-source.
>
> Using objdump this change reduces the function clocksource_read_cycles()
> function from a total of 15 instructions (including 3 branches and 7 loads)
> to 5 instructions (including 1 branch and 3 loads). Please note that before
> the minimum number of instructions that would be executed when calling
> clocksource_read_cycles() would be 9 instructions (including 2 branches and 5
> loads) where as now it will always be 5 instructions.
>
> This change also reduces the function dmtimer_read_sched_clock() function from
> a total of 17 instructions (including 4 branches and 8 loads) to 6 instructions
> (including 1 branch and 4 loads). Please note that before the minimum number of
> instructions that would be executed when calling dmtimer_read_sched_clock()
> would be 11 instructions (including 2 branches and 6 loads) where as now it
> will always be 6 instructions.
>
This isn't right way to calculate the penalty of posted mode. Non-posted 
mode can results in 100 of cycles wait over interconnect
and that can not be justified with few instructions savings.

> This change removes the configuration of posted mode from the
> __omap_dm_timer_reset() function and adds a new function called
> omap_dm_timer_enable_posted() for enabling posted mode. Hence, call
> omap_dm_timer_enable_posted() where ever we are calling __omap_dm_timer_reset().
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
But clock-source doesn't involve much into writes so patch as
such is fine.

Regards
Santosh

