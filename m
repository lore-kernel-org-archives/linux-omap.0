From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 03/14] ARM: OMAP3+: Implement timer workaround for
 errata i103 and i767
Date: Wed, 7 Nov 2012 16:14:00 -0600
Message-ID: <509ADD28.20707@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com> <1352314890-22224-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38934 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770Ab2KGWOF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 17:14:05 -0500
In-Reply-To: <1352314890-22224-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wednesday 07 November 2012 01:01 PM, Jon Hunter wrote:
> Errata Titles:
> i103: Delay needed to read some GP timer, WD timer and sync timer registers
>        after wakeup (OMAP3/4)
> i767: Delay needed to read some GP timer registers after wakeup (OMAP5)
>
> Description (i103/i767):
> If a General Purpose Timer (GPTimer) is in posted mode (TSICR [2].POSTED=1),
> due to internal resynchronizations, values read in TCRR, TCAR1 and TCAR2
> registers right after the timer interface clock (L4) goes from stopped to
> active may not return the expected values. The most common event leading to
> this situation occurs upon wake up from idle.
>
> GPTimer non-posted synchronization mode is not impacted by this limitation.
>
> Workarounds:
> 1). Disable posted mode
> 2). Use static dependency between timer clock domain and MPUSS clock domain
> 3). Use no-idle mode when the timer is active
>
> Workarounds #2 and #3 are not pratical from a power standpoint and so
> workaround #1 has been implemented. Disabling posted mode adds some CPU overhead
> for configuring the timers as the CPU has to wait for the write to complete.
> However, disabling posted mode guarantees correct operation.
>
> Please note that it is safe to use posted mode for timers if the counter (TCRR)
> and capture (TCARx) registers will never be read. An example of this is the
> clock-event system timer. This is used by the kernel to schedule events however,
> the timers counter is never read and capture registers are not used. Given that
> the kernel configures this timer often yet never reads the counter register it
> is safe to enable posted mode in this case. Hence, for the timer used for kernel
> clock-events, posted mode is enabled by overriding the errata for devices that
> are impacted by this defect.
>
> For drivers using the timers that do not read the counter or capture registers
> and wish to use posted mode, can override the errata and enable posted mode by
> making the following function calls.
>
> 	omap_dm_timer_override_errata(timer, OMAP_TIMER_ERRATA_I103_I767);
> 	omap_dm_timer_enable_posted(timer);
>
> Both dmtimers and watchdogs are impacted by this defect this patch only
> implements the workaround for the dmtimer. Currently the watchdog driver does
> not read the counter register and so no workaround is necessary.
>
> Confirmed with Vaibhav Hiremath that this bug also impacts AM33xx devices.
>
> Please note that now calls to omap_dm_timer_enable_posted() may not able posted
> mode if the device is impacted by this errata. Therefore, for system-timers
> check to see if the intended posted mode matches the actual. If it does not then
> there is a configuration error in the system timers posted configuration.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Looks sensible considering alternative WAs.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

