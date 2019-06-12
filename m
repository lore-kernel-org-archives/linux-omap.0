From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH-next 04/20] gpio: gpio-omap: clean up edge interrupt handling
Date: Wed, 12 Jun 2019 09:57:45 +0200
Message-ID: <CACRpkdZ2o1AP4YdbNqS7BjHZzpgfpMLSM8GeXNWFPdJ8_C0shQ@mail.gmail.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com> <20190610171103.30903-5-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-5-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

On Mon, Jun 10, 2019 at 7:11 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Russell King <rmk+kernel@armlinux.org.uk>
>
> The edge interrupt handling was effectively:
>
>         isr = ISR_reg & enabled;
>         if (bank->level_mask)
>                 level_mask = bank->level_mask & enabled;
>         else
>                 level_mask = 0;
>
>         edge = isr & ~level_mask;
>
> When bank->level_mask is zero, level_mask will be computed as zero
> anyway, so the if() statement is redundant.  We are then left with:
>
>         isr = ISR_reg & enabled;
>         level_mask = bank->level_mask & enabled;
>         edge = isr & ~level_mask;
>
> This can be simplified further to:
>
>         isr = ISR_reg & enabled;
>         edge = isr & ~bank->level_mask;
>
> since the second mask with 'enabled' is redundant.
>
> Improve the associated comment as well.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
