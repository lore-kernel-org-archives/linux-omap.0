From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3] OMAP3: Serial: Improved sleep logic
Date: Thu, 11 Feb 2010 15:11:39 -0800
Message-ID: <20100211231139.GM21755@atomide.com>
References: <>
 <1265895541-12300-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62020 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197Ab0BKXK6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 18:10:58 -0500
Content-Disposition: inline
In-Reply-To: <1265895541-12300-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

* Tero Kristo <tero.kristo@nokia.com> [100211 03:48]:
> From: Tero Kristo <tero.kristo@nokia.com>
> 
> This patch contains following improvements:
> - Only RX interrupt will now kick the sleep prevent timer
> - TX fifo status is checked before disabling clocks, this will prevent
>   on-going transmission to be cut
> - Smartidle is disabled while entering idle if we have data in the transmit
>   buffer because having this enabled would prevent wakeups from the TX
>   interrupt and this would cause pauses while sending large blocks of data
> - Sleep prevent timer is changed to use ktime_get() instead of a jiffy timer
>   as jiffy timers are not valid within idle loop (tick scheduler is stopped)
> - Added RX ignore timer for ignoring the first character received during
>   first millisecond of wakeup, this prevents garbage character to be received
>   in low sleep states

Cool, sounds like the way to go. Note that current mainline kernel has
the DEFAULT_TIMEOUT set to 0 because of the lost/corrupt characters.
 
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -36,13 +39,14 @@
>  #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
>  #define UART_OMAP_WER		0x17	/* Wake-up enable register */
>  
> -#define DEFAULT_TIMEOUT (5 * HZ)
> +#define DEFAULT_TIMEOUT (5LL * NSEC_PER_SEC)

Won't apply to mainline..
  
> @@ -420,9 +443,9 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  
>  	uart->can_sleep = 0;
>  	uart->timeout = DEFAULT_TIMEOUT;
> -	setup_timer(&uart->timer, omap_uart_idle_timer,
> -		    (unsigned long) uart);
> -	mod_timer(&uart->timer, jiffies + uart->timeout);
> +
> +	uart->expire_time = ktime_add_ns(ktime_get(), uart->timeout);
> +
>  	omap_uart_smart_idle_enable(uart, 0);
>  
>  	if (cpu_is_omap34xx()) {

And the above should probably be:

	if (uart->timeout)
		uart->expire_time = ktime_add_ns(ktime_get(), uart->timeout); 

In order to support zero default timeout. Some other changes
may be necessary too if DEFAULT_TIMEOUT is 0.

Regards,

Tony
