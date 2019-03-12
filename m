From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 36/42] drivers: gpio: uniphier: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 18:37:02 +0900
Message-ID: <CAK7LNASPyZVpN2JVT8v6qzXUNfu-dLqcwwSc-eZL+yMyMEFXCg@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-36-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-36-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, andrew@aj.id.au, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Broadcom Kernel Feedback List <bcm-kernel-feedback-list@broadcom.com>, hoan@os.amperecomputing.com, orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, keguang.zhang@gmail.com, Vladimir Zapolskiy <vz@mleia.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shaw>
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 12, 2019 at 3:57 AM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  drivers/gpio/gpio-uniphier.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-uniphier.c b/drivers/gpio/gpio-uniphier.c
> index 0f662b2..93cdcc4 100644
> --- a/drivers/gpio/gpio-uniphier.c
> +++ b/drivers/gpio/gpio-uniphier.c
> @@ -346,7 +346,6 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
>         struct uniphier_gpio_priv *priv;
>         struct gpio_chip *chip;
>         struct irq_chip *irq_chip;
> -       struct resource *regs;
>         unsigned int nregs;
>         u32 ngpios;
>         int ret;
> @@ -370,8 +369,7 @@ static int uniphier_gpio_probe(struct platform_device *pdev)
>         if (!priv)
>                 return -ENOMEM;
>
> -       regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       priv->regs = devm_ioremap_resource(dev, regs);
> +       priv->regs = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(priv->regs))
>                 return PTR_ERR(priv->regs);
>
> --
> 1.9.1
>


-- 
Best Regards
Masahiro Yamada
