From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: v3.19: Nokia N900 - auto not working
Date: Sat, 31 Jan 2015 10:35:45 +0100
Message-ID: <201501311035.45875@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2795180.rAg2yimMeu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37847 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbbAaJfs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 04:35:48 -0500
Received: by mail-wi0-f169.google.com with SMTP id h11so7159006wiw.0
        for <linux-omap@vger.kernel.org>; Sat, 31 Jan 2015 01:35:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>

--nextPart2795180.rAg2yimMeu
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

audio on (real) n900 device does not working with 3.19 kernel. Here is rele=
vant dmesg output:

[    5.687438] omap_i2c 48070000.i2c: bus 1 rev3.3 at 2200 kHz
[    5.696166] tpa6130a2 2-0060: Write failed
[    5.696228] tpa6130a2 2-0060: Failed to initialize chip
[    5.696380] tpa6130a2: probe of 2-0060 failed with error -121
[    5.697937] omap_i2c 48072000.i2c: bus 2 rev3.3 at 100 kHz
[    5.700256] omap_i2c 48060000.i2c: bus 3 rev3.3 at 400 kHz
[    6.289154] rx51-audio n900-audio: Failed to add TPA6130A2 controls
[    6.295715] rx51-audio n900-audio: ASoC: failed to init TLV320AIC34: -19
[    6.302459] rx51-audio n900-audio: ASoC: failed to instantiate card -19
[    6.309173] gpiod_unexport: invalid GPIO
[    6.315612] rx51-audio n900-audio: snd_soc_register_card failed (-19)
[    6.397949] ALSA device list:
[    6.404876]   No soundcards found.

Any idea why tpa6130a2 fails to initialize?

I applied also these patches:
https://lkml.org/lkml/2015/1/29/465
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-January/087228.ht=
ml

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2795180.rAg2yimMeu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTMofEACgkQi/DJPQPkQ1JRhQCgq08hW+XD2crjrLhPKspstOSH
vYwAnicXhyx9eektZADYl7J43EUrDizc
=vURF
-----END PGP SIGNATURE-----

--nextPart2795180.rAg2yimMeu--
