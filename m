From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.10-rc7
Date: Mon, 1 Jul 2013 23:42:36 +0300
Message-ID: <20130701204236.GA805@arwen.pp.htv.fi>
References: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818Ab3GAUnE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Jul 2013 16:43:04 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1307011946180.4358@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 01, 2013 at 07:48:50PM +0000, Paul Walmsley wrote:
> Boot to userspace:
>     FAIL ( 2/12): 37xxevm, am335xbonelt

<quoting part of [1]>
| U-Boot# tftp 0x82000000 am335x-boneblack.dtb
| link up on port 0, speed 100, full duplex
| Using cpsw device
| TFTP from server 192.168.57.1; our IP address is 192.168.57.138
| Filename 'am335x-boneblack.dtb'.

Where are you taking am335x-boneblack.dtb from ? It's not in mainline
v3.10-rc7 kernel:

$ ls arch/arm/boot/dts/am33*.dts
arch/arm/boot/dts/am335x-bone.dts  arch/arm/boot/dts/am335x-evm.dts
arch/arm/boot/dts/am335x-evmsk.dts
$ git grep -e boneblack arch/arm/
$ echo $
1
$ git show
commit 9e895ace5d82df8929b16f58e9f515f6d54ab82d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat Jun 22 09:47:31 2013 -1000

    Linux 3.10-rc7

diff --git a/Makefile b/Makefile
index c6863b5..0142c93 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION =3D 3
 PATCHLEVEL =3D 10
 SUBLEVEL =3D 0
-EXTRAVERSION =3D -rc6
+EXTRAVERSION =3D -rc7
 NAME =3D Unicycling Gorilla
=20
 # *DOCUMENTATION*

[1] http://www.pwsan.com/omap/testlogs/test_v3.10-rc7/20130630191558/boot/a=
m335xbonelt/am335x-bone/am335xbonelt_log.txt

--=20
balbi

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR0em8AAoJEIaOsuA1yqREFXMP/0Qyqg0F0LBzFrSHClIrDKo8
O4fLUeQ8OGlfHendAwxbvwZRk/08hZuWjmudfneTKTVQ9k2TMaxKa3h1VTR0pU0A
dAkipJSycB6DzEJzwWfKDYEAI4AyvWozbgcP0EC28QIsjk/1HM0EJwiYKsI9epB8
B/RCxnsk2u+uvjozWOlTUq95mYXSPUAY6wFpAfDls8615sFZ51GGM5swWKiGOfEG
Elv0/gMyUR+ZRVSmh5WryU2hxYg3+mV7oBQyTcmATigfhq0veRhrIqhjp6C2TAoN
tNv3aJS0zUW5MDmsqgu9CX9JNzXIgNHt5POOuuXS7LtcFKkNBEnxd9HCIgQjkxnH
um/fGHos05jSr/Lg9tiZW5QoxlZDpS3wQhONDNPVPBI3xwhv9uzp2utPj1jDBffw
vkhev0We1B1ZoYcxrGfF5x5RRjbITQcsrRH9xOkwIwNgxIdk0IR6j+Ue0gKXID2y
JP5bkj9mXGF4BIe5kiVP/yNVbEby8ZZ+JuC/dMiUuXY8c9csiw/In3V92hNDLIBF
PVfIXjW4tkFznSX3eTeTiYypALlf68OTHcgfQEifoUH+zV38E1EO5p31f5HxgAoz
iGz+yuUQ+e8zlddY8TzMmvqXDvFxV5JloGAtiw/pFHAbVWZXX0vRS2Gu5nPj5QYG
vfGnVO7wJuN+PsqZ7i9Z
=ibS1
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
