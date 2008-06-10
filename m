From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH v2] omap3beagle: add a platform device to hook up the GPIO leds to the leds-gpio driver
Date: Tue, 10 Jun 2008 23:23:47 +0200
Message-ID: <96F02D3C-315B-4D51-812F-8E8B1C592B1A@student.utwente.nl>
References: <1212195566-22695-1-git-send-email-k.kooi@student.utwente.nl>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:37597 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbYFJVYj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jun 2008 17:24:39 -0400
Received: from [172.20.1.5] (vpn006024.vpn.utwente.nl [130.89.6.24])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m5ALNoD7007533
          for <linux-omap@vger.kernel.org>; Tue, 10 Jun 2008 23:23:51 +0200
In-Reply-To: <1212195566-22695-1-git-send-email-k.kooi@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 31 mei 2008, om 02:59 heeft Koen Kooi het volgende geschreven:

> From: Koen Kooi <koen@openembedded.org>
>
> omap3beagle: add a platform device to hook up the GPIO leds to the  
> leds-gpio driver
> * on revision A5 and earlier board the two leds can't be controlled  
> seperately, should be fixed in rev. B and C boards.
>
> Changes since v1: indented structs with tabs
>
> Signed-off-by: Koen Kooi <koen@openembedded.org>


Any objections against applying this patch?




>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |   28 ++++++++++++++++++++++ 
> ++++++
> 1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach- 
> omap2/board-omap3beagle.c
> index c992cc7..83891fc 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -19,6 +19,7 @@
> #include <linux/err.h>
> #include <linux/clk.h>
> #include <linux/io.h>
> +#include <linux/leds.h>
>
> #include <asm/hardware.h>
> #include <asm/mach-types.h>
> @@ -72,6 +73,32 @@ static struct omap_lcd_config  
> omap3_beagle_lcd_config __initdata = {
> 	.ctrl_name	= "internal",
> };
>
> +struct gpio_led gpio_leds[] = {
> +	{
> +		.name = "beagleboard::led0",
> +		.default_trigger = "none",
> +		.gpio = 149,
> +	},
> +	{
> +		.name = "beagleboard::led1",
> +		.default_trigger = "none",
> +		.gpio = 150,
> +	},
> +};
> +
> +static struct gpio_led_platform_data gpio_led_info = {
> +	.leds = gpio_leds,
> +	.num_leds = ARRAY_SIZE(gpio_leds),
> +};
> +
> +static struct platform_device leds_gpio = {
> +	.name = "leds-gpio",
> +	.id   = -1,
> +	.dev  = {
> +		.platform_data = &gpio_led_info,
> +	},
> +};
> +
> static struct omap_board_config_kernel omap3_beagle_config[]  
> __initdata = {
> 	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
> 	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
> @@ -83,6 +110,7 @@ static struct platform_device  
> *omap3_beagle_devices[] __initdata = {
> #ifdef CONFIG_RTC_DRV_TWL4030
> 	&omap3_beagle_twl4030rtc_device,
> #endif
> +	&leds_gpio,
> };
>
> static void __init omap3_beagle_init(void)
> -- 
> 1.5.4.3
>
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFITvDlMkyGM64RGpERAuZiAJ98z/SmVIojeYFkeawMqnPxAyvzcACeIJwX
u+WuEQPKIZjh3aRskDG7UlU=
=7RQA
-----END PGP SIGNATURE-----
