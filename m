From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] nokia N9: Add support for magnetometer and touchscreen
Date: Wed, 3 Jan 2018 11:25:53 +0100
Message-ID: <20180103102553.GA28083@amd>
References: <20180102131722.GA20706@amd>
 <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-02 18:27:20, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, Jan 02, 2018 at 02:17:22PM +0100, Pavel Machek wrote:
> > This adds dts support for magnetometer and touchscreen on Nokia N9.
>=20
> I think it makes sense to have this splitted.

Creating more work for everyone for little gain? Meh.

> > diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n=
9.dts
> > index 39e35f8..57a6679 100644
> > --- a/arch/arm/boot/dts/omap3-n9.dts
> > +++ b/arch/arm/boot/dts/omap3-n9.dts
> > @@ -36,6 +57,22 @@
> >  			};
> >  		};
> >  	};
> > +
> > +	touch@4b {
>=20
> touchscreen@

Ok.

> > +		compatible =3D "atmel,maxtouch";
> > +		reg =3D <0x4b>;
> > +		interrupt-parent =3D <&gpio2>;
> > +		interrupts =3D <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/
>=20
> reset-gpios =3D <&gpio3 17 GPIO_ACTIVE_SOMETHING>;
>=20
> > +		vdd-supply =3D <&vio>;
> > +		avdd-supply =3D <&vaux1>;
>=20
> Those two are not mentioned in the binding and not supported by the
> driver as far as I can see?

Driver will need to be fixed, AFAICT :-(.

> Touchscreen with the same settings is required for n950, so it
> should be in the shared n950 + n9 file.

In future, settings will be different for n9/n950: calibration matrix
is different as panel is rotated in different way. Still it probably
makes sense to share. Ok.

> > +&i2c3 {
> > +	ak8975@0f {
> > +		compatible =3D "asahi-kasei,ak8975";
> > +		reg =3D <0x0f>;
> > +	};
> >  };
>=20
> Looking at the N9 board file this is missing a rotation matrix. This
> is supported by the binding:
>=20
> Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt

Do you have an idea how the rotation matrix should look like? I don't
currently have an userland software that could calibrate and test the
sensor, so I'd prefer to merge basic binding now and do calibration
later.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpMr7EACgkQMOfwapXb+vJp/gCfSEwsIp7eOvdP8HBddQ4DltMd
pfAAoId9OEf4iR9nAyvzgFZsD3nZtE8C
=CUSD
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
