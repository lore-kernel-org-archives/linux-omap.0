From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 2/2][RFC] OMAP4: UART4 Support for OMAP_4430SDP.
Date: Tue, 12 May 2009 12:14:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B476C630@dbde02.ent.ti.com>
References: <51950.192.168.10.89.1241612607.squirrel@dbdmail.itg.ti.com>
 <55287.192.168.10.89.1242109234.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45031 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754353AbZELGo4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 02:44:56 -0400
In-Reply-To: <55287.192.168.10.89.1242109234.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed, Rafiuddin" <rafiuddin.syed@ti.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Both patches looks independent. In that case this need not be a series.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Syed Rafiuddin
> Sent: Tuesday, May 12, 2009 11:51 AM
> To: linux-arm-kernel@lists.arm.linux.org.uk
> Cc: linux-omap@vger.kernel.org
> Subject: [PATCH 2/2][RFC] OMAP4: UART4 Support for OMAP_4430SDP.
> 
> This patch enables support for UART4 on OMAP4430 development platform.
> 
> Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> ---
> arch/arm/mach-omap2/board-4430sdp.c |    2 +-
>  arch/arm/mach-omap2/serial.c        |   12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c	
> 2009-05-12
> 10:43:41.000000000 +0530
> +++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c	
> 2009-05-12 11:40:54.000000000
> +0530
> @@ -38,7 +38,7 @@
>  };
> 
>  static struct omap_uart_config sdp4430_uart_config __initdata = {
> -	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
> +	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2) | (1 << 3)),
>  };
> 
>  static struct omap_lcd_config sdp4430_lcd_config __initdata = {
> Index: linux-2.6/arch/arm/mach-omap2/serial.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/serial.c	
> 2009-05-12 11:35:55.000000000
> +0530
> +++ linux-2.6/arch/arm/mach-omap2/serial.c	2009-05-12 
> 11:46:13.000000000 +0530
> @@ -53,8 +53,20 @@
>  		.iotype		= UPIO_MEM,
>  		.regshift	= 2,
>  		.uartclk	= OMAP24XX_BASE_BAUD * 16,
> +
> +	}, {
> +#ifdef CONFIG_ARCH_OMAP4
> +		.membase        = IO_ADDRESS(OMAP_UART3_BASE),
> +		.mapbase        = OMAP_UART4_BASE,
> +		.irq            = 70,
> +		.flags          = UPF_BOOT_AUTOCONF,
> +		.iotype         = UPIO_MEM,
> +		.regshift       = 2,
> +		.uartclk        = OMAP24XX_BASE_BAUD * 16,
>  	}, {
> +#else
>  		.flags		= 0
> +#endif
>  	}
>  };


Regards,
Santosh
  
