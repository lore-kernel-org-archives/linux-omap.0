From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 13/20] gpio: gpio-omap: simplify omap_toggle_gpio_edge_triggering()
Date: Wed, 12 Jun 2019 10:54:10 +0200
Message-ID: <CACRpkdZmnezPYiKpi+7Ka70YL4H4O=_Gv=DqXfvY9J4xv8X37Q@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-14-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-14-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> This function open-codes an exclusive-or bitwise operation using an
> if() statement and explicitly setting or clearing the bit. Instead,
> use an exclusive-or operation instead, and simplify the function.
>
> We can combine the preprocessor conditional using IS_ENABLED() and
> gain some additional compilation coverage.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
