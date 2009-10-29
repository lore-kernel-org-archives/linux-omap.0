From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Subject: Re: [PATCHv2 2/3] OMAP UART: Add platform data for omap-serial
 driver.
Date: Thu, 29 Oct 2009 16:11:52 +0200
Message-ID: <1256825512.18599.58.camel@kauppi-desktop>
References: <36298.192.168.10.88.1256714022.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24131 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbZJ2OML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 10:12:11 -0400
In-Reply-To: <36298.192.168.10.88.1256714022.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Govindraj.R" <govindraj.raja@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Wed, 2009-10-28 at 08:13 +0100, ext Govindraj.R wrote:
> From 0f017ffac2990876331a2378e7845d91b2e0088c Mon Sep 17 00:00:00 2001
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Wed, 28 Oct 2009 12:23:02 +0530
> Subject: [PATCHv2 2/3] OMAP UART: Add platform data for omap-serial driver.
> 
> This patch adds platform data support for omap-serial driver.

One issue found when CONFIG_PM is not defined, will not compile due to:
-- clip --
arch/arm/mach-omap2/built-in.o: In function `omap_serial_init':
arch/arm/mach-omap2/serial.c:816: undefined reference to `omap_hsuart_idle_init'
arch/arm/mach-omap2/serial.c:816: undefined reference to `omap_hsuart_idle_init'
arch/arm/mach-omap2/serial.c:816: undefined reference to `omap_hsuart_idle_init'
-- clip --


> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |  166 ++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 166 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index dabc089..aa3a282 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -13,6 +13,9 @@
>   * Copyright (C) 2009 Texas Instruments
>   * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com
>   *
> + * Copyright (C) 2009 Texas Instruments
> + * Added support for Omap-Serial driver - Govindraj R <govindraj.raja@ti.com>
> + *
>   * This file is subject to the terms and conditions of the GNU General Public
>   * License. See the file "COPYING" in the main directory of this archive
>   * for more details.
> @@ -29,6 +32,10 @@
>  #include <plat/clock.h>
>  #include <plat/control.h>
> 
> +#ifdef CONFIG_SERIAL_OMAP
> +#include <plat/dma.h>
> +#include <plat/omap-serial.h>
> +#endif
>  #include "prm.h"
>  #include "pm.h"
>  #include "prm-regbits-34xx.h"
> @@ -37,6 +44,7 @@
> 
>  #define DEFAULT_TIMEOUT (5 * HZ)
> 
> +#ifdef CONFIG_SERIAL_8250
>  struct omap_uart_state {
>  	int num;
>  	int can_sleep;
> @@ -654,3 +662,161 @@ void __init omap_serial_init(void)
>  		}
>  	}
>  }
> +#endif
> +
> +#ifdef CONFIG_SERIAL_OMAP
> +
> +static struct uart_port_info uart1_port_info = {
> +		.dma_enabled	= 0,
> +		.uartclk	= OMAP24XX_BASE_BAUD * 16
> +};
> +
> +static struct uart_port_info uart2_port_info = {
> +		.dma_enabled	= 1,
> +		.uartclk	= OMAP24XX_BASE_BAUD * 16
> +};
> +
> +static struct uart_port_info uart3_port_info = {
> +		.dma_enabled	= 0,
> +		.uartclk	= OMAP24XX_BASE_BAUD * 16
> +};
> +
> +static struct resource omap2_uart1_resources[] = {
> +	{
> +		.start          = OMAP_UART1_BASE,
> +		.end            = OMAP_UART1_BASE + 0x3ff,
> +		.flags          = IORESOURCE_MEM,
> +	}, {
> +		/* UART1 IRQ - 72*/
> +		.start          = INT_24XX_UART1_IRQ,
> +		.flags          = IORESOURCE_IRQ,
> +	}, {
> +		/* UART1 TX DMA CHANNEL -S_DMA_48- */
> +		.start		= OMAP24XX_DMA_UART1_TX,
> +		.flags		= IORESOURCE_DMA,
> +	}, {
> +		/* UART1 RX DMA CHANNEL -S_DMA_49- */
> +		.start		= OMAP24XX_DMA_UART1_RX,
> +		.flags		= IORESOURCE_DMA,
> +	}
> +};
> +
> +static struct resource omap2_uart2_resources[] = {
> +	{
> +		.start          = OMAP_UART2_BASE,
> +		.end            = OMAP_UART2_BASE + 0x3ff,
> +		.flags          = IORESOURCE_MEM,
> +	}, {
> +		/* UART2 IRQ - 73*/
> +		.start          = INT_24XX_UART2_IRQ,
> +		.flags          = IORESOURCE_IRQ,
> +	}, {
> +		/* UART2 TX DMA CHANNEL -S_DMA_50- */
> +		.start		= OMAP24XX_DMA_UART2_TX,
> +		.flags		= IORESOURCE_DMA,
> +	}, {
> +		/* UART2 RX DMA CHANNEL -S_DMA_51- */
> +		.start		= OMAP24XX_DMA_UART2_RX,
> +		.flags		= IORESOURCE_DMA,
> +	}
> +};
> +
> +static struct resource omap2_uart3_resources[] = {
> +	{
> +		.start          = OMAP_UART3_BASE,
> +		.end            = OMAP_UART3_BASE + 0x3ff,
> +		.flags          = IORESOURCE_MEM,
> +	}, {
> +		/* UART3 IRQ - 74*/
> +		.start          = INT_24XX_UART3_IRQ,
> +		.flags          = IORESOURCE_IRQ,
> +	}, {
> +		/* UART3 TX DMA CHANNEL -S_DMA_52- */
> +		.start		= OMAP24XX_DMA_UART3_TX,
> +		.flags		= IORESOURCE_DMA,
> +	}, {
> +		/* UART3 RX DMA CHANNEL -S_DMA_53- */
> +		.start		= OMAP24XX_DMA_UART3_RX,
> +		.flags		= IORESOURCE_DMA,
> +	}
> +};
> +
> +/* OMAP UART platform structure */
> +static struct platform_device uart1_device = {
> +	.name			= "omap-uart",
> +	.id			= 1,
> +	.num_resources		= ARRAY_SIZE(omap2_uart1_resources),
> +	.resource		= omap2_uart1_resources,
> +	.dev			= {
> +		.platform_data  = &uart1_port_info
> +	},
> +};
> +static struct platform_device uart2_device = {
> +	.name			= "omap-uart",
> +	.id			= 2,
> +	.num_resources		= ARRAY_SIZE(omap2_uart2_resources),
> +	.resource		= omap2_uart2_resources,
> +	.dev			= {
> +		.platform_data  = &uart2_port_info,
> +	},
> +};
> +static struct platform_device uart3_device = {
> +	.name			= "omap-uart",
> +	.id			= 3,
> +	.num_resources		= ARRAY_SIZE(omap2_uart3_resources),
> +	.resource		= omap2_uart3_resources,
> +	.dev			= {
> +		.platform_data  = &uart3_port_info,
> +	},
> +};
> +
> +static struct platform_device *uart_devices[] = {
> +	&uart1_device,
> +	&uart2_device,
> +	&uart3_device,
> +};
> +
> +void omap_serial_hsuart_wakeup_source_init(int num)
> +{
> +	struct omap_hsuart_state *uart = &omap_hsuart[num];
> +
> +	if (cpu_is_omap34xx()) {
> +		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
> +		u32 wk_mask = 0;
> +		u32 padconf = 0;
> +
> +		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
> +		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
> +		switch (uart->num) {
> +		case 0:
> +			wk_mask = OMAP3430_ST_UART1_MASK;
> +			padconf = 0x182;
> +			break;
> +		case 1:
> +			wk_mask = OMAP3430_ST_UART2_MASK;
> +			padconf = 0x17a;
> +			break;
> +		case 2:
> +			wk_mask = OMAP3430_ST_UART3_MASK;
> +			padconf = 0x19e;
> +			break;
> +		}
> +		uart->wk_mask = wk_mask;
> +		uart->padconf = padconf;
> +	} else {
> +		uart->wk_en = 0;
> +		uart->wk_st = 0;
> +		uart->wk_mask = 0;
> +		uart->padconf = 0;
> +	}
> +}
> +
> +void __init omap_serial_init(void)
> +{
> +	int ret = 0, i;
> +	for (i = 0; i < ARRAY_SIZE(uart_devices); i++)
> +		omap_hsuart_idle_init(i);

-- HERE --

> +
> +	ret = platform_add_devices(uart_devices, ARRAY_SIZE(uart_devices));
> +}
> +#endif /* CONFIG_SERIAL_OMAP */


--
Ari

