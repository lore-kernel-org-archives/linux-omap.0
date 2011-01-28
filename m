From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH 4/5] omap4: board-omap4panda: Initialise the serial pads
Date: Sat, 29 Jan 2011 02:23:01 +0530
Message-ID: <2d8db7abba67b9f29041e0f3512fa98b@mail.gmail.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com> <1296191298-17545-5-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:43666 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282Ab1A1UxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Jan 2011 15:53:04 -0500
Received: by mail-ww0-f47.google.com with SMTP id 39so4561897wwb.16
        for <linux-omap@vger.kernel.org>; Fri, 28 Jan 2011 12:53:04 -0800 (PST)
In-Reply-To: <1296191298-17545-5-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sricharan R <r.sricharan@ti.com>, linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, tony@atomide.com, paul@pwsan.com

Sricharan wrote:
> Use the mux framework to initialise the serial pads.
>
> Signed-off-by: sricharan <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   72
+++++++++++++++++++++++++++++++-
>  1 files changed, 71 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
> b/arch/arm/mach-omap2/board-omap4panda.c
> index b43e3ff..9688ea9 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -370,13 +370,83 @@ static int __init omap4_panda_i2c_init(void)
>  	omap_register_i2c_bus(4, 400, NULL, 0);
>  	return 0;
>  }
> -
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
> +
> +static struct omap_device_pad serial2_pads[] __initdata = {
> +	{ .name   = "uart2_cts.uart2_cts",
> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	  .flags  = OMAP_DEVICE_PAD_REMUX_IDLE,
> +	  .idle   = OMAP_MUX_MODE7,
> +	},
> +	{ .name   = "uart2_rts.uart2_rts",
> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{ .name   = "uart2_rx.uart2_rx",
> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	},
> +	{ .name   = "uart2_tx.uart2_tx",
> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +};
> +
> +static struct omap_device_pad serial3_pads[] __initdata = {
> +	{ .name   = "uart3_cts_rctx.uart3_cts_rctx",
> +	  .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
> +	},
> +	{ .name   = "uart3_rts_sd.uart3_rts_sd",
> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +	{ .name   = "uart3_rx_irrx.uart3_rx_irrx",
> +	  .enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> +	},
> +	{ .name   = "uart3_tx_irtx.uart3_tx_irtx",
> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +};
> +
> +static struct omap_device_pad serial4_pads[] __initdata = {
> +	{ .name   = "uart4_rx.uart4_rx",
> +	.enable = OMAP_PIN_INPUT | OMAP_MUX_MODE0,
> +	},
> +	{ .name   = "uart4_tx.uart4_tx",
> +	  .enable = OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
> +	},
> +};
> +
> +static struct omap_board_data serial2_data = {
> +	.id             = 1,
> +	.pads           = serial2_pads,
> +	.pads_cnt       = ARRAY_SIZE(serial2_pads),
> +};
> +
> +static struct omap_board_data serial3_data = {
> +	.id             = 2,
> +	.pads           = serial3_pads,
> +	.pads_cnt       = ARRAY_SIZE(serial3_pads),
> +};
> +
> +static struct omap_board_data serial4_data = {
> +	.id             = 3,
> +	.pads           = serial4_pads,
> +	.pads_cnt       = ARRAY_SIZE(serial4_pads),
> +};
> +
> +static inline void board_serial_init(void)
> +{
> +	omap_serial_init_port(&serial2_data);
> +	omap_serial_init_port(&serial3_data);
> +	omap_serial_init_port(&serial4_data);
> +}
>  #else
>  #define board_mux	NULL
> +
> +static inline void board_serial_init(void)
> +{
> +	omap_serial_init();
> +}
>  #endif
>
>  static void __init omap4_panda_init(void)

You are changing the behavior with this patch.
Original code configured all 4 UARTs, while it
appears that your patch changes this to skip UART1.

This is not explained in the changelog. Is this
a deliberate change? Why would you want to do this?

- Anand
