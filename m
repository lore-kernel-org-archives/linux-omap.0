From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/8] mfd: Add TWL6030 power driver, with minimal support
 for power off
Date: Sat, 02 Apr 2016 22:14:17 +0200
Message-ID: <1459628057.12073.37.camel@paulk.fr>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
	 <1459279341-17389-4-git-send-email-contact@paulk.fr>
	 <56FBF722.5060803@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-fBiR0lrKRTe2oLk5yXkS"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FBF722.5060803@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org


--=-fBiR0lrKRTe2oLk5yXkS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 30 mars 2016 =C3=A0 18:56 +0300, Grygorii Strashko a =C3=A9crit=
=C2=A0:
> On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> >=20
> > This adds a TWL6030 power driver, that currently only supports powering=
 off
> > the
> > device when the TWL is used as system power controller.
> >=20
> > This driver might be extended to support more power-related features of=
 the
> > TWL6030.
> >=20
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> > =C2=A0 .../devicetree/bindings/mfd/twl6030-power.txt=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A031 +++++++
> > =C2=A0 drivers/mfd/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=
=C2=A0=C2=A010 ++
> > =C2=A0 drivers/mfd/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A0=C2=A05 +-
> > =C2=A0 drivers/mfd/twl-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A0=C2=
=A08 ++
> > =C2=A0 drivers/mfd/twl6030-power.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 102
> > +++++++++++++++++++++
> Seems proper place for this driver is drivers/power/reset.

twl4030-power is in=C2=A0drivers/mfd/ and contains similar functions. Shoul=
d those be
split into a separate driver in driver/power/reset?

If not, I'd rather keep this basic driver in drivers/mfd/ since it might be
extended later to support more power-related things.

