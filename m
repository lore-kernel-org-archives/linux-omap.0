From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 14/20] gpio: gpio-omap: simplify omap_set_gpio_irqenable()
Date: Wed, 12 Jun 2019 10:54:57 +0200
Message-ID: <CACRpkdZ0fwHuFr9f_QTn=gXGo56Vo1CUM7=zmiCaxfwjp_Pyxg@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-15-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-15-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> omap_set_gpio_irqenable() calls two helpers that are almost the same
> apart from whether they set or clear bits. We can consolidate these:
>
> - in the set/clear bit register case, we can perform the operation on
>   our saved context copy and write the appropriate set/clear register.
> - otherwise, we can use our read-modify-write helper and invert enable
>   if irqenable_inv is set.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
