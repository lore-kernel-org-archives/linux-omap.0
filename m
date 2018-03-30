From: Pavel Machek <pavel@ucw.cz>
Subject: Re: omap4-droid4: voice call support was Re: [PATCHv5,5/5] ARM: dts:
 omap4-droid4: add soundcard
Date: Sat, 31 Mar 2018 00:31:52 +0200
Message-ID: <20180330223152.GB3389@amd>
References: <20180326155828.ttnduivadob4iqmd@earth.universe>
 <20180327121441.GH29239@sirena.org.uk>
 <20180327222237.wcx2aqznvdrvbaa5@earth.universe>
 <20180328022910.GM29239@sirena.org.uk>
 <20180328140219.f6667up5evrrafkv@earth.universe>
 <20180329014507.GM5700@atomide.com>
 <20180329133613.khldv72w3zj63vsk@earth.universe>
 <20180329135904.GN5700@atomide.com>
 <20180329154600.qhels5fqzzg364gj@earth.universe>
 <20180329160611.GP5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329160611.GP5700@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>
List-Id: linux-omap@vger.kernel.org


--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Your override kills most settings from alsamixer. You can try to
> > just override CPCAP_REG_VAUDIOC, CPCAP_REG_CC and CPCAP_REG_CDI
> > and setup everything else with alsamixer.
>=20
> OK I'll try to narrow it down and play with the mic settings
> tonight or over the weekend.

No, just the three+alsamixer will not work. You also need to

814: |=3D 400

824: |=3D 400 CPCAP_REG_RXCOA : CPCAP_BIT_PGA_CDC_EN
81c: |=3D 006 CPCAP_REG_RXOA : CPCAP_BIT_A2_LDSP_L_EN / CPCAP_BIT_A2_LDSP_R=
_EN

You can set those using sudo aplay -D plughw:CARD=3DAudio,DEV=3D1
/usr/share/sounds/alsa/Front_Left.wav ... but that will do bad stuff
to the rest of the bits.

You might find this useful:

 watch 'cat /sys/kernel/debug/regmap/spi0.0/registers | grep "0800\|0804\|0=
808\|0814\|0818\|081c\|0820\|0824\|0828"'

Good luck, I need some sleep,

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlq+utgACgkQMOfwapXb+vKdRwCgk42W9KTV2310PKUMvFqHFiRD
sz0AoI4KM0o0hvQUfK+kuSG80yd5ldHp
=498e
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
