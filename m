From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/12] gpio: use resource management for irq descriptors
Date: Tue, 14 Mar 2017 16:18:07 +0100
Message-ID: <CACRpkdbyuWhOVZvB9d1AKmWFUYhF6uhJeoLgTKhsFx7c8A-i9Q@mail.gmail.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Mar 4, 2017 at 5:23 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:

> The following series uses the recently introduced set of
> devm_irq_alloc_desc*() helpers in the GPIO drivers.
>
> While we're at it: if the modified drivers called request_irq(), it
> was changed to devm_request_irq() too.
>
> Some drivers correctly clean up resources (e.g. gpio-mockup,
> gpio-pch) - for them this change leads to an actual code shrink.
>
> Other drivers are meant to be built-in and the devices they control
> are never removed (e.g. gpio-pxa, gpio-davinci), so they deliberately
> omit the cleanup. Still: in case something changes it's better to free
> the resources - especially since these drivers already use other
> devm_* routines like devm_kzalloc() etc.
>
> The last group of drivers are the ones which can be compiled as
> modules, but leak resources unintentionally (e.g. gpio-twl4030,
> gpio-omap). This change fixes the interrupt descriptor leaks, but some
> drivers will require additional work since they still don't release
> other resources.
>
> The following drivers were tested: gpio-mockup, gpio-omap
> and gpio-davinci. The rest was compile-tested only.
>
> Bartosz Golaszewski (12):
>   gpio: mockup: use devm_irq_alloc_descs()
>   gpio: twl4030: use devm_irq_alloc_descs()
>   gpio: omap: use devm_irq_alloc_descs()
>   gpio: pch: use resource management for irqs
>   gpio: ml-ioh: use resource management for irqs
>   gpio: xlp: use resource management for irqs
>   gpio: pxa: use devm_irq_alloc_descs()
>   gpio: davinci: use devm_irq_alloc_descs()
>   gpio: sodaville: use resource management for irqs
>   gpio: mxc: use devm_irq_alloc_descs()
>   gpio: mxs: use devm_irq_alloc_descs()
>   gpio: sta2x11: use resource management for irqs

Excellent series, applied all and pushing to the build servers for
testing.

Interested in the job to go over to drivers/pinctrl and check if we
have some dangling descs there if this works out?

Yours,
Linus Walleij
