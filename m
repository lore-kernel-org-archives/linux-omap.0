From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv6] OMAP3: Serial: Improved sleep logic
Date: Mon, 01 Mar 2010 12:46:15 -0800
Message-ID: <87ljebdb3c.fsf@deeprootsystems.com>
References: <1267118749-1836-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57563 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab0CAUqT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Mar 2010 15:46:19 -0500
Received: by pwj8 with SMTP id 8so1903932pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 01 Mar 2010 12:46:18 -0800 (PST)
In-Reply-To: <1267118749-1836-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 25 Feb 2010 19\:25\:49 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

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
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks Tero.  This version looks good.

Adding to pm-fixes queue for 2.6.34-rcX after minor change below...

> ---
>  arch/arm/mach-omap2/serial.c |   67 +++++++++++++++++++++++++++++++++++-------
>  1 files changed, 56 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 5f3035e..06d18f5 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -23,6 +23,7 @@
>  #include <linux/serial_reg.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/workqueue.h>
>  
>  #include <plat/common.h>
>  #include <plat/board.h>
> @@ -48,7 +49,10 @@ struct omap_uart_state {
>  	int num;
>  	int can_sleep;
>  	struct timer_list timer;
> +	struct timer_list garbage_timer;
> +	struct work_struct wakeup_work;
>  	u32 timeout;
> +	u8 garbage_ignore;
>  
>  	void __iomem *wk_st;
>  	void __iomem *wk_en;
> @@ -243,6 +247,11 @@ static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
>  static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
>  #endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
>  
> +#ifdef CONFIG_PM
> +static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
> +		int enable);
> +#endif

I moved this up into the #ifdef block just above and added a dummy function
into the #else clause...

>  static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
>  {
>  	if (uart->clocked)
> @@ -252,6 +261,15 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
>  	clk_enable(uart->fck);
>  	uart->clocked = 1;
>  	omap_uart_restore_context(uart);
> +#ifdef CONFIG_PM
> +	omap_uart_smart_idle_enable(uart, 0);
> +#endif

and then dropped this #ifdef.

> +	/* Set up garbage timer to ignore RX during first jiffy */
> +	if (uart->timeout) {
> +		mod_timer(&uart->garbage_timer, jiffies + 1);
> +		uart->garbage_ignore = 1;
> +	}
>  }

Kevin
