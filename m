From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] ARM: OMAP1: ams-delta: register MODEM device earlier
Date: Thu, 23 Aug 2018 12:45:22 +0200
Message-ID: <CACRpkdb5B14Z-hnqxtkE_KaAAAT0EWwC_1ogZBBzHHtBfck-jg@mail.gmail.com>
References: <20180820181333.2527-1-jmkrzyszt@gmail.com> <20180820181333.2527-4-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820181333.2527-4-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 20, 2018 at 8:12 PM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Amstrad Delta MODEM device used to be initialized at arch_initcall
> before it was once moved to late_initcall by commit f7519d8c8290 ("ARM:
> OMAP1: ams-delta: register latch dependent devices later"). The purpose
> of that change was to postpone initialization of devices which depended
> on latch2 pins until latch2 converted to GPIO device was ready.
>
> After recent fixes to GPIO handling, it was possible to moove
> registration of most of those device back to where they were before.
> The same can be safely done with the MODEM device as initialization
> of GPIO pins it depends on was moved to machine_init by preceding
> patch.
>
> Move registration of the MODEM device to arch_initcall_sync, not to
> arch_initcall, so it is never exposed to potential conflictinh
> registration order hazard against OMAP serial ports.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
