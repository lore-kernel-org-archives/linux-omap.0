From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP: ads7846: fix pendown debounce setting
Date: Wed, 21 Nov 2012 11:08:47 -0800
Message-ID: <20121121190847.GE18567@atomide.com>
References: <1353341038-14381-1-git-send-email-grinberg@compulab.co.il>
 <1353341038-14381-3-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:59438 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755566Ab2KUTIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Nov 2012 14:08:54 -0500
Content-Disposition: inline
In-Reply-To: <1353341038-14381-3-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zumeng Chen <zumeng.chen@windriver.com>

* Igor Grinberg <grinberg@compulab.co.il> [121119 08:06]:
> Commit 97ee9f01 (ARM: OMAP: fix the ads7846 init code) have enabled the
> pendown GPIO debounce time setting by the below sequence:
> 
>   gpio_request_one()
>   gpio_set_debounce()
>   gpio_free()
> 
> It also revealed a bug in the OMAP GPIO handling code which prevented
> the GPIO debounce clock to be disabled and CORE transition to low power
> states.
> 
> Commit c9c55d9 (gpio/omap: fix off-mode bug: clear debounce settings on
> free/reset) fixes the OMAP GPIO handling code by making sure that the
> GPIO debounce clock gets disabled if no GPIO is requested from current
> bank.
> 
> While fixing the OMAP GPIO handling code (in the right way), the above
> commit makes the gpio_request->set_debounce->free sequence invalid as
> after freeing the GPIO, the debounce settings are lost.
> 
> Fix the debounce settings by moving the debounce initialization to the
> actual GPIO requesting code - the ads7846 driver.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Zumeng Chen <zumeng.chen@windriver.com>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/mach-omap2/common-board-devices.c |   34 ++++++++++++++++-----------
>  1 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
> index ad85609..d246efd 100644
> --- a/arch/arm/mach-omap2/common-board-devices.c
> +++ b/arch/arm/mach-omap2/common-board-devices.c
> @@ -63,30 +63,36 @@ void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>  	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
>  	int err;
>  
> -	err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> -	if (err) {
> -		pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> -		return;
> -	}
> +	/*
> +	 * If a board defines get_pendown_state() function, request the pendown
> +	 * GPIO and set the GPIO debounce time.
> +	 * If a board does not define the get_pendown_state() function, then
> +	 * the ads7846 driver will setup the pendown GPIO itself.
> +	 */
> +	if (board_pdata && board_pdata->get_pendown_state) {
> +		err = gpio_request_one(gpio_pendown, GPIOF_IN, "TSPenDown");
> +		if (err) {
> +			pr_err("Couldn't obtain gpio for TSPenDown: %d\n", err);
> +			return;
> +		}
> +
> +		if (gpio_debounce)
> +			gpio_set_debounce(gpio_pendown, gpio_debounce);
>  
> -	if (gpio_debounce)
> -		gpio_set_debounce(gpio_pendown, gpio_debounce);
> +		gpio_export(gpio_pendown, 0);
> +	}
>  
>  	spi_bi->bus_num	= bus_num;
>  	spi_bi->irq	= gpio_to_irq(gpio_pendown);
>  
> +	ads7846_config.gpio_pendown = gpio_pendown;
> +
>  	if (board_pdata) {
>  		board_pdata->gpio_pendown = gpio_pendown;
> +		board_pdata->gpio_pendown_debounce = gpio_debounce;
>  		spi_bi->platform_data = board_pdata;
> -		if (board_pdata->get_pendown_state)
> -			gpio_export(gpio_pendown, 0);
> -	} else {
> -		ads7846_config.gpio_pendown = gpio_pendown;
>  	}
>  
> -	if (!board_pdata || (board_pdata && !board_pdata->get_pendown_state))
> -		gpio_free(gpio_pendown);
> -
>  	spi_register_board_info(&ads7846_spi_board_info, 1);
>  }
>  #else
> -- 
> 1.7.3.4
> 
