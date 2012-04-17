From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] OMAP2+: UART: Add mechanism to probe uart pins and
 configure rx wakeup
Date: Mon, 16 Apr 2012 18:41:03 -0700
Message-ID: <20120417014103.GA21106@atomide.com>
References: <1334065246-21294-1-git-send-email-govindraj.raja@ti.com>
 <1334065246-21294-3-git-send-email-govindraj.raja@ti.com>
 <20120410161136.GF6487@atomide.com>
 <CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:23018 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab2DQBlG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 21:41:06 -0400
Content-Disposition: inline
In-Reply-To: <CAMrsUdK2ZqCGWtL104tBC_h-XHD0UMMFagch_eSER+92zC1FiQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Kevin Hilman <khilman@ti.com>, Russ Dill <russ.dill@gmail.com>

Hi,

Few more comments below.

* Raja, Govindraj <govindraj.raja@ti.com> [120411 04:53]:
...
 
> +static int  __init omap_serial_fill_default_pads(struct omap_board_data *bdata,
> +						struct omap_uart_state *uart)
> +{
> +	struct omap_mux_partition *tx_partition = NULL, *rx_partition = NULL;
> +	struct omap_mux *rx_mux = NULL, *tx_mux = NULL;
> +	char *rx_fmt, *tx_fmt;
> +	int uart_nr = bdata->id + 1;
> +
> +	if (bdata->id != 2) {
> +		rx_fmt = "uart%d_rx.uart%d_rx";
> +		tx_fmt = "uart%d_tx.uart%d_tx";
> +	} else {
> +		rx_fmt = "uart%d_rx_irrx.uart%d_rx_irrx";
> +		tx_fmt = "uart%d_tx_irtx.uart%d_tx_irtx";
> +	}
> +
> +	snprintf(rx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, rx_fmt,
> +			uart_nr, uart_nr);
> +	snprintf(tx_pad_name, OMAP_UART_DEFAULT_PAD_NAME_LEN, tx_fmt,
> +			uart_nr, uart_nr);

This naming won't work for the fourth port on 3630 as there are no "uart4_rx"
or "uart4_tx" mux entries, they are "gpmc_wait2.uart4_tx" and
"gpmc_wait3.uart4_tx".

> @@ -289,8 +354,8 @@ void __init omap_serial_board_init(struct
> omap_uart_port_info *info)
>  		bdata.pads = NULL;
>  		bdata.pads_cnt = 0;
> 
> -		if (cpu_is_omap44xx() || cpu_is_omap34xx())
> -			omap_serial_fill_default_pads(&bdata);
> +		if (omap_serial_fill_default_pads(&bdata, uart))
> +			continue;
> 
>  		if (!info)
>  			omap_serial_init_port(&bdata, NULL);

Can't the omap_serial_board_init() now be just be omap_serial_init(void)
as it's not used anywhere else?

Anyways, this is getting too complex for the -rc series as at least 2430sdp
is using alternative pins for the first uart. Let's patch to remove just
the uart4 entry for 3630 for the -rc and then we can properly fix this
for the next merge window.

Regards,

Tony
