From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] OMAP3:PM:  Keep UART clocks disabled is resume idle path
Date: Tue, 29 Jun 2010 08:10:44 -0700
Message-ID: <87zkydub63.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0323763481@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:33435 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756520Ab0F2PKu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jun 2010 11:10:50 -0400
Received: by pxi8 with SMTP id 8so2363124pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 29 Jun 2010 08:10:48 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0323763481@dbde02.ent.ti.com>
	(Teerth Reddy's message of "Tue, 29 Jun 2010 12:28:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Reddy, Teerth" <teerth@ti.com> writes:

> From: Teerth Reddy <teerth@ti.com>
>
> The UART clocks should not be turned on in resume idle path. The UART clocks
> should be turned on only when there is a uart wakeup event. 

No, UART clocks should be on whenever someone is accessing the UART.

Besides wakeups, applications can open/access UARTs whenever they want.
With this patch, an application wil fault if it tries to open a UART as
the 8250 driver will access registers and not know how to turn on clocks.

After the UART hwmod conversion done and the omap-serial driver is
merged, we will convert the omap-serial driver to use runtime PM which
will then be much more efficient in power as the driver is the only
place that knows when the device needs to be enabled.

Kevin

> This optimization
> will help save power.
>
> Signed-off-by: Raja Govindraj <govindraj.raja@ti.com>
> Signed-off-by: Teerth Reddy <teerth@ti.com>
>
> ---
>  arch/arm/mach-omap2/serial.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 3771254..d545eed 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -343,6 +343,7 @@ static void omap_uart_idle_timer(unsigned long data)
>  {
>  	struct omap_uart_state *uart = (struct omap_uart_state *)data;
>  
> +	uart->timeout = DEFAULT_TIMEOUT;
>  	omap_uart_allow_sleep(uart);
>  }
>  
> @@ -364,7 +365,6 @@ void omap_uart_resume_idle(int num)
>  
>  	list_for_each_entry(uart, &uart_list, node) {
>  		if (num == uart->num) {
> -			omap_uart_enable_clocks(uart);
>  
>  			/* Check for IO pad wakeup */
>  			if (cpu_is_omap34xx() && uart->padconf) {
> @@ -436,7 +436,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  	int ret;
>  
>  	uart->can_sleep = 0;
> -	uart->timeout = DEFAULT_TIMEOUT;
> +	uart->timeout = 30 * HZ;
>  	setup_timer(&uart->timer, omap_uart_idle_timer,
>  		    (unsigned long) uart);
>  	if (uart->timeout)
