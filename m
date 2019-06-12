From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 07/20] gpio: gpio-omap: simplify omap_gpio_get_direction()
Date: Wed, 12 Jun 2019 10:47:23 +0200
Message-ID: <CACRpkdYaropisZADA61LF_0aUmWzi44c7pQbEUV92r06Qu3m_w@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-8-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-8-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Architectures are single-copy atomic, which means that simply reading
> a register is an inherently atomic operation.  There is no need to
> take a spinlock here.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

This makes me wonder how many more instances we have
of this kind of mistake in the kernel :/ I guess it is mostly
harmless but it sure makes for massive code complexity.

I would sure like e.g. drivers/gpio/gpio-mmio.c to avoid
taking locks on architectures where this is not a problem
given it is used on a plethora of architectures.

Yours,
Linus Walleij
