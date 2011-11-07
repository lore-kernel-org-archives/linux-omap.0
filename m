From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH] arm:omap:serial:cleanup: use module rev instead of
 cpu_is_xxxx
Date: Mon, 7 Nov 2011 15:00:22 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8023CEF@DBDE01.ent.ti.com>
References: <1320677860-32663-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57750 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816Ab1KGPA2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 10:00:28 -0500
In-Reply-To: <1320677860-32663-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, November 07, 2011 8:28 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Hiremath, Vaibhav
> Subject: [PATCH] arm:omap:serial:cleanup: use module rev instead of
> cpu_is_xxxx
> 
> For OMAP3 uarts (module rev >= 0x52) and all successor devices
> (omap4, TI81xx, AM33xx, etc...) empty fifo read errata is applicable,
> so we can get rid of cpu_is_xxxx check and simply check for module rev
> here.
> 
Ideally, isn't module errata information should come
from HWMOD data? I think it should...does it make sense?

Thanks,
Vaibhav

> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> NOTE: This patch has been tested on OMAP3EVM, and I expect to work on all
> OMAP3
> family of devices (including TI816x, TI814x, AM335x, etc...).
> but I am quite not sure about OMAP2 device, can anybody comment/test?
> 
>  arch/arm/mach-omap2/serial.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 9992dbf..ac274dc 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -740,16 +740,16 @@ void __init omap_serial_init_port(struct
> omap_board_data *bdata)
>  	p->private_data = uart;
> 
>  	/*
> -	 * omap44xx, ti816x: Never read empty UART fifo
> +	 * all >omap3 family of devices: Never read empty UART fifo
>  	 * omap3xxx: Never read empty UART fifo on UARTs
>  	 * with IP rev >=0x52
>  	 */
>  	uart->regshift = p->regshift;
>  	uart->membase = p->membase;
> -	if (cpu_is_omap44xx() || cpu_is_ti816x())
> -		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
> -	else if ((serial_read_reg(uart, UART_OMAP_MVER) & 0xFF)
> -			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +	if (cpu_is_omap34xx() && (serial_read_reg(uart, UART_OMAP_MVER) &
> 0xFF)
> +			< UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +		uart->errata &= ~UART_ERRATA_FIFO_FULL_ABORT;
> +	else
>  		uart->errata |= UART_ERRATA_FIFO_FULL_ABORT;
> 
>  	if (uart->errata & UART_ERRATA_FIFO_FULL_ABORT) {
> --
> 1.7.0.4

