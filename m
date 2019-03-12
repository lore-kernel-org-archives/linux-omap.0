From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 29/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 10:40:03 +0800
Message-ID: <CAMz4kuJECc9uvJ-z9A+b1H2u6-XEOxrBQiQ-=YQy0jeAbm8wvw@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-29-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-29-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, Thierry Reding <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, ssantosh@kernel.org, khilman@kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>, jun.nie@linaro.org, shawnguo@kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.orgli
List-Id: linux-omap@vger.kernel.org

Hi,
On Tue, 12 Mar 2019 at 02:57, Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-sprd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
> index 55072d2..f5c8b3a 100644
> --- a/drivers/gpio/gpio-sprd.c
> +++ b/drivers/gpio/gpio-sprd.c
> @@ -219,7 +219,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>  {
>         struct gpio_irq_chip *irq;
>         struct sprd_gpio *sprd_gpio;
> -       struct resource *res;
>         int ret;
>
>         sprd_gpio = devm_kzalloc(&pdev->dev, sizeof(*sprd_gpio), GFP_KERNEL);
> @@ -232,8 +231,7 @@ static int sprd_gpio_probe(struct platform_device *pdev)
>                 return sprd_gpio->irq;
>         }
>
> -       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       sprd_gpio->base = devm_ioremap_resource(&pdev->dev, res);
> +       sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(sprd_gpio->base))
>                 return PTR_ERR(sprd_gpio->base);
>

Thanks for your patch.

Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

-- 
Baolin Wang
Best Regards
