From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 0/4] Drop legacy support for omap3517
Date: Tue, 13 Jan 2015 21:50:56 +0100
Message-ID: <201501132150.56938@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com> <10549142.7lWnPtPtZG@wuerfel> <20150113204219.GJ2419@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1562934.lrmlcYJ1FA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:37326 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbAMUvA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Jan 2015 15:51:00 -0500
Received: by mail-we0-f173.google.com with SMTP id q58so5204657wes.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Jan 2015 12:50:58 -0800 (PST)
In-Reply-To: <20150113204219.GJ2419@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>

--nextPart1562934.lrmlcYJ1FA
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 13 January 2015 21:42:20 Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> > On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > > It seems we can now drop omap3517 legacy booting support
> > > to get a bit closer to making all of omap3 boot in device
> > > tree only mode.
> > >=20
> > > All these boards have at least minimal support for booting
> > > with device tree, and pretty much anything supported with
> > > the legacy board files can be configured also for device
> > > tree based booting if not done already.
> >=20
> > Ah, very nice.
> >=20
> > Just out of curiosity, what are the remaining showstoppers
> > for the 3430 and 3530 based boards?
>=20
> Not much really. We're now printing a warning to get a people
> to upgrade their systems. So with some boards we need to wait
> a while.
>=20
> Then here are the remaining items that I'm aware of:
>=20
> - A regression at least on some n900 with appended DTB not
> booting properly any longer reported by Pali
>=20
> - A regression where the legacy ATAGs don't seem to get
> properly translated by the uncompress code for atag_rev at
> least reported by Pali
>=20
> - A few missing .dts files for devkit8000, omap3logic,
> omap3stalker, omap3pandora and omap3touchbook
>=20
> Pali and Sebastian probably know best of any other remaining
> issues to drop n900 legacy booting.
>=20
> If people have the boards listed above, please pitch in to do
> the .dts files or send the boards to me and I can do minimal
> .dts files for them.
>=20
> Regards,
>=20
> Tony

CCing Pavel Machek

He reported also some (still not fixed) regressions on n900.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1562934.lrmlcYJ1FA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlS1hTAACgkQi/DJPQPkQ1KGzgCeMcFMZko/atFDk6MmweTjJN0P
JXYAoI4l86EfOUxozy/JmffRVYomY/45
=Y1rM
-----END PGP SIGNATURE-----

--nextPart1562934.lrmlcYJ1FA--
