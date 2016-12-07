From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] n900 device tree: cleanup
Date: Wed, 7 Dec 2016 04:10:48 +0100
Message-ID: <20161207031048.pi7j4dms5uuco3yf@earth>
References: <20161011075416.GA22453@amd>
 <20161011081243.GA24580@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uqstkrsbppxds7w7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161011081243.GA24580@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--uqstkrsbppxds7w7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

It looks like this fell through the cracks. Apart from inconsistent
patch subject:

Reviewed-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

On Tue, Oct 11, 2016 at 10:12:43AM +0200, Pavel Machek wrote:
> Fix GPIO comment to be consistent with rest of file and add comment what
> tpa6130 is.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>=20
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n=
900.dts
> index bfffd6c..ca9fe8c 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -47,7 +47,7 @@
>  		compatible =3D "gpio-leds";
>  		heartbeat {
>  			label =3D "debug::sleep";
> -			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* gpio162 */
> +			gpios =3D <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* 162 */
>  			linux,default-trigger =3D "default-on";
>  			pinctrl-names =3D "default";
>  			pinctrl-0 =3D <&debug_leds>;
> @@ -637,6 +637,7 @@
>  		reg =3D <0x55>;
>  	};
> =20
> +	/* Stereo headphone amplifier */
>  	tpa6130a2: tpa6130a2@60 {
>  		compatible =3D "ti,tpa6130a2";
>  		reg =3D <0x60>;

--uqstkrsbppxds7w7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhHfbgACgkQ2O7X88g7
+pqSoQ/6AnTjb+nRzDT3OoTlFnKQ7nLv3/CUHf5Inl9MhwAWSSK+aMrdvfi4J+01
UxOXa4rI2iXHzujfdyxKpozK9waHJmNIBE1L+N8cJ8p/RkTFZeubomuY8UOT9yeh
blhbl0qQzhlKXEHKdZ6kmmMuNI2XzzpjgXkzYX37sz2HVzLQnVmbtBZyk4S7yld9
56sq8inkfAHfMphpoucR2u4h/YOhazCqX/jEU4KzpI8GeHHWFCizjJBuKt0pMU6N
rUELRPdQAwiEIOrJqQx5ov2TgAzxAS7Y8fSRe2ymZ8h/7qRdtRf4rfOEagyWxBzv
dMq8g4QDEh0mb5NEcvb60FfBPVZ/E29Zxemxqad3t1MqU9AAjge9r6HpBGDknK9n
Sd3Qdh3K4jPk5vtVp1uEeM/EFFkGKHS9gJD/yMnmZC3l8ukY8K5SJnoRtA7bvU4O
jjNUrl4/FMVnG4QJW3F59xzY44vOUt68YVBH2RHWM9c4pRUubb2jXz1myZCSuNBQ
fa0piByxb+x5T7YcPMgqKO/grP3t0MEsOvNMuet0Dvo1laexsWdCxy1qK2jQsHCQ
e1c3ZIxG7fi5QdAi1g9s+leh8A2OWJlZmjGEFo0aYyBCHh6AmwOTw1V/CX2u09V9
MZc5MHlJGm2Xu0MhegLNcMI/0Y7tsy5emuLQdKTm7X3n1rltVWQ=
=0JtK
-----END PGP SIGNATURE-----

--uqstkrsbppxds7w7--
