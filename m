From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] gpio: omap: Allow building as a loadable module
Date: Fri, 24 Apr 2015 17:59:31 +0300
Message-ID: <553A5A53.2090402@linaro.org>
References: <1429833382-28532-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34433 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbbDXO7h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2015 10:59:37 -0400
Received: by laat2 with SMTP id t2so37272678laa.1
        for <linux-omap@vger.kernel.org>; Fri, 24 Apr 2015 07:59:35 -0700 (PDT)
In-Reply-To: <1429833382-28532-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>

On 04/24/2015 02:56 AM, Tony Lindgren wrote:
> We currently get all kinds of errors building the omap gpio driver
> as a module starting with:
>
> undefined reference to `omap2_gpio_resume_after_idle'
> undefined reference to `omap2_gpio_prepare_for_idle'
> ...
>
> Let's fix the issue by adding inline functions to the header.
> Note that we can now also remove the two unused functions for
> omap_set_gpio_debounce and omap_set_gpio_debounce_time.
>
> Then doing rmmod on the module produces further warnings
> because of missing exit related functions. Let's add those.
>
> And finally, we can make the Kconfig entry just a tristate
> option that's selected for omaps.

Reviewed-by: Grygorii Strashko <grygorii.strashko@linaro.org>
boot tested on: dra7-evm with gpio-omap.ko

>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/Kconfig                    |  2 +-
>   drivers/gpio/gpio-omap.c                | 24 ++++++++++++++++++++++++
>   include/linux/platform_data/gpio-omap.h | 12 ++++++++++--
>   3 files changed, 35 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index caefe80..ff7df95 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -308,7 +308,7 @@ config GPIO_OCTEON
>   	  family of SOCs.
>
>   config GPIO_OMAP
> -	bool "TI OMAP GPIO support" if COMPILE_TEST && !ARCH_OMAP2PLUS
> +	tristate "TI OMAP GPIO support" if ARCH_OMAP2PLUS || COMPILE_TEST
>   	default y if ARCH_OMAP
>   	depends on ARM
>   	select GENERIC_IRQ_CHIP
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b59c3ca..384a852 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1202,6 +1202,17 @@ static int omap_gpio_probe(struct platform_device *pdev)
>   	return 0;
>   }
>
> +static int omap_gpio_remove(struct platform_device *pdev)
> +{
> +	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +
> +	list_del(&bank->node);
> +	gpiochip_remove(&bank->chip);
> +	pm_runtime_disable(bank->dev);
> +
> +	return 0;
> +}
> +
>   #ifdef CONFIG_ARCH_OMAP2PLUS
>
>   #if defined(CONFIG_PM)
> @@ -1387,6 +1398,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
>   }
>   #endif /* CONFIG_PM */
>
> +#if IS_BUILTIN(CONFIG_GPIO_OMAP)
>   void omap2_gpio_prepare_for_idle(int pwr_mode)
>   {
>   	struct gpio_bank *bank;
> @@ -1412,6 +1424,7 @@ void omap2_gpio_resume_after_idle(void)
>   		pm_runtime_get_sync(bank->dev);
>   	}
>   }
> +#endif
>
>   #if defined(CONFIG_PM)
>   static void omap_gpio_init_context(struct gpio_bank *p)
> @@ -1567,6 +1580,7 @@ MODULE_DEVICE_TABLE(of, omap_gpio_match);
>
>   static struct platform_driver omap_gpio_driver = {
>   	.probe		= omap_gpio_probe,
> +	.remove		= omap_gpio_remove,
>   	.driver		= {
>   		.name	= "omap_gpio",
>   		.pm	= &gpio_pm_ops,
> @@ -1584,3 +1598,13 @@ static int __init omap_gpio_drv_reg(void)
>   	return platform_driver_register(&omap_gpio_driver);
>   }
>   postcore_initcall(omap_gpio_drv_reg);
> +
> +static void __exit omap_gpio_exit(void)
> +{
> +	platform_driver_unregister(&omap_gpio_driver);
> +}
> +module_exit(omap_gpio_exit);
> +
> +MODULE_DESCRIPTION("omap gpio driver");
> +MODULE_ALIAS("platform:gpio-omap");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
> index 5d50b25..cb26181 100644
> --- a/include/linux/platform_data/gpio-omap.h
> +++ b/include/linux/platform_data/gpio-omap.h
> @@ -208,9 +208,17 @@ struct omap_gpio_platform_data {
>   	int (*get_context_loss_count)(struct device *dev);
>   };
>
> +#if IS_BUILTIN(CONFIG_GPIO_OMAP)
>   extern void omap2_gpio_prepare_for_idle(int off_mode);
>   extern void omap2_gpio_resume_after_idle(void);
> -extern void omap_set_gpio_debounce(int gpio, int enable);
> -extern void omap_set_gpio_debounce_time(int gpio, int enable);
> +#else
> +static inline void omap2_gpio_prepare_for_idle(int off_mode)
> +{
> +}
> +
> +static inline void omap2_gpio_resume_after_idle(void)
> +{
> +}
> +#endif
>
>   #endif
>


-- 
regards,
-grygorii
