From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfc] leds: add TI LMU backlight driver
Date: Thu, 30 Aug 2018 22:18:25 +0200
Message-ID: <20180830201825.GA1936@amd>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Here's preview of driver for TI LMU. It controls LEDs on Droid 4
> > smartphone, including keyboard and screen backlights.
> >=20
> > This adds backlight support for the following TI LMU
> > chips: LM3532, LM3631, LM3632, LM3633, LM3695 and LM3697.
> >=20
> > Signed-off-by: Milo Kim <milo.kim@ti.com>
> > [add LED subsystem support for keyboard backlight and rework DT
> > binding according to Rob Herrings feedback]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > [remove backlight subsystem support for now]
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > ---
> >=20
> > Does it looks mostly reasonable? I guess it will need some
> > s/BACKLIGHT/LEDS/ , and I'll need to remove my debugging hacks.
> >=20
> > I'd prefer this to be LED driver, first; I'll need to figure out what
> > to do with backlight. I guess something like existing "backlight"
> > trigger should do the trick.
> >=20
>=20
> I looked at this driver from Milo before submitting a specific LM3697 dri=
ver.

Aha. I did not realize that was for same hardware... I should have
cc-ed you, I guess.

> I do not like this driver.
> I don't like that it smashes numerous devices into some structure with va=
rying register maps.
>

Can you elaborate? The chips are similar enough that single driver
makes sense, and we certainly want to maintain one driver, not 6
drivers differing only in .. what exactly?

> Not only that but it appears that you just pulled this driver from a repo=
 and posted it without clean up.
>=20

a) No I did not, feel free to generate a diff.

b) Even if I did, why would that be a problem?

> If the devices share register maps and can be added to families I would p=
refer to do it that way.
>=20
> So if the LM3695 and LM3697 share the same features and register map they=
 should be one driver
> The LM363x series may be able to be a different driver.

Well all 6 chips this driver supports seem to be similar enough, so
that single driver makes sense.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluIUREACgkQMOfwapXb+vL8KwCeMpKoYEObj7fqpBoF7bsieAw+
6toAoKmI0gfwYf2ktMx4tcV6VR+DMkRw
=rXfV
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
