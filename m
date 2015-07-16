From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [4.2-rc1][PATCH] gpio: omap: add missed spin_unlock_irqrestore in omap_gpio_irq_type
Date: Thu, 16 Jul 2015 10:36:22 +0200
Message-ID: <CACRpkdZeBYrff4ZwVyzSKk9Gcy_57WK-3FcfwbzbD8DY06Adng@mail.gmail.com>
References: <1435157657-17843-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435157657-17843-1-git-send-email-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 24, 2015 at 4:54 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>
> Add missed spin_unlock_irqrestore in omap_gpio_irq_type when
> omap_set_gpio_triggering() is failed.
>
> It fixes static checker warning:
>
>         drivers/gpio/gpio-omap.c:523 omap_gpio_irq_type()
>         warn: inconsistent returns 'spin_lock:&bank->lock'.
>
> This fixes commit:
> 1562e4618ded ('gpio: omap: fix error handling in omap_gpio_irq_type')
>
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>

Patch applied for fixes.

Yours,
Linus Walleij
