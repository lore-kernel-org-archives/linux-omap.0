From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH 9/9] leds: lm3632: Introduce the TI LM3632 driver
Date: Sun, 7 Oct 2018 15:46:30 +0200
Message-ID: <20181007134630.GA19323@amd>
References: <20180926130921.12329-1-dmurphy@ti.com>
 <20180926130921.12329-10-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180926130921.12329-10-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-09-26 08:09:21, Dan Murphy wrote:
> Add the dedicated TI LM3632 LED driver.  This
> LED device is capable of driving a backlight display.
>=20
> In addition to the backlight the device has control
> of a strobe and torch output.

Is this in some way similar to 3639? That also seems to include flash
and torch.

drivers/video/backlight/lm3639_bl.c
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu6DjYACgkQMOfwapXb+vKIfgCfaCzUEz9ZpoY/EfPeEOMPf4a9
KQAAnRlaLwr0s5K4pIDwlOTMD6W6XxRB
=upBE
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
