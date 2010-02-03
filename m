From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 9/9] omap: Disable serial port autoidle by default
Date: Wed, 03 Feb 2010 06:40:09 -0800
Message-ID: <87aavq9yd2.fsf@deeprootsystems.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
	<20100203022618.26347.51428.stgit@baageli.muru.com>
	<20100203034322.GZ22747@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:56214 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754994Ab0BCOkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 09:40:14 -0500
Received: by yxe27 with SMTP id 27so1160082yxe.4
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 06:40:13 -0800 (PST)
In-Reply-To: <20100203034322.GZ22747@atomide.com> (Tony Lindgren's message of "Tue\, 2 Feb 2010 19\:43\:22 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> writes:

> * Tony Lindgren <tony@atomide.com> [100202 18:23]:
>> Currently the omap serial clocks are autoidled after 5 seconds.
>> However, this causes lost characters on the serial ports. As this
>> is considered non-standard behaviour for Linux, disable the timeout.
>> 
>> Note that this will also cause blocking of any deeper omap sleep
>> states.
>> 
>> To enable the autoidling of the serial ports, do something like
>> this for each serial port:
>> 
>> # echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
>> # echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
>> ...
>
> Turns out we also need to disable the timer in init, otherwise
> the very first character after boot can get corrupt.
>
> Updated version below, Kevin can you take one more look and see
> if your S-O-B is still valid? :)

Yeah, looks right.  s-o-b still valid.

Kevin

> Regards,
>
> Tony
> From ff7ce25ec59223bf987ad209c1eb183031811c07 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 1 Feb 2010 12:34:31 -0800
> Subject: [PATCH] omap: Disable serial port autoidle by default
>
> Currently the omap serial clocks are autoidled after 5 seconds.
> However, this causes lost characters on the serial ports. As this
> is considered non-standard behaviour for Linux, disable the timeout.
>
> Note that this will also cause blocking of any deeper omap sleep
> states.
>
> To enable the autoidling of the serial ports, do something like
> this for each serial port:
>
> # echo 5 > /sys/devices/platform/serial8250.0/sleep_timeout
> # echo 5 > /sys/devices/platform/serial8250.1/sleep_timeout
> ...
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 8c964be..e10a02d 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -36,7 +36,13 @@
>  #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
>  #define UART_OMAP_WER		0x17	/* Wake-up enable register */
>  
> -#define DEFAULT_TIMEOUT (5 * HZ)
> +/*
> + * NOTE: By default the serial timeout is disabled as it causes lost characters
> + * over the serial ports. This means that the UART clocks will stay on until
> + * disabled via sysfs. This also causes that any deeper omap sleep states are
> + * blocked. 
> + */
> +#define DEFAULT_TIMEOUT 0
>  
>  struct omap_uart_state {
>  	int num;
> @@ -422,7 +428,8 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  	uart->timeout = DEFAULT_TIMEOUT;
>  	setup_timer(&uart->timer, omap_uart_idle_timer,
>  		    (unsigned long) uart);
> -	mod_timer(&uart->timer, jiffies + uart->timeout);
> +	if (uart->timeout)
> +		mod_timer(&uart->timer, jiffies + uart->timeout);
>  	omap_uart_smart_idle_enable(uart, 0);
>  
>  	if (cpu_is_omap34xx()) {
