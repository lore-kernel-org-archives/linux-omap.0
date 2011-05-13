From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH 2/4] omap: igep0020: minor refactoring
Date: Fri, 13 May 2011 20:44:38 +0200
Message-ID: <201105132044.39163.arnd@arndb.de>
References: <cover.1305235542.git.mike@compulab.co.il> <91dd03e6af514a628fc4d797066f3ef0d971b802.1305235542.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54028 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758895Ab1ENUeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 May 2011 16:34:09 -0400
In-Reply-To: <91dd03e6af514a628fc4d797066f3ef0d971b802.1305235542.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Mike Rapoport <mike@compulab.co.il>, Tony.Lindgren.tony@atomide.com, Enric =?utf-8?q?Balletb=EF=BF=BD_i_Serra?= <eballetbo@gmail.com>, linux-omap@vger.kernel.org

On Thursday 12 May 2011, Mike Rapoport wrote:
> @@ -299,17 +299,14 @@ static struct omap2_hsmmc_info mmc[] = {
>  static struct gpio_led igep_gpio_leds[] = {
>         [0] = {
>                 .name                   = "gpio-led:red:d0",
> -               .gpio                   = IGEP2_GPIO_LED0_RED,
>                 .default_trigger        = "default-off"
>         },
>         [1] = {
>                 .name                   = "gpio-led:green:d0",
> -               .gpio                   = IGEP2_GPIO_LED0_GREEN,
>                 .default_trigger        = "default-off",
>         },
>         [2] = {
>                 .name                   = "gpio-led:red:d1",
> -               .gpio                   = IGEP2_GPIO_LED1_RED,
>                 .default_trigger        = "default-off",
>         },
>         [3] = {
> @@ -335,6 +332,10 @@ static struct platform_device igep_led_device = {
>  
>  static void __init igep_leds_init(void)
>  {
> +       igep_gpio_leds[0].gpio = IGEP2_GPIO_LED0_RED;
> +       igep_gpio_leds[1].gpio = IGEP2_GPIO_LED0_GREEN;
> +       igep_gpio_leds[2].gpio = IGEP2_GPIO_LED1_RED;
> +
>         platform_device_register(&igep_led_device);
>  }

Hi Mike,

Overall, the series looks great, but I'm somewhat worried by the fact that you
have to replace data structures with code in order to get there. Are there any
other options to do this?

	Arnd

