From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/4] input: misc: introduce retu-pwrbutton
Date: Wed, 31 Oct 2012 12:13:23 -0700
Message-ID: <5231769.AbPKHSmERx@dtor-d630.eng.vmware.com>
References: <1351706626-32186-1-git-send-email-aaro.koskinen@iki.fi> <1351706626-32186-5-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1351706626-32186-5-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-input-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Aaro,

On Wednesday, October 31, 2012 08:03:46 PM Aaro Koskinen wrote:
> Add Retu power button driver.
>=20
> Cc: linux-input@vger.kernel.org
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/input/misc/Kconfig          |   10 +++
>  drivers/input/misc/Makefile         |    1 +
>  drivers/input/misc/retu-pwrbutton.c |  118
> +++++++++++++++++++++++++++++++++++ 3 files changed, 129 insertions(+=
), 0
> deletions(-)
>  create mode 100644 drivers/input/misc/retu-pwrbutton.c
>=20
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 7c0f1ec..e5be189 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -367,6 +367,16 @@ config INPUT_CM109
>  	  To compile this driver as a module, choose M here: the module wil=
l be
>  	  called cm109.
>=20
> +config INPUT_RETU_PWRBUTTON
> +	tristate "Retu Power button Driver"
> +	depends on MFD_RETU
> +	help
> +	  Say Y here if you want to enable power key reporting via the
> +	  Retu chips found in Nokia Internet Tablets (770, N800, N810).
> +
> +	  To compile this driver as a module, choose M here. The module wil=
l
> +	  be called retu-pwrbutton.
> +
>  config INPUT_TWL4030_PWRBUTTON
>  	tristate "TWL4030 Power button Driver"
>  	depends on TWL4030_CORE
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefil=
e
> index 83fe6f5..4fbee0d 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_INPUT_PMIC8XXX_PWRKEY)	+=3D pmic8xxx-p=
wrkey.o
>  obj-$(CONFIG_INPUT_POWERMATE)		+=3D powermate.o
>  obj-$(CONFIG_INPUT_PWM_BEEPER)		+=3D pwm-beeper.o
>  obj-$(CONFIG_INPUT_RB532_BUTTON)	+=3D rb532_button.o
> +obj-$(CONFIG_INPUT_RETU_PWRBUTTON)	+=3D retu-pwrbutton.o
>  obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+=3D rotary_encoder.o
>  obj-$(CONFIG_INPUT_SGI_BTNS)		+=3D sgi_btns.o
>  obj-$(CONFIG_INPUT_SPARCSPKR)		+=3D sparcspkr.o
> diff --git a/drivers/input/misc/retu-pwrbutton.c
> b/drivers/input/misc/retu-pwrbutton.c new file mode 100644
> index 0000000..51e94a7
> --- /dev/null
> +++ b/drivers/input/misc/retu-pwrbutton.c
> @@ -0,0 +1,118 @@
> +/*
> + * Retu power button driver.
> + *
> + * Copyright (C) 2004-2010 Nokia Corporation
> + *
> + * Original code written by Ari Saastamoinen, Juha Yrj=F6l=E4 and Fe=
lipe Balbi.
> + * Rewritten by Aaro Koskinen.
> + *
> + * This file is subject to the terms and conditions of the GNU Gener=
al
> + * Public License. See the file "COPYING" in the main directory of t=
his
> + * archive for more details.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/errno.h>
> +#include <linux/input.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mfd/retu.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +
> +#define RETU_STATUS_PWRONX (1 << 5)
> +
> +struct retu_pwrbutton {
> +	struct input_dev	*idev;
> +	struct retu_dev		*rdev;
> +	struct device		*dev;

I do not thhink you are using it anywhere.

> +	bool			pressed;
> +	int			irq;

You do not need to store IRQ is you are using devm_* to mamage it.

> +};

Come to think of it you do not need separate retu_pwrbutton structure,
you can just allocate input device and do input_set_drvdata(input, rdev=
).

> +
> +static irqreturn_t retu_pwrbutton_irq(int irq, void *_pwr)
> +{
> +	struct retu_pwrbutton *pwr =3D _pwr;
> +	bool state;
> +
> +	state =3D !(retu_read(pwr->rdev, RETU_REG_STATUS) & RETU_STATUS_PWR=
ONX);
> +
> +	if (pwr->pressed !=3D state) {
> +		input_report_key(pwr->idev, KEY_POWER, state);
> +		input_sync(pwr->idev);
> +		pwr->pressed =3D state;
> +	}

No need to suppress duplicate events, input core will do it for you.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit retu_pwrbutton_probe(struct platform_device *pd=
ev)
> +{
> +	struct retu_dev *rdev =3D dev_get_drvdata(pdev->dev.parent);
> +	struct retu_pwrbutton *pwr;
> +	int ret;
> +
> +	pwr =3D devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
> +	if (!pwr)
> +		return -ENOMEM;
> +
> +	pwr->rdev =3D rdev;
> +	pwr->dev  =3D &pdev->dev;
> +	pwr->irq  =3D platform_get_irq(pdev, 0);
> +	platform_set_drvdata(pdev, pwr);
> +
> +	ret =3D devm_request_threaded_irq(&pdev->dev, pwr->irq, NULL,
> +					retu_pwrbutton_irq, 0, "retu-pwrbutton",
> +					pwr);
> +	if (ret < 0)
> +		return ret;

You just crashed here if button was pressed.

> +
> +	pwr->idev =3D input_allocate_device();
> +	if (!pwr->idev)
> +		return -ENOMEM;
> +
> +	pwr->idev->evbit[0]			=3D BIT_MASK(EV_KEY);
> +	pwr->idev->keybit[BIT_WORD(KEY_POWER)]	=3D BIT_MASK(KEY_POWER);
> +	pwr->idev->name				=3D "retu-pwrbutton";
> +
> +	ret =3D input_register_device(pwr->idev);
> +	if (ret < 0) {
> +		input_free_device(pwr->idev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __devexit retu_pwrbutton_remove(struct platform_device *p=
dev)
> +{
> +	struct retu_pwrbutton *pwr =3D platform_get_drvdata(pdev);
> +
> +	input_unregister_device(pwr->idev);

And here (if button was pressed).

> +	input_free_device(pwr->idev);

And here as it is double-free.

The good news is that input core is getting devm_ support so you can al=
locate
input device with devm_input_allocate_device() and then not bother with=
 either
input_unregister_device or input_free_device.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver retu_pwrbutton_driver =3D {
> +	.probe		=3D retu_pwrbutton_probe,
> +	.remove		=3D __devexit_p(retu_pwrbutton_remove),
> +	.driver		=3D {
> +		.name	=3D "retu-pwrbutton",
		.owner	=3D THIS_MODULE,

> +	},
> +};
> +module_platform_driver(retu_pwrbutton_driver);
> +
> +MODULE_ALIAS("platform:retu-pwrbutton");
> +MODULE_DESCRIPTION("Retu Power Button");
> +MODULE_AUTHOR("Ari Saastamoinen");
> +MODULE_AUTHOR("Felipe Balbi");
> +MODULE_AUTHOR("Aaro Koskinen <aaro.koskinen@iki.fi>");
> +MODULE_LICENSE("GPL");

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
