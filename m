From: Darren Etheridge <detheridge@ti.com>
Subject: Re: [PATCH] ARM: dts: am335x-evm: fix comments for lcd pins
Date: Fri, 9 May 2014 10:59:30 -0500
Message-ID: <20140509155929.GJ2626@ti.com>
References: <1399648580-14487-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49877 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaEIQAn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 12:00:43 -0400
Content-Disposition: inline
In-Reply-To: <1399648580-14487-1-git-send-email-wsa@the-dreams.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@sang-engineering.com>, Benoit Parrot <bparrot@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Wolfram,

Wolfram Sang <wsa@the-dreams.de> wrote on Fri [2014-May-09 17:15:50 +0200]:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> In the comments, LCD pins 16-23 were numbered in the wrong order.
> Fix this and use proper pinmux constants for all entries while we are
> 
Looks like you are absolutely correct - I just confirmed this from both
the AM335x-EVM schematic and the AM335x pinmux utility.

The same mistake is also in my EVMSK LCD enabling patch that is floating
around on this list at the moment.  I will fix that and resend it.
BeagleBone Black only uses the first 16 LCD pins so the dts for that is
correct.

Thanks for finding and fixing it.

Darren

> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Cc: Benoit Parrot <bparrot@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts | 56 ++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 6028217ace0f..1b642f1cd469 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -268,34 +268,34 @@
>  
>  	lcd_pins_s0: lcd_pins_s0 {
>  		pinctrl-single,pins = <
> -			0x20 0x01	/* gpmc_ad8.lcd_data16, OUTPUT | MODE1 */
> -			0x24 0x01	/* gpmc_ad9.lcd_data17, OUTPUT | MODE1 */
> -			0x28 0x01	/* gpmc_ad10.lcd_data18, OUTPUT | MODE1 */
> -			0x2c 0x01	/* gpmc_ad11.lcd_data19, OUTPUT | MODE1 */
> -			0x30 0x01	/* gpmc_ad12.lcd_data20, OUTPUT | MODE1 */
> -			0x34 0x01	/* gpmc_ad13.lcd_data21, OUTPUT | MODE1 */
> -			0x38 0x01	/* gpmc_ad14.lcd_data22, OUTPUT | MODE1 */
> -			0x3c 0x01	/* gpmc_ad15.lcd_data23, OUTPUT | MODE1 */
> -			0xa0 0x00	/* lcd_data0.lcd_data0, OUTPUT | MODE0 */
> -			0xa4 0x00	/* lcd_data1.lcd_data1, OUTPUT | MODE0 */
> -			0xa8 0x00	/* lcd_data2.lcd_data2, OUTPUT | MODE0 */
> -			0xac 0x00	/* lcd_data3.lcd_data3, OUTPUT | MODE0 */
> -			0xb0 0x00	/* lcd_data4.lcd_data4, OUTPUT | MODE0 */
> -			0xb4 0x00	/* lcd_data5.lcd_data5, OUTPUT | MODE0 */
> -			0xb8 0x00	/* lcd_data6.lcd_data6, OUTPUT | MODE0 */
> -			0xbc 0x00	/* lcd_data7.lcd_data7, OUTPUT | MODE0 */
> -			0xc0 0x00	/* lcd_data8.lcd_data8, OUTPUT | MODE0 */
> -			0xc4 0x00	/* lcd_data9.lcd_data9, OUTPUT | MODE0 */
> -			0xc8 0x00	/* lcd_data10.lcd_data10, OUTPUT | MODE0 */
> -			0xcc 0x00	/* lcd_data11.lcd_data11, OUTPUT | MODE0 */
> -			0xd0 0x00	/* lcd_data12.lcd_data12, OUTPUT | MODE0 */
> -			0xd4 0x00	/* lcd_data13.lcd_data13, OUTPUT | MODE0 */
> -			0xd8 0x00	/* lcd_data14.lcd_data14, OUTPUT | MODE0 */
> -			0xdc 0x00	/* lcd_data15.lcd_data15, OUTPUT | MODE0 */
> -			0xe0 0x00	/* lcd_vsync.lcd_vsync, OUTPUT | MODE0 */
> -			0xe4 0x00	/* lcd_hsync.lcd_hsync, OUTPUT | MODE0 */
> -			0xe8 0x00	/* lcd_pclk.lcd_pclk, OUTPUT | MODE0 */
> -			0xec 0x00	/* lcd_ac_bias_en.lcd_ac_bias_en, OUTPUT | MODE0 */
> +			0x20 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad8.lcd_data23 */
> +			0x24 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad9.lcd_data22 */
> +			0x28 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad10.lcd_data21 */
> +			0x2c (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad11.lcd_data20 */
> +			0x30 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad12.lcd_data19 */
> +			0x34 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad13.lcd_data18 */
> +			0x38 (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad14.lcd_data17 */
> +			0x3c (PIN_OUTPUT | MUX_MODE1)		/* gpmc_ad15.lcd_data16 */
> +			0xa0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data0.lcd_data0 */
> +			0xa4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data1.lcd_data1 */
> +			0xa8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data2.lcd_data2 */
> +			0xac (PIN_OUTPUT | MUX_MODE0)		/* lcd_data3.lcd_data3 */
> +			0xb0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data4.lcd_data4 */
> +			0xb4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data5.lcd_data5 */
> +			0xb8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data6.lcd_data6 */
> +			0xbc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data7.lcd_data7 */
> +			0xc0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data8.lcd_data8 */
> +			0xc4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data9.lcd_data9 */
> +			0xc8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data10.lcd_data10 */
> +			0xcc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data11.lcd_data11 */
> +			0xd0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data12.lcd_data12 */
> +			0xd4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data13.lcd_data13 */
> +			0xd8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_data14.lcd_data14 */
> +			0xdc (PIN_OUTPUT | MUX_MODE0)		/* lcd_data15.lcd_data15 */
> +			0xe0 (PIN_OUTPUT | MUX_MODE0)		/* lcd_vsync.lcd_vsync */
> +			0xe4 (PIN_OUTPUT | MUX_MODE0)		/* lcd_hsync.lcd_hsync */
> +			0xe8 (PIN_OUTPUT | MUX_MODE0)		/* lcd_pclk.lcd_pclk */
> +			0xec (PIN_OUTPUT | MUX_MODE0)		/* lcd_ac_bias_en.lcd_ac_bias_en */
>  		>;
>  	};
>  
> -- 
> 1.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
