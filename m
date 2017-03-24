From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Fri, 24 Mar 2017 11:06:22 +0100
Message-ID: <20170324100622.mzra66z35xlndhdj@earth>
References: <20170322234210.5557-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bz6ywdakcfq7ko25"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170322234210.5557-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--bz6ywdakcfq7ko25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 22, 2017 at 04:42:10PM -0700, Tony Lindgren wrote:
> The custom CPCAP PMIC used on Motorola phones such as Droid 4 has a
> USB battery charger. It can optionally also have a companion chip that
> is used for wireless charging.
>=20
> The charger on CPCAP also can feed VBUS for the USB host mode. This
> can be handled by the existing kernel phy_companion interface.
>
> [...]
>
> diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-charger=
=2Etxt b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
> @@ -0,0 +1,34 @@
> +Motorola CPCAP PMIC battery charger binding
> +
> +Required properties:
> +- compatible: Shall be "motorola,cpcap-charger" or
> +	      "motorola,mapphone-cpcap-charger"
> +- interrupts: Interrupts used on the CPCAP PMIC
> +- interrupt-names: Names of the interrupts

That's usually done like

interrupts: Interrupt specifier for each name in interrupt-names
interrupt-names: Should contain the following entries:
 "bla", "foo", "42"

> +- io-channels: IIO ADC channels used by the charger
> +- io-channel-names: Names of the IIO ADC channels

Same as for interrupts.

> +Optional properties:
> +- mode-gpios: Optionally CPCAP charger can have a companion wireless
> +	      charge controller that is controlled with two GPIOs

DT people prefer to have GPIO activity (high/low) to be specified in the
binding.

> +Example:
> +
> +cpcap_charger: charger {
> +	compatible =3D "motorola,mapphone-cpcap-charger";
> +	interrupts-extended =3D <
> +		&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
> +		&cpcap 22 0 &cpcap 20 0 &cpcap 19 0 &cpcap 54 0
> +	>;
> +	interrupt-names =3D
> +		"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
> +		"rvrs_mode", "chrgcurr1", "vbusvld", "battdetb";
> +	mode-gpios =3D <&gpio3 29 GPIO_ACTIVE_LOW
> +		      &gpio3 23 GPIO_ACTIVE_LOW>;
> +	io-channels =3D <&cpcap_adc 0 &cpcap_adc 1
> +		       &cpcap_adc 2 &cpcap_adc 5
> +		       &cpcap_adc 6>;
> +	io-channel-names =3D "battdetb", "battp",
> +			   "vbus", "chg_isense",
> +			   "batti";
> +};
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -317,6 +317,13 @@ config BATTERY_RX51
>  	  Say Y here to enable support for battery information on Nokia
>  	  RX-51, also known as N900 tablet.
> =20
> +config CHARGER_CPCAP
> +	tristate "CPCAP PMIC Charger Driver"
> +	depends on MFD_CPCAP
> +	help
> +	  Say Y to enable support for CPCAP PMIC charger driver for Motorola
> +	  mobile devices such as Droid 4.
> +

I think adding "default MFD_CPCAP" for CPCPAP's subdrivers would be nice.

>  config CHARGER_ISP1704
>  	tristate "ISP1704 USB Charger Detection"
>  	depends on USB_PHY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
>=20
> [...]
>
> +#include <linux/gpio/consumer.h>
> +#include <linux/usb/phy_companion.h>
> +#include <linux/phy/omap_usb.h>
> +#include <linux/usb/otg.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/mfd/motorola-cpcap.h>

This looks very entangled with mapphone specific things,
so maybe we should not add "motorola,cpcap-charger" for
now?

> [...]
>
> +static int cpcap_charger_get_ints_state(struct cpcap_charger_ddata *ddat=
a,
> +					struct cpcap_charger_ints_state *s)
> +{
> +	int val, error;
> +
> +	error =3D regmap_read(ddata->reg, CPCAP_REG_INTS1, &val);
> +	if (error)
> +		return error;
> +
> +	s->chrg_det =3D val & BIT(13);
> +	s->rvrs_chrg =3D val & BIT(12);
> +	s->vbusov =3D val & BIT(11);
> +
> +	error =3D regmap_read(ddata->reg, CPCAP_REG_INTS2, &val);
> +	if (error)
> +		return error;
> +
> +	s->chrg_se1b =3D val & BIT(13);
> +	s->rvrs_mode =3D val & BIT(6);
> +	s->chrgcurr1 =3D val & BIT(4);
> +	s->vbusvld =3D val & BIT(3);
> +
> +	error =3D regmap_read(ddata->reg, CPCAP_REG_INTS4, &val);
> +	if (error)
> +		return error;
> +
> +	s->battdetb =3D val & BIT(6);

Did you avoid using cpcap_sense_virq() for performance reasons?

s->battdetb =3D cpcap_sense_virq(ddata->reg, ddata->irq_battdetb);
(and so on)

looks cleaner IMHO.

> +
> +	return 0;
> +}
>
> [...]

-- Sebastian

--bz6ywdakcfq7ko25
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljU75sACgkQ2O7X88g7
+prOhw//Qfuc+k+riK97zAdlAW9MEeevDYwLyiUwKFDv/CRovcy+AaOViAHwNSY3
zCnw8xorQpg4ON/96mp6fQqZHMZ8JpJk5cZuLc+ar3OIrsP4pYDPDkHmF0w4f3RE
bxmBzRo8CuJ0PELmEcduUEYF1nUH7Tt0L2UOPXBioW2A4HtAjwkwz8P4Qo5551QY
uP+5DS3CsCDPGflNCARi7cdiFrLHhZi2eU9eG7caGoKDvfKyG2Zn8bbZ5Ash1ciy
0SKX+h8hUInq85fHI8OMk23L9gRcaGx3BCsxAUCYsYo33XTkX9Vm97Os2dg9bDxd
voiDvfoEmx3LQ0PwXBWv67qsYZZi0M/hgQGpLe3zjbluEo29s2TbaXtzpT8QvP3E
y09DyYhVgF2hy4Rhzt6tqgeIQhwUEYJ/U8JOkrNJhhwv3z/LTyJl8bw9qq0rMTXd
OEnOVNdTMsPFpE0v4CsFva4vV6BCi39BDkJubsazudRbIWblzkM07DXlqeMOLCjp
9QPYi/S2FG+KbeLExnxaaR0wnfZeYuMp2Jupr6+fDzI5feIkw5JHou9LBEU/r1ph
A20d7Tewp+IGPJCiKr8/O6qWWVTfWTaWRNkKjavuCAHG+NZMSSPvOTE4W4rwJ9FP
FWZpFNGxxxKg4Oqh/a70FO/WvCrjm42ll0G4pdw8GiNbVs2zh0Q=
=2OW2
-----END PGP SIGNATURE-----

--bz6ywdakcfq7ko25--
