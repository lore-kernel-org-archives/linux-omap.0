From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 08/20] gpio: gpio-omap: simplify get() method
Date: Wed, 12 Jun 2019 10:49:18 +0200
Message-ID: <CACRpkdY4eUN=E6BD-J=8oo+QjDPhL8giFasNrb-=vvGE7dTy1Q@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-9-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-9-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> omap_gpio_get() calls omap_get_gpio_datain() or omap_get_gpio_dataout()
> to read the GPIO state. These two functions are only called from this
> method, so they don't add much value.  Move their contents into
> omap_gpio_get() method and simplify.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
