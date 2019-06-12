From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 01/20] gpio: gpio-omap: ensure irq is enabled before wakeup
Date: Wed, 12 Jun 2019 09:54:50 +0200
Message-ID: <CACRpkdZvd_pApYbDL+PTJ1LDuDuvcVc2OCA_anRoWvwka_xm6g@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-2-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-2-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Documentation states:
>
>   NOTE: There must be a correlation between the wake-up enable and
>   interrupt-enable registers. If a GPIO pin has a wake-up configured
>   on it, it must also have the corresponding interrupt enabled (on
>   one of the two interrupt lines).
>
> Ensure that this condition is always satisfied by enabling the detection
> events after enabling the interrupt, and disabling the detection before
> disabling the interrupt.  This ensures interrupt/wakeup events can not
> happen until both the wakeup and interrupt enables correlate.
>
> If we do any clearing, clear between the interrupt enable/disable and
> trigger setting.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
