From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/6] omap3: pm: Fixes for low power code
Date: Wed, 02 Mar 2011 17:22:50 -0800
Message-ID: <87k4ghro9h.fsf@ti.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:45623 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754658Ab1CCBWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 20:22:53 -0500
Received: by pxi20 with SMTP id 20so101272pxi.13
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 17:22:53 -0800 (PST)
In-Reply-To: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Mon, 21 Feb 2011 18:49:19 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The series does below fixes to the omap3 low power code.
> 	1. Use supported ARMv7 instructions instead of the legacy ones
> 	2. Fix the MMU on sequence
> 	3. Fix the cache flush scenario when only L1 lost.
> 	4. Remove all un-necessary context save registers
> 	5. Disable C-bit before cache clean
> 	6. Use set_cr() exported API instead of custom one. 

Look like good cleanups, thanks.

> It's generated against mainline and tested with OMAP3630 ZOOM3.
> 	1. Renetion and off-mode mode in suspend - ok.
> 	2. Retention in idle - ok

Testing this series along with other PM changes queued up for mainline
(my pm-core branch), this doesn't work for me on 3630/Zoom3 (but works
fine on 3430/n900.)

Here's what I did using omap2plus_defconfig + enabling CPUidle

First tested suspend:

echo 4 > /debug/pm_debug/wakeup_timer_seconds 
echo mem > /sys/power/state

then, setup UART idle/wakeup:

echo 5 > /sys/devices/platform/omap/omap_uart.0/sleep_timeout 
echo 5 > /sys/devices/platform/omap/omap_uart.1/sleep_timeout 
echo 5 > /sys/devices/platform/omap/omap_uart.2/sleep_timeout 
echo 5 > /sys/devices/platform/omap/omap_uart.3/sleep_timeout 
echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/wakeup 

then enabled idle:

echo 1 > /debug/pm_debug/sleep_while_idle  

As soon as I do this, it hangs.

Without your series, it's working fine for me.  Only after merging your
series it hangs.

Kevin


> The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
>   Linus Torvalds (1):
>         Linux 2.6.38-rc5
>
> Santosh Shilimkar (6):
>   omap3: pm: Use amrv7 supported instructions instead of legacy cp15
>     ones
>   omap3: pm: Fix the mmu on sequence in the asm code
>   omap3: pm: Allow the cache clean when L1 is lost.
>   omap3: pm: Remove un-necessary cp15 registers form low power cpu
>     context
>   omap3: pm: Clear the SCTLR C bit in asm code to prevent data cache
>     allocation
>   omap3: pm: Use exported set_cr() instead of a custom one.
>
>  arch/arm/mach-omap2/pm34xx.c    |    7 +-
>  arch/arm/mach-omap2/sleep34xx.S |  223 ++++++++++++++-------------------------
>  2 files changed, 78 insertions(+), 152 deletions(-)
