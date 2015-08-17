From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpiolib: irqchip: use different lockdep class for
 each gpio irqchip
Date: Mon, 17 Aug 2015 15:33:04 +0200
Message-ID: <CACRpkdbB7YY6pBhyG6_Rq9BY1Xk-tikk2_88D5YHibaGDm+5DQ@mail.gmail.com>
References: <1439814924-11881-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439814924-11881-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 17, 2015 at 2:35 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Since IRQ chip helpers were introduced drivers lose ability to
> register separate lockdep classes for each registered GPIO IRQ
> chip and the gpiolib now is using shared lockdep class for
> all GPIO IRQ chips (gpiochip_irq_lock_class).
> As result, lockdep will produce warning when there are min two
> stacked GPIO chips and all of them are interrupt controllers.
>
> HW configuration which generates lockdep warning (TI dra7-evm):
(...)
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Roger Quadros <rogerq@ti.com>
> Reported-by: Roger Quadros <rogerq@ti.com>
> Tested-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
> Changes in v2:
> - removed accidental change in gpio chip structure description.

This v2 patch applied. I see no better alternative.

Yours,
Linus Walleij
