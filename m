From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Mon, 11 Jul 2011 09:57:14 +0300
Message-ID: <20110711065713.GG2680@legolas.emea.dhcp.ti.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
 <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59375 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757003Ab1GKG5U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 02:57:20 -0400
Received: by gyh20 with SMTP id 20so1512621gyh.30
        for <linux-omap@vger.kernel.org>; Sun, 10 Jul 2011 23:57:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107100541110.15984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, hemahk@ti.com, tony@atomide.com, linux-omap@vger.kernel.org


--SUk9VBj82R8Xhb8H
Content-Type: multipart/mixed; boundary="QWpDgw58+k1mSFBj"
Content-Disposition: inline


--QWpDgw58+k1mSFBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Sun, Jul 10, 2011 at 05:43:23AM -0600, Paul Walmsley wrote:
> On Sun, 10 Jul 2011, Felipe Balbi wrote:
>=20
> > On Sat, Jul 09, 2011 at 07:57:20PM -0600, Paul Walmsley wrote:
> > > Hello Hema, Felipe,
> > >=20
> > > Commits 208466dc10083e734a8af71d10f923ee4bff950c ("usb: otg:
> > > OMAP4430: Powerdown the internal PHY when USB is disabled") and
> > > fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430:
> > > Power down the PHY during board init") break compilation on OMAP2:
> > >=20
> > >   LD      .tmp_vmlinux1
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7ce0): undefined reference to=
 `omap4430_phy_init'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7ce4): undefined reference to=
 `omap4430_phy_exit'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7ce8): undefined reference to=
 `omap4430_phy_power'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7cec): undefined reference to=
 `omap4430_phy_set_clk'
> > > arch/arm/mach-omap2/built-in.o:(.data+0x7cf0): undefined reference to=
 `omap4430_phy_suspend'
> > > make: *** [.tmp_vmlinux1] Error 1
> > >=20
> > >=20
> > > Could you please figure out a clean way to fix this for the 3.1 rc se=
ries?
> >=20
> > Patch attached, if you want to queue it for the merge window.
>=20
> This patch doesn't build when based on the arm-soc omap/cleanup branch.
>=20
> arch/arm/mach-omap2/twl-common.c:55:19: error: 'omap4430_phy_set_clk'=20
> undeclared here (not in a function)

new version attached. It's always compiling omap_phy_internal.c as we
always compile usb-musb.c and twl-common.c. Later I'll come up with a
better solution for this issue.

--=20
balbi

--QWpDgw58+k1mSFBj
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-usb-musb-fix-build-breakage.diff"
Content-Transfer-Encoding: quoted-printable

=46rom 1de870130718c3aef8db86006e9fa5389bc4059f Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <balbi@ti.com>
Date: Sun, 10 Jul 2011 12:22:20 +0300
Subject: [PATCH] usb: musb: fix build breakage
Organization: Texas Instruments\n

This patch fixes the compilation brekage which
commits 208466dc ("usb: otg:OMAP4430: Powerdown
the internal PHY when USB is disabled") and
fb91cde4 ("usb: musb: OMAP4430: Power down
the PHY during board init") introduced when
building a OMAP2-only kernel.

  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o:(.data+0x7ce0): undefined reference to
+`omap4430_phy_init'
arch/arm/mach-omap2/built-in.o:(.data+0x7ce4): undefined reference to
+`omap4430_phy_exit'
arch/arm/mach-omap2/built-in.o:(.data+0x7ce8): undefined reference to
+`omap4430_phy_power'
arch/arm/mach-omap2/built-in.o:(.data+0x7cec): undefined reference to
+`omap4430_phy_set_clk'
arch/arm/mach-omap2/built-in.o:(.data+0x7cf0): undefined reference to
+`omap4430_phy_suspend'
make: *** [.tmp_vmlinux1] Error 1

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Makefile |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ff1466f..455231c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -232,14 +232,11 @@ obj-$(CONFIG_MACH_IGEP0020)		+=3D board-igep0020.o \
 obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+=3D board-omap3touchbook.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_4430SDP)		+=3D board-4430sdp.o \
-					   hsmmc.o \
-					   omap_phy_internal.o
+					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP4_PANDA)		+=3D board-omap4panda.o \
-					   hsmmc.o \
-					   omap_phy_internal.o
+					   hsmmc.o
=20
-obj-$(CONFIG_MACH_OMAP3517EVM)		+=3D board-am3517evm.o \
-					   omap_phy_internal.o \
+obj-$(CONFIG_MACH_OMAP3517EVM)		+=3D board-am3517evm.o
=20
 obj-$(CONFIG_MACH_CRANEBOARD)		+=3D board-am3517crane.o
=20
@@ -250,6 +247,8 @@ obj-$(CONFIG_MACH_TI8168EVM)		+=3D board-ti8168evm.o
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:=3D usb-fs.o
 obj-y					+=3D $(usbfs-m) $(usbfs-y)
 obj-y					+=3D usb-musb.o
+obj-y					+=3D omap_phy_internal.o
+
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+=3D usb-tusb6010.o
 obj-y					+=3D usb-host.o
=20
--=20
1.7.6


--QWpDgw58+k1mSFBj--

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGp7JAAoJEAv8Txj19kN1V/MH/jEhMXgnyZw4/dz3VubHf2Rd
0i+YYKLbmhvKgyqIhIFGBuarQnAtAcGD5TkXR1/4TyoyusRjq9xJkRl6XiGA4U01
DnLd/K7sHna88o7DMFaP4o2aLOmsFwW9xavqwZaOuMMovQODcT9xp2wW1Denh8M8
ABHWJe0ATspMovB0lyLBB8M/Ok3LQo2XTTyYxJBbsBUSBlmmR4mW/LgfAMcTbKuk
PIy7qXRNDXizhnk3Qr1TXtFKmsyXPdvlWZJLIT/ZjniIf4C1Ot/bmMsLavf78WVC
nwTLxKcDdThp8/TAIpngvWE/hAsiMB8V1pvnvWamdQut/Qc/fPaOk0KX7Z/jLw4=
=ciZb
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--
