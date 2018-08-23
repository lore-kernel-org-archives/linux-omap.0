From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/3] ARM: OMAP1: ams-delta: assign MODEM IRQ from GPIO descriptor
Date: Thu, 23 Aug 2018 12:42:27 +0200
Message-ID: <CACRpkdb7E7cjZuYx6Cgxv2sNJmxvwqg0dNh3WpALwtnuCsezuw@mail.gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <20180820181333.2527-2-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820181333.2527-2-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 20, 2018 at 8:12 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Don't request MODEM IRQ GPIO by its global number in
> ams_delta_modem_init().  Instead, obtain its GPIO descriptor
> and assign related IRQ to the MODEM.  Do that from
> omap_gpio_deps_init(), where the chip is already looked up.  Then, in
> ams_delta_modem_init(), just check for the IRQ number having been
> already assigned.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

It's a bit unorthodox to have the board files intercept and poke
around inside the gpio_chip like the code in this file does,
I prefer to keep it encapsulated inside the GPIO driver.
However this is the lesser evil... if OMAP1 is ever phased
over to device tree it will go away, until then it is just nicely
contained.

Yours,
Linus Walleij
