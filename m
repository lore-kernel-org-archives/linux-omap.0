From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv4 06/10] mfd: ti-lmu: add PWM support
Date: Mon, 9 Apr 2018 17:46:49 +0200
Message-ID: <20180409154649.6zpqjsh4psblmlw7@earth.universe>
References: <20180330172414.26575-1-sebastian.reichel@collabora.co.uk>
 <20180330172414.26575-7-sebastian.reichel@collabora.co.uk>
 <e2b6ec34-c5b8-2ff1-ee05-4c41fc255295@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tpkq2w5powuflht6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e2b6ec34-c5b8-2ff1-ee05-4c41fc255295@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jingoo Han <jingoohan1@gmail.com>, Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--tpkq2w5powuflht6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 04, 2018 at 02:04:16PM -0500, Dan Murphy wrote:
> Sebastian
>=20
> -Milo
>=20
> On 03/30/2018 12:24 PM, Sebastian Reichel wrote:
> > This adds support to acquire the optional PWM channel,
> > that can be used by some of the LMU variants.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  drivers/mfd/ti-lmu.c       | 11 +++++++++++
> >  include/linux/mfd/ti-lmu.h |  3 +++
> >  2 files changed, 14 insertions(+)
> >=20
> > diff --git a/drivers/mfd/ti-lmu.c b/drivers/mfd/ti-lmu.c
> > index ce16c896879b..f43b8acc30e1 100644
> > --- a/drivers/mfd/ti-lmu.c
> > +++ b/drivers/mfd/ti-lmu.c
> > @@ -183,6 +183,17 @@ static int ti_lmu_probe(struct i2c_client *cl, con=
st struct i2c_device_id *id)
> >  		return ret;
> >  	}
> > =20
> > +	lmu->pwm =3D devm_pwm_get(dev, "lmu-backlight");
>=20
> Patch 9 of this series, or a derivative of it, should technically
> be before Patch 6 so that the binding is correct.  Otherwise the
> binding will not match the code.

I guess the binding update should be the first patch. I will change
this in the next revision.

-- Sebastian

> > +	if (IS_ERR(lmu->pwm)) {
> > +		ret =3D PTR_ERR(lmu->pwm);
> > +		if (ret !=3D -EINVAL) {
> > +			dev_err(dev, "Failed to get PWM: %d\n", ret);
> > +			return ret;
> > +		}
> > +
> > +		lmu->pwm =3D NULL;
> > +	}
> > +
> >  	ret =3D ti_lmu_enable_hw(lmu, id->driver_data);
> >  	if (ret)
> >  		return ret;
> > diff --git a/include/linux/mfd/ti-lmu.h b/include/linux/mfd/ti-lmu.h
> > index 1ef51ed36be5..246ab5145dff 100644
> > --- a/include/linux/mfd/ti-lmu.h
> > +++ b/include/linux/mfd/ti-lmu.h
> > @@ -17,6 +17,7 @@
> >  #include <linux/notifier.h>
> >  #include <linux/regmap.h>
> >  #include <linux/gpio/consumer.h>
> > +#include <linux/pwm.h>
> > =20
> >  /* Notifier event */
> >  #define LMU_EVENT_MONITOR_DONE		0x01
> > @@ -77,12 +78,14 @@ enum lm363x_regulator_id {
> >   * @dev:	Parent device pointer
> >   * @regmap:	Used for i2c communcation on accessing registers
> >   * @en_gpio:	GPIO for HWEN pin [Optional]
> > + * @pwm:	PWM for module [Optional]
> >   * @notifier:	Notifier for reporting hwmon event
> >   */
> >  struct ti_lmu {
> >  	struct device *dev;
> >  	struct regmap *regmap;
> >  	struct gpio_desc *en_gpio;
> > +	struct pwm_device *pwm;
> >  	struct blocking_notifier_head notifier;
> >  };
> >  #endif
> >=20
>=20
>=20
> --=20
> ------------------
> Dan Murphy

--tpkq2w5powuflht6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrLiuYACgkQ2O7X88g7
+posSRAAlli1Akbn8Lc5ct+xa3qxcis9mMFxlSTF9Qt9EL/D5vcMUK/7KVABjrV2
P3J16CF8JeIAhND2ewSniZ95ePuGdN/gzTo0D97oSJSRMrfe6v/6uFERT9rUMsvV
M43SFDh+O+fNlLP1hX+vachaZ6CeWybBNvdvrUjGcv9elchL+WroAp6KwJFAahHF
ikHBH3efaz5gT9dkSQF6Hp4HPIWD/IsHk8gyDW7IqXWFD6ailwbJTL8cAnN9XOTf
R9bjVN6utZXFSzjE+L7Z2YBzEN2/8Zn37mbJzqJBB2D+p+yU3Lcm7xn7648vBn4m
+xD0hxqNfkG5zYwL1d2MOgM2gdnog7OoXXGja6GInjXSStkbfQHcaC/rANHFFtvT
sCHpagu8wiN+uJMU/FeWH5ysfiUPA7b3lzig2nm8ZezYuoHN3qGvkxPf7GpXuEgS
bQRI0Y3uc/5/5NiHGCgsqz4mQVwwWm90vlWdXcZxqKNs84iWHSNr4ihI+hRMgvDT
hBJxRXXVy2iC1m90tRZPh/2gKwjsGe7FIKP90Kj8pmOlZZJ66/lcix1RhOebqE4R
cJaZUK/Jpf9VCZWoJdFKDEr3uPcxN/mBZHg74tx8M+3he0Vdqfo05buTN+ZOvPcE
lo/kltHm9rAGYKvuQugoFpiV8YvGm3ZYGCjIIcoilcDc5R/KJkQ=
=TF2c
-----END PGP SIGNATURE-----

--tpkq2w5powuflht6--
