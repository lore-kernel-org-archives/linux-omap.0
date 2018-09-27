From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 7/9] leds: lm3633: Introduce the lm3633 driver
Date: Thu, 27 Sep 2018 23:47:52 +0200
Message-ID: <20180927214752.GG17346@amd>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-8-dmurphy@ti.com>
 <20180926223612.GA32286@amd>
 <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7da01c06-f0f1-9022-54ec-f851d01f86ee@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Duplicate.
> >=20
> > Can we get some more sharing? One way would be to have struct with
> > all the constants (instead of #defines) use that...?
>=20
> I will look at the adding common constants to but they should be common a=
cross
> more then just 2 devices.  As you can see the LM3632 code is quite differ=
ent
> when you add in the flash/torch support.

LM3632 is indeed different, I see.

On the other hand, I'd really like to see the code shared, even if it
is just for 2 devices. (I believe that family is big enough that we'll
likely see more sharing in future).

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlutUAgACgkQMOfwapXb+vJLFQCeL4YKXfqkDl+7md+fsLrHBgwp
YOUAn1r4iDOnflyNQ8BWi2AF31Apg1XE
=0NJ2
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--
