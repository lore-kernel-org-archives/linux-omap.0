From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 26/42] drivers: gpio: rcar: pendantic formatting
Date: Tue, 12 Mar 2019 20:03:42 +0100
Message-ID: <CAMuHMdX7HCHJiKYXVMzYrHmjjDy6YbLntZbep_AKsLY3bxpZWA@mail.gmail.com>
References: <1552330521-4276-1-git-send-email-info@metux.net> <1552330521-4276-26-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552330521-4276-26-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Andrew Jeffery <andrew@aj.id.au>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linaro.org>, Lyra Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com, vz@mleia.com, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Masahiro Yamada <yamada.masahiro@socionext>
List-Id: linux-omap@vger.kernel.org

CC linux-renesas-soc

On Mon, Mar 11, 2019 at 7:57 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> a tab sneaked in, where it shouldn't be.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>

With Thierry's comments addressed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -490,7 +490,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>         irq_chip->irq_unmask = gpio_rcar_irq_enable;
>         irq_chip->irq_set_type = gpio_rcar_irq_set_type;
>         irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
> -       irq_chip->flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
> +       irq_chip->flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
>
>         ret = gpiochip_add_data(gpio_chip, p);
>         if (ret) {

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
