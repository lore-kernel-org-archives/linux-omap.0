From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: n900 audio: any ideas how to get headset speaker to work?
Date: Sun, 15 Feb 2015 17:27:03 +0100
Message-ID: <201502151727.03129@pali>
References: <20150215102152.GA23736@amd> <201502151208.03126@pali> <20150215162028.GA6857@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3041876.fX2Tttci5o";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:35252 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbbBOQ1H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Feb 2015 11:27:07 -0500
In-Reply-To: <20150215162028.GA6857@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, joerg Reisenweber <joerg@openmoko.org>

--nextPart3041876.fX2Tttci5o
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 15 February 2015 17:20:29 Pavel Machek wrote:
> On Sun 2015-02-15 12:08:02, Pali Roh=C3=A1r wrote:
> > On Sunday 15 February 2015 11:21:52 Pavel Machek wrote:
> > > Hi!
> > >=20
> > > By default, output goes to loudspeaker (top right relative
> > > to keyboard). Any ideas how to switch it to the speaker
> > > on the left or wired headset? Because I suspect that echo
> > > cancelation is not going to be simple...
> > >=20
> > > 									Pavel
> >=20
> > I do not know but maybe this file could help:
> >=20
> > https://gitorious.org/community-ssu/policy-settings-rx51/sou
> > rce/dcb6429c12006dc9850cc942b7143358fe3fd330:rx51/etc/alsape
> > d.conf
> >=20
> > There are definitions of alsa channels and settings for
> > different profiles.
>=20
> Thanks... it seems to be what I needed. More code to write...
> 									Pavel

Will you create asoundrc file with both speakers for n900?

I would like to see n900 sound setup without pulseaudio...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3041876.fX2Tttci5o
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTgyNcACgkQi/DJPQPkQ1IF4QCghjVMbNkvZWyo7zPZHZ0EZzIL
oWYAoLQPbMC5Jg6RIKAbypYhLVNWW8z0
=XNN7
-----END PGP SIGNATURE-----

--nextPart3041876.fX2Tttci5o--
