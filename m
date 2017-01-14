From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
Date: Sat, 14 Jan 2017 23:56:15 +0100
Message-ID: <20170114225614.GA25321@amd>
References: <20170112181826.GA28290@amd>
 <201701121934.19810@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201701121934.19810@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, alsa-devel@alsa-project.org, helen.koike@collabora.co.uk, lars@metafoo.de, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > In v4.10 (and probably v4.9, too) I can no longer use the in-call
> > speaker. I can no longer use the wired headset, either.
> >=20
> > v4.4 (and probably v4.6) works ok.
> >=20
> > Any ideas? Does wired headset / in-call speaker work for you?
> >=20
> > "Mono" and "Mono DAC" options are still there.. but something else
> > changed, as alsamixer now shows way many more options (meaning they
> > are shorter?) and I get complains from alsactl:
> >=20
> > alsactl: set_control:1328: failed to obtain info for control #49 (No
> > such file or directory)
> > ...
> > alsactl: set_control:1328: failed to obtain info for control #229 (No
> > such file or directory)
>=20
> Looks like there are not so much commits related to=20
> sound/soc/omap/rx51.c Maybe it can be one of these twos?
>=20
> cb7e62256e99d285e415cf75db67558f0f8bb107
> 6d2de5ab4328718302c54b20222c6b1a574c3fce

Both are based on v4.7-rc1. v4.6 worked ok for me.

Lets test mini-v4.7: in-call speaker works ok there, and no alsactl
warnings.

mini-v4.7+cb7e62256e99d285e415cf75db67558f0f8bb107+6d2de5ab4328718302c54b20=
222c6b1a574c3fce
: something seems to be broken there already.

alsactl: set_control:1464: Cannot write control '2:0:0:TPA6130A2
Headphone Playback Volume:0' : Remote I/O error

But in-call speakers and wired headset still seems to work.

Lets test mini-v4.9... works ok. I don't even get the remote i/o
error. Interesting.

So regression seems to be between v4.9 and v4.10. Any ideas?

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh6rI4ACgkQMOfwapXb+vJ9OQCdG8C3fMoWzWYXXVDmXcI4HlLI
e1gAoKpgyETNlh+LOGHxNsJqvNlWGv/I
=2QF9
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
