From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V6 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Wed, 02 May 2012 13:39:59 -0700
Message-ID: <87mx5qfhb4.fsf@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
	<1335967014-11937-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:58351 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756407Ab2EBUkA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 16:40:00 -0400
Received: by dadz9 with SMTP id z9so422303dad.25
        for <linux-omap@vger.kernel.org>; Wed, 02 May 2012 13:39:58 -0700 (PDT)
In-Reply-To: <1335967014-11937-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Wed, 2 May 2012 19:26:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> So there can be 3 options -
>
> 1. 32KHz sync-timer
> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> 3. 32KHz based gptimer.
>
> The optional gptimer based clocksource was added so that it can
> give the high precision than sync-timer, so expected usage was 2
> and not 3.
> Unfortunately option 2, clocksource doesn't meet the requirement of
> free-running clock as per clocksource need. It stops in low power states
> when sys_clock is cut. That makes gptimer based clocksource option
> useless for OMAP2/3/4 devices with sys_clock as a clock input.
> So, in order to use option 2, deeper idle state MUST be disabled.
>
> Option 3 will still work but it is no better than 32K sync-timer
> based clocksource.
>
> We must support both sync timer and gptimer based clocksource as
> some OMAP based derivative SoCs like AM33XX does not have the
> sync timer.
>
> Considering above, make sync-timer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code.
>
> And, in order to precisely configure/setup sched_clock for given
> clocksource, decision has to be made early enough in boot sequence.
>
> So, the solution is,
>
> Use standard kernel parameter ("clocksource=") to override
> default 32k_sync-timer, in addition to this, we also use hwmod database
> lookup mechanism, through which at run-time we can identify availability
> of 32k-sync timer on the device, else fall back to gptimer.
>
> Also, moved low-level SoC specific init code to respective files,
> (mach-omap1/timer32k.c and mach-omap2/timer.c)
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Ming Lei <tom.leiming@gmail.com>

Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>

tested on OMAP3530/Overo with default 32k timer and cmdline override for
GPtimer.

Kevin
