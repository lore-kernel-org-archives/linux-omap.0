From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC PATCH v2 1/9] leds: add TI LMU backlight driver
Date: Wed, 3 Oct 2018 00:07:54 +0200
Message-ID: <20181002220754.GA20413@amd>
References: <20180928182954.25446-1-dmurphy@ti.com>
 <20180928182954.25446-2-dmurphy@ti.com>
 <20181002075629.GB19677@amd>
 <23dd6b46-cd16-ee67-3006-76a8dc67a7cb@ti.com>
 <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0be423a9-174c-60ce-0c67-7193c6af3063@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We have debated this over and over and now we have 3 different implemen=
tations
> > available we need to collude on which one we want to support.
> >=20
> > Jacek I defer to you and Pavel since you are both LED maintainers.
> >=20
> > I can support the dedicated LED drivers but I cannot support the TI LMU=
 only implementation.
>=20
> I uphold my previous opinion - please go ahead with moving the support
> for non-MFD devices from MFD subsystem to the LED subsystem. And yes -
> along with the bindings. This is semantically correct, and yet we don't
> have mainline users.
>=20
> Pavel - you will have to engage more people for your crusade to prevail.
> For now, to speed up the things, I am forced to ignore your NAK.
> So NAK to your NAK. Sorry.

No need to be sorry :-).

Lets ignore the code for now, as code can be changed easily.

Bindings are not something you or I maintain, so we don't have final
word there, and I have feeling this is not going to go past device
tree maintainers. [AFAICT: you can move binding in Documentation/ to
different place, that's not a problem; but creating a new binding when
old one exists is.]

If you and Dan feel that is okay, you are welcome to try to get the
patches past Rob, just please retain the NAK so that he remembers the
discussion, and so that it is clear that I don't like the changes.

I believe smart thing to do is to try to do that before working
further on the code, but of course, its all up to you :-).

Friends,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluz7DoACgkQMOfwapXb+vJnxQCdHpH3662vekGqNWYJsBMpPjLj
ZSIAoLpKy+Libu1zIKlStBseOo/ZzfZF
=CMwe
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
