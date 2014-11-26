From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: n900: kernel cmdline from bootloader in DT mode
Date: Thu, 27 Nov 2014 00:25:53 +0100
Message-ID: <201411270025.53559@pali>
References: <201411261354.33652@pali> <201411261436.42166@pali> <20141126152159.GA26123@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1794735.tIlvv96XQK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33212 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbaKZXZ4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2014 18:25:56 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so6633305wiv.8
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2014 15:25:55 -0800 (PST)
In-Reply-To: <20141126152159.GA26123@amd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Sebastian Reichel <sre@ring0.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, freemangordon@abv.bg

--nextPart1794735.tIlvv96XQK
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

Can you try to set:

CONFIG_USE_OF=3Dy
CONFIG_ATAGS=3Dy
# CONFIG_DEPRECATED_PARAM_STRUCT is not set
CONFIG_ZBOOT_ROM_TEXT=3D0x0
CONFIG_ZBOOT_ROM_BSS=3D0x0
CONFIG_ARM_APPENDED_DTB=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT=3Dy
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=3Dy
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
CONFIG_CMDLINE=3D"init=3D/sbin/preinit ubi.mtd=3Drootfs root=3Dubi0:rootfs =
rootfstype=3Dubifs=20
rootflags=3Dbulk_read,no_chk_data_crc rw mtdoops.mtddev=3Dlog console=3Dtty=
0 console=3DttyO2 omapfb_vram=3D7M=20
omapfb.mode=3Dlcd:848x480-16 nokia-modem.pm=3D0"
CONFIG_CMDLINE_FROM_BOOTLOADER=3Dy
# CONFIG_CMDLINE_EXTEND is not set
# CONFIG_CMDLINE_FORCE is not set
CONFIG_KEXEC=3Dy
CONFIG_ATAGS_PROC=3Dy
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=3Dy

and then boot kernel 3.18-rc6 with cmdline specified in bootloader?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1794735.tIlvv96XQK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlR2YYEACgkQi/DJPQPkQ1Kw7wCffeFqz4jvasxrCsk/a1aOtMOc
grsAmwcT37IFwCjxja3zJmhPmMICA+uz
=3BKL
-----END PGP SIGNATURE-----

--nextPart1794735.tIlvv96XQK--
