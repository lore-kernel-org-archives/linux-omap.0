From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] drivers: gpio: omap: use devm_platform_ioremap_resource()
Date: Thu, 14 Mar 2019 12:43:45 +0200
Message-ID: <d9f45854-e4f6-824a-330f-2ec76a41089c@ti.com>
References: <d3b12ed4-67e6-2993-4f56-80b1be572a24@gmail.com>
 <1552333805-23235-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552333805-23235-1-git-send-email-info@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: ssantosh@kernel.org, khilman@kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 11.03.19 21:50, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-omap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 7f33024..ce6e67a 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1289,7 +1289,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	const struct of_device_id *match;
>  	const struct omap_gpio_platform_data *pdata;
> -	struct resource *res;
>  	struct gpio_bank *bank;
>  	struct irq_chip *irqc;
>  	int ret;
> @@ -1375,8 +1374,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  	raw_spin_lock_init(&bank->wa_lock);
>  
>  	/* Static mapping, never released */
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	bank->base = devm_ioremap_resource(dev, res);
> +	bank->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(bank->base)) {
>  		return PTR_ERR(bank->base);
>  	}
> 

Acked-by: Grygorii Strashko <grygorii.strashko@ti.com> 

-- 
Best regards,
grygorii
