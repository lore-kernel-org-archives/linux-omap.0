From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH 7/8] input: misc: Add TWL6030 power button support to
 twl-pwrbutton
Date: Sat, 02 Apr 2016 22:30:10 +0200
Message-ID: <1459629010.12073.46.camel@paulk.fr>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
	 <1459279341-17389-7-git-send-email-contact@paulk.fr>
	 <56FBFBD8.7010401@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-PYqQ4xjH2IWrTX6Rr8BO"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56FBFBD8.7010401-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--=-PYqQ4xjH2IWrTX6Rr8BO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 30 mars 2016 =C3=A0 19:16 +0300, Grygorii Strashko a =C3=A9crit=
=C2=A0:
> On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> >=20
> > This renames the twl4030-pwrbutton driver to twl-pwrbutton, since power
> > button
> > handling is very similar on most TWL chips. This also introduces TWL603=
0
> > power
> > button support.
> >=20
> > TWL6030 power button support requires the following additional changes:
> > * Devicetree binding and support
> > * Interrupt unmasking and remasking support
>
> Again. pls, do not mix clean up/beautification and adding new features.
> And don't mix DT changes with code changes.

Thanks for the review!

I'll split that one into smaller logical chunks then.

> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> > ---
> > =C2=A0 .../devicetree/bindings/input/twl-pwrbutton.txt=C2=A0=C2=A0=C2=
=A0=C2=A0|=C2=A0=C2=A022 ++++
> > =C2=A0 .../bindings/input/twl4030-pwrbutton.txt=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A021 ---
> > =C2=A0 arch/arm/boot/dts/twl6030.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A05 +
> > =C2=A0 arch/arm/configs/omap2plus_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A0=C2=A02 +-
> > =C2=A0 drivers/input/misc/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A08 +-
> > =C2=A0 drivers/input/misc/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A02 +-
> > =C2=A0 drivers/input/misc/twl-pwrbutton.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 1=
43
> > +++++++++++++++++++++
> > =C2=A0 drivers/input/misc/twl4030-pwrbutton.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 116 ---------------=
--
> > =C2=A0 drivers/mfd/twl-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A012 +-
> > =C2=A0 include/linux/i2c/twl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A01 =
+
> > =C2=A0 10 files changed, 187 insertions(+), 145 deletions(-)
> > =C2=A0 create mode 100644 Documentation/devicetree/bindings/input/twl-
> > pwrbutton.txt
> > =C2=A0 delete mode 100644 Documentation/devicetree/bindings/input/twl40=
30-
> > pwrbutton.txt
> > =C2=A0 create mode 100644 drivers/input/misc/twl-pwrbutton.c
> > =C2=A0 delete mode 100644 drivers/input/misc/twl4030-pwrbutton.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> > b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> > new file mode 100644
> > index 0000000..4931be4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/twl-pwrbutton.txt
> > @@ -0,0 +1,22 @@
> > +Texas Instruments TWL family pwrbutton module
> > +
> > +This module is part of a TWL chip. For more details about the whole
> > +chip see Documentation/devicetree/bindings/mfd/twl-familly.txt.
> > +
> > +This module provides a simple power button event via an Interrupt.
> > +
> > +Required properties:
> > +- compatible: should be one of the following
> > +=C2=A0=C2=A0=C2=A0- "ti,twl4030-pwrbutton": For controllers compatible=
 with twl4030
> > +=C2=A0=C2=A0=C2=A0- "ti,twl6030-pwrbutton": For controllers compatible=
 with twl6030
> > +- interrupts: should be one of the following
> > +=C2=A0=C2=A0=C2=A0- <8>: For controllers compatible with the twl
> > +
> > +Example:
> > +
> > +&twl {
> > +	twl_pwrbutton: pwrbutton {
> > +		compatible =3D "ti,twl4030-pwrbutton";
> > +		interrupts =3D <8>;
> > +	};
> > +};
> > diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.=
txt
> > b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> > deleted file mode 100644
> > index c864a46..0000000
> > --- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> > +++ /dev/null
> > @@ -1,21 +0,0 @@
> > -Texas Instruments TWL family (twl4030) pwrbutton module
> > -
> > -This module is part of the TWL4030. For more details about the whole
> > -chip see Documentation/devicetree/bindings/mfd/twl-familly.txt.
> > -
> > -This module provides a simple power button event via an Interrupt.
> > -
> > -Required properties:
> > -- compatible: should be one of the following
> > -=C2=A0=C2=A0=C2=A0- "ti,twl4030-pwrbutton": For controllers compatible=
 with twl4030
