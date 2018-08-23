From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/3] ARM: OMAP1: ams-delta: initialize latch2 pins to safe values
Date: Thu, 23 Aug 2018 12:44:06 +0200
Message-ID: <CACRpkdaEahLO=z4TxyNfUNOqnTvQWsTzvd-HEciZWX57tQ5-mQ@mail.gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <20180820181333.2527-3-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820181333.2527-3-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 20, 2018 at 8:12 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Latch2 pins control a number of on-board devices, namely LCD, NAND,
> MODEM and CODEC.  Those pins used to be initialized with safe values
> from init_machine before that operation was:
> 1) moved to late_initcall in preparation for conversion of latch2 to
> GPIO device - see commit f7519d8c8290 ("ARM: OMAP1: ams-delta: register
> latch dependent devices later"),
> 2) replaced with non-atomic initialization performed by means of
> gpio_request_array() - see commit 937eb4bb0058 ("ARM: OMAP1: ams-delta:
> convert latches to basic_mmio_gpio"),
> 3) made completely asynchronous by delegation of GPIO request
> operations performed on subsets of pins to respective device drivers in
> subsequent commits.
>
> One visible negative result of that disintegration was corrupt keyboard
> data reported by serio driver, recently fixed by commit 41f8fee385a0
> ("ARM: OMAP1: ams-delta: Hog "keybrd_dataout" GPIO pin").
>
> Moreover, initialization of LATCH2_PIN_MODEM_CODEC still performed with
> ams_delta_latch2_write() wrapper from late_init() is now done on not
> requested GPIO pin.
>
> Reintroduce atomic initialization of latch2 pins at machine_init to
> prevent from random values potentially corrupting NAND data or maybe
> even destroing other hardware.  Also take care of MODEM/CODEC related
> pins so MODEM device probe succeeds even if latch2 GPIO device or
> dependent regulator is not ready and CODEC can be reached over the
> MODEM even if audio driver doesn't take control over
> LATCH2_PIN_MODEM_CODEC.
>
> Once done, remove the no longer needed GPIO based implementation of
> ams_delta_latch_write() and its frontend macro.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

This should turn into a nice pin control driver some day.

But until then, this looks way better after than before the patch,
so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
