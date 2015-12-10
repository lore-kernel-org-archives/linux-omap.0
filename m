From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 004/182] gpio: generic: factor into gpio_chip struct
Date: Thu, 10 Dec 2015 08:06:32 +0000
Message-ID: <20151210080632.GC17876@x1>
References: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Anton Vorontsov <anton@enomsg.org>, arm@kernel.org, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexandre Courbot <gnurou@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Olof Johansson <olof@lixom.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Rabin Vincent <rab>
List-Id: linux-omap@vger.kernel.org

On Wed, 09 Dec 2015, Linus Walleij wrote:

> The separate struct bgpio_chip has been a pain to handle, both
> by being confusingly similar in name to struct gpio_chip and
> for being contained inside a struct so that struct gpio_chip
> is contained in a struct contained in a struct, making several
> steps of dereferencing necessary.
>=20
> Make things simpler: include the fields directly into
> <linux/gpio/driver.h>, #ifdef:ed for CONFIG_GENERIC_GPIO, and
> get rid of the <linux/basic_mmio_gpio.h> altogether. Prefix
> some of the member variables with bgpio_* and add proper
> kerneldoc while we're at it.
>=20
> Modify all users to handle the change and use a struct
> gpio_chip directly. And while we're at it: replace all
> container_of() dereferencing by gpiochip_get_data() and
> registering the gpio_chip with gpiochip_add_data().
>=20
> Cc: arm@kernel.org
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Gregory Fong <gregory.0xf0@gmail.com>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Rabin Vincent <rabin@rab.in>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks and Lee: it would be great if you could
> ACK the few lines hitting arch/arm/* and drivers/mfd/* in this
> so I can take it through the GPIO tree.
> ---
>  arch/arm/mach-clps711x/board-autcpu12.c |   2 +-
>  arch/arm/mach-clps711x/board-p720t.c    |   2 +-
>  arch/arm/mach-imx/mach-mx21ads.c        |   2 +-
>  arch/arm/mach-omap1/board-ams-delta.c   |   2 +-
>  arch/arm/mach-s3c64xx/mach-crag6410.c   |   2 +-
>  drivers/gpio/gpio-74xx-mmio.c           |  37 ++--
>  drivers/gpio/gpio-brcmstb.c             |  80 ++++-----
>  drivers/gpio/gpio-clps711x.c            |  28 +--
>  drivers/gpio/gpio-dwapb.c               |  92 +++++-----
>  drivers/gpio/gpio-ep93xx.c              |  25 +--
>  drivers/gpio/gpio-etraxfs.c             |  49 +++---
>  drivers/gpio/gpio-ge.c                  |  24 +--
>  drivers/gpio/gpio-generic.c             | 292 +++++++++++++++-------=
----------
>  drivers/gpio/gpio-grgpio.c              |  73 ++++----
>  drivers/gpio/gpio-moxart.c              |  29 ++--
>  drivers/gpio/gpio-mxc.c                 |  27 ++-
>  drivers/gpio/gpio-mxs.c                 |  33 ++--
>  drivers/gpio/gpio-sodaville.c           |  13 +-
>  drivers/gpio/gpio-xgene-sb.c            |  40 ++---
>  drivers/mfd/vexpress-sysreg.c           |   8 +-

Acked-by: Lee Jones <lee.jones@linaro.org>

>  include/linux/basic_mmio_gpio.h         |  80 ---------
>  include/linux/gpio/driver.h             |  54 ++++++
>  22 files changed, 442 insertions(+), 552 deletions(-)
>  delete mode 100644 include/linux/basic_mmio_gpio.h

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
