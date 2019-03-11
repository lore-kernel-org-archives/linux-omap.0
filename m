From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] gpio: omap: avoid clang warning
Date: Mon, 11 Mar 2019 13:09:21 +0100
Message-ID: <CAK8P3a1+yitZDApTkkz843NBhi++A54rupi_cBKa59K1XQ6N2Q@mail.gmail.com>
References: <20190307103348.1591457-1-arnd@arndb.de> <CAMpxmJXpYtJp5eZfz1uCQfE8yg_uLzQxWNt9wKZ4uMzfckU2TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMpxmJXpYtJp5eZfz1uCQfE8yg_uLzQxWNt9wKZ4uMzfckU2TQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>, Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 11, 2019 at 10:40 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
> czw., 7 mar 2019 o 11:39 Arnd Bergmann <arnd@arndb.de> napisał(a):
> > clang warns about a tentative array definition in the gpio-omap driver:
> >
> > drivers/gpio/gpio-omap.c:1282:34: error: tentative array definition assumed to have one element [-Werror]
> > static const struct of_device_id omap_gpio_match[];
> >
> > It's best to just reorder the entire file to avoid forward declarations,
> > which lets us use the regular declaration. To do this, the unnecessary
> > CONFIG_OF check must also be removed.
> >

> > +static const struct dev_pm_ops gpio_pm_ops = {
> > +       SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
> > +                                                                       NULL)
> > +};
> > +
> >  static struct platform_driver omap_gpio_driver = {
> >         .probe          = omap_gpio_probe,
> >         .remove         = omap_gpio_remove,
> >         .driver         = {
> >                 .name   = "omap_gpio",
> >                 .pm     = &gpio_pm_ops,
> > -               .of_match_table = of_match_ptr(omap_gpio_match),
> > +               .of_match_table = omap_gpio_match,
>
> This doesn't seem like a logical part of this commit. Can you send a
> separate patch?
>
> Other than that, looks good to me.

This change has to be kept together the with removal of the #ifdef,
otherwise I'd introduce a new warning about an unused variable.

I could try to split out the reordering of the file though.

      Arnd
