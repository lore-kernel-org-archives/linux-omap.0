From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] omap4: board-omap4panda: Initialise the serial pads
Date: Wed, 23 Feb 2011 10:49:50 -0800
Message-ID: <20110223184950.GX15225@atomide.com>
References: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
 <1296191298-17545-5-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:36197 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271Ab1BWStx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Feb 2011 13:49:53 -0500
Content-Disposition: inline
In-Reply-To: <1296191298-17545-5-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, paul@pwsan.com

* sricharan <r.sricharan@ti.com> [110127 21:05]:
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

Here too please check the need for dynamic remuxing and
update the patch if necessary.

Regards,

Tony
