From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/1] omap: serial: fix non-empty uart fifo read abort
Date: Tue, 17 Nov 2009 18:31:48 -0600
Message-ID: <4B034074.8040209@ti.com>
References: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48257 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345AbZKRAbt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Nov 2009 19:31:49 -0500
In-Reply-To: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Pandita, Vikram had written, on 11/17/2009 05:39 PM, the following:
> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.
> 
> Overrigt the default 8250 read handler: mem_serial_in()
   ^^^^^^^^ <- I am just being a nuisance, but I think you mean override

> by a custom handler: serial_in_8250()
> 
> serial_in_8250() makes sure that RX fifo is not read when empty,
> on omap4 and 3630 silicons only
> 
> tested on zoom3(3630) board
> 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> v1: initial implementation
> 	http://patchwork.kernel.org/patch/60785/
> 	http://patchwork.kernel.org/patch/60786/
> 
> v2: incorporate review comments from Alan Cox
> 	http://patchwork.kernel.org/patch/60785/
> 	No 8250 driver change required now
> 
>  arch/arm/mach-omap2/serial.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 2e17b57..362cb82 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -71,6 +71,30 @@ struct omap_uart_state {
>  
>  static LIST_HEAD(uart_list);
>  
> +static struct omap_uart_state omap_uart[];
> +static inline unsigned int serial_read_reg(struct plat_serial8250_port *, int);
> +
> +/*
> + * Overrigt the default 8250 read handler: mem_serial_in()
       ^^^^^^^^^ <- same here
> + * Empty RX fifo read causes an abort on omap3630 and omap4
> + * This function makes sure that an empty rx fifo is not read on these silicons
> + * (OMAP1/2/3 are not affected)
> + */
> +static unsigned int serial_in_8250(struct uart_port *up, int offset)
> +{
> +	/* Do not read empty UART fifo on omap3630/44xx */
> +	if ((UART_RX == offset) &&
> +		(cpu_is_omap3630() || cpu_is_omap44xx())) {
Do we want to use FEATURE here? I can expect to see more silicons use 
this new UART IP, so using the OMAP FEATURE framework might make sense.
I wonder if you can at least use MVR_REG to detect if we want to enable 
this?
or better still we could even skip the check.. might save cpu cycles..
> +
> +		unsigned int lsr;
> +
> +		lsr = serial_read_reg(omap_uart[up->line].p, UART_LSR);
> +		if (!(lsr & UART_LSR_DR))
> +			return 0;
> +	}
> +	return serial_read_reg(omap_uart[up->line].p, offset);
> +}
> +
>  static struct plat_serial8250_port serial_platform_data0[] = {
>  	{
>  		.mapbase	= OMAP_UART1_BASE,
> @@ -79,6 +103,7 @@ static struct plat_serial8250_port serial_platform_data0[] = {
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> +		.serial_in	= serial_in_8250,
>  	}, {
>  		.flags		= 0
>  	}
> @@ -92,6 +117,7 @@ static struct plat_serial8250_port serial_platform_data1[] = {
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> +		.serial_in	= serial_in_8250,
>  	}, {
>  		.flags		= 0
>  	}
> @@ -105,6 +131,7 @@ static struct plat_serial8250_port serial_platform_data2[] = {
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> +		.serial_in	= serial_in_8250,
>  	}, {
>  		.flags		= 0
>  	}
> @@ -119,6 +146,7 @@ static struct plat_serial8250_port serial_platform_data3[] = {
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> +		.serial_in	= serial_in_8250,
>  	}, {
>  		.flags		= 0
>  	}


-- 
Regards,
Nishanth Menon
