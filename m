From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: Fix gpiochip_add() handling for deferred probe
Date: Tue, 8 Sep 2015 15:57:39 +0200
Message-ID: <CACRpkdZdTM5Sgtcn8PoP2X-haqzHZTgjEsvPJzZNLP=0A7XYYg@mail.gmail.com>
References: <1440787489-15992-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1440787489-15992-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 28, 2015 at 8:44 PM, Tony Lindgren <tony@atomide.com> wrote:

> Currently we gpio-omap breaks if gpiochip_add() returns -EPROBE_DEFER:
>
> [    0.570000] gpiochip_add: GPIOs 0..31 (gpio) failed to register
> [    0.570000] omap_gpio 48310000.gpio: Could not register gpio chip -517
> ...
> [    3.670000] omap_gpio 48310000.gpio: Unbalanced pm_runtime_enable!
>
> Let's fix the issue by adding the missing pm_runtime_put() on error.
>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/gpio/gpio-omap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index b0c57d5..f09bf0b 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1232,8 +1232,11 @@ static int omap_gpio_probe(struct platform_device *pdev)
>         omap_gpio_mod_init(bank);
>
>         ret = omap_gpio_chip_init(bank, irqc);
> -       if (ret)
> +       if (ret) {
> +               pm_runtime_put_sync(bank->dev);
> +               pm_runtime_disable(bank->dev);
>                 return ret;
> +       }
>
>         omap_gpio_show_rev(bank);

Patch applied for fixes with Santosh's ACK.

Yours,
Linus Walleij
