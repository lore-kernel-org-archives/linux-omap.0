From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 27/42] drivers: gpio: rcar: use devm_platform_ioremap_resource()
Date: Tue, 12 Mar 2019 20:01:18 +0100
Message-ID: <CAMuHMdV4cT6rsA0DbGLRAzY8A6kXZ1C_2_GNjdXxamdXPA7_6w@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-27-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-27-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Jeffery <andrew@aj.id.au>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Lyra Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com, vz@mleia.com, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Masahiro Yamada <yamada.masahiro@socionext>
List-Id: linux-omap@vger.kernel.org

CC linux-renesas-soc

On Mon, Mar 11, 2019 at 7:58 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> Use the new helper that wraps the calls to platform_get_resource()
> and devm_ioremap_resource() together.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -430,7 +430,7 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
>  static int gpio_rcar_probe(struct platform_device *pdev)
>  {
>         struct gpio_rcar_priv *p;
> -       struct resource *io, *irq;
> +       struct resource *irq;
>         struct gpio_chip *gpio_chip;
>         struct irq_chip *irq_chip;
>         struct device *dev = &pdev->dev;
> @@ -461,8 +461,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>                 goto err0;
>         }
>
> -       io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       p->base = devm_ioremap_resource(dev, io);
> +       p->base = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(p->base)) {
>                 ret = PTR_ERR(p->base);
>                 goto err0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
