From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: add dev_dbg() message for
 effective period and duty cycle
Date: Tue, 2 Feb 2016 17:23:30 +0100
Message-ID: <20160202162330.GA4918@ulmo>
References: <1454128014-22866-1-git-send-email-drivshin.allworx@gmail.com>
 <1454128014-22866-5-git-send-email-drivshin.allworx@gmail.com>
 <CAA3gFWvSsctXtds6_SEtYY1yUdWJDR1XjznGS6qjdrGW5Dbw=A@mail.gmail.com>
 <20160201132228.2634b72e.drivshin.allworx@gmail.com>
 <20160201185952.GN19432@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160201185952.GN19432@atomide.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "David Rivshin (Allworx)" <drivshin.allworx@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Erickson <marathon96@gmail.com>, NeilBrown <neilb@suse.de>, Joachim Eastwood <manabian@gmail.com>
List-Id: linux-omap@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 01, 2016 at 10:59:52AM -0800, Tony Lindgren wrote:
> Hi,
>=20
> * David Rivshin (Allworx) <drivshin.allworx@gmail.com> [160201 10:23]:
> > On Sat, 30 Jan 2016 15:51:06 +0100
> > Neil Armstrong <narmstrong@baylibre.com> wrote:
> >=20
> > > 2016-01-30 5:26 GMT+01:00 David Rivshin (Allworx)
> > > <drivshin.allworx@gmail.com>:
> > > > From: David Rivshin <drivshin@allworx.com>
> > > >
> > > > After going through the math and constraints checking to compute
> > > > load and match values, it is helpful to know what the resultant
> > > > period and duty cycle are.
> > > >
> > > > Signed-off-by: David Rivshin <drivshin@allworx.com>
> > > > ---
> > > >
> > > > I found this helpful while testing the other changes, so I included
> > > > it in case it may be of use to someone in the future. I would have
> > > > no issues with dropping this if it's not considered worthwhile. =20
> > >=20
> > > It's useful, but converting it as a sysfs attribute would be great !
> >=20
> > Hrm, yes that is an interesting thought. I imagine that many PWM=20
> > devices have similar constraints, so perhaps that would be best=20
> > handled generically in the pwm core? Maybe as new optional get_*()=20
> > ops, a modification to the config() op to add output params, or just=20
> > updating new fields in the struct pwm directly?
>=20
> Yeah for /sys entry it should be Linux generic. The other option
> is to use debugfs for driver specific things.

Let's go with debugfs for this one. This is used for diagnostic purposes
and not typically needed when configuring a PWM. While other drivers may
compute similar hardware-specific values, there's nothing generic to
them. The period and duty cycle are the generic input values and those
are already exposed via sysfs.

Thierry

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWsNf+AAoJEN0jrNd/PrOhFAAP/1coNlmdgICGW0xChC+uhJEy
ZrmBYcNBxL/h71L0gkXjEczK72JC4OqH9cM/yv5zC8mAsoeoJZjUsXGo9VNFxODX
OsYr/qX/uSgSblolN/vvbeltBq8x3Ofna4/ltRw9WgL2CyRbqQ5qySQ8BypaxEUo
XazoV5eTjMfpmSOdvF/3tqo5P9p/63hkMcvf3b4WCNI/JlW3oEG8Mwnpxwuv1bl9
YMxmpQa5xR6Zsux1i3xn6E4ZHVmjEKI1FkOJeVmircl155TTVaU2L/VF8ODNcS3U
puIU3jInkq3Yelv66vrLNzPsL+sKgun/j10JEHI7z5Jy2BQVYpBUwK6qiX28WPhq
PQqZYx/HTeCighustMj9gFNMPRAHaMLkMmo0mwHUawXMgBo7UKMXC5ATMXWPPuPj
ElaqVK04/1S/ULb6KE8FeUuEHrh13yotHY5ETlhywStwxAsvBpn5kbSduHlXuKew
iunBQDuOR673Qaf2q1rkJjgFvZOaFeFI5xbuitYiA1EL7bOMcwkIFODQdBqwCKGg
QCGDtYO58QqC5Gzi/0baJen8N+FBsMfYETNPqFAxuqjXse8SSgyx/zi9D4qwA7L0
vrZyM5yd+1MK8y2KzYWifyHfFOw38RRBP5IGShUHeNTYrDbPsZtg08sgOVvOeYTQ
TjuXxwHLe0bQXg7qXXyu
=8QlR
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
