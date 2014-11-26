From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: n900: kernel cmdline from bootloader in DT mode
Date: Wed, 26 Nov 2014 14:36:42 +0100
Message-ID: <201411261436.42166@pali>
References: <201411261354.33652@pali> <20141126132800.GA27610@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1801510.pQTkF9UG7N";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:42200 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaKZNgu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 08:36:50 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so3741503wgh.4
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 05:36:49 -0800 (PST)
In-Reply-To: <20141126132800.GA27610@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@ring0.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, freemangordon@abv.bg

--nextPart1801510.pQTkF9UG7N
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 November 2014 14:28:01 Pavel Machek wrote:
> Hi!
>=20
> > for some unknown reasons when I compile kernel for n900 in
> > DT mode it ignore cmdline passed by bootloader. When I
> > comment
> >=20
> > CONFIG_ARM_APPENDED_DTB=3Dy
> >=20
> > then it boots into legacy board mode and cmdline is used
> > from bootloader.
> >=20
> > When is problem?
>=20
> It seems to work for me, I'm booting using 0xffff, with
> attached config.
> 									Pavel

Can you try to set some "root=3Dsomething" into CONFIG_CMDLINE and=20
then add real "root=3D" param via 0xffff?

My problem is that I have specified ubifs mtd root in=20
CONFIG_CMDLINE and when I set correct root via bootloader (from=20
0xffff or flasher-3.5) it is ignored and used only what is=20
specified in CONFIG_CMDLINE.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1801510.pQTkF9UG7N
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR112oACgkQi/DJPQPkQ1J48wCbB8A8hAz2M+7KNqC4qyXSQMR/
fwYAoJyWcrFW4ENkA2GDOIRmnqqb9gG1
=N0Hp
-----END PGP SIGNATURE-----

--nextPart1801510.pQTkF9UG7N--
