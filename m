From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 0/3] GPIO OMAP driver changes for v3.17
Date: Wed, 02 Jul 2014 13:55:17 -0700
Message-ID: <7h8uobiiq2.fsf@paris.lan>
References: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
	(Javier Martinez Canillas's message of "Fri, 27 Jun 2014 22:17:34
	+0200")
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <jmartinez@softcrates.net>
List-Id: linux-omap@vger.kernel.org

Javier Martinez Canillas <javier@dowhile0.org> writes:

> Hi Linus,
>
> This is a small series with trivial changes to the gpio-omap driver.
>
> There are no functional changes. Patches 1 and 2 removes code that it's
> not necessary anymore now that the driver has been converted to use the
> gpiolib irqchip and Patch 3 adds an "omap" prefix to all driver functions,
> something that you suggested me to do before if I remember correctly.
>
> The patch-set is composed of the following patches:
>
> Javier Martinez Canillas (3):
>   gpio: omap: Remove unnecessary lockdep class
>   gpio: omap: Remove unneeded include
>   gpio: omap: Add an omap prefix to all functions

Acked-by: Kevin Hilman <khilman@linaro.org>

For the series.

Kevin
