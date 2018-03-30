From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Fri, 30 Mar 2018 12:37:44 +0200
Message-ID: <20180330103744.GA17404@amd>
References: <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329163716.GA20743@amd>
 <20180329164113.GR5700@atomide.com>
 <20180329184007.GA27688@amd>
 <20180329215612.GS5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329215612.GS5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-03-29 14:56:13, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180329 18:41]:
> > Thanks. I got call working including outgoing audio: in capture
> > settings, right->mic 1, Mic1 + Mic2 in alsamixer -> 100%. But I had
> > the other phone muted, so I don't yet know if such call would be of
> > usable quality.
>=20
> Great, good to hear that :)

I also got ofonod to work, with rather crazy hacks. But I now have
incoming/outgoing calls with GUI :-).

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+E3gACgkQMOfwapXb+vJqYgCdEIQDUYgSFcuFUK7WMjX3IWDe
USQAoJvcUkS9oFbmkLoI7NemXj00E1V2
=EJns
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
