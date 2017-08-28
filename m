From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH linux-next] fix compilation error in mach-omap2/display.c
Date: Mon, 28 Aug 2017 13:24:40 +0200
Message-ID: <20170828112439.47zuaxeemkqmjuof@earth>
References: <20170828093207.GA29080@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ba5wsf6s2eieo6ah"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170828093207.GA29080@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--ba5wsf6s2eieo6ah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 28, 2017 at 11:32:07AM +0200, Pavel Machek wrote:
> In linux-next 0828, I get
>=20
>   CC      arch/arm/mach-omap2/display.o
>   arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
>   arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first
>=20
> Fix it.
>=20
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

https://lkml.org/lkml/2017/8/23/346

-- Sebastian

--ba5wsf6s2eieo6ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmj/XQACgkQ2O7X88g7
+pqsJA//dThEU369aIYGaa1QHFXUlip0YH1iaBsLeBl4vanIlq3gAzH3j740LZQp
tfiTehs8XZA+0K3uV+7Y90VeL+JTNOdeGTgyFszua7JBCyCL6+SvoAZ9lIBDI6ZE
0hYZdk9NJVk6e6Dp0sqpCC91e2sJRqQjE2MVyT9K9U1M0HRGPNUAXwZ1Z5zUy9Us
Dte39Pw1fQtA3e3ifBEqnV3+AQ4idL7MtHsyLaxjd/gFlhkNjYtLVwIsyfFQU7W8
SrAK3kfudY9xNtgYu80PknF8LIvQncVxxLY77iN8876WnjkEn1pkz0e2H20Aae9N
/vVxTZrgb3gbrjf/aoUtR1Fxho8gucy+5YG/L8N2Db5dfLsCM59CN5+k60ux0dg8
u330PkLjjw1T7A8TydonPoVCBg8ac1r+RPBSfPEi+YrjqH7+RE8Zrze9QMeroRN+
VGr/pLhvmKJQvKUu4WWdtiENYffuZHxIHXtttLh0kbjB4zd2421vt3SjCFJpoaBa
phUxFuJfuNYTz5T1gNTSzu5Jdjj4RtbnODW9v/m5sP0WPyVF1t9my5v50Kn3AN3h
gF1c3xx/G7pO8ayHzsdHh7yT7wAJQTdNQLp6QPKbkiVVl3n9MDh4oeArjjS0gFn1
1q5Ou89HiEtU7SEbEwOuJhUGcoimaUpZrasHzv4rwtyDYQZnP3s=
=RgQ1
-----END PGP SIGNATURE-----

--ba5wsf6s2eieo6ah--
