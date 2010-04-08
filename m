From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv7] OMAP3: Serial: Improved sleep logic
Date: Thu, 08 Apr 2010 10:32:11 -0700
Message-ID: <87vdc14zqc.fsf@deeprootsystems.com>
References: <1268408332-15579-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:60155 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407Ab0DHRc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Apr 2010 13:32:28 -0400
Received: by bwz1 with SMTP id 1so1973793bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 08 Apr 2010 10:32:25 -0700 (PDT)
In-Reply-To: <1268408332-15579-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 12 Mar 2010 17\:38\:52 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Peter Tseng <tsenpet09@gmail.com>

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> This patch contains following improvements:
> - Only RX interrupt will now kick the sleep prevent timer
> - TX fifo status is checked before disabling clocks, this will prevent
>   on-going transmission to be cut
> - Smartidle is now enabled/disabled only while switching clocks, as having
>   smartidle enabled while RX/TX prevents any wakeups from being received
>   from UART module
> - Added workqueue for wakeup checks, as jiffy timer access within the
>   idle loop results into skewed timers as jiffy timers are stopped
> - Added garbage_timer for ignoring the first character received during
>   the first tick after clock enable, this prevents garbage characters to be
>   received in low sleep states
> - omap_uart_enable_irqs() changed to use enable_irq / disable_irq instead
>   of request / free. Using request/free changes the behavior after first
>   suspend due to reversed interrupt handler ordering

Hi Tero,

FYI... I had to make one additional change (diff below) to this patch
after discovering a regression pointed out by Peter Tseng.

If the UART timeouts are disabled (set to zero), which they are by
default, and you suspend the system, the UART would not be usable
after wakeup.   Simply enabling a timeout was fixing the problem.

I tracked the problem to the garbage timer being enabled even when
the UART timeout was not enabled.  Since the garbage_ignore flag
is only ever cleared when a uart->timeout is set, the garbage
timer was never being disabled, effectively disabling the UART.

I've folded this fix below into your patch in the pm-fixes branch
and pushed a new PM branch.

Kevin


diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b731556..b709cf8 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -396,7 +396,8 @@ void omap_uart_prepare_idle(int num)
 
 static void serial_wakeup(struct omap_uart_state *uart)
 {
-	uart->garbage_ignore = 1;
+	if (uart->timeout)
+		uart->garbage_ignore = 1;
 	schedule_work(&uart->wakeup_work);
 }
 
k
