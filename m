From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2-V2] AM3517: Enable RTC driver support for AM3517EVM
Date: Thu, 11 Feb 2010 12:32:43 -0800
Message-ID: <20100211203243.GH21755@atomide.com>
References: <hvaibhav@ti.com>
 <1265875947-12306-2-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57894 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab0BKUcG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 15:32:06 -0500
Content-Disposition: inline
In-Reply-To: <1265875947-12306-2-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org

* hvaibhav@ti.com <hvaibhav@ti.com> [100211 00:09]:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Add platform hook-up interface to support RTC driver (S35390A).
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index 247c700..d9f487f 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -174,6 +174,18 @@ struct platform_device am3517_evm_dss_device = {
>  		.platform_data	= &am3517_evm_dss_data,
>  	},
>  };
> +/*
> + * RTC - S35390A
> + */
> +#define	GPIO_RTCS35390A_IRQ	55

Please change this into standard

#define GPIO_RTCS35390A_IRQ     55

instead of having a tab between #define and GPIO...

> +static struct i2c_board_info __initdata am3517evm_i2c_boardinfo[] = {
> +	{
> +		I2C_BOARD_INFO("s35390a", 0x30),
> +		.type		= "s35390a",
> +	},
> +};
> +
> 
>  static int __init am3517_evm_i2c_init(void)
>  {
> @@ -235,6 +247,19 @@ static void __init am3517_evm_init(void)
>  	usb_ehci_init(&ehci_pdata);
>  	/* DSS */
>  	am3517_evm_display_init();
> +
> +	/* RTC - S35390A */
> +	omap_mux_init_gpio(55, OMAP_PIN_INPUT_PULLUP);
> +	if (gpio_request(GPIO_RTCS35390A_IRQ, "rtcs35390a-irq") < 0)
> +		printk(KERN_WARNING "failed to request GPIO#%d\n",
> +				GPIO_RTCS35390A_IRQ);

Here you need to check the return value before trying to change
the GPIO value. In general it's preferred to use:

	int err;

	err = gpio_request()
	if (err < 0)
		return err;
	...


> +	if (gpio_direction_input(GPIO_RTCS35390A_IRQ))
> +		printk(KERN_WARNING "GPIO#%d cannot be configured as "
> +				"input\n", GPIO_RTCS35390A_IRQ);

And only after that call gpio_direction_input.

Regards,

Tony

> +	am3517evm_i2c_boardinfo[0].irq = gpio_to_irq(GPIO_RTCS35390A_IRQ);
> +
> +	i2c_register_board_info(1, am3517evm_i2c_boardinfo,
> +				ARRAY_SIZE(am3517evm_i2c_boardinfo));
>  }
> 
>  static void __init am3517_evm_map_io(void)
> --
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
