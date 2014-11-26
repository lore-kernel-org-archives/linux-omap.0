From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: n900: kernel cmdline from bootloader in DT mode
Date: Wed, 26 Nov 2014 16:27:57 +0100
Message-ID: <201411261627.57241@pali>
References: <201411261354.33652@pali> <201411261436.42166@pali> <20141126152159.GA26123@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4195630.Q5WrA1YLtE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:37729 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbaKZP2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 10:28:00 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so4026534wgh.40
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 07:27:59 -0800 (PST)
In-Reply-To: <20141126152159.GA26123@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@ring0.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, freemangordon@abv.bg

--nextPart4195630.Q5WrA1YLtE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 November 2014 16:22:00 Pavel Machek wrote:
> On Wed 2014-11-26 14:36:42, Pali Roh=C3=A1r wrote:
> > On Wednesday 26 November 2014 14:28:01 Pavel Machek wrote:
> > > Hi!
> > >=20
> > > > for some unknown reasons when I compile kernel for n900
> > > > in DT mode it ignore cmdline passed by bootloader. When
> > > > I comment
> > > >=20
> > > > CONFIG_ARM_APPENDED_DTB=3Dy
> > > >=20
> > > > then it boots into legacy board mode and cmdline is used
> > > > from bootloader.
> > > >=20
> > > > When is problem?
> > >=20
> > > It seems to work for me, I'm booting using 0xffff, with
> > > attached config.
> > >=20
> > > 									Pavel
> >=20
> > Can you try to set some "root=3Dsomething" into CONFIG_CMDLINE
> > and then add real "root=3D" param via 0xffff?
> >=20
> > My problem is that I have specified ubifs mtd root in
> > CONFIG_CMDLINE and when I set correct root via bootloader
> > (from 0xffff or flasher-3.5) it is ignored and used only
> > what is specified in CONFIG_CMDLINE.
>=20
> CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
> # CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
> CONFIG_CMDLINE=3D"console=3DttyO2,115200 console=3Dtty"
>=20
> Um.. Internal commandline should be completely ignored for me.
>=20
> Do you have
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER?
>=20
> 									Pavel

Yes, I have:

CONFIG_ARM_APPENDED_DTB=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
CONFIG_CMDLINE=3D"...."
CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4195630.Q5WrA1YLtE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR18X0ACgkQi/DJPQPkQ1KjogCgyP7KGMJNRUK4UHCtWWEeDG/i
pcEAoK7YPucvTZ+MT0ml+D5jgY4Ib22w
=BxOP
-----END PGP SIGNATURE-----

--nextPart4195630.Q5WrA1YLtE--
