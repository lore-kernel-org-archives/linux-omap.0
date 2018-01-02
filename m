From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] nokia N9: Add support for magnetometer and touchscreen
Date: Tue, 2 Jan 2018 18:27:20 +0100
Message-ID: <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
References: <20180102131722.GA20706@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjhokxxi55k52kkf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180102131722.GA20706@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--kjhokxxi55k52kkf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 02, 2018 at 02:17:22PM +0100, Pavel Machek wrote:
> This adds dts support for magnetometer and touchscreen on Nokia N9.

I think it makes sense to have this splitted.

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.=
dts
> index 39e35f8..57a6679 100644
> --- a/arch/arm/boot/dts/omap3-n9.dts
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -36,6 +57,22 @@
>  			};
>  		};
>  	};
> +
> +	touch@4b {

touchscreen@

> +		compatible =3D "atmel,maxtouch";
> +		reg =3D <0x4b>;
> +		interrupt-parent =3D <&gpio2>;
> +		interrupts =3D <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/

reset-gpios =3D <&gpio3 17 GPIO_ACTIVE_SOMETHING>;

> +		vdd-supply =3D <&vio>;
> +		avdd-supply =3D <&vaux1>;

Those two are not mentioned in the binding and not supported by the
driver as far as I can see?

> +	};
> +};

Touchscreen with the same settings is required for n950, so it
should be in the shared n950 + n9 file.

> +&i2c3 {
> +	ak8975@0f {
> +		compatible =3D "asahi-kasei,ak8975";
> +		reg =3D <0x0f>;
> +	};
>  };

Looking at the N9 board file this is missing a rotation matrix. This
is supported by the binding:

Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt

> =20
>  &isp {

-- Sebastian

--kjhokxxi55k52kkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpLwPQACgkQ2O7X88g7
+pqr0Q/+JdAZBW7gGAwKYMTEjWLx/SBatKx3/+CLy6boFFlLzi+ttm3y80hhTrJV
811TCRpf42qAUgz5Rc9jnFyS8kUkn9d7AeU8YYVXk+i1PcPJm0/XaQwRbbofPcbK
lzQWalZTjQO0TB8SKZ9fUkFz1IoqWMlKm1CpvrhlA+zRv5hyAOTzceMi9uq9hL5K
ectxGKuzvAMH8fHtlsYiFeWGbNslddfNBoNhzbkVTUk7N+iTHFe3ClvKkBzA5fRP
rR1ZDYMiEm9f/ZPd2Z52vC86hkvTH9wl5qjasoHqeX6/9jCsT+cZBIuLrTTZPTjm
HThiYr+jbs1+90A66t8apm17nIJVxVCPgQM2NVu75LQ2noNxL+JXqJGvCNrHHwU6
nJ0aWm5/gYCz7KF6MV8VBJuckR6s+jaShj9qPgdu76aQ0szOZGVIqLhDwdVOKf8B
h1rLPz+X/B25b+WmDLs6GvPuYBYolpKYFqrTJ8wqXCrXhB2qYIenmbyQss/KQ5ld
Xbn935ELPSt618SU41ZkLABqBYfDjQ8DZDVUb1qwhCmlEMBaKqTYdghc+xhPA/H5
fFNkKvJUi40oPQAldelWVVvadK++wImRgkvWFjNJvhioRppl6q5mdWbnm3jzGmqN
UO/cpqB9eRz2q1S91O+eQObQgvu/AjL2JRVwvzCe2QCq0HxrgSg=
=e6lp
-----END PGP SIGNATURE-----

--kjhokxxi55k52kkf--
