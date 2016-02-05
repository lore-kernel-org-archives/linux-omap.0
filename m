From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Fri, 05 Feb 2016 19:49:12 +0100
Message-ID: <1454698152.2623.5.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <5680839E.4080800@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Q2TcVy+v3XwCMHP0cvrX"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5680839E.4080800@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <milo.kim@ti.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-Q2TcVy+v3XwCMHP0cvrX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 28 d=C3=A9cembre 2015 =C3=A0 09:34 +0900, Milo Kim a =C3=A9crit :
> Hi Paul,
>=20
> Thanks for the patches. Please see my comments below.

Thanks for the review Milo, I have just submitted v2 with those
suggestions integrated.

> On 23/12/15 19:58, Paul Kocialkowski wrote:
> > LP872x regulators are made active via the EN pin, which might be hooked=
 to a
> > GPIO. This adds support for driving the GPIO high when the driver is in=
 use.
>=20
> EN pin is used for enabling HW logic like I2C block. It's not regulator=
=20
> enable pin. Please check the block diagram in the datasheet.
>=20
> All regulators of LP8720 and LP8725 are controlled through I2C=20
> registers. Additionally, LP8725 provides external pin control for LDO3=
=20
> and BUCK2. In this case, you can use 'regulator_config.ena_gpio' when a=
=20
> regulator is registered.
>=20
> >
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> > ---
> >   .../devicetree/bindings/regulator/lp872x.txt       |  1 +
> >   drivers/regulator/lp872x.c                         | 33 +++++++++++++=
+++++++--
> >   include/linux/regulator/lp872x.h                   |  2 ++
> >   3 files changed, 33 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/D=
ocumentation/devicetree/bindings/regulator/lp872x.txt
> > index 7818318..0559c25 100644
> > --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
> > +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
> > @@ -28,6 +28,7 @@ Optional properties:
> >     - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872=
x devices.
> >     - ti,dvs-vsel: DVS selector. 0 =3D SEL_V1, 1 =3D SEL_V2.
> >     - ti,dvs-state: initial DVS pin state. 0 =3D DVS_LOW, 1 =3D DVS_HIG=
H.
> > +  - ti,enable-gpio: GPIO specifier for EN pin control of LP872x device=
s.
>=20
> Please use general property, "enable-gpios" instead of "ti,enable-gpio".
>=20
> >
> >     Sub nodes for regulator_init_data
> >       LP8720 has maximum 6 nodes. (child name: ldo1 ~ 5 and buck)
> > diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
> > index 21c49d8..c8855f3 100644
> > --- a/drivers/regulator/lp872x.c
> > +++ b/drivers/regulator/lp872x.c
> > @@ -726,6 +726,27 @@ static struct regulator_desc lp8725_regulator_desc=
[] =3D {
> >   	},
> >   };
> >
> > +static int lp872x_init_enable(struct lp872x *lp)
>=20
> lp872x_enable_hw() would be better.
>=20
> > +{
> > +	int ret, gpio;
> > +
> > +	if (!lp->pdata)
> > +		return -EINVAL;
> > +
> > +	gpio =3D lp->pdata->enable_gpio;
> > +	if (!gpio_is_valid(gpio))
> > +		return 0;
> > +
> > +	/* Always set enable GPIO high. */
> > +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP=
872X EN");
> > +	if (ret) {
> > +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> > +		return ret;
> > +	}
>=20
> LP8720 device needs max 200usec for startup time.
> LP8725 also requires enable time about 30ms.
> Please use usleep_range() after EN pin control.
>=20
> > +
> > +	return 0;
> > +}
> > +
> >   static int lp872x_init_dvs(struct lp872x *lp)
> >   {
> >   	int ret, gpio;
> > @@ -763,14 +784,18 @@ static int lp872x_config(struct lp872x *lp)
> >   	int ret;
> >
> >   	if (!pdata || !pdata->update_config)
> > -		goto init_dvs;
> > +		goto init_dvs_enable;
> >
> >   	ret =3D lp872x_write_byte(lp, LP872X_GENERAL_CFG, pdata->general_con=
fig);
> >   	if (ret)
> >   		return ret;
> >
> > -init_dvs:
> > -	return lp872x_init_dvs(lp);
> > +init_dvs_enable:
> > +	ret =3D lp872x_init_dvs(lp);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return lp872x_init_enable(lp);
> >   }
>=20
> Logic should be enabled prior to DVS configuration. And please call=20
> lp872x_enable_hw() in _probe().
>=20
> >
> >   static struct regulator_init_data
> > @@ -875,6 +900,8 @@ static struct lp872x_platform_data
> >   	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
> >   	pdata->dvs->init_state =3D dvs_state ? DVS_HIGH : DVS_LOW;
> >
> > +	pdata->enable_gpio =3D of_get_named_gpio(np, "ti,enable-gpio", 0);
> > +
>=20
> Please replace "ti,enable-gpio" with "enable-gpios".
>=20
> Best regards,
> Milo


--=-Q2TcVy+v3XwCMHP0cvrX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWtO6oAAoJEIT9weqP7pUMczMP/0eWIu+E505wQDL+P515UP/R
I6DpflhKUH247X58E+Au+AIS5Onwbi7aqg1y+V5w0IVdwTIZ76+d2bR5RcBEaFw7
2/wWtUVCPGtNLhejqm/9DyiiXQOuXZfefEIVJauW2H6eoyvZssHCoa4JU9WeJu3u
Hik1m8QGo+rrTJaZLv8DAN2fiD/7ZeY1CJ5UKhERjKQmNCHqTi30p/ipn4E618Y5
7rJHYOYg0xOYiv/0hgBz9uqZqAxKPul8k9ugN+jbhkG3Jra1OIoh0n4GS5zn2W/S
IJnLo9qaQFE+ZwzAJmn4yyPNirpAX2+o1VeuyRySyGfmJWn2fCe5gS6DSHmsDd5N
kP9k1rhrzsPL0U33TUjR6mSYscYnyC3eVU1CYYXr/AFMa8NgRId5EZS/oicmG5gx
0CNjKQpIAD3CeAF+LQz1/xWY3Mj9UlB7I3jOx9nryJuHQlNb9FaIaJiJ3F8CNz69
am/jvHV6QwR3LoLisC2ChqS+OG3fobopGo9jHTKwtv7AjHjbz/7ed5g4zVKSEDom
MlIYj7jBRDR4nw/RyRARyyyTF0V82lXzYHMNytcMx6cD/7Z1ajjU1DWzvXGuUVta
fxcoGxB89gMWEBjMXymobf3ClFZRAqt7L8tH3LAFC3LE23IUpN7+iynEoIHfR7Gt
wGLzV9Oy2O0gWFPFfINc
=oabc
-----END PGP SIGNATURE-----

--=-Q2TcVy+v3XwCMHP0cvrX--
