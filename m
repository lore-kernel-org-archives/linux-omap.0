From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/7] gpio: omap: fix omap_gpio_free to not clean up irq configuration
Date: Mon, 1 Jun 2015 15:11:50 +0200
Message-ID: <CACRpkdZT6TKNLFQf2Yh7fWHpaUkRtVYv-KWwAVwuuW6O3WFb1w@mail.gmail.com>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
	<1432305354-5968-2-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1432305354-5968-2-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, May 22, 2015 at 4:35 PM, Grygorii Strashko
<grygorii.strashko@linaro.org> wrote:

> This patch fixes following issue:
> - GPIOn is used as IRQ by some dev, for example PCF8575.INT ->  gpio6.11
> - PCFx driver knows nothing about type of IRQ line (GPIO or not)
>   so it doesn't request gpio and just do request_irq()
> - If gpio6.11 will be exported through the sysfs and then un-xeported
> then IRQs from PCFx will not be received any more, because
> IRQ configuration for gpio6.11 will be cleaned up unconditionally
> in omap_gpio_free.
>
> Fix this by removing all GPIO IRQ specific code from omap_gpio_free()
> and also do GPIO clean up (change direction to 'in' and disable debounce)
> only if corresponding GPIO is not used as IRQ too.
> GPIO IRQ will be properly cleaned up by GPIO irqchip code.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Can I get an ACK or comment from one of the three (!) maintainers
on atleast these non-RFC patches?

Yours,
Linus Walleij
