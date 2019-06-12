From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 10/20] gpio: gpio-omap: simplify set_multiple()
Date: Wed, 12 Jun 2019 10:51:49 +0200
Message-ID: <CACRpkdYCiPRPM7evyZsL2jvsfiAYZ36fL1PRjoG7a0jvduqpwQ@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-11-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-11-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:12 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> One of the reasons for set_multiple() to exist is to allow multiple
> GPIOs on the same chip to be changed simultaneously - see commit
> 5f42424354f5 ("gpiolib: allow simultaneous setting of multiple GPIO
> outputs"):
>
>  - Simultaneous glitch-free setting of multiple pins on any kind of
>    parallel bus attached to GPIOs provided they all reside on the
>    same chip and bank.
>
> In order for this to work, we should not use the atomic set/clear
> registers, but instead read-modify-write the dataout register.  We
> already take the spinlock to ensure that happens atomically, so
> move the code into the set_multiple() function and kill the two
> helper functions.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
