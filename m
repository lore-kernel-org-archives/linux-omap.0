From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] Nokia N9: add support for up/down keys in the dts
Date: Tue, 2 Jan 2018 20:42:36 +0100
Message-ID: <20180102194236.ahrhkvnefre2l6gf@earth.universe>
References: <20180102125948.GA20051@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w3msx4wwaosk7qlr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180102125948.GA20051@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, clayton@craftyguy.net, martijn@brixit.nl, sakari.ailus@linux.intel.com, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--w3msx4wwaosk7qlr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 02, 2018 at 01:59:48PM +0100, Pavel Machek wrote:
>=20
> This adds support for volume up/down keys in the dts.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>=20
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.=
dts
> index 39e35f8..57a6679 100644
> --- a/arch/arm/boot/dts/omap3-n9.dts
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -11,9 +11,10 @@
>  /dts-v1/;
> =20
>  #include "omap3-n950-n9.dtsi"
> +#include <dt-bindings/input/input.h>
> =20
>  / {
>  	model =3D "Nokia N9";
>  	compatible =3D "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
>  };
> =20
> @@ -72,3 +133,9 @@
>  	st,max-limit-y =3D <46>;
>  	st,max-limit-z =3D <46>;
>  };
> +
> +&twl_keypad {
> +	linux,keymap =3D < MATRIX_KEY(6, 8, KEY_VOLUMEUP)
> +			 MATRIX_KEY(7, 8, KEY_VOLUMEDOWN)
> +			 >;
> +};
>=20
>=20
> --=20
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html



--w3msx4wwaosk7qlr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlpL4KkACgkQ2O7X88g7
+prlRQ//Y9YXJEp63Ilr687kIxLZrSNSzZD+Brpm2AXN4mjf1YnUqYvzBqwH9oTT
H29yvC6zrMqc2DMzC/A1jSrj9C0eN7bB3yV8Pc9wFNmW0K5eBapM8MHIDUrQRpEx
tlxYQRG0stGpiECho6Jto6Wfvz4kPz77/UW3Wg5+Rr03q8Q4YSs7FHnPEW8Dv6ev
X2gSGkLhzdx54neNzQQhbCGDGXarlyKO0Qf1GE6O+hGBKbGj3+Pg3tWo4OE4bxVM
bCJysflGti1ZrvPrdBnIfH+hq2yTKDNMvxlQ3VlH4syW9PoCiPujNvsO4igyr3xh
YecAS/JRMm33NOCi8TeN6anSKCCBhht2mlUwcEIMBCQP2f8DQJFm8gTx3YLQymcx
FGKYyLKgkot5ILDkf7FWvRiHuxaU8VircVF/KHTkyMrXLgl1oHlTUv2NQ7n7ieNf
9ALsmQ3WdpySh7SqXgcc5314iI+PgPJjnAKMrsMVvtiqQ2GTkH+3C4Pv8Wngh8Gx
4UsH/2/wj+q9UvpdB8vTj0IFts/1bTcuHcDzBUIOy0duvAkDCV14OLdVX0gXuvrX
7HvPT+odS2uk4Wz/8XjNOuhnUTKW5xjSLD3BrUYV9cQLJF08WNyCKFMQEkuvkExz
lSw5h5Mk20anRku9+apEVy0F/cbzsRpUNww0XzH7ETGPvrf8gbY=
=mnzd
-----END PGP SIGNATURE-----

--w3msx4wwaosk7qlr--
