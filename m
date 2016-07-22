From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] ARM: fix three implicit module use cases fed via gpio
Date: Fri, 22 Jul 2016 17:29:05 +0200
Message-ID: <CACRpkdbSGPfMTQs9pD+-eDMf7LjnWH1xcpsUcCbgLF5GxMK7Aw@mail.gmail.com>
References: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160720041332.30789-1-paul.gortmaker@windriver.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 20, 2016 at 6:13 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> While working on some for-4.9 cleanups of linux/gpio/driver.h it was
> found that changes there caused build failures when walking all the
> ARM defconfigs, in ARM specific mach-* files.
(...)
> Paul Gortmaker (3):
>   ARM: mach-omap2: remove bogus "or_module" from rx51-peripherals
>   ARM: pxa: add module.h for corgi symbol_get/symbol_put usage
>   ARM: pxa: add module.h for spitz symbol_get/symbol_put usage

For all three:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
