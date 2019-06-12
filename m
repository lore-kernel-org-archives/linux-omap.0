From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 03/20] gpio: gpio-omap: remove remainder of list management
Date: Wed, 12 Jun 2019 09:56:55 +0200
Message-ID: <CACRpkdaH6mE8GoLGJfZFTQZntBdOLqJ3GxSGMX8xyi5nRzXhug@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-4-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-4-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> Commit c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list") removed the
> list head and addition to the list head of each gpio bank, but failed
> to remove the list_del() call and the node inside struct gpio_bank.
> Remove these too.
>
> Fixes: c4791bc6e3a6 ("gpio: omap: drop omap_gpio_list")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
