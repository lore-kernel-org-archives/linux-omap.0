From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer can use in-call speaker
Date: Sun, 15 Jan 2017 01:00:54 +0100
Message-ID: <201701150100.54214@pali>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali> <20170114225614.GA25321@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5760031.zLcFHnr57N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170114225614.GA25321@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, alsa-devel@alsa-project.org, helen.koike@collabora.co.uk, lars@metafoo.de, broonie@kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart5760031.zLcFHnr57N
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 14 January 2017 23:56:15 Pavel Machek wrote:
> Hi!
>=20
> > > In v4.10 (and probably v4.9, too) I can no longer use the in-call
> > > speaker. I can no longer use the wired headset, either.
> > >=20
> > > v4.4 (and probably v4.6) works ok.
> > >=20
> > > Any ideas? Does wired headset / in-call speaker work for you?
> > >=20
> > > "Mono" and "Mono DAC" options are still there.. but something
> > > else changed, as alsamixer now shows way many more options
> > > (meaning they are shorter?) and I get complains from alsactl:
> > >=20
> > > alsactl: set_control:1328: failed to obtain info for control #49
> > > (No such file or directory)
> > > ...
> > > alsactl: set_control:1328: failed to obtain info for control #229
> > > (No such file or directory)
> >=20
> > Looks like there are not so much commits related to
> > sound/soc/omap/rx51.c Maybe it can be one of these twos?
> >=20
> > cb7e62256e99d285e415cf75db67558f0f8bb107
> > 6d2de5ab4328718302c54b20222c6b1a574c3fce
>=20
> Both are based on v4.7-rc1. v4.6 worked ok for me.
>=20
> Lets test mini-v4.7: in-call speaker works ok there, and no alsactl
> warnings.
>=20
> mini-v4.7+cb7e62256e99d285e415cf75db67558f0f8bb107+6d2de5ab4328718302
> c54b20222c6b1a574c3fce
>=20
> : something seems to be broken there already.
>=20
> alsactl: set_control:1464: Cannot write control '2:0:0:TPA6130A2
> Headphone Playback Volume:0' : Remote I/O error
>=20
> But in-call speakers and wired headset still seems to work.
>=20
> Lets test mini-v4.9... works ok. I don't even get the remote i/o
> error. Interesting.
>=20
> So regression seems to be between v4.9 and v4.10. Any ideas?

Interesting... seems there are no sound relevant changes after v4.9.

Looks like there are only three commits after v4.9 for sound/soc which=20
are built for Nokia N900:

e411b0b5eb9b65257a050eac333d181d6e00e2c6
e7aa450fe17890e59db7d3c2d8eff5b6b41fc531
63c3194b82530bd71fd49db84eb7ab656b8d404a

Maybe something not related to sound/soc could broke it?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart5760031.zLcFHnr57N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlh6u7YACgkQi/DJPQPkQ1JtMQCfXGAkgD4yq+3cvBQD/ABv5mgD
MS8AoI+wvzIYVBCACPiGKnix9hf+P6xD
=Gsmb
-----END PGP SIGNATURE-----

--nextPart5760031.zLcFHnr57N--
