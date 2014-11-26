From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: n900: kernel cmdline from bootloader in DT mode
Date: Wed, 26 Nov 2014 13:54:33 +0100
Message-ID: <201411261354.33652@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3510717.j7ejXyExco";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60205 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbaKZMyg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 07:54:36 -0500
Received: by mail-wi0-f178.google.com with SMTP id hi2so4838476wib.17
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 04:54:35 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@ring0.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, freemangordon@abv.bg

--nextPart3510717.j7ejXyExco
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

for some unknown reasons when I compile kernel for n900 in DT=20
mode it ignore cmdline passed by bootloader. When I comment

CONFIG_ARM_APPENDED_DTB=3Dy

then it boots into legacy board mode and cmdline is used from=20
bootloader.

When is problem?

In defconfig I have:

CONFIG_ARM_APPENDED_DTB=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
CONFIG_CMDLINE=3D"...."
CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3510717.j7ejXyExco
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR1zYkACgkQi/DJPQPkQ1K2QQCdHQhKmy5IMEG1JLiduE8J/oea
hrcAoLNpX6UBdCO+B6l0PRB0S12apG4U
=9alM
-----END PGP SIGNATURE-----

--nextPart3510717.j7ejXyExco--
