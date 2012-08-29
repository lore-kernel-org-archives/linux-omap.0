From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC PATCH 5/5] arm: omap: n8x0: enable retu
Date: Wed, 29 Aug 2012 16:40:08 -0700
Message-ID: <20120829234008.GK1303@atomide.com>
References: <1346189667-32330-1-git-send-email-aaro.koskinen@iki.fi>
 <1346189667-32330-6-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43504 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754612Ab2H2XkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 19:40:10 -0400
Content-Disposition: inline
In-Reply-To: <1346189667-32330-6-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [120828 14:35]:
> Add Retu configuration.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/mach-omap2/board-n8x0.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
> index 8ea0dea..6ac8cd9 100644
> --- a/arch/arm/mach-omap2/board-n8x0.c
> +++ b/arch/arm/mach-omap2/board-n8x0.c
> @@ -58,8 +58,16 @@ static struct platform_device n8x0_cbus_device = {
>  	},
>  };
>  
> +static struct i2c_board_info n8x0_i2c_board_info_3[] __initdata = {
> +	{
> +		I2C_BOARD_INFO("retu-mfd", 0x01),
> +	},
> +};
> +
>  static void __init n8x0_cbus_init(void)
>  {
> +	i2c_register_board_info(3, n8x0_i2c_board_info_3,
> +				ARRAY_SIZE(n8x0_i2c_board_info_3));
>  	platform_device_register(&n8x0_cbus_device);
>  }
>  #else /* CONFIG_I2C_CBUS */

I suggest merging patches 4 & 5 into patch 1 and merge it via the
i2c list:

Acked-by: Tony Lindgren <tony@atomide.com>
