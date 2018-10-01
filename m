From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio: omap: get rid of the conditional PM runtime calls
Date: Mon, 1 Oct 2018 12:29:20 +0200
Message-ID: <CACRpkdZ-WOGqSThAPHw8LykriTnSEKZcZaL+iB5-jmaVKmN4bg@mail.gmail.com>
References: <20180928213950.27415-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928213950.27415-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 28, 2018 at 11:39 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:

> OMAP GPIO driver is checking !BANK_USED() used condition before calling PM
> runtime API, because of PM runtime calls in
> omap2_gpio_prepare/resume_for_idle(). It's not required any more since
> "omap gpio add level idle, cpu_pm and drop runtime_irq_safe" series [1]
> from Tony Lindgren was accepted and PM runtime management was enabled in
> IRQ chip core by commit be45beb2df69 ("genirq: Add runtime power management
> support for IRQ chips") .
>
> As result safely drop !BANK_USED() checks from omap_gpio_request/free(),
> omap_gpio_irq_bus_lock/unlock() and enable PM runtime management for OMAP
> GPIO IRQ chip.
>
> [1] https://www.spinics.net/lists/arm-kernel/msg677583.html
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Patch applied.

Yours,
Linus Walleij
