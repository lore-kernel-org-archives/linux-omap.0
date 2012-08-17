From: Radek Pilar <mrkva@mrkva.eu>
Subject: [PATCH 1/1] Config fix for omap3-touchbook board
Date: Fri, 17 Aug 2012 18:03:43 +0200
Message-ID: <502E6B5F.8020407@mrkva.eu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEFD3B5711580A58BFA70FD18"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mrkva.eu ([83.167.228.102]:40029 "EHLO mail.mrkva.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828Ab2HQQEU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Aug 2012 12:04:20 -0400
Received: from [192.168.1.104] (unknown [94.127.132.46])
	by mail.mrkva.eu (Postfix) with ESMTPSA id 351FD12F40EC
	for <linux-omap@vger.kernel.org>; Fri, 17 Aug 2012 18:04:12 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEFD3B5711580A58BFA70FD18
Content-Type: multipart/mixed;
 boundary="------------060608030302030507020704"

This is a multi-part message in MIME format.
--------------060608030302030507020704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Fix inconsistency between mach-types and CONFIG_ name that prevents touch=
book board from booting.
Signed-off-by: Radek Pilar <mrkva@mrkva.eu>

diff -ur linux-3.5.1/arch/arm/mach-omap2/Kconfig linux-3.5.1-mrkva/arch/a=
rm/mach-omap2/Kconfig
--- linux-3.5.1/arch/arm/mach-omap2/Kconfig	2012-08-09 17:23:56.000000000=
 +0200
+++ linux-3.5.1-mrkva/arch/arm/mach-omap2/Kconfig	2012-08-14 13:48:27.000=
000000 +0200
@@ -215,10 +215,11 @@
 	select OMAP_PACKAGE_CBB
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
=20
-config MACH_OMAP3_TOUCHBOOK
+config MACH_TOUCHBOOK
 	bool "OMAP3 Touch Book"
 	depends on ARCH_OMAP3
 	default y
+	select OMAP_PACKAGE_CBB
=20
 config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
diff -ur linux-3.5.1/arch/arm/mach-omap2/Makefile linux-3.5.1-mrkva/arch/=
arm/mach-omap2/Makefile
--- linux-3.5.1/arch/arm/mach-omap2/Makefile	2012-08-09 17:23:56.00000000=
0 +0200
+++ linux-3.5.1-mrkva/arch/arm/mach-omap2/Makefile	2012-08-14 13:48:13.00=
0000000 +0200
@@ -221,7 +221,7 @@
 obj-$(CONFIG_MACH_CM_T35)		+=3D board-cm-t35.o
 obj-$(CONFIG_MACH_CM_T3517)		+=3D board-cm-t3517.o
 obj-$(CONFIG_MACH_IGEP0020)		+=3D board-igep0020.o
-obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+=3D board-omap3touchbook.o
+obj-$(CONFIG_MACH_TOUCHBOOK)		+=3D board-omap3touchbook.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+=3D board-4430sdp.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+=3D board-omap4panda.o
=20

--------------060608030302030507020704
Content-Type: application/pgp-keys;
 name="0xE60DBF0D.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0xE60DBF0D.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.12 (GNU/Linux)

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
lwC5nSPK2jCoESLE87iiKLYyXBm/Gss/
=3DAGI8
-----END PGP PUBLIC KEY BLOCK-----

--------------060608030302030507020704--

--------------enigEFD3B5711580A58BFA70FD18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJQLmtmAAoJEIiYJZPmDb8NwT4P/23VITfGstNaE/8g37IRk8ns
S9enO4iHqjGVe25+u/LjOFPutMSPnUiPhXxmrthH/y6qo1a07JbHbPVNPqYQkruQ
6U/E9gqWcXfmbKpn0h+riRKP0SRfGsyd/VpyNADBCivyxt7T/QqdeLHaLY89YcH1
QDuQ2nZ/1EsqmuPN0PD0xgn2i0waAtszt3g3DSGlUYPvyacq3HmH/OjkCA2cj6Rh
+x1JUMdHv7v6w4BKA9RROhefsuve8IFb+3nR7FDrO6G8T0gzZ0L8wg1aylmT26Gw
sGrwG+2Nl1PAvtq6s4EYCPnuEVTjEM4iDx3vGaticsSDhjPf68QMMOd1vrEYwUtt
RloZIBpM6WuAdeWj2IwrsKO6mipLTTGQKwPWdS83iGYDVL/0DYP3U4tTbiMYp86H
CifG9yA6q4+MazSBHLih2CTv6imcFFDPrzV5SFZevfjjztLt3a3lnd4RWl5awmam
QV673kSC0q74KzIqDuZiukb6OfTB1q4MtLKgBf7lxIDR0W9lyIh2mFFHDy192t9M
Ab0BxmcWnJxMaTbuAjbdNvitV89z7FosSM6wq/AkumcypA38OS8JW4YBlbBCMWHj
p/LV/3tSne81nxJNB0AJEwLTpkhr91QTyUk7KId5C2OfJPxeA2q7qzPj8lyYpUKz
Lnr23mVNRAH4Npy5v1Q1
=94qI
-----END PGP SIGNATURE-----

--------------enigEFD3B5711580A58BFA70FD18--
