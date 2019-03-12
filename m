From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 09/42] drivers: gpio: sprd: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 10:38:43 +0800
Message-ID: <CAMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-9-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-9-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com, vz@mleia.com, matthias.bgg@gmail.com, Thierry Reding <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, ssantosh@kernel.org, khilman@kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Masahiro Yamada <yamada.masahiro@socionext.com>, jun.nie@linaro.org, shawnguo@kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-mips@vger.kernel.org, linux-pwm@vger.kernel.orgli
List-Id: linux-omap@vger.kernel.org

On Tue, 12 Mar 2019 at 02:55, Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  drivers/gpio/gpio-eic-sprd.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index f0223ce..c12de87 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -567,7 +567,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
>         const struct sprd_eic_variant_data *pdata;
>         struct gpio_irq_chip *irq;
>         struct sprd_eic *sprd_eic;
> -       struct resource *res;
>         int ret, i;
>
>         pdata = of_device_get_match_data(&pdev->dev);
> @@ -596,13 +595,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>                  * have one bank EIC, thus base[1] and base[2] can be
>                  * optional.
>                  */
> -               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -               if (!res)
> -                       continue;
> -
> -               sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
> +               sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, 0);

This is incorrect, since we can have multiple IO resources, but you
only get index 0.

>                 if (IS_ERR(sprd_eic->base[i]))
> -                       return PTR_ERR(sprd_eic->base[i]);
> +                       continue;
>         }
>
>         sprd_eic->chip.label = sprd_eic_label_name[sprd_eic->type];
> --
> 1.9.1
>
-- 
Baolin Wang
Best Regards
