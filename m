From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/8] gpio: omap: drop 'gpio' param from omap_gpio_init_irq()
Date: Fri, 27 Mar 2015 11:05:56 +0100
Message-ID: <CACRpkdYOgTCq22Zu=GAF6nC-PaSEFQssJLgBa1YHFANX7xm8=A@mail.gmail.com>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
	<1427113110-20813-5-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1427113110-20813-5-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 23, 2015 at 1:18 PM,  <grygorii.strashko@linaro.org> wrote:

> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> The 'gpio' parameter isn't needed any more as it
> duplicates 'offset' parameter, so drop it.
>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Patch applied.

Yours,
Linus Walleij
