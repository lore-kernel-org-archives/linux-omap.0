From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 03/12] OMAP2+: Serial: Add default mux for all uarts.
Date: Wed, 4 May 2011 03:00:51 -0700
Message-ID: <20110504100051.GZ2092@atomide.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
 <1304080796-625-4-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57134 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752185Ab1EDKAx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 06:00:53 -0400
Content-Disposition: inline
In-Reply-To: <1304080796-625-4-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

* Govindraj.R <govindraj.raja@ti.com> [110429 05:39]:
> Add default mux data for all uarts if mux info is not passed from
> board file to avoid breaking any board support.

This should only happen if omap_serial_init is called,
then boards can still use platform data with omap_serial_init_port.
 
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -66,6 +66,129 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
>  	},
>  };
>  
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_device_pad default_uart1_pads[] __initdata = {
> +	{
> +		.name	= "uart1_cts.uart1_cts",
> +		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart1_rts.uart1_rts",
> +		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart1_tx.uart1_tx",
> +		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart1_rx.uart1_rx",
> +		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> +		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	},
> +};
> +
> +static struct omap_device_pad default_uart2_pads[] __initdata = {
> +	{
> +		.name	= "uart2_cts.uart2_cts",
> +		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart2_rts.uart2_rts",
> +		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart2_tx.uart2_tx",
> +		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart2_rx.uart2_rx",
> +		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> +		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	},
> +};
> +
> +static struct omap_device_pad default_uart3_pads[] __initdata = {
> +	{
> +		.name	= "uart3_cts_rctx.uart3_cts_rctx",
> +		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart3_rts_sd.uart3_rts_sd",
> +		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart3_tx_irtx.uart3_tx_irtx",
> +		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart3_rx_irrx.uart3_rx_irrx",
> +		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> +		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> +	},
> +};
> +
> +static struct omap_device_pad default_omap36xx_uart4_pads[] __initdata = {
> +	{
> +		.name   = "gpmc_wait2.uart4_tx",
> +		.enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "gpmc_wait3.uart4_rx",
> +		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> +		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE2,
> +	},
> +};
> +
> +static struct omap_device_pad default_omap4_uart4_pads[] __initdata = {
> +	{
> +		.name	= "uart4_tx.uart4_tx",
> +		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{
> +		.name	= "uart4_rx.uart4_rx",
> +		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
> +		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> +	},

Looks like you could easily allocate the struct and use sprintf
to generate this as needed to avoid duplication.

Tony
