From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/12] gpio: use resource management for irq descriptors
Date: Tue, 14 Mar 2017 16:45:46 +0100
Message-ID: <CAMpxmJWZMwZqS7=1X9AgMhQqOut3WJmeZvzb6bL0L5=itfY0Lg@mail.gmail.com>
References: <1488644620-11488-1-git-send-email-bgolaszewski@baylibre.com> <CACRpkdbyuWhOVZvB9d1AKmWFUYhF6uhJeoLgTKhsFx7c8A-i9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbyuWhOVZvB9d1AKmWFUYhF6uhJeoLgTKhsFx7c8A-i9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-omap@vger.kernel.org

2017-03-14 16:18 GMT+01:00 Linus Walleij <linus.walleij@linaro.org>:
>
> Excellent series, applied all and pushing to the build servers for
> testing.
>

Thanks!

> Interested in the job to go over to drivers/pinctrl and check if we
> have some dangling descs there if this works out?
>

If time permits, I will be improving the resource management for
interrupts (generic-chip, domains etc.), so I may end up in pinctrl at
some point.

Best regards,
Bartosz Golaszewski
