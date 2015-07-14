From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH] i2c: omap: fix bus recovery setup
Date: Tue, 14 Jul 2015 14:12:07 +0200
Message-ID: <20150714121207.GI1517@katana>
References: <1436366127-24756-1-git-send-email-jlu@pengutronix.de>
 <20150714111004.GB1517@katana>
 <55A4FC19.4040709@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55A4FC19.4040709-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Jan Luebbe <jlu-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2015 at 03:10:01PM +0300, Grygorii Strashko wrote:
> Hi Wolfram,
>=20
> On 07/14/2015 02:10 PM, Wolfram Sang wrote:
> > On Wed, Jul 08, 2015 at 04:35:27PM +0200, Jan Luebbe wrote:
> >> At least on the AM335x, enabling OMAP_I2C_SYSTEST_ST_EN is not enough =
to
> >=20
> > Felipe: it seems you did not need this; is this AM335x specific?
>=20
> We need it (Felipe's reply can be delayed).

So, how did it work for him?

> It's not AM335x specific. TMODE has to be configured for all OMAP4+ SoCs =
too.

Okay, thanks for the stepping in!


--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVpPyXAAoJEBQN5MwUoCm2vZ4P/i0IgC1Gl2D470NbXV5toyII
Hze3HvGRHy7rmHg6327g31jlPKWiyy1Ln3d4HKG5Q4N1z61yA5zJX6KNw4fDy3B9
yAtegzHZoyvvW9mT5pZM7wa5UuvSSU5QJW3Zc3HANORyUOV06Mj5Jyixn7TxU2d7
olb8USvbU+wxLgrECd86FURgrs1r3mphIlteL5HNWpq6+pjIKFoInTS3iNw7ubUR
a00nA7UNY7k/RYq31e/Uno/Dx4cxZl/cAv/MJbkYuIXGLwpvKk1hZomquoikRXMz
LT33LDkUjaowNhVv26GaP7t1cEB3loTQl2uuNgQIgvzSHoyJMFWdZWYQYlrIOig1
iGgkeMduFoK3u3gDX5TFSVDvPrlob680XjiqZkgaHganQaZNn0Mu9MyMRmn6LqM6
j29Gncq3aFkF5XJMQwyusiUGzf5ViNeV7S8VpcVY7vaMHtCSRZ1pFKUr6Sf24SI3
SQfaSmRWmwPKdSzxZufnAZnEnv5Mibkba3qGikAC8RfZpRGOCzJ5ddeWSTZYuacY
YIQgh16LgP/9yFZuAno0JptgFgvlA875Kem35IbdtlytnMGEGk27KgdSswiaJ32V
bt2FSL+vmNMF2YPmFcFSOwyWJxkWC8q0YWzgNLfCa9gcESas9dbXF/YYoxSgRLqP
9KQrijU8N7w1QWjWqNbK
=5C4P
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
