From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH] omap: rx51: Platform support for lp5523 led chip
Date: Thu, 31 Mar 2011 15:27:36 +0300 (EEST)
Message-ID: <alpine.DEB.1.10.1103311524420.2634@esdhcp041196.research.nokia.com>
References: <1301573877-26010-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:33514 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab1CaMbB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 08:31:01 -0400
In-Reply-To: <1301573877-26010-1-git-send-email-ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap@vger.kernel.org, mathias.nyman@nokia.com, linux-arm-kernel@lists.infradead.org

Hi,

On Thu, 31 Mar 2011, Ameya Palande wrote:
> +static int rx51_lp5523_setup(void)
> +{
> +	int err;
> +
> +	err = gpio_request(RX51_LP5523_CHIP_EN_GPIO, "lp5523_enable");
> +	if (err < 0) {
> +		pr_err("Unable to get lp5523_enable GPIO\n");
> +		return err;
> +	}
> +
> +	err = gpio_direction_output(RX51_LP5523_CHIP_EN_GPIO, 1);
> +	if (err < 0) {
> +		pr_err("Failed to change direction for %d GPIO\n",
> +				RX51_LP5523_CHIP_EN_GPIO);

The error branch is missing gpio_free(). You can fix that by replacing
these with just a single gpio_request_one() call.

> +	}
> +	return err;
> +}
> +
> +static void rx51_lp5523_release(void)
> +{
> +	gpio_free(RX51_LP5523_CHIP_EN_GPIO);
> +}
> +
> +static void rx51_lp5523_enable(bool state)
> +{
> +	if (state)
> +		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 1);
> +	else
> +		gpio_set_value(RX51_LP5523_CHIP_EN_GPIO, 0);
> +}
> +
> +static struct lp5523_platform_data rx51_lp5523_platform_data = {
> +	.led_config		= rx51_lp5523_led_config,
> +	.num_channels		= ARRAY_SIZE(rx51_lp5523_led_config),
> +	.clock_mode		= LP5523_CLOCK_AUTO,
> +	.setup_resources	= rx51_lp5523_setup,
> +	.release_resources 	= rx51_lp5523_release,
> +	.enable			= rx51_lp5523_enable,
> +};
> +#endif
> +
> static struct omap2_mcspi_device_config wl1251_mcspi_config = {
> 	.turbo_mode	= 0,
> 	.single_channel	= 1,
> @@ -816,6 +891,12 @@ static struct i2c_board_info __initdata rx51_peripherals_i2c_board_info_2[] = {
> 		.platform_data = &rx51_tsl2563_platform_data,
> 	},
> #endif
> +#if defined(CONFIG_LEDS_LP5523) || defined(CONFIG_LEDS_LP5523_MODULE)
> +	{
> +		I2C_BOARD_INFO("lp5523", 0x32),
> +		.platform_data  = &rx51_lp5523_platform_data,
> +	},
> +#endif
> 	{
> 		I2C_BOARD_INFO("tpa6130a2", 0x60),
> 		.platform_data = &rx51_tpa6130a2_data,
> -- 
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
