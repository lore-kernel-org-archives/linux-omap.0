From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Fri, 18 Mar 2016 14:36:41 +0100
Message-ID: <20160318133641.GB16747@earth>
References: <56E68B71.2030202@ti.com>
 <20160316133319.GR8413@pali>
 <20160316144709.GA3389@earth>
 <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com>
 <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com>
 <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1458306829.11841.2.camel@Nokia-N900>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <ivo.g.dimitrov.75@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2016 at 03:13:49PM +0200, =D0=98=D0=B2=D0=B0=D0=B9=D0=BB=D0=
=BE =D0=94=D0=B8=D0=BC=D0=B8=D1=82=D1=80=D0=BE=D0=B2 wrote:
> On Fri Mar 18 12:33:14 2016 Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> > But enabling the pull via DT for the i2c2 works?
>=20
> No :(. I even migrated the driver to regmap - no gain. Maybe i2c
> bus is blocked by another device held in reset. The next thing I
> am going to try is to deassert reset/power gpios on all the
> devices on i2c-2 bus, to see if it will make any difference. Or if
> you have any other ideas, please share.

Have you tried the ideas from <20160317004917.GA6750@earth> (Date:
Thu, 17 Mar 2016 01:49:18 +0100)?

-- Sebastian

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW7ARpAAoJENju1/PIO/qaY5AP/iVGXLliQigSo9Ddk3VyVme8
gzHfE9zOKxKrUpn1yn9P82D5NkEKEYOAGeTWOhkGzQsWhEqoQel7k31j/2STCjIr
vXza1iwxpqcHAiFWKc1xr5ufUOh5EG4q7CG3mKErWWA8D5BLP9i/vw7uRChnKzd7
OfDh4ePzg6Z8J3sUkdAzTOG+Va1BDvS2SFl6kFp8L77P0qq18dExRtoJou3tbqHh
oj3HrR428HDuarjqpYkRRxi8tS9X1dFa3DiJYm5ghrLCTS4OH+w/k17qtfOeNNAj
f+Pxl6PJA3pgfwykz6XjEytiZ71nvzM3J8PgM3KO9TOP+P4bHziwQdcX5oTSsyxJ
YDh/R16ewDoXmLan/L61OD1kbAgSYPbdIKYaYQUzaN0kA3jRddlq5gkKRrH6Z9u+
SxlDxb+I4Q1wd9QMIAQWgSVF1/DvkHIcjuMXKh1SzSqMF4pbtZKJvicHvzLYkoAz
8d8Pq9k9EsvslJvT7JllAVKBhKxshoAyusodQIHTg5vYMR/tkmPT/dkEb6F3yHlm
k0yVsCfRr5uQ88F5Z35EkJ/ZGi2FZwzVFR6G/RZ/GCT4qzouOXUkYO1dbgbReG76
KEA8y2Bpoph2CEYddi3DTKqSmrNkEhu5SylwnV1Jrv83iLyEn+uafBMY5MLv0zmr
sJkyskeNM44y9b91P9YM
=nCVj
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
