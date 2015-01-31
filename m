From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v3.19: Nokia N900 - usb nokia gadget crash
Date: Sat, 31 Jan 2015 10:25:09 +0100
Message-ID: <201501311025.09553@pali>
References: <201501311006.11909@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1627809.pMZRTcSuy3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:45095 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbbAaJZM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 31 Jan 2015 04:25:12 -0500
In-Reply-To: <201501311006.11909@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

--nextPart1627809.pMZRTcSuy3
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 31 January 2015 10:06:11 Pali Roh=C3=A1r wrote:
> Hello,
>=20
> when I try to modprobe g_nokia.ko gadget module on n900
> device, it produce tons on lines to display and then crash
> and reboot device. So its not working and I (without Nokia
> (TM) serial console I cannot debug it).

When I compile g_nokia into zImage (not as external module) then=20
it kernel loads correctly and usb is working.

Any idea why g_nokia as external kernel module cause problems,=20
but compiled into zImage is working??

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1627809.pMZRTcSuy3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTMn3UACgkQi/DJPQPkQ1LnbACfQV52BgPRuuyOOoA/DkQS1m9S
U5UAnin+LW5Z9CN/oHzWX3/FEbzm4fPW
=6qsp
-----END PGP SIGNATURE-----

--nextPart1627809.pMZRTcSuy3--
