From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/2] gpio: omap: irq_shutdown: remove unnecessary call of gpiochip_unlock_as_irq
Date: Mon, 9 Mar 2015 18:29:25 +0100
Message-ID: <CACRpkdZi54SVpviyjL1VWbTH5gHYO-NoHWUmUa-+8Nmyj=Gw6g@mail.gmail.com>
References: <1425670017-19598-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1425670017-19598-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Santosh Shilimkar <ssantosh@kernel.org>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Alexandre Courbot <gnurou@gmail.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 6, 2015 at 8:26 PM,  <grygorii.strashko@linaro.org> wrote:

> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> GPIOLib core implemnts irqchip->irq_request/release_resources callbacks
> internally and these callbacks already contain clalls of
> gpiochip_lock/unlock_as_irq().
>
> Hence, remove unnecessary call of gpiochip_unlock_as_irq() from
> omap_gpio_irq_shutdown().
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Looks like a simple oversight. Patch applied.

Yours,
Linus Walleij
