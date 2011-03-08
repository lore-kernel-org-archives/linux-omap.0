From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 0/6] omap3: pm: Fixes for low power code
Date: Tue, 8 Mar 2011 17:11:04 +0530
Message-ID: <b5cdbcef5de05fd6fa85f532e8c29271@mail.gmail.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com> <87k4ghro9h.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48109 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753831Ab1CHLlI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:41:08 -0500
Received: by qyg14 with SMTP id 14so4366976qyg.12
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:41:06 -0800 (PST)
In-Reply-To: <87k4ghro9h.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Thursday, March 03, 2011 6:53 AM
> To: Santosh Shilimkar
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 0/6] omap3: pm: Fixes for low power code
>
> Hi Santosh,
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > The series does below fixes to the omap3 low power code.
> > 	1. Use supported ARMv7 instructions instead of the legacy ones
> > 	2. Fix the MMU on sequence
> > 	3. Fix the cache flush scenario when only L1 lost.
> > 	4. Remove all un-necessary context save registers
> > 	5. Disable C-bit before cache clean
> > 	6. Use set_cr() exported API instead of custom one.
>
> Look like good cleanups, thanks.
>
> > It's generated against mainline and tested with OMAP3630 ZOOM3.
> > 	1. Renetion and off-mode mode in suspend - ok.
> > 	2. Retention in idle - ok
>
> Testing this series along with other PM changes queued up for
> mainline
> (my pm-core branch), this doesn't work for me on 3630/Zoom3 (but
> works
> fine on 3430/n900.)
>
> Here's what I did using omap2plus_defconfig + enabling CPUidle
>
> First tested suspend:
>
> echo 4 > /debug/pm_debug/wakeup_timer_seconds
> echo mem > /sys/power/state
>
> then, setup UART idle/wakeup:
>
> echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout
> echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout
> echo enabled >
> /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup
>
> then enabled idle:
>
> echo 1 > /debug/pm_debug/sleep_while_idle
>
> As soon as I do this, it hangs.
>
> Without your series, it's working fine for me.  Only after merging
> your series it hangs.
>

I rebased this series against latest pm-core branch which also
has Dave's THUMB2 series merged.

After few trials I managed to reproduce the issue. With
above steps it was still working for me but with off mode
enabled, I saw a lock-up in suspend. Further debugging, I
found that one CP15 register save/restore position was
swapped which lead to this. I fixed that.

I have pushed the rebased series on below branch.

git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
pm-core-omap3-asm

Regards,
Santosh
