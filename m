From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 05/42] drivers: gpio: bcm-kona: use
 devm_platform_ioremap_resource()
Date: Fri, 15 Mar 2019 09:19:39 +0100
Message-ID: <20190315081939.zr3vv3a7a6wf7byw@pengutronix.de>
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-5-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1552330521-4276-5-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, bgolaszewski@baylibre.com, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, thierry.reding@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, robert.jarzmik@free.fr, yamada.masahiro@socionext.com, jun.nie@linaro.org, shawnguo@kernel.org, linux-gpio@vger.kernel.org, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, kernel@pengutronix.de, Julia Lawall <Julia.Lawall@lip6.fr>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 11, 2019 at 07:54:44PM +0100, Enrico Weigelt, metux IT consult wrote:
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
>  	if (IS_ERR(kona_gpio->reg_base)) {
>  		ret = -ENXIO;

This should be

	ret = PTR_ERR(kona_gpio->reg_base)

, shouldn't it? (If yes, this is orthogonal to this patch, but still
worth fixing.)

@Julia: Is this something that coccinelle could catch?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