> > -- interrupts: should be one of the following
> > -=C2=A0=C2=A0=C2=A0- <8>: For controllers compatible with twl4030
> > -
> > -Example:
> > -
> > -&twl {
> > -	twl_pwrbutton: pwrbutton {
> > -		compatible =3D "ti,twl4030-pwrbutton";
> > -		interrupts =3D <8>;
> > -	};
> > -};
> > diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030=
.dtsi
> > index 55eb35f..6a52df1 100644
> > --- a/arch/arm/boot/dts/twl6030.dtsi
> > +++ b/arch/arm/boot/dts/twl6030.dtsi
> > @@ -99,4 +99,9 @@
> > =C2=A0=C2=A0		compatible =3D "ti,twl6030-pwmled";
> > =C2=A0=C2=A0		#pwm-cells =3D <2>;
> > =C2=A0=C2=A0	};
> > +
> > +	twl_pwrbutton: pwrbutton {
> > +		compatible =3D "ti,twl6030-pwrbutton";
> > +		interrupts =3D <0>;
> > +	};
> > =C2=A0 };
> > diff --git a/arch/arm/configs/omap2plus_defconfig
> > b/arch/arm/configs/omap2plus_defconfig
> > index 156bc88..ff9752a 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -217,7 +217,7 @@ CONFIG_TOUCHSCREEN_TSC2007=3Dm
> > =C2=A0 CONFIG_TOUCHSCREEN_TI_AM335X_TSC=3Dm
> > =C2=A0 CONFIG_INPUT_MISC=3Dy
> > =C2=A0 CONFIG_INPUT_TPS65218_PWRBUTTON=3Dm
> > -CONFIG_INPUT_TWL4030_PWRBUTTON=3Dm
> > +CONFIG_INPUT_TWL_PWRBUTTON=3Dm
> > =C2=A0 CONFIG_INPUT_PALMAS_PWRBUTTON=3Dm
> > =C2=A0 CONFIG_SERIO=3Dm
> > =C2=A0 # CONFIG_LEGACY_PTYS is not set
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index 6abb6df..f643e14 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -459,15 +459,15 @@ config INPUT_AXP20X_PEK
> > =C2=A0=C2=A0	=C2=A0=C2=A0be called axp20x-pek.
> > =C2=A0=C2=A0
> > =C2=A0=C2=A0
> > -config INPUT_TWL4030_PWRBUTTON
> > -	tristate "TWL4030 Power button Driver"
> > +config INPUT_TWL_PWRBUTTON
> > +	tristate "TWL Power button Driver"
> > =C2=A0=C2=A0	depends on TWL_CORE
> > =C2=A0=C2=A0	help
> > =C2=A0=C2=A0	=C2=A0=C2=A0Say Y here if you want to enable power key rep=
orting via the
> > -	=C2=A0=C2=A0TWL4030 family of chips.
> > +	=C2=A0=C2=A0TWL family of chips.
> > =C2=A0=C2=A0
> > =C2=A0=C2=A0	=C2=A0=C2=A0To compile this driver as a module, choose M h=
ere. The module
> > will
> > -	=C2=A0=C2=A0be called twl4030_pwrbutton.
> > +	=C2=A0=C2=A0be called twl_pwrbutton.
> > =C2=A0=C2=A0
> > =C2=A0 config INPUT_TWL4030_VIBRA
> > =C2=A0=C2=A0	tristate "Support for TWL4030 Vibrator"
> > diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> > index 0357a08..f77f5e7 100644
> > --- a/drivers/input/misc/Makefile
> > +++ b/drivers/input/misc/Makefile
> > @@ -66,7 +66,7 @@ obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+=3D sirfsoc-
> > onkey.o
> > =C2=A0 obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+=3D soc_button_array.o
> > =C2=A0 obj-$(CONFIG_INPUT_SPARCSPKR)		+=3D sparcspkr.o
> > =C2=A0 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+=3D tps65218-pwrbutton.o
> > -obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+=3D twl4030-pwrbutton.o
> > +obj-$(CONFIG_INPUT_TWL_PWRBUTTON)	+=3D twl-pwrbutton.o
> > =C2=A0 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+=3D twl4030-vibra.o
> > =C2=A0 obj-$(CONFIG_INPUT_TWL6040_VIBRA)	+=3D twl6040-vibra.o
> > =C2=A0 obj-$(CONFIG_INPUT_UINPUT)		+=3D uinput.o
> > diff --git a/drivers/input/misc/twl-pwrbutton.c b/drivers/input/misc/tw=
l-
> > pwrbutton.c
> > new file mode 100644
> > index 0000000..a7bc8ad
> > --- /dev/null
> > +++ b/drivers/input/misc/twl-pwrbutton.c
> > @@ -0,0 +1,143 @@
> > +/**
> > + * twl4030-pwrbutton.c - TWL4030 Power Button Input Driver

This should probably be changed, by the way.

> > + * Copyright (C) 2008-2009 Nokia Corporation
> > + *
> > + * Written by Peter De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > + * Several fixes by Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > + *
> > + * This file is subject to the terms and conditions of the GNU General
> > + * Public License. See the file "COPYING" in the main directory of thi=
s
> > + * archive for more details.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0=C2=A0See=
 the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, write to the Free Software
> > + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA=C2=A0=C2=
=A002111-
> > 1307=C2=A0=C2=A0USA
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/errno.h>
> > +#include <linux/input.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/i2c/twl.h>
> > +
> > +#define PWR_PWRON_IRQ (1 << 0)
> > +
> > +#define TWL4030_STS_HW_CONDITIONS 0x0f
> > +#define TWL6030_STS_HW_CONDITIONS 0x21
> > +
> > +static irqreturn_t powerbutton_irq(int irq, void *_pwr)
> > +{
> > +	struct input_dev *pwr =3D _pwr;
> > +	int err;
> > +	u8 value;
> > +
> > +	if (twl_class_is_4030())
> one of the benefits of using DT is that we can get rid of code
> like above - compatible string should provide enough info.

I fully agree with you here, especially given what twl_class_is_4030=C2=A0i=
s actually
doing.

If we're not going to use platform data at all for supporting twl6030 on th=
is
driver, let's just fallback to twl4030 when dt is not used.

> > +		err =3D twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &value,
> > +				TWL4030_STS_HW_CONDITIONS);
> > +	else
> > +		err =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &value,
> > +				TWL6030_STS_HW_CONDITIONS);
> > +
> > +	if (!err)=C2=A0=C2=A0{
> > +		pm_wakeup_event(pwr->dev.parent, 0);
> > +		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
> > +		input_sync(pwr);
> > +	} else {
> > +		dev_err(pwr->dev.parent, "twl4030: i2c error %d while
> > reading"
> > +			" TWL4030 PM_MASTER STS_HW_CONDITIONS register\n",
> > err);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int twl_pwrbutton_probe(struct platform_device *pdev)
> > +{
> > +	struct input_dev *pwr;
> > +	int irq =3D platform_get_irq(pdev, 0);
> It may fail ?! and return -EPROBE_DEFER

Fair enough, not that this is inherited from the previous driver, but a cle=
anup
won't hurt. I should probably have formatted the patch with -M though.

> > +	int err;
> > +
> > +	pwr =3D devm_input_allocate_device(&pdev->dev);
> > +	if (!pwr) {
> > +		dev_err(&pdev->dev, "Can't allocate power button\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pwr->evbit[0] =3D BIT_MASK(EV_KEY);
> > +	pwr->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY_POWER);
> > +	pwr->name =3D "twl_pwrbutton";
> > +	pwr->phys =3D "twl_pwrbutton/input0";
> > +	pwr->dev.parent =3D &pdev->dev;
> > +
> > +	if (twl_class_is_6030()) {
> > +		twl6030_interrupt_unmask(TWL6030_PWRON_INT_MASK,
> > +			REG_INT_MSK_LINE_A);
> > +		twl6030_interrupt_unmask(TWL6030_PWRON_INT_MASK,
> > +			REG_INT_MSK_STS_A);
> Seems it's time to update twl6030-irq.c and add enable_irq()/disable_irq(=
)
> functionality.

I'll look into that.

> >=20
> > +	}
> > +
> > +	err =3D devm_request_threaded_irq(&pwr->dev, irq, NULL,
> > powerbutton_irq,
> > +			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> > +			IRQF_ONESHOT,
> > +			"twl_pwrbutton", pwr);
> > +	if (err < 0) {
> > +		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n",
> > err);
> > +		return err;
> > +	}
> > +
> > +	err =3D input_register_device(pwr);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "Can't register power button: %d\n",
> > err);
> > +		return err;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, pwr);
> > +	device_init_wakeup(&pdev->dev, true);
> > +
> > +	return 0;
> > +}
> > +
> > +static int twl_pwrbutton_remove(struct platform_device *pdev)
> > +{
> > +	if (twl_class_is_6030()) {
> > +		twl6030_interrupt_mask(TWL6030_PWRON_INT_MASK,
> > +			REG_INT_MSK_LINE_A);
> > +		twl6030_interrupt_mask(TWL6030_PWRON_INT_MASK,
> > +			REG_INT_MSK_STS_A);
> > +	}
> 	device_init_wakeup(&pdev->dev, 0);
>=20
>=20
> >=20
> > +
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id twl_pwrbutton_dt_match_table[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "ti,twl403=
0-pwrbutton" },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "ti,twl603=
0-pwrbutton" },
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{},
> > +};
> > +MODULE_DEVICE_TABLE(of, twl_pwrbutton_dt_match_table);
> > +#endif
> > +
> > +static struct platform_driver twl_pwrbutton_driver =3D {
> > +	.probe		=3D twl_pwrbutton_probe,
> > +	.remove		=3D twl_pwrbutton_remove,
> > +	.driver		=3D {
> > +		.name	=3D "twl_pwrbutton",
> > +		.of_match_table =3D
> > of_match_ptr(twl_pwrbutton_dt_match_table),
> > +	},
> > +};
> > +module_platform_driver(twl_pwrbutton_driver);
> > +
> > +MODULE_ALIAS("platform:twl_pwrbutton");
> > +MODULE_DESCRIPTION("TWL Power Button");
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Peter De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>");
> > +MODULE_AUTHOR("Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>");
> > diff --git a/drivers/input/misc/twl4030-pwrbutton.c
> > b/drivers/input/misc/twl4030-pwrbutton.c
> > deleted file mode 100644
> > index 603fc2f..0000000
> > --- a/drivers/input/misc/twl4030-pwrbutton.c
> > +++ /dev/null
> > @@ -1,116 +0,0 @@
> > -/**
> > - * twl4030-pwrbutton.c - TWL4030 Power Button Input Driver
> > - *
> > - * Copyright (C) 2008-2009 Nokia Corporation
> > - *
> > - * Written by Peter De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > - * Several fixes by Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
> > - *
> > - * This file is subject to the terms and conditions of the GNU General
> > - * Public License. See the file "COPYING" in the main directory of thi=
s
> > - * archive for more details.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0=C2=A0See=
 the
> > - * GNU General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program; if not, write to the Free Software
> > - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA=C2=A0=C2=
=A002111-
> > 1307=C2=A0=C2=A0USA
> > - */
> > -
> > -#include <linux/module.h>
> > -#include <linux/init.h>
> > -#include <linux/kernel.h>
> > -#include <linux/errno.h>
> > -#include <linux/input.h>
> > -#include <linux/interrupt.h>
> > -#include <linux/platform_device.h>
> > -#include <linux/i2c/twl.h>
> > -
> > -#define PWR_PWRON_IRQ (1 << 0)
> > -
> > -#define STS_HW_CONDITIONS 0xf
> > -
> > -static irqreturn_t powerbutton_irq(int irq, void *_pwr)
> > -{
> > -	struct input_dev *pwr =3D _pwr;
> > -	int err;
> > -	u8 value;
> > -
> > -	err =3D twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &value,
> > STS_HW_CONDITIONS);
> > -	if (!err)=C2=A0=C2=A0{
> > -		pm_wakeup_event(pwr->dev.parent, 0);
> > -		input_report_key(pwr, KEY_POWER, value & PWR_PWRON_IRQ);
> > -		input_sync(pwr);
> > -	} else {
> > -		dev_err(pwr->dev.parent, "twl4030: i2c error %d while
> > reading"
> > -			" TWL4030 PM_MASTER STS_HW_CONDITIONS register\n",
> > err);
> > -	}
> > -
> > -	return IRQ_HANDLED;
> > -}
> > -
> > -static int twl4030_pwrbutton_probe(struct platform_device *pdev)
> > -{
> > -	struct input_dev *pwr;
> > -	int irq =3D platform_get_irq(pdev, 0);
> > -	int err;
> > -
> > -	pwr =3D devm_input_allocate_device(&pdev->dev);
> > -	if (!pwr) {
> > -		dev_err(&pdev->dev, "Can't allocate power button\n");
> > -		return -ENOMEM;
> > -	}
> > -
> > -	pwr->evbit[0] =3D BIT_MASK(EV_KEY);
> > -	pwr->keybit[BIT_WORD(KEY_POWER)] =3D BIT_MASK(KEY_POWER);
> > -	pwr->name =3D "twl4030_pwrbutton";
> > -	pwr->phys =3D "twl4030_pwrbutton/input0";
> > -	pwr->dev.parent =3D &pdev->dev;
> > -
> > -	err =3D devm_request_threaded_irq(&pwr->dev, irq, NULL,
> > powerbutton_irq,
> > -			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
> > -			IRQF_ONESHOT,
> > -			"twl4030_pwrbutton", pwr);
> > -	if (err < 0) {
> > -		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n",
> > err);
> > -		return err;
> > -	}
> > -
> > -	err =3D input_register_device(pwr);
> > -	if (err) {
> > -		dev_err(&pdev->dev, "Can't register power button: %d\n",
> > err);
> > -		return err;
> > -	}
> > -
> > -	platform_set_drvdata(pdev, pwr);
> > -	device_init_wakeup(&pdev->dev, true);
> > -
> > -	return 0;
> > -}
> > -
> > -#ifdef CONFIG_OF
> > -static const struct of_device_id twl4030_pwrbutton_dt_match_table[] =
=3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ .compatible =3D "ti,twl403=
0-pwrbutton" },
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{},
> > -};
> > -MODULE_DEVICE_TABLE(of, twl4030_pwrbutton_dt_match_table);
> > -#endif
> > -
> > -static struct platform_driver twl4030_pwrbutton_driver =3D {
> > -	.probe		=3D twl4030_pwrbutton_probe,
> > -	.driver		=3D {
> > -		.name	=3D "twl4030_pwrbutton",
> > -		.of_match_table =3D
> > of_match_ptr(twl4030_pwrbutton_dt_match_table),
> > -	},
> > -};
> > -module_platform_driver(twl4030_pwrbutton_driver);
> > -
> > -MODULE_ALIAS("platform:twl4030_pwrbutton");
> > -MODULE_DESCRIPTION("Triton2 Power Button");
> > -MODULE_LICENSE("GPL");
> > -MODULE_AUTHOR("Peter De Schrijver <peter.de-schrijver-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>");
> > -MODULE_AUTHOR("Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>");
> > -
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index 74372bc..a1bfe23 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -848,13 +848,21 @@ add_children(struct twl_platform_data *pdata, uns=
igned
> > irq_base,
> > =C2=A0=C2=A0			return PTR_ERR(child);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0
> > -	if (IS_ENABLED(CONFIG_INPUT_TWL4030_PWRBUTTON) &&
> > twl_class_is_4030()) {
> > -		child =3D add_child(TWL_MODULE_PM_MASTER,
> > "twl4030_pwrbutton",
> > +	if (IS_ENABLED(CONFIG_INPUT_TWL_PWRBUTTON) && twl_class_is_4030())
> > {
> > +		child =3D add_child(TWL_MODULE_PM_MASTER, "twl_pwrbutton",
> > =C2=A0=C2=A0				=C2=A0=C2=A0NULL, 0, true, irq_base + 8 + 0, 0);
> > =C2=A0=C2=A0		if (IS_ERR(child))
> > =C2=A0=C2=A0			return PTR_ERR(child);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0
> > +	if (IS_ENABLED(CONFIG_INPUT_TWL_PWRBUTTON) && twl_class_is_6030())
> > {
> > +		child =3D add_child(TWL_MODULE_PM_MASTER, "twl_pwrbutton",
> > +				=C2=A0=C2=A0NULL, 0, true, irq_base + 0, 0);
> > +		if (IS_ERR(child))
> > +			return PTR_ERR(child);
> > +	}
> > +
> no legacy code for twl6030 pls

That's fine with me.

> >=20
> > +
> > =C2=A0=C2=A0	if (IS_ENABLED(CONFIG_MFD_TWL4030_AUDIO) && pdata->audio &=
&
> > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0twl_class_is_4030()) {
> > =C2=A0=C2=A0		child =3D add_child(TWL4030_MODULE_AUDIO_VOICE, "twl4030-
> > audio",
> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> > index 2decb190..20d33b7 100644
> > --- a/include/linux/i2c/twl.h
> > +++ b/include/linux/i2c/twl.h
> > @@ -127,6 +127,7 @@ enum twl6030_module_ids {
> > =C2=A0 #define REG_INT_MSK_STS_C		0x08
> > =C2=A0=C2=A0
> > =C2=A0 /* MASK INT REG GROUP A */
> > +#define TWL6030_PWRON_INT_MASK		0x01
> > =C2=A0 #define TWL6030_PWR_INT_MASK=C2=A0		0x07
> > =C2=A0 #define TWL6030_RTC_INT_MASK=C2=A0		0x18
> > =C2=A0 #define TWL6030_HOTDIE_INT_MASK=C2=A0	0x20
> >=20
>=20
--=-PYqQ4xjH2IWrTX6Rr8BO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXACvTAAoJEIT9weqP7pUMoI0P/3nY3CQ6PnLlu+g+b584wXdj
2685qO0O8QE29/rGfn23aQX3L0QHOKdC+MuCY558PWKuJ4bUWNvJq2Fp7Y75xgWf
ekVuLKagQrgH3y0IzKYW+2ClKl+wMkZFiT8fvI70aVsBJhd9Jy9Nf3cKDYuXG2hD
b/fz0qOoF4ZPRs7zHktBzWKa3a+Q7YO/F7zU6OjbUrdHyStEWTJA3WkyVcfeh3jG
Dvu5Zch/KNaVJGVBPNlKeWw7a9730Vv3earrVvz3M5138kCtWdbX2ndZUPI836ze
BUydGNyesTNKlMkpPQleUWM8ZcVhIsrZlYIF49b/ywBeFHoQzJmHKjcrPGHIFNXw
IE7j59RodCapdgBfMGJgDvI71JMjb7YrMFm8FxAOt6jWgKMCNrM2CLhOSlpHMCVz
uE9t83JCBdf3Si2RJ55iZNdp+aTGS89Ei+OOjTl++Mqa5GDzIit8f5xemW2CtXFp
x9VO+cLZytKfXd89ZxYUZ+zfpY/bbrh3I7tZL3l9HzTqxaixX6SWmoiXF1TlK/Ai
Uygn670NhGYKqnA66bMtcJXkVNaULvCMglymvqpOcWKUiNXu8qZtV1ZunYZfqb2a
xpUXp6z9n2010TSn7p93zPhBQZiqSx6e9g3iMh7QKOIflo88uoGvlYDV/ygsHUWL
QxUDqrsSvg0+9qZVXAYY
=qjl+
-----END PGP SIGNATURE-----

--=-PYqQ4xjH2IWrTX6Rr8BO--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
