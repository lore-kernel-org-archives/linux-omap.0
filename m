From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 11/22] clocksource: ti-dmtimer: avoid using mach/hardware.h
Date: Fri, 9 Aug 2019 09:33:32 +0200
Message-ID: <CAK8P3a0cDSr=nyaTFPywnYzUNdeJEhNBDkmWxBhVgXL+2vSyfg@mail.gmail.com>
References: <20190808212234.2213262-1-arnd@arndb.de> <20190808212234.2213262-12-arnd@arndb.de>
 <ba446856-0fa1-d06d-9e74-18ed9d630376@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ba446856-0fa1-d06d-9e74-18ed9d630376@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Thomas Gleixner <tglx@linutronix.de>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 9, 2019 at 9:01 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 08/08/2019 23:22, Arnd Bergmann wrote:
> > As a preparation for future omap1 multiplatform support, stop
> > using mach/hardware.h and instead include the omap1-io.h
> > for low-level register access to MOD_CONF_CTRL_1.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
>
> Do you want me to apply it through me tree?

Sorry, I should have included you in the cover letter. I would
like to take the whole series through the soc tree, as there are
dependencies between the patches and this cannot be applied
by itself.

       Arnd
