From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 2/9] dt-bindings: ti-lmu: Remove LM3697
Date: Wed, 3 Oct 2018 15:01:54 +0200
Message-ID: <20181003130154.GA20418@amd>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-3-dmurphy@ti.com>
 <20181002072827.GA19677@amd>
 <fef2c612-ac35-126e-669e-335fb3075f64@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <fef2c612-ac35-126e-669e-335fb3075f64@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-10-03 07:24:23, Dan Murphy wrote:
> Hello
>=20
> On 10/02/2018 02:28 AM, Pavel Machek wrote:
> > On Fri 2018-09-28 13:29:47, Dan Murphy wrote:
> >> Remove support for the LM3697 LED device
> >> from the ti-lmu.  The LM3697 will be supported
> >> via a stand alone LED driver.
> >>
> >> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> >=20
> > NAK, for reasons I explained before. Please add it to the patch so
> > that it does not get applied by mistake. Ouch and AFAICT Rob was not
> > happy with this either.
> >=20
> > Yes, you are creating new drivers, ok; but that does _not_ mean you
> > should create new binding.
>=20
> I am copying my comment here on the review of this original binding for
> records
>=20
> I found the review or at least the reference for the ti-lmu.txt binding.
>=20
> https://lore.kernel.org/patchwork/patch/764180/
>=20
> Does not appear that the binding was sent to the device tree mail list.
> (Maybe that email list did not exist in Feb 2017).

Quick google shows:

https://lwn.net/Articles/666023/

Now can we stop this nonsense? If there is a problem with the binding,
submit patches to fix the problem.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlu0vcIACgkQMOfwapXb+vIm0gCfZRhz/H99fwqzddIrtxEKxoiG
7HsAniIXwUKKaLfbQD7nCAE2yZtfsSmH
=MZOx
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
