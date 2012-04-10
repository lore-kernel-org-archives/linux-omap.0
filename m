From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Tue, 10 Apr 2012 09:11:37 -0700
Message-ID: <20120410161136.GF6487@atomide.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-3-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31497 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab2DJQLm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Apr 2012 12:11:42 -0400
Content-Disposition: inline
In-Reply-To: <1334065246-21294-3-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>

* Govindraj.R <govindraj.raja@ti.com> [120410 06:44]:
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -120,11 +120,63 @@ static void omap_uart_set_smartidle(struct platform_device *pdev) {}
>  #endif /* CONFIG_PM */
>  
>  #ifdef CONFIG_OMAP_MUX
> -static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
> +
> +#define OMAP_UART_DEFAULT_PAD_NAME_LEN	28
> +static char rx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN],
> +		tx_pad_name[OMAP_UART_DEFAULT_PAD_NAME_LEN] __initdata;
> +static struct omap_device_pad default_omap_uart_pads[2] __initdata;

Won't the default_omap_uart_pads get overwritten for each port?
We need that information in the driver too for each port? Why don't you
just allocate bdata.pads in omap_serial_board_init as we now assume it's
needed for each port?

> +static void  __init omap_serial_fill_default_pads(struct omap_board_data *bdata)
>  {
> +	struct omap_mux_partition *tx_partition = NULL, *rx_partition = NULL;
> +	struct omap_mux *rx_mux = NULL, *tx_mux = NULL;
> +
> +	if (bdata->id != 2) {
> +		snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> +			 "uart%d_rx.uart%d_rx", bdata->id + 1, bdata->id + 1);
> +		snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> +			 "uart%d_tx.uart%d_tx", bdata->id + 1, bdata->id + 1);
> +	} else {
> +		snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> +			"uart%d_rx_irrx.uart%d_rx_irrx", bdata->id + 1,
> +			bdata->id + 1);
> +		snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN,
> +			"uart%d_tx_irtx.uart%d_tx_irtx", bdata->id + 1,
> +			bdata->id + 1);
> +	}

This would be simpler with something like this (untested):

	char *rx_fmt, *tx_fmt;
	int uart_nr = bdata->id + 1;

	if (bdata->id == 2) {
		rx_fmt = "uart%d_rx.uart%d_rx";
		tx_fmt = "uart%d_tx.uart%d_tx";
        } else {
		rx_fmt = "uart%d_rx_irrx.uart%d_rx_irrx";
		tx_fmt = "uart%d_tx_irtx.uart%d_tx_irtx";
        }

	snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, rx_fmt,
			uart_nr, uart_nr);
	snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, tx_fmt,
			uart_nr, uart_nr);

> +	if (omap_mux_get_by_name(rx_pad_name, &rx_partition, &rx_mux) >= 0 &&
> +			omap_mux_get_by_name
> +				(tx_pad_name, &tx_partition, &tx_mux) >= 0) {
> +		u16 tx_mode, rx_mode;
> +
> +		tx_mode = omap_mux_read(tx_partition, tx_mux->reg_offset);
> +		rx_mode = omap_mux_read(rx_partition, rx_mux->reg_offset);
> +
> +		/*
> +		 * Check if uart is used in default tx/rx mode i.e. in mux mode0
> +		 * if yes then configure rx pin for wake up capability
> +		 */
> +		if (!(rx_mode & 0x07) && !(tx_mode & 0x07)) {
> +			default_omap_uart_pads[0].name = rx_pad_name;
> +			default_omap_uart_pads[0].flags  =
> +				OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP;
> +			default_omap_uart_pads[0].enable = OMAP_PIN_INPUT |
> +								OMAP_MUX_MODE0;
> +			default_omap_uart_pads[0].idle = OMAP_PIN_INPUT |
> +								OMAP_MUX_MODE0;
> +
> +			default_omap_uart_pads[1].name = tx_pad_name;
> +			default_omap_uart_pads[1].enable = OMAP_PIN_OUTPUT |
> +								OMAP_MUX_MODE0;
> +			bdata->pads = default_omap_uart_pads;
> +			bdata->pads_cnt = ARRAY_SIZE(default_omap_uart_pads);
> +		}
> +	}
>  }

Then looking at omap_serial_board_init, it still looks wrong:

void __init omap_serial_board_init(struct omap_uart_port_info *info)
{
	struct omap_uart_state *uart;
	struct omap_board_data bdata;

	list_for_each_entry(uart, &uart_list, node) {
		bdata.id = uart->num;
		bdata.flags = 0;
		bdata.pads = NULL;
		bdata.pads_cnt = 0;

		if (cpu_is_omap44xx() || cpu_is_omap34xx())
			omap_serial_fill_default_pads(&bdata);

Why don't you fill the pads for omap2? It has the same pads, although
it does not have the serial wake-up events working.

And why don't you exit if omap_serial_fill_default_pads fails for the
no info case?

Shouldn't it be something like:

		if (!info) {
			res = omap_serial_fill_default_pads(&bdata);
			if (!res)
				return;
			port = NULL;
		} else {
			port = &info[uart->num];		
		}
		omap_serial_init_port(&bdata, port);

Regards,

Tony
