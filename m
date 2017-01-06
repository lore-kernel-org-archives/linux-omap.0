From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Nokia N900 headset detection & MIC Bias + TVOUT
Date: Sat, 7 Jan 2017 00:07:49 +0100
Message-ID: <201701070007.49137@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1799285.OAnZPb9qbT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--nextPart1799285.OAnZPb9qbT
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi!

=46or jack cable and headset detection in Nokia N900 I would need to=20
enable/disable MIC Bias and also enable/disable TVOUT output.

All that is needed in N900 sound driver, file sound/soc/omap/rx51.c. Can=20
you help me which functions should I call to enable/disable it=20
correctly? In headset detection code I need to be sure that nobody=20
(other kernel drivers or userspace via alsamixer) except current=20
function could change Bias settings.

MIC Bias is controlled by MICBIAS_CTRL in aic34 'B' part codec, file=20
tlv320aic3x.c.

And according to RX-51 Schematics TVOUT is controlled by OMAP3430 pins:=20
TV_OUT1 and TV_VFB1. I have not found any references to them in kernel,=20
just in omap trm. How is OMAP3430's TV_OUT1 controlled?

(Existing code in Maemo 2.6.28 kernel is doing it by big hack - exports=20
function which directly modify MICBIAS_CTRL)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1799285.OAnZPb9qbT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlhwI0UACgkQi/DJPQPkQ1Jl4ACeLNJyw5K5ptyPEpEVNggI8x+I
dtMAoJtWA56RHD5O/MTq1Th7hhlIA/Yt
=MEFA
-----END PGP SIGNATURE-----

--nextPart1799285.OAnZPb9qbT--
