From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix cleanup regression
Date: Fri, 31 Jul 2015 12:39:54 +0200
Message-ID: <20150731103954.GC1522@katana>
References: <1436875847-18700-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1436875847-18700-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2015 at 02:10:47PM +0200, Wolfram Sang wrote:
> Patch "i2c: omap: abolish variable name confusion" triggered a
> coccinelle warning which we fix here:
>=20
> drivers/i2c/busses/i2c-omap.c:1333:5-24: pm_runtime_get_sync returns < 0 =
as error. Unecessary IS_ERR_VALUE at line 1334
>=20
> Signed-off-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>

Applied to for-next, thanks!


--mvpLiMfbWzRoNl4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVu1B6AAoJEBQN5MwUoCm2iZUP/094tCwzCAW/itUkzim7IW0X
IbRiY/7e5zoIQ32mL1H7zis5sNCJoxov2gLM7MltZHkxIgJMeoa50j0g+mUm1J3y
jluodBL9eE0XlNdscPhYR4bGPgk/QnFCkh8h2eu0Bylg16gdB3+1Rk1GuiaCj4og
QQ+zzZujXn0CRnqwkU1TYIkYgbmwaeA8PY1Ffte2iJiuiYAd4KmaEnw8Y8xVmcL8
Tve35bMLu9T8rJF0AyCrpnk3SaeNPK7VQfxCslPRbjGu3wtg0wh2CriyRZW0oQY/
ZigWMzfw5qJSpKmMlFhOeZyJAmhieBZcgNPw4yZXtsp4agv4CeMJAVxYbAoZ1Lds
OCT7m8o2Rw1DpSjk2inMeSaPBf99XONQqmFo4wTUvSPOvo/NQaPkSN1eUAZTi+Iv
REsc3TOGBfgICAK1hmyg6uoNqVSXnYu9KMIxOfA3S0nVIiEdx6tXsB4Z6KRA9AHu
oQkFhmz80OWnmghWCvnWwOOLI7WyoW8BVjvLPRjimOE6IsAetE6N4sIaKce0CbWs
GZaLXXCplqa/ruakgxfnsdlha7vWPabnOQZf9iy+Jp1MCgo5f6i/2fcHH2P9fsbt
D9jYdPIRC854NkZt7pgaaEvYp70SIHNe29yW/50kYY1APSn/fUQZ+87HbqqzGH2m
ttKUkYL+AyNd+9SOyy/3
=cAXC
-----END PGP SIGNATURE-----

--mvpLiMfbWzRoNl4x--
