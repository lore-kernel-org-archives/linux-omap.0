From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] ARM: dts: n900: Use linux input defines instead
 hardcoded constants
Date: Sun, 21 Feb 2016 17:28:38 +0100
Message-ID: <20160221162838.GA10626@earth>
References: <1456052808-14461-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456052808-14461-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Pavel Machel <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 21, 2016 at 12:06:48PM +0100, Pali Roh=E1r wrote:
> This makes DTS structure more readable.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n=
900.dts
> index e0443cd..85c29f3 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -65,45 +65,45 @@
>  		camera_lens_cover {
>  			label =3D "Camera Lens Cover";
>  			gpios =3D <&gpio4 14 GPIO_ACTIVE_LOW>; /* 110 */
> -			linux,input-type =3D <5>; /* EV_SW */
> -			linux,code =3D <0x09>; /* SW_CAMERA_LENS_COVER */
> +			linux,input-type =3D <EV_SW>;
> +			linux,code =3D <SW_CAMERA_LENS_COVER>;
>  			wakeup-source;
>  		};
> =20
>  		camera_focus {
>  			label =3D "Camera Focus";
>  			gpios =3D <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
> -			linux,code =3D <0x210>; /* KEY_CAMERA_FOCUS */
> +			linux,code =3D <KEY_CAMERA_FOCUS>;
>  			wakeup-source;
>  		};
> =20
>  		camera_capture {
>  			label =3D "Camera Capture";
>  			gpios =3D <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
> -			linux,code =3D <0xd4>; /* KEY_CAMERA */
> +			linux,code =3D <KEY_CAMERA>;
>  			wakeup-source;
>  		};
> =20
>  		lock_button {
>  			label =3D "Lock Button";
>  			gpios =3D <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
> -			linux,code =3D <0x98>; /* KEY_SCREENLOCK */
> +			linux,code =3D <KEY_SCREENLOCK>;
>  			wakeup-source;
>  		};
> =20
>  		keypad_slide {
>  			label =3D "Keypad Slide";
>  			gpios =3D <&gpio3 7 GPIO_ACTIVE_LOW>; /* 71 */
> -			linux,input-type =3D <5>; /* EV_SW */
> -			linux,code =3D <0x0a>; /* SW_KEYPAD_SLIDE */
> +			linux,input-type =3D <EV_SW>;
> +			linux,code =3D <SW_KEYPAD_SLIDE>;
>  			wakeup-source;
>  		};
> =20
>  		proximity_sensor {
>  			label =3D "Proximity Sensor";
>  			gpios =3D <&gpio3 25 GPIO_ACTIVE_HIGH>; /* 89 */
> -			linux,input-type =3D <5>; /* EV_SW */
> -			linux,code =3D <0x0b>; /* SW_FRONT_PROXIMITY */
> +			linux,input-type =3D <EV_SW>;
> +			linux,code =3D <SW_FRONT_PROXIMITY>;
>  		};
>  	};
> =20

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWyeWzAAoJENju1/PIO/qa9qgQAKaa9h6g3oJRG5uTrPLF58ng
0z6wNVK/ZvOwRt0g0zyRqDNyUsWqhllsM+xkvvdRFQQDHFxuVFt+IlkM1PbleA7n
KqGr1lRiyA9i9CUsr+LYMGTWque/wJAila2VlKwVKsXPznKhgi7L4YKpn9epWkUx
BD5pTgUsODPrzICn40TO8KPxhtlBAPgyRXT1oaUq+48rei+DmSZZDThhVj8ta5dK
8Oah/eAdojWfMObAdgqfY7hMkELWmucJj3eNO/xwEKOINjot9Sl9wLnoV+gvuAzc
tvsoToR22qr7VT9XfMCu8/5GlcfrzBg9Q6SUh+zwOtrZK5/f2eCqFDSDdvbFa+3y
+gdkUsMyHXphBYt8mbFkqcuL6WbVXOhBVLYRDbX1K66jhbN13AM+oc7d5JVS7PSI
iyDC4CddNxFRvS5HKbvhIe1mvqyLNxel/RXm5hyJbU33jV/yNwWpydhTRm7WKA4z
621ih/o6/fnVPhdruRA3Wu8e5jfEpmbdN/UX1F4iKD1vzP0PtyKEf2EtaL+InsKs
d1ok25uwJmDGs2JONgZeHPSVPYA+LQR+3H584BJ6fqLZtHpCe2HI7EVME2/Igco1
816FiD8K58IB/wCwmu4QE5tzE0YZ4sf0jTan1m8q7/bsNePQ9RdQgIS2e6QkwxJA
iL3dcE9RwjSCoyptna8u
=/Cq2
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
