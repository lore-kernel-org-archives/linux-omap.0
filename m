From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 5/8] gpio: omap: convert gpio irq functions to use GPIO offset
Date: Fri, 27 Mar 2015 11:06:50 +0100
Message-ID: <CACRpkdZ4Kj0a5yO9F-U6fZ3PTy3jhvsjXKAXudy7FvM+S2pfFA@mail.gmail.com>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
	<1427113110-20813-6-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427113110-20813-6-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 23, 2015 at 1:18 PM,  <grygorii.strashko@linaro.org> wrote:

> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Convert GPIO IRQ functions to use GPIO offset instead of system
> GPIO numbers. This allows to drop unneeded conversations between
> system GPIO <-> GPIO offset which are done in many places and
> many times.
> It is safe to do now because:
> - gpiolib always passes GPIO offset to GPIO controller
> - OMAP GPIO driver converted to use IRQ domain, so
>   struct irq_data->hwirq contains GPIO offset
>
> This is preparation step before removing:
>  #define GPIO_INDEX(bank, gpio)
>  #define GPIO_BIT(bank, gpio)
>  int omap_irq_to_gpio()
>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Patch applied.

Yours,
Linus Walleij
