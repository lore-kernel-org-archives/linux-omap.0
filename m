From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5] OMAP UART: Add omap-serial driver support.
Date: Wed, 27 Jan 2010 09:25:26 -0800
Message-ID: <20100127172526.GB23505@atomide.com>
References: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56982 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab0A0RZI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 12:25:08 -0500
Content-Disposition: inline
In-Reply-To: <63111.192.168.10.88.1264586216.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

Hi,

Almost there.. Few more DMA related comments and some cosmetic
things to fix below.

* Govindraj.R <govindraj.raja@ti.com> [100127 01:55]:
> From 869dde60756b2115c35d97f8e2daf014cb1af08e Mon Sep 17 00:00:00 2001
> From: Govindraj R <govindraj.raja@ti.com>
> Date: Wed, 27 Jan 2010 14:57:58 +0530
> Subject: [PATCH] OMAP UART: Add omap-serial driver support.
> 
> This patch adds support for OMAP-HIGH SPEED UART Controller.
> 
> It adds support for the following features:
> 1. It supports Interrupt mode and DMA mode of operation.
> 2. Supports Hardware flow control and software flow control.
> 3. Debug Console support on all UARTs.
> 
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/omap-serial.h |  128 +++
>  drivers/serial/Kconfig                        |   23 +
>  drivers/serial/Makefile                       |    1 +
>  drivers/serial/omap-serial.c                  | 1349 +++++++++++++++++++++++++
>  include/linux/serial_core.h                   |    3 +
>  5 files changed, 1504 insertions(+), 0 deletions(-)
>  create mode 100755 arch/arm/plat-omap/include/plat/omap-serial.h
>  create mode 100755 drivers/serial/omap-serial.c
> 
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h

<snip>

> +
> +#define DRIVER_NAME	"omap-hsuart"
> +
> +/*
> + * Use tty device name as ttyO, [O -> OMAP]
> + * in bootargs we specify as console=ttyO0 if uart1
> + * is used as console uart.
> + * Use Major 204 and minor 64.
> + * This is necessary if we should coexist with the 8250 driver,
> + * if we have an external TI-16C750 UART. Ex.ZOOM2/3 Boards.
> + */

Please change the "if we should coexist" to "in order to coexist".

All drivers should be able to coexist with the other drivers.

The wording above makes it sound like it "might be ok" to not
coexist with other drivers :)


> +#define OMAP_SERIAL_NAME	"ttyO"
> +#define OMAP_SERIAL_MAJOR	204
> +#define OMAP_SERIAL_MINOR	64

<snip>

> +#ifdef CONFIG_ARCH_OMAP4
> +#define OMAP_MAX_HSUART_PORTS 4
> +#else
> +#define OMAP_MAX_HSUART_PORTS 3
> +#endif

Also 3630 has uart4 in addition to omap4.

Then, please don't use any ifdef else settings, that will cause problems
for the multiboot. Instead, set the max number to 4 and allocate as many
instances as passed from the platform data.

