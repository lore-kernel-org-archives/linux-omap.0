From: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
Subject: Re: [PATCH v2 2/4] regulator: lp872x: Add enable GPIO pin support
Date: Fri, 12 Feb 2016 19:25:32 +0100
Message-ID: <1455301532.2760.1.camel@collins>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
	 <1454697741-8687-3-git-send-email-contact@paulk.fr>
	 <56BD23ED.8010207@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-qIiZQ1wLbQ0vxd7Wo8QE"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56BD23ED.8010207-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kim, Milo" <milo.kim-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--=-qIiZQ1wLbQ0vxd7Wo8QE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Le vendredi 12 f=C3=A9vrier 2016 =C3=A0 09:14 +0900, Kim, Milo a =C3=A9crit=
 :
> Thanks for the patch. Please see my comments below.

Thanks for the review!

> On 2/6/2016 3:42 AM, Paul Kocialkowski wrote:
> > LP872x regulators are made active via the EN pin, which might be hooked=
 to a
> > GPIO. This adds support for driving the GPIO high when the driver is in=
 use.
> >
> > Signed-off-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> > ---
> >   .../devicetree/bindings/regulator/lp872x.txt       |  1 +
> >   drivers/regulator/lp872x.c                         | 34 +++++++++++++=
+++++++++
> >   include/linux/regulator/lp872x.h                   |  5 ++++
> >   3 files changed, 40 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/lp872x.txt b/D=
ocumentation/devicetree/bindings/regulator/lp872x.txt
> > index 7818318..ca58a68 100644
> > --- a/Documentation/devicetree/bindings/regulator/lp872x.txt
> > +++ b/Documentation/devicetree/bindings/regulator/lp872x.txt
> > @@ -28,6 +28,7 @@ Optional properties:
> >     - ti,dvs-gpio: GPIO specifier for external DVS pin control of LP872=
x devices.
> >     - ti,dvs-vsel: DVS selector. 0 =3D SEL_V1, 1 =3D SEL_V2.
> >     - ti,dvs-state: initial DVS pin state. 0 =3D DVS_LOW, 1 =3D DVS_HIG=
H.
> > +  - enable-gpios: GPIO specifier for EN pin control of LP872x devices.
> >
> >     Sub nodes for regulator_init_data
> >       LP8720 has maximum 6 nodes. (child name: ldo1 ~ 5 and buck)
> > diff --git a/drivers/regulator/lp872x.c b/drivers/regulator/lp872x.c
> > index 21c49d8..3899211 100644
> > --- a/drivers/regulator/lp872x.c
> > +++ b/drivers/regulator/lp872x.c
> > @@ -15,6 +15,7 @@
> >   #include <linux/regmap.h>
> >   #include <linux/err.h>
> >   #include <linux/gpio.h>
> > +#include <linux/delay.h>
> >   #include <linux/regulator/lp872x.h>
> >   #include <linux/regulator/driver.h>
> >   #include <linux/platform_device.h>
> > @@ -757,6 +758,33 @@ set_default_dvs_mode:
> >   				default_dvs_mode[lp->chipid]);
> >   }
> >
> > +static int lp872x_hw_enable(struct lp872x *lp)
> > +{
> > +	int ret, gpio;
> > +
> > +	if (!lp->pdata)
> > +		return -EINVAL;
> > +
> > +	gpio =3D lp->pdata->enable_gpio;
> > +	if (!gpio_is_valid(gpio))
> > +		return 0;
>=20
> It seems gpio is always 0 when it starts from DT. 'enable_gpio' is=20
> updated in lp872x_config() but lp872x_hw_enable() is called first.

Actually, enable_gpio is updated in lp872x_populate_pdata_from_dt.

> > +
> > +	/* Always set enable GPIO high. */
> > +	ret =3D devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP=
872X EN");
> > +	if (ret) {
> > +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	/* Each chip has a different enable delay. */
> > +	if (lp->chipid =3D=3D LP8720)
> > +		usleep_range(LP8720_ENABLE_DELAY, 1.5 * LP8720_ENABLE_DELAY);
> > +	else
> > +		usleep_range(LP8725_ENABLE_DELAY, 1.5 * LP8725_ENABLE_DELAY);
> > +
> > +	return 0;
> > +}
> > +
> >   static int lp872x_config(struct lp872x *lp)
> >   {
> >   	struct lp872x_platform_data *pdata =3D lp->pdata;
> > @@ -875,6 +903,8 @@ static struct lp872x_platform_data
> >   	of_property_read_u8(np, "ti,dvs-state", &dvs_state);
> >   	pdata->dvs->init_state =3D dvs_state ? DVS_HIGH : DVS_LOW;
> >
> > +	pdata->enable_gpio =3D of_get_named_gpio(np, "enable-gpios", 0);
>=20
> Please move this code to lp872x_populate_pdata_from_dt().

This already adds it in lp872x_populate_pdata_from_dt (see the context
around the insertion).

I don't know why the diff makes it seem like it's added in
lp872x_config. It's really not.

> lp872x_hw_enable() is called prior to lp872x_config(), so enable_gpio=20
> should be set on parsing the DT properties.

Of course.

> > +
> >   	if (of_get_child_count(np) =3D=3D 0)
> >   		goto out;
> >
> > @@ -948,6 +978,10 @@ static int lp872x_probe(struct i2c_client *cl, con=
st struct i2c_device_id *id)
> >   	lp->chipid =3D id->driver_data;
> >   	i2c_set_clientdata(cl, lp);
> >
> > +	ret =3D lp872x_hw_enable(lp);
> > +	if (ret)
> > +		return ret;
> > +
> >   	ret =3D lp872x_config(lp);
> >   	if (ret)
> >   		return ret;
> > diff --git a/include/linux/regulator/lp872x.h b/include/linux/regulator=
/lp872x.h
> > index 132e05c..6029279 100644
> > --- a/include/linux/regulator/lp872x.h
> > +++ b/include/linux/regulator/lp872x.h
> > @@ -18,6 +18,9 @@
> >
> >   #define LP872X_MAX_REGULATORS		9
> >
> > +#define LP8720_ENABLE_DELAY		200
> > +#define LP8725_ENABLE_DELAY		30000
> > +
> >   enum lp872x_regulator_id {
> >   	LP8720_ID_BASE,
> >   	LP8720_ID_LDO1 =3D LP8720_ID_BASE,
> > @@ -79,12 +82,14 @@ struct lp872x_regulator_data {
> >    * @update_config     : if LP872X_GENERAL_CFG register is updated, se=
t true
> >    * @regulator_data    : platform regulator id and init data
> >    * @dvs               : dvs data for buck voltage control
> > + * @enable_gpio       : gpio pin number for enable control
> >    */
> >   struct lp872x_platform_data {
> >   	u8 general_config;
> >   	bool update_config;
> >   	struct lp872x_regulator_data regulator_data[LP872X_MAX_REGULATORS];
> >   	struct lp872x_dvs *dvs;
> > +	int enable_gpio;
> >   };
> >
> >   #endif
> >
>=20
> Best regards,
> Milo


--=-qIiZQ1wLbQ0vxd7Wo8QE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWviOcAAoJEIT9weqP7pUMUNMP/2BqQOwV4Inh45cpgD6aRQe7
5RkLsjQHZZDUvgjH/BK+hBAR3vOg67rgXGCcbTpTRAsAj75FZKgeq6pYbyGCqPWJ
YN1jj0JlALxlYvX5tj1TIXcLtwZ8T1Y/+RLv0kSVPyAeiojH59YCdpswl9xoUlRt
8+1D7yjukUrT39h+r9iUA/q8bhKnTi/o8tTYshdf6TvYCUUfqb0QF6y4DY13Axtn
GzpghnwSxz4Xgb3n7V+LWOuaHNxnVpoHjqvHbYwgB975nCKTpbptldB12s0TyjTd
R+EePtgQpKAGJMbVuGvt+LO8CKbhH8cnvzWCdZMeVc9g2wVlNsNpF2MI6UMIdDXd
wGr2sIl+lWZEi3FPRPa8RjIeZLPOFs/DiGp2+l3dY0IcdPw+gPlsT6CK0eOTTSUq
GfuHhx4F8VorOGBcCag4LDUX6T8lHDw6f6Datkszje4+lmD3Hh8L/gpUnGulu9vz
uwI6/VgpDlPPI9nqPK1tNtSkNFvI3eX5sac+LHzIzAwz4OoXQFDtgLMMSUCIdPoN
j5gguEEhcD6AZ3nsDeT/1itvSriZcuU+1G2coc8hSOBMFLCgQFuMeHMTnWTJxQ7E
gqHQRCmZCVm9/4/wAD3IxPf4p9aNF+G0DJf8wtHWEGJb4a2czlpoXwRCkeyUuCQq
N+KZ4tcn1VYQUDTONoed
=qmiU
-----END PGP SIGNATURE-----

--=-qIiZQ1wLbQ0vxd7Wo8QE--

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
