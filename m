From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP2: Zoom2: Pass irqflags to 8250 driver
Date: Mon, 10 Aug 2009 19:39:00 +0300
Message-ID: <20090810163859.GI1938@atomide.com>
References: <1245713126-18312-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57635 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217AbZHJQjC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 12:39:02 -0400
Content-Disposition: inline
In-Reply-To: <1245713126-18312-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

* Vikram Pandita <vikram.pandita@ti.com> [090623 02:29]:
> Pass irqflags to 8250 driver from zoom2 board file
> Zoom2 has IRQF_TRIGGER_RISING requirement for the 8250 GPIO irq
> 
> This patch is dependent on 8250 driver changes getting accepted upstream:
> Refer: http://patchwork.kernel.org/patch/31884/

FYI, I'll archive this for now, please resubmit once the related changes
are integrated. Or if resubmitting the related changes, please submit this
too via the serial list.

Acked-by: Tony Lindgren <tony@atomide.com>

 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
> 
> Warning: 
> could cause compilation break if 8250 patch is not integrated first
> 
>  arch/arm/mach-omap2/board-zoom-debugboard.c |    2 ++
>  arch/arm/mach-omap2/serial.c                |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
> index bac5c43..f546063 100644
> --- a/arch/arm/mach-omap2/board-zoom-debugboard.c
> +++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
> @@ -12,6 +12,7 @@
>  #include <linux/gpio.h>
>  #include <linux/serial_8250.h>
>  #include <linux/smsc911x.h>
> +#include <linux/interrupt.h>
>  
>  #include <mach/gpmc.h>
>  
> @@ -84,6 +85,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
>  		.mapbase	= 0x10000000,
>  		.irq		= OMAP_GPIO_IRQ(102),
>  		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
> +		.irqflags	= IRQF_SHARED | IRQF_TRIGGER_RISING,
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 1,
>  		.uartclk	= QUART_CLK,
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index b094c15..45d4884 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -429,7 +429,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
>  		omap_ctrl_writew(v, uart->padconf);
>  	}
>  
> -	p->flags |= UPF_SHARE_IRQ;
> +	p->irqflags |= IRQF_SHARED;
>  	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
>  			  "serial idle", (void *)uart);
>  	WARN_ON(ret);
> -- 
> 1.6.0.3.613.g9f8f13
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
