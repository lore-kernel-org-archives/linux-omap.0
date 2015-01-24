From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: n900: kernel cmdline from bootloader in DT mode
Date: Sat, 24 Jan 2015 15:01:19 +0100
Message-ID: <201501241501.20009@pali>
References: <201411261354.33652@pali> <20141126152159.GA26123@amd> <201411261627.57241@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1774337.JxefYNoYfD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:63586 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbbAXOBZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Jan 2015 09:01:25 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so2229445wiv.4
        for <linux-omap@vger.kernel.org>; Sat, 24 Jan 2015 06:01:23 -0800 (PST)
In-Reply-To: <201411261627.57241@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@ring0.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, freemangordon@abv.bg

--nextPart1774337.JxefYNoYfD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 November 2014 16:27:57 Pali Roh=C3=A1r wrote:
> On Wednesday 26 November 2014 16:22:00 Pavel Machek wrote:
> > On Wed 2014-11-26 14:36:42, Pali Roh=C3=A1r wrote:
> > > On Wednesday 26 November 2014 14:28:01 Pavel Machek wrote:
> > > > Hi!
> > > >=20
> > > > > for some unknown reasons when I compile kernel for
> > > > > n900 in DT mode it ignore cmdline passed by
> > > > > bootloader. When I comment
> > > > >=20
> > > > > CONFIG_ARM_APPENDED_DTB=3Dy
> > > > >=20
> > > > > then it boots into legacy board mode and cmdline is
> > > > > used from bootloader.
> > > > >=20
> > > > > When is problem?
> > > >=20
> > > > It seems to work for me, I'm booting using 0xffff, with
> > > > attached config.
> > > >=20
> > > > 									Pavel
> > >=20
> > > Can you try to set some "root=3Dsomething" into
> > > CONFIG_CMDLINE and then add real "root=3D" param via
> > > 0xffff?
> > >=20
> > > My problem is that I have specified ubifs mtd root in
> > > CONFIG_CMDLINE and when I set correct root via bootloader
> > > (from 0xffff or flasher-3.5) it is ignored and used only
> > > what is specified in CONFIG_CMDLINE.
> >=20
> > CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> > CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
> > # CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
> > CONFIG_CMDLINE=3D"console=3DttyO2,115200 console=3Dtty"
> >=20
> > Um.. Internal commandline should be completely ignored for
> > me.
> >=20
> > Do you have
> > CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER?
> >=20
> > 									Pavel
>=20
> Yes, I have:
>=20
> CONFIG_ARM_APPENDED_DTB=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
> CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
> CONFIG_CMDLINE=3D"...."
> CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy

Problem detected and fix patch here:
https://lkml.org/lkml/2015/1/23/701

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1774337.JxefYNoYfD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTDpbAACgkQi/DJPQPkQ1JnAQCeMxQghWBUqlwInrrz9yUZnHZo
N9EAoJCid5IMamnbBiH4B5SB77iiuk/s
=lGqg
-----END PGP SIGNATURE-----

--nextPart1774337.JxefYNoYfD--
