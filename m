From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Nokia N900 - audio TPA6130A2 problems
Date: Sat, 25 Jul 2015 12:28:27 +0200
Message-ID: <201507251228.27128@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6073105.sSrUNI8SQX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.orglinux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart6073105.sSrUNI8SQX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

sometimes after rebooting Nokia N900 initializing alsa audio fails.
Here output from dmesg log when it happen:

[    6.925140] tpa6130a2 2-0060: Write failed
[    6.929534] tpa6130a2 2-0060: Failed to initialize chip
[    6.935272] tpa6130a2: probe of 2-0060 failed with error -121
[    7.624237] rx51-audio n900-audio: Failed to add TPA6130A2 controls
[    7.635101] rx51-audio n900-audio: ASoC: failed to init TLV320AIC34: -19
[    7.645874] rx51-audio n900-audio: ASoC: failed to instantiate card -19
[    7.665740] rx51-audio n900-audio: snd_soc_register_card failed (-19)
[    8.063049] ALSA device list:
[    8.070343]   No soundcards found.

Any idea what to do?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6073105.sSrUNI8SQX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWzZMsACgkQi/DJPQPkQ1IaLwCfUgAyfPNi29I4t4+Z2CUN8jyx
OwcAoLiIjb9j9zeRZQPaauFnGh8seBZU
=kw3n
-----END PGP SIGNATURE-----

--nextPart6073105.sSrUNI8SQX--
