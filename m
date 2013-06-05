From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio/omap: omap_gpio_init_context stub must be inline
Date: Wed, 5 Jun 2013 08:38:47 -0700
Message-ID: <20130605153847.GV3331@atomide.com>
References: <2942784.trumtc2GjZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:26478 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab3FEPiw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Jun 2013 11:38:52 -0400
Content-Disposition: inline
In-Reply-To: <2942784.trumtc2GjZ@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>

* Arnd Bergmann <arnd@arndb.de> [130531 09:05]:
> The bug fix 352a2d5bf "gpio/omap: ensure gpio context is initialised"
> has caused a new warning for omap1_defconfig:
> 
> drivers/gpio/gpio-omap.c:1465:13: warning: 'omap_gpio_init_context' defined but not used [-Wunused-function]
>  static void omap_gpio_init_context(struct gpio_bank *p) {}
>              ^
> 
> The solution is to mark the stub function as 'static inline' so
> it gets left out of the build when unused.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index d3f7d2d..e5fba65 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1462,7 +1462,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
>  #else
>  #define omap_gpio_runtime_suspend NULL
>  #define omap_gpio_runtime_resume NULL
> -static void omap_gpio_init_context(struct gpio_bank *p) {}
> +static inline void omap_gpio_init_context(struct gpio_bank *p) {}
>  #endif
>  
>  static const struct dev_pm_ops gpio_pm_ops = {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
