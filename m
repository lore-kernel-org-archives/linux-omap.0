From: Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 004/182] gpio: generic: factor into gpio_chip struct
Date: Wed, 9 Dec 2015 15:45:33 +0000
Message-ID: <20151209154533.GO972@e106497-lin.cambridge.arm.com>
References: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449666760-29876-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, Johan Hovold <johan@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Michael Welling <mwelling@ieee.org>, Markus Pargmann <mpa@pengutronix.de>, Anton Vorontsov <anton@enomsg.org>, arm@kernel.org, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Tony Lindgren <tony@atomide.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexandre Courbot <gnurou@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Brian Norris <computersforpeace@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Olof Johansson <olof@lixom.net>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Rabin Vincent <rabi>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 09, 2015 at 02:12:40PM +0100, Linus Walleij wrote:
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

[....]

>  drivers/mfd/vexpress-sysreg.c           |   8 +-

[....]

> diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sys=
reg.c
> index 3e628df9280c..855c0204f09a 100644
> --- a/drivers/mfd/vexpress-sysreg.c
> +++ b/drivers/mfd/vexpress-sysreg.c
> @@ -11,7 +11,7 @@
>   * Copyright (C) 2012 ARM Limited
>   */
> =20
> -#include <linux/basic_mmio_gpio.h>
> +#include <linux/gpio/driver.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/mfd/core.h>
> @@ -164,7 +164,7 @@ static int vexpress_sysreg_probe(struct platform_=
device *pdev)
>  {
>  	struct resource *mem;
>  	void __iomem *base;
> -	struct bgpio_chip *mmc_gpio_chip;
> +	struct gpio_chip *mmc_gpio_chip;
>  	int master;
>  	u32 dt_hbi;
> =20
> @@ -201,8 +201,8 @@ static int vexpress_sysreg_probe(struct platform_=
device *pdev)
>  		return -ENOMEM;
>  	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
>  			NULL, NULL, NULL, NULL, 0);
> -	mmc_gpio_chip->gc.ngpio =3D 2;
> -	gpiochip_add(&mmc_gpio_chip->gc);
> +	mmc_gpio_chip->ngpio =3D 2;
> +	gpiochip_add(mmc_gpio_chip);
> =20
>  	return mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
>  			vexpress_sysreg_cells,

[....]

> --=20
> 2.4.3
>=20

=46or the drivers/mfd/vexpress-sysreg.c part:

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
