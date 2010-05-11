From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv7] OMAP3: Serial: Improved sleep logic
Date: Tue, 11 May 2010 16:15:18 -0700
Message-ID: <87r5lirpx5.fsf@deeprootsystems.com>
References: <1268408332-15579-1-git-send-email-tero.kristo@nokia.com>
	<87vdc14zqc.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37215 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab0EKXPb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:15:31 -0400
Received: by pvh11 with SMTP id 11so93067pvh.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 16:15:30 -0700 (PDT)
In-Reply-To: <87vdc14zqc.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 08 Apr 2010 10\:32\:11 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org, Peter Tseng <tsenpet09@gmail.com>

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Tero Kristo <tero.kristo@nokia.com> writes:
>
>> From: Tero Kristo <tero.kristo@nokia.com>
>>
>> This patch contains following improvements:
>> - Only RX interrupt will now kick the sleep prevent timer
>> - TX fifo status is checked before disabling clocks, this will prevent
>>   on-going transmission to be cut
>> - Smartidle is now enabled/disabled only while switching clocks, as having
>>   smartidle enabled while RX/TX prevents any wakeups from being received
>>   from UART module
>> - Added workqueue for wakeup checks, as jiffy timer access within the
>>   idle loop results into skewed timers as jiffy timers are stopped
>> - Added garbage_timer for ignoring the first character received during
>>   the first tick after clock enable, this prevents garbage characters to be
>>   received in low sleep states
>> - omap_uart_enable_irqs() changed to use enable_irq / disable_irq instead
>>   of request / free. Using request/free changes the behavior after first
>>   suspend due to reversed interrupt handler ordering
>
> Hi Tero,
>
> FYI... I had to make one additional change (diff below) to this patch
> after discovering a regression pointed out by Peter Tseng.
>
> If the UART timeouts are disabled (set to zero), which they are by
> default, and you suspend the system, the UART would not be usable
> after wakeup.   Simply enabling a timeout was fixing the problem.
>
> I tracked the problem to the garbage timer being enabled even when
> the UART timeout was not enabled.  Since the garbage_ignore flag
> is only ever cleared when a uart->timeout is set, the garbage
> timer was never being disabled, effectively disabling the UART.
>
> I've folded this fix below into your patch in the pm-fixes branch
> and pushed a new PM branch.

OK, I'm dropping this patch from the PM branch.  It has caused me more
problems that it has solved so far, and I just noticed that
UART2-based consoles (n900, beagle) stop working all together when I
enable UART timeouts with this patch.  Seems to be again related to
the garbage timer.

What I would like to see instead is UART hwmods finished and the
omap-serial driver merged so that we can start moving this PM logic
into the omap-serial driver using the runtime PM layer.

Kevin

>
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index b731556..b709cf8 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -396,7 +396,8 @@ void omap_uart_prepare_idle(int num)
>  
>  static void serial_wakeup(struct omap_uart_state *uart)
>  {
> -	uart->garbage_ignore = 1;
> +	if (uart->timeout)
> +		uart->garbage_ignore = 1;
>  	schedule_work(&uart->wakeup_work);
>  }
>  
> k
