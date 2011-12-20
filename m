From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH V2 2/2] mcx: support for HTKW mcx board
Date: Wed, 21 Dec 2011 00:07:37 +0400
Message-ID: <4EF0EB09.4010008@emcraft.com>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com> <1323910383-1184-3-git-send-email-yanok@emcraft.com> <4EE9CEB1.3050003@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:47649 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703Ab1LTUHH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 15:07:07 -0500
In-Reply-To: <4EE9CEB1.3050003@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com

Hi Igor,

On 15.12.2011 14:40, Igor Grinberg wrote:
>> +	r = gpio_request_array(mcx_dss_gpios, ARRAY_SIZE(mcx_dss_gpios));
>> +	if (r) {
>> +		pr_err("failed to get DSS control GPIOs\n");
>> +		return;
>> +	}
>> +
>> +	omap_mux_init_gpio(LCD_BKLIGHT_EN, OMAP_PIN_OUTPUT);
>> +	omap_mux_init_gpio(LCD_LVL_SFHT_BUF_ENn, OMAP_PIN_OUTPUT);
>> +	omap_mux_init_gpio(LCD_PWR_ENn, OMAP_PIN_OUTPUT);
>> +	omap_mux_init_gpio(HDMI_TRCVR_PDn, OMAP_PIN_OUTPUT);
> 
> Shouldn't you mux the pins, before you access the GPIO
> (e.g. before the gpio_request_array()).
> Are there any safety problems?

No, there are no problems. I will move mux settings above
gpio_request_array() call.

>> +static struct omap2_hsmmc_info mmc[] = {
>> +	{
>> +		.mmc		= 1,
>> +		.caps		= MMC_CAP_4_BIT_DATA,
>> +		.gpio_cd        = SD_CARD_CD,
>> +		.gpio_wp        = SD_CARD_WP,
>> +		.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34 |
>> +					MMC_VDD_165_195,
> 
> The ocr_mask will be overridden, by the following patch:
> -----------------
> commit e89715a7e48d505f42813a4e3ee0f0efb49832ba
> Author: Abhilash K V <abhilash.kv@ti.com>
> Date:   Fri Dec 9 12:27:36 2011 -0800
> 
>     ARM: OMAP: hsmmc: Support for AM3517 MMC1 voltages
> --------------
> 
> in Tony's hsmmc branch.
> 
> IMO it should be fixed, by adding a check if the ocr_mask is
> already set...
> I can't send a patch for this right now...

Well, I think I should just drop the .ocr_mask field then. Everything
works fine for me with the above mentioned patch.

>> +#ifdef CONFIG_OMAP_MUX
>> +static struct omap_board_mux board_mux[] __initdata = {
>> +	OMAP3_MUX(CHASSIS_DMAREQ3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
>> +	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
>> +			OMAP_PULL_ENA | OMAP_PULL_UP),
>> +	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>> +	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>> +	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
>> +			OMAP_PULL_ENA | OMAP_PULL_UP),
> 
> Hmm... pullup for output? Is this needed for kind of safety?

This is a mistake indeed. Will remove the pullups.

>> +static void __init mcx_init(void)
>> +{
>> +	int err;
>> +
>> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>> +	mcx_i2c_init();
>> +	platform_add_devices(mcx_devices, ARRAY_SIZE(mcx_devices));
>> +	omap_serial_init();
> 
> Shouldn't this one be before the mcx_i2c_init() call?

Well, I think I've taken this order from some other board init... I
think the idea was to bring up regulator chip earlier. But I can move
serial up with no problem.

>> +	mcx_display_init();
>> +
>> +	/* Configure EHCI ports */
>> +	err = gpio_request_one(USB_HOST_PWR_EN, GPIOF_OUT_INIT_HIGH,
>> +			"USB_HOST_PWR_EN");
>> +	if (err)
>> +		pr_warn("Failed to request USB host power enable GPIO\n");
> 
> empty line here will improve the readability.

Ok.

Regards, Ilya.