> +struct uart_omap_dma {
> +	u8 			uart_dma_tx;
> +	u8 			uart_dma_rx;
> +	int		 	rx_dma_channel;

Spaces after tabs ^^^ here.

> +	int 			tx_dma_channel;
> +	dma_addr_t 		rx_buf_dma_phys;
> +	dma_addr_t	 	tx_buf_dma_phys;

Here too            ^^^

<snip>

> --- /dev/null
> +++ b/drivers/serial/omap-serial.c

<snip>

> +static void serial_omap_start_tx(struct uart_port *port)
> +{
> +	struct uart_omap_port *up = (struct uart_omap_port *)port;
> +
> +	if (up->use_dma && !(up->port.x_char)) {
> +
> +		struct circ_buf *xmit = &up->port.state->xmit;
> +		unsigned int start = up->uart_dma.tx_buf_dma_phys +
> +				(xmit->tail & (UART_XMIT_SIZE - 1));
> +		if (uart_circ_empty(xmit) || up->uart_dma.tx_dma_state)
> +			return;
> +		spin_lock(&(up->uart_dma.tx_lock));
> +		up->uart_dma.tx_dma_state = 1;
> +		spin_unlock(&(up->uart_dma.tx_lock));
> +
> +		up->uart_dma.tx_buf_size = uart_circ_chars_pending(xmit);
> +		/*
> +		 * It is a circular buffer. See if the buffer has wounded back.
> +		 * If yes it will have to be transferred in two separate dma
> +		 * transfers
> +		 */
> +		if (start + up->uart_dma.tx_buf_size >=
> +				up->uart_dma.tx_buf_dma_phys + UART_XMIT_SIZE)
> +			up->uart_dma.tx_buf_size =
> +				(up->uart_dma.tx_buf_dma_phys +
> +				UART_XMIT_SIZE) - start;
> +
> +		if (up->uart_dma.tx_dma_channel == 0xFF)
> +			omap_request_dma(up->uart_dma.uart_dma_tx,
> +					"UART Tx DMA",
> +					(void *)uart_tx_dma_callback, up,
> +					&(up->uart_dma.tx_dma_channel));

You need to check the result from omap_request_dma. On a busy system
it's quite possible that all DMA channels are taken and you need to
dynamically fall back to PIO transfer instead.

Looks like this function is easy to fix for that. Maybe you also
need to reprogram something in the UART for switching between DMA
and PIO?


> +		omap_set_dma_dest_params(up->uart_dma.tx_dma_channel, 0,
> +					OMAP_DMA_AMODE_CONSTANT,
> +					up->uart_dma.uart_base, 0, 0);
> +		omap_set_dma_src_params(up->uart_dma.tx_dma_channel, 0,
> +					OMAP_DMA_AMODE_POST_INC, start, 0, 0);
> +
> +		omap_set_dma_transfer_params(up->uart_dma.tx_dma_channel,
> +					OMAP_DMA_DATA_TYPE_S8,
> +					up->uart_dma.tx_buf_size, 1,
> +					OMAP_DMA_SYNC_ELEMENT,
> +					up->uart_dma.uart_dma_tx, 0);
> +
> +		omap_start_dma(up->uart_dma.tx_dma_channel);
> +
> +	} else if (!(up->ier & UART_IER_THRI)) {
> +		up->ier |= UART_IER_THRI;
> +		serial_out(up, UART_IER, up->ier);
> +	}
> +}

<snip>

> +static void serial_omap_start_rxdma(struct uart_omap_port *up)
> +{
> +	if (up->uart_dma.rx_dma_channel == 0xFF) {
> +		omap_request_dma(up->uart_dma.uart_dma_rx, "UART Rx DMA",
> +			(void *)uart_rx_dma_callback, up,
> +				&(up->uart_dma.rx_dma_channel));

You need to check for the result for omap_request_dma here too and
dynamically switch to PIO if you don't get a DMA channel.


> +		omap_set_dma_src_params(up->uart_dma.rx_dma_channel, 0,
> +				OMAP_DMA_AMODE_CONSTANT,
> +				up->uart_dma.uart_base, 0, 0);
> +		omap_set_dma_dest_params(up->uart_dma.rx_dma_channel, 0,
> +				OMAP_DMA_AMODE_POST_INC,
> +				up->uart_dma.rx_buf_dma_phys, 0, 0);
> +		omap_set_dma_transfer_params(up->uart_dma.rx_dma_channel,
> +				OMAP_DMA_DATA_TYPE_S8,
> +				up->uart_dma.rx_buf_size, 1,
> +				OMAP_DMA_SYNC_ELEMENT,
> +				up->uart_dma.uart_dma_rx, 0);
> +	}
> +	up->uart_dma.prev_rx_dma_pos = up->uart_dma.rx_buf_dma_phys;
> +	if (cpu_is_omap44xx())
> +		omap_writel(0, OMAP44XX_DMA4_BASE
> +			+ OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
> +	else
> +		omap_writel(0, OMAP34XX_DMA4_BASE
> +			+ OMAP_DMA4_CDAC(up->uart_dma.rx_dma_channel));
> +	omap_start_dma(up->uart_dma.rx_dma_channel);
> +	mod_timer(&up->uart_dma.rx_timer, jiffies +
> +				usecs_to_jiffies(up->uart_dma.rx_timeout));
> +	up->uart_dma.rx_dma_state = 1;
> +}

<snip>

> +static int serial_omap_probe(struct platform_device *pdev)
> +{
> +	struct uart_omap_port	*up;
> +	struct resource		*mem, *irq, *dma_tx, *dma_rx;
> +	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;

Do you have the board related patches somewhere so people can
actually test this driver?

Regards,

Tony
