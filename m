From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: n900 audio: any ideas how to get headset speaker to work?
Date: Sun, 15 Feb 2015 12:08:02 +0100
Message-ID: <201502151208.03126@pali>
References: <20150215102152.GA23736@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart21581326.CSzcQf79CX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:49704 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbbBOLIH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Feb 2015 06:08:07 -0500
In-Reply-To: <20150215102152.GA23736@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com

--nextPart21581326.CSzcQf79CX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 15 February 2015 11:21:52 Pavel Machek wrote:
> Hi!
>=20
> By default, output goes to loudspeaker (top right relative to
> keyboard). Any ideas how to switch it to the speaker on the
> left or wired headset? Because I suspect that echo
> cancelation is not going to be simple...
> 									Pavel

I do not know but maybe this file could help:

https://gitorious.org/community-ssu/policy-settings-rx51/source/dcb6429c120=
06dc9850cc942b7143358fe3fd330:rx51/etc/alsaped.conf

There are definitions of alsa channels and settings for different profiles.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart21581326.CSzcQf79CX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTgfhMACgkQi/DJPQPkQ1IY8wCfQnfuhSbcmD/J6FtgoERsg6+e
Kz8AoI2rESBPJA0PCb0jVTInRUsKVCUn
=kXpJ
-----END PGP SIGNATURE-----

--nextPart21581326.CSzcQf79CX--
