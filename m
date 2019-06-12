From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 16/20] gpio: gpio-omap: clean up omap_gpio_restore_context()
Date: Wed, 12 Jun 2019 10:56:55 +0200
Message-ID: <CACRpkda7d9SV-muuvEpO5VhCHrJozRtOMVGi+1siyWzabTMmww@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-17-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-17-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:13 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Use local variables to store the base iomem address and regs table
> pointer like omap_gpio_init_context() does. Not only does this make
> the function neater, it also avoids unnecessary reloads of the same
> data multiple times.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
