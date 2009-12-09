From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Preventing OMAP3 serial driver to take control of all UARTs
Date: Wed, 09 Dec 2009 14:43:42 -0800
Message-ID: <878wdbu5sx.fsf@deeprootsystems.com>
References: <20091130084651.GA17675@esdhcp04058.research.nokia.com>
	<1259599010.4649.51.camel@thunk>
	<fa686aa40911300901nd47259ar2e1beae7be447937@mail.gmail.com>
	<20091130194031.GV4348@atomide.com> <1259613066.4649.127.camel@thunk>
	<20091130210957.GY4348@atomide.com>
	<20091201110256.GB17675@esdhcp04058.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f212.google.com ([209.85.217.212]:33163 "EHLO
	mail-gx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758436AbZLIWni (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 17:43:38 -0500
Received: by gxk4 with SMTP id 4so11664038gxk.8
        for <linux-omap@vger.kernel.org>; Wed, 09 Dec 2009 14:43:44 -0800 (PST)
In-Reply-To: <20091201110256.GB17675@esdhcp04058.research.nokia.com> (Mika Westerberg's message of "Tue\, 1 Dec 2009 13\:02\:56 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Peter Barada <peterb@logicpd.com>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Olof Johansson <olof@lixom.net>

[sorry for being late to the party, I've been on vacation]

Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:

[...]

> How about something like in the patch attached?
>
> Then for example we would do in board-rx51.c:
> 	...
> 	omap_serial_init_port(2);
>
> (we only use UART3 as serial port).
>
> I quickly tested this with RX-51 and seems to work.
>

I like this approach.

I'm against going back to the previsus platform_data extending
approach since it requires doing different stuff when using 8250 or
the upcoming omap-serial driver.

>
> ---
>
> From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> Date: Tue, 1 Dec 2009 12:54:21 +0200
> Subject: [PATCH] OMAP3: serial - allow platforms specify which UARTs to initialize
>
> This patch adds new function: omap_serial_init_port(port) that can be
> used to initialize only selected UARTs as serial ports. Platforms can
> then in their board files call this function instead of omap_serial_init()
> if they don't want to use all UARTs as serial ports.
>
> Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>


> ---
>  arch/arm/mach-omap2/serial.c             |   59 +++++++++++++++++++++++-------
>  arch/arm/plat-omap/include/plat/serial.h |    1 +
>  2 files changed, 46 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 2e17b57..fe46560 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -631,24 +631,55 @@ void __init omap_serial_early_init(void)
>  	}
>  }
>  
> +/**
> + * omap_serial_init_port() - initialize single serial port
> + * @port: serial port number (0-3)
> + *
> + * This function initialies serial driver for given @port only.
> + * Platforms can call this function instead of omap_serial_init()
> + * if they don't plan to use all available UARTs as serial ports.
> + *
> + * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
> + * use only one of the two.
> + */
> +void __init omap_serial_init_port(int port)
> +{
> +	struct omap_uart_state *uart;
> +	struct platform_device *pdev;
> +	struct device *dev;
> +
> +	BUG_ON(port < 0);
> +	BUG_ON(port >= ARRAY_SIZE(omap_uart));
> +
> +	uart = &omap_uart[port];
> +	pdev = &uart->pdev;
> +	dev = &pdev->dev;
> +
> +	omap_uart_reset(uart);
> +	omap_uart_idle_init(uart);
> +
> +	if (WARN_ON(platform_device_register(pdev)))
> +		return;
> +
> +	if ((cpu_is_omap34xx() && uart->padconf) ||
> +	    (uart->wk_en && uart->wk_mask)) {
> +		device_init_wakeup(dev, true);
> +		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
> +	}
> +}
> +
> +/**
> + * omap_serial_init() - intialize all supported serial ports
> + *
> + * Initializes all available UARTs as serial ports. Platforms
> + * can call this function when they want to have default behaviour
> + * for serial ports (e.g initialize them all as serial ports).
> + */
>  void __init omap_serial_init(void)
>  {
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(omap_uart); i++) {
> -		struct omap_uart_state *uart = &omap_uart[i];
> -		struct platform_device *pdev = &uart->pdev;
> -		struct device *dev = &pdev->dev;
> -
> -		omap_uart_reset(uart);
> -		omap_uart_idle_init(uart);
> -
> -		if (WARN_ON(platform_device_register(pdev)))
> -			continue;
> -		if ((cpu_is_omap34xx() && uart->padconf) ||
> -		    (uart->wk_en && uart->wk_mask)) {
> -			device_init_wakeup(dev, true);
> -			DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
> -		}
> +		omap_serial_init_port(i);
>  	}
>  }
> diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
> index 9951345..f5a4a92 100644
> --- a/arch/arm/plat-omap/include/plat/serial.h
> +++ b/arch/arm/plat-omap/include/plat/serial.h
> @@ -53,6 +53,7 @@
>  #ifndef __ASSEMBLER__
>  extern void __init omap_serial_early_init(void);
>  extern void omap_serial_init(void);
> +extern void omap_serial_init_port(int port);
>  extern int omap_uart_can_sleep(void);
>  extern void omap_uart_check_wakeup(void);
>  extern void omap_uart_prepare_suspend(void);
> -- 
> 1.5.6.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
