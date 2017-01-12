From: Pavel Machek <pavel@ucw.cz>
Subject: Nokia N900: mixers changed between 4.6 and 4.10, no longer can use
 in-call speaker
Date: Thu, 12 Jan 2017 19:18:26 +0100
Message-ID: <20170112181826.GA28290@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
Cc: peter.ujfalusi@ti.com, jarkko.nikula@bitmer.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

In v4.10 (and probably v4.9, too) I can no longer use the in-call
speaker. I can no longer use the wired headset, either.

v4.4 (and probably v4.6) works ok.

Any ideas? Does wired headset / in-call speaker work for you?

"Mono" and "Mono DAC" options are still there.. but something else
changed, as alsamixer now shows way many more options (meaning they
are shorter?) and I get complains from alsactl:

alsactl: set_control:1328: failed to obtain info for control #49 (No
such file or directory)
=2E..
alsactl: set_control:1328: failed to obtain info for control #229 (No
such file or directory)



								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlh3yHIACgkQMOfwapXb+vKLhwCfUHuT2WvMo2Wi9XLkJIa4KIH2
ovgAn0V5wK72mV/NHwsaBuGsRfILMhFg
=WTeM
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
