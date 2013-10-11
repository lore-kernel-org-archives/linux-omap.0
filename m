From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapdss: Add new panel driver for Topolly td028ttec1
 LCD.
Date: Fri, 11 Oct 2013 11:17:36 +0300
Message-ID: <5257B420.10808@ti.com>
References: <1381352915-17219-1-git-send-email-marek@goldelico.com> <525662F5.3090600@ti.com> <7FAC77D4-5E1E-4B11-B067-3A8233C69240@goldelico.com> <52568B40.4040802@ti.com> <04AC7291-38E4-421B-979C-BF03D52E94BD@goldelico.com> <525699EF.6090803@ti.com> <52569CE8.5070201@metafoo.de> <A7739B52-2632-4DD8-924D-B657A6BFE3ED@goldelico.com> <5256F8DF.2020801@metafoo.de> <5257815F.5070803@ti.com> <5257A402.5030806@metafoo.de> <5570E6D7-4F66-40BE-A50C-6CCA8074BD83@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3iHUkkh7XsED0U0cL1BRWplQIvKg3E0Wm"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5570E6D7-4F66-40BE-A50C-6CCA8074BD83@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Belisko <marek@goldelico.com>, plagnioj@jcrosoft.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--3iHUkkh7XsED0U0cL1BRWplQIvKg3E0Wm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/10/13 10:42, Dr. H. Nikolaus Schaller wrote:

> I am not sure if there is a SPI driver for a McBSP port [1]? And to mak=
e that
> work (reliably) and tested it might need a lot of work for us. At least=
 I think
> such a change (e.g. setting up clock polarity etc.) is not done in some=
 minutes.
> And the only feedback we have from the panel is "does not work"/"works"=
=2E I.e.
> if we are not lucky that it works immediately we have no real means to =
debug.
>=20
> IMHO it also gives more flexibility to board designers to choose GPIOs =
instead
> of enforcing some SPI interface by the driver (and encapsulate this arg=
uable
> protocol in the driver). Maybe some board has 3 spare GPIOs but neither=

> McBSPs nor McSPIs available.

This has been an interesting thread, I've learnt a lot =3D).

I still think the panel driver should not handle this, but there should
be a separate spi bitbang driver for it.

I understand you're not enthusiastic going that way, as the current
version works for you. However, when using DT, we need to think how to
represent the hardware in the device tree data, and it has to be right
from the beginning.

That's why I won't allow representing this panel as having 4 gpios in
the DT data, because that is not correct. The panel has 3 pins. But
then, the panel does allow reading, which could be implemented using 4
gpios as you have done. This data should be in the spi-bitbang data, and
the panel should just use the standard SPI framework.

Using SPI framework does not mean you should use McBSP or McSPI. It's up
to you how the 3-wire SPI is implemented on the SoC side, the panel
would just work in all the cases.

 Tomi



--3iHUkkh7XsED0U0cL1BRWplQIvKg3E0Wm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSV7QgAAoJEPo9qoy8lh71aBQP/Rk3tQ+GsVBciDg+c3R6nkPf
5NR+rWAkYxOM8I9fi1FjThjeoQ4OQ/Av1xEApQR5+CgQx2GzlF6c4LFxwXsV97yN
Rag9DqD/F+0esbRqQ7g0ZbEj3V12DKCT7X3Zoidch3p94XSYzzZGJr+ekQmff4L7
xUABb+SrfIdvS+DIjJ7ZmIUEoFulCkz0rU8av8Mu0WLkwCZorgpn2Tw7dh/p/YTw
knKg5zg5EOvt7dA7jSXqZIWqniQxT0+NPWFdXfe1VCL+ypvFIotijTqG0MKo89vr
C2nGnmTsMQCn9bI3+vS7f6csdT0ir0XgNRVTi6d/i1mr41eU4HCiMzj5H8Y4TTge
uwG25nRFGRosOW3phfYx3v35bUvpenthhSBYibQO1PgIVemrioJwUWFCdeZ/ycpU
unzARlR7r54MwVwq9SS+pSAYj7BcfXWGpuGj0Way0Sj/6Z21tMVhLtJ/+0Qb8Uz9
DjMKfWj3gR9wuA68skBm6pi4xb7lX+3R7s/UsIo3bIvOldmAFqX6Zk7UZVAY+ONm
SgfmPNzAsKguymFmQ7FBPgv0YLd9VNVU4E8vTWw4mHlTvx7NwutzQ5uDSobPN+jM
kBJo2Ck+E+eAv6flHkYD1xEmrxzYdVuq38r3ScYOrTFUH3JelxEkrgya4Q1gUwmj
QIDcxOZivYX3P/L2vHP2
=w+kN
-----END PGP SIGNATURE-----

--3iHUkkh7XsED0U0cL1BRWplQIvKg3E0Wm--
