From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data
 GPIO resource
Date: Sun, 29 Jul 2018 22:33:48 +0200
Message-ID: <CACRpkdZ316o4rwCftOWsRMNd3B+4v0mWGbdMFvp1mm7yaFsccA@mail.gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-8-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-8-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>, =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, ext Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Mark Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi Janusz!

Nice work overall! Some feedback:

On Thu, Jul 19, 2018 at 1:57 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> +#include <linux/gpio/driver.h>

Let's skip that.

> +       /*
> +        * For acceptable performance require the data GPIO
> +        * chip to support get/set_multiple() callbacks.
> +        */
> +       if (!data_gpioc->get_multiple || !data_gpioc->set_multiple) {
> +               err = -EINVAL;
> +               dev_err(&pdev->dev,
> +                       "data GPIO chip does not support get/set_multiple()\n");
> +               goto out_mtd;
> +       }

Since we know which platform it is, we know that we applied the previous
get/set multiple patch, so we need not check this if the patches are
applied in sequence.

As long as all patches go in the same merge window, no problem.

I'm BTW ready to apply the get/set multiple patch already.

Yours,
Linus Walleij