> > =C2=A0 5 files changed, 154 insertions(+), 2 deletions(-)
> > =C2=A0 create mode 100644 Documentation/devicetree/bindings/mfd/twl6030=
-power.txt
> > =C2=A0 create mode 100644 drivers/mfd/twl6030-power.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/mfd/twl6030-power.txt
> > b/Documentation/devicetree/bindings/mfd/twl6030-power.txt
> > new file mode 100644
> > index 0000000..97600e7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/twl6030-power.txt
> > @@ -0,0 +1,31 @@
> > +Texas Instruments TWL family (twl6030) reset and power management modu=
le
> > +
> > +For now, the binding only supports the complete shutdown of the system
> > after
> > +poweroff.
> > +
> > +Required properties:
> > +- compatible : must be
> > +	"ti,twl6030-power"
> > +
> > +Optional properties:
> > +
> > +- ti,system-power-controller: This indicates that TWL6030 is the
> > +=C2=A0=C2=A0power supply master of the system. With this flag, the chi=
p will
> > +=C2=A0=C2=A0initiate an ACTIVE-to-OFF or SLEEP-to-OFF transition when =
the
> > +=C2=A0=C2=A0system poweroffs.
> > +
> > +Example:
> > +&i2c1 {
> > +	clock-frequency =3D <2600000>;
> > +
> > +	twl: twl@48 {
> > +		reg =3D <0x48>;
> > +		interrupts =3D <7>; /* SYS_NIRQ cascaded to intc */
> > +		interrupt-parent =3D <&intc>;
> > +
> > +		twl_power: power {
> > +			compatible =3D "ti,twl6030-power";
> > +			ti,system-power-controller;
> > +		};
> > +	};
> > +};
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 28bfe3d..a0a8012 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1301,6 +1301,16 @@ config MFD_TWL4030_AUDIO
> > =C2=A0=C2=A0	select MFD_CORE
> > =C2=A0=C2=A0	default n
> >=20
> > +config TWL6030_POWER
> > +	bool "TI TWL6030 power resources"
> > +	depends on TWL_CORE && ARM
> > +	help
> > +	=C2=A0=C2=A0Say yes here if you want to use the power resources on th=
e
> > +	=C2=A0=C2=A0TWL6030 family chips.
> > +
> > +	=C2=A0=C2=A0When used as system power controller, this driver allows =
turning
> > off
> > +	=C2=A0=C2=A0the main power supply.
> > +
> > =C2=A0 config TWL6040_CORE
> > =C2=A0=C2=A0	bool "TI TWL6040 audio codec"
> > =C2=A0=C2=A0	depends on I2C=3Dy
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 7daeab5..5aa16c8 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -81,9 +81,10 @@ obj-$(CONFIG_MFD_TPS65912_SPI)=C2=A0=C2=A0+=3D tps65=
912-spi.o
> > =C2=A0 obj-$(CONFIG_MFD_TPS80031)	+=3D tps80031.o
> > =C2=A0 obj-$(CONFIG_MENELAUS)		+=3D menelaus.o
> >=20
> > -obj-$(CONFIG_TWL_CORE)	+=3D twl-core.o twl4030-irq.o twl6030-irq.o
> > -obj-$(CONFIG_TWL4030_POWER)=C2=A0=C2=A0=C2=A0=C2=A0+=3D twl4030-power.=
o
> > +obj-$(CONFIG_TWL_CORE)		+=3D twl-core.o twl4030-irq.o twl6030-
> > irq.o
> > +obj-$(CONFIG_TWL4030_POWER)	+=3D twl4030-power.o
> > =C2=A0 obj-$(CONFIG_MFD_TWL4030_AUDIO)	+=3D twl4030-audio.o
> > +obj-$(CONFIG_TWL6030_POWER)	+=3D twl6030-power.o
> > =C2=A0 obj-$(CONFIG_TWL6040_CORE)	+=3D twl6040.o
> >=20
> > =C2=A0 obj-$(CONFIG_MFD_MX25_TSADC)	+=3D fsl-imx25-tsadc.o
> > diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> > index dae52f7..74372bc 100644
> > --- a/drivers/mfd/twl-core.c
> > +++ b/drivers/mfd/twl-core.c
> > @@ -972,6 +972,14 @@ add_children(struct twl_platform_data *pdata, unsi=
gned
> > irq_base,
> > =C2=A0=C2=A0			return PTR_ERR(child);
> > =C2=A0=C2=A0	}
> >=20
> > +	if (IS_ENABLED(CONFIG_TWL6030_POWER) && pdata->power) {
> > +		child =3D add_child(TWL_MODULE_PM_MASTER, "twl6030_power",
> > +				=C2=A0=C2=A0pdata->power, sizeof(*pdata->power),
> > false,
> > +				=C2=A0=C2=A00, 0);
> > +		if (IS_ERR(child))
> > +			return PTR_ERR(child);
> > +	}
> > +
> non-DT boot option is not supported for twl6030 any more and
> all related code was removed already.
>=20
> >=20
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> >=20
> > diff --git a/drivers/mfd/twl6030-power.c b/drivers/mfd/twl6030-power.c
> > new file mode 100644
> > index 0000000..a0bb6d8
> > --- /dev/null
> > +++ b/drivers/mfd/twl6030-power.c
> > @@ -0,0 +1,102 @@
> > +/*
> > + * TWL6030 power
> > + *
> > + * Copyright (C) 2016 Paul Kocialkowski <contact@paulk.fr>
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
> I think header should look different now (but not sure).
>=20
> >=20
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/i2c/twl.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +
> > +#define TWL6030_PHOENIX_DEV_ON		0x25
> > +
> > +#define TWL6030_PHOENIX_APP_DEVOFF	(1 << 0)
> > +#define TWL6030_PHOENIX_CON_DEVOFF	(1 << 1)
> > +#define TWL6030_PHOENIX_MOD_DEVOFF	(1 << 2)
> > +
> > +void twl6030_power_off(void)
> > +{
> > +	int err;
> > +
> > +	err =3D twl_i2c_write_u8(TWL6030_MODULE_ID0,
> > TWL6030_PHOENIX_APP_DEVOFF |
> > +		TWL6030_PHOENIX_CON_DEVOFF | TWL6030_PHOENIX_MOD_DEVOFF,
> > +		TWL6030_PHOENIX_DEV_ON);
> > +	if (err)
> > +		pr_err("TWL6030 Unable to power off\n");
> > +}
> > +
> > +static bool twl6030_power_use_poweroff(const struct twl_power_data *pd=
ata,
> > +	struct device_node *node)
> > +{
> > +	if (pdata && pdata->use_poweroff)
> > +		return true;
> the same comment as above - only DT support for this PMIC as of now.
>=20
> >=20
> > +
> > +	if (of_property_read_bool(node, "ti,system-power-controller"))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id twl6030_power_of_match[] =3D {
> > +	{
> > +		.compatible =3D "ti,twl6030-power",
> > +	},
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, twl6030_power_of_match);
> > +#endif	/* CONFIG_OF */
> > +
> > +static int twl6030_power_probe(struct platform_device *pdev)
> > +{
> > +	const struct twl_power_data *pdata =3D dev_get_platdata(&pdev->dev);
> > +	struct device_node *node =3D pdev->dev.of_node;
> > +
> > +	if (!pdata && !node) {
> > +		dev_err(&pdev->dev, "Platform data is missing\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Board has to be wired properly to use this feature */
> > +	if (twl6030_power_use_poweroff(pdata, node) && !pm_power_off)
> > +		pm_power_off =3D twl6030_power_off;
> > +
> > +	return 0;
> > +}
> > +
> > +static int twl6030_power_remove(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver twl6030_power_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "twl6030_power",
> > +		.of_match_table =3D of_match_ptr(twl6030_power_of_match),
> > +	},
> > +	.probe		=3D twl6030_power_probe,
> > +	.remove		=3D twl6030_power_remove,
> > +};
> > +
> > +module_platform_driver(twl6030_power_driver);
> > +
> > +MODULE_AUTHOR("Paul Kocialkowski <contact@paulk.fr>");
> > +MODULE_DESCRIPTION("Power management for TWL6030");
> > +MODULE_LICENSE("GPL");
> >=20
>=20
--=-fBiR0lrKRTe2oLk5yXkS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXACgaAAoJEIT9weqP7pUMyf8P/0uShYjRz2pXu2eHCMhCh2z0
lR0xgyeawm8ye4taBd5B4Noy4D+e0Xir9YVyvNbI5YRbdu2kQpbYFsSJeTZywby8
M6ctDYvZGhJB/zSvuu5Qaa+a15QnwOgNaQjJGVMjywXRkX7tm7+RRAXsKeJGfUQ9
XrkRFhmSpQ45odcGwHeaH4kFHKPcqr0fbctFDcKHHspYvRprfI06D2wx4Xj8p9Xo
uPJF+umPfU6oEfRZp+mD04YVR2LAiVg09iSSeoAPwrTxZURgYpK38Iv4D95zP7Ga
yBdGlNlxLU4+F6n3gHiEAM+Gur80VS3NWixHtLzNUEkXgyG9K12yDl1iqEBmvMIU
LO3Ah6sMPbhDCqfTkPZIaF5hWspdxKluLS0zf1N/hM6fxxShGLdEoredgxbRbrxs
8YIUxSl9wIvcxg8C4tlSQJkqdbzya/NQkJe2Xfozplm0ptGPc9AzWn3P8lJGTyOu
ezeoXxTsVKeubv1Rf3+YjmzmE/nxkC1vCuna1BzXSMEw8qaZ56Xt0ZAGMAFpOhuz
yGloGlQwOfUGvmVGtTTnMWln3w1K3vsZZa1t5qYiF4UzyxoZm+f/7Z/2ygcJVLS0
pvQpylfC6FGGD8uqMSJQJvceQyAntGq3hd0VOtENYiUPji5VT1LC8k226/hYZkUg
KrzlAOQcuPmpj+akSwsZ
=t4zj
-----END PGP SIGNATURE-----

--=-fBiR0lrKRTe2oLk5yXkS--
