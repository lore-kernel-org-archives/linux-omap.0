From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 05/42] drivers: gpio: bcm-kona: use
 devm_platform_ioremap_resource()
Date: Mon, 11 Mar 2019 11:59:57 -0700
Message-ID: <04b068f6-8045-98fc-de8d-f9b5e2d7acde@gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-5-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-5-git-send-email-info@metux.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 3/11/19 11:54 AM, Enrico Weigelt, metux IT consult wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-bcm-kona.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> index c5536a5..9fa6d3a 100644
> --- a/drivers/gpio/gpio-bcm-kona.c
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -568,7 +568,6 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	const struct of_device_id *match;
> -	struct resource *res;
>  	struct bcm_kona_gpio_bank *bank;
>  	struct bcm_kona_gpio *kona_gpio;
>  	struct gpio_chip *chip;
> @@ -618,8 +617,7 @@ static int bcm_kona_gpio_probe(struct platform_device *pdev)
>  		return -ENXIO;
>  	}
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	kona_gpio->reg_base = devm_ioremap_resource(dev, res);
> +	kona_gpio->reg_base = devm_platform_ioremap_resource(pdev, 0);

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
