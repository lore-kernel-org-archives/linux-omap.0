From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 20/20] gpio: gpio-omap: clean up register access in omap2_set_gpio_debounce()
Date: Tue, 18 Jun 2019 13:28:18 +0200
Message-ID: <CACRpkdarzvVAFz90xJQCoF2+8rDf4_-Dys490HaXV+wbQGGxGw@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
 <20190610171103.30903-21-grygorii.strashko@ti.com> <CACRpkda2FhYNYA2TkVANOF5GWd3hE9cqM7N_pFDFj9nh-fh=iA@mail.gmail.com>
 <0ab98094-f8b2-69a3-e73c-1dfdf812d627@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0ab98094-f8b2-69a3-e73c-1dfdf812d627@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 17, 2019 at 8:57 PM grygorii <grygorii.strashko@ti.com> wrote:

> By the way, there seems no ABI for debounce cfg in gpio_dev interface.
> (or i'm missing smth?)

No that is correct.

I tend to be conservative with exposing stuff to userspace, but if somone
comes with a valid usecase for using debounce from userspace we will
add it I suppose. It's pretty much on need-to-have basis since we can
never change the userspace ABI.

Yours,
Linus Walleij
