From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: initialize gpioirq chip as part of gpiochip_add_data
Date: Wed, 29 Nov 2017 14:19:34 +0100
Message-ID: <CACRpkdaSCMyp9kjsWZiR-gLU-d4C93FMB+SH+VVAWvB6J0_-Jg@mail.gmail.com>
References: <20171115183633.12382-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20171115183633.12382-1-grygorii.strashko@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <ssantosh@kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-gpio@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 15, 2017 at 7:36 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> Hence, series from Thierry Reding [1] merged - the OMAP GPIO driver can be
> switched to reuse new feature and just fill new struct gpio_irq_chip before
> calling gpiochip_add_data() instead of using few separate gpioirq chip
> APIs. gpiochip_add_data() will do the job and create and initialize gpioirq
> chip
>
> [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1531592.html
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Thierry: can you confirm that the stuff is used as intended?

Yours,
Linus Walleij
