From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
Date: Sun, 29 Jul 2018 22:29:05 +0200
Message-ID: <CACRpkdbH9Vu12RckQPKhGgyJnyxaQ04d5qa9srHwneP3SS6FAA@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-7-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-7-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Grygorii Strashko <grygorii.strashko@ti.com>, ext Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Jul 19, 2018 at 1:56 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> This should make applications utilizing whole banks work faster.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

This patch looks good to me and I have an urge to just apply it.

Can we get some feedback from the maintainers?

Yours,
Linus Walleij
