From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP2-only kernel compile broken
Date: Sun, 10 Jul 2011 12:52:18 +0300
Message-ID: <20110710095216.GN31978@legolas.emea.dhcp.ti.com>
References: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bJ3jXuwtxrXxD2iT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:49846 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755528Ab1GJJwZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 10 Jul 2011 05:52:25 -0400
Received: by bwf12 with SMTP id 12so4213840bwf.22
        for <linux-omap@vger.kernel.org>; Sun, 10 Jul 2011 02:52:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1107091955040.15984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: balbi@ti.com, hemahk@ti.com, tony@atomide.com, linux-omap@vger.kernel.org


--bJ3jXuwtxrXxD2iT
Content-Type: multipart/mixed; boundary="z3ovhOgMYmj8MRdq"
Content-Disposition: inline


--z3ovhOgMYmj8MRdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 09, 2011 at 07:57:20PM -0600, Paul Walmsley wrote:
> Hello Hema, Felipe,
>=20
> Commits 208466dc10083e734a8af71d10f923ee4bff950c ("usb: otg:
> OMAP4430: Powerdown the internal PHY when USB is disabled") and
> fb91cde49c327ff957c55d91805bc6abda59b311 ("usb: musb: OMAP4430:
> Power down the PHY during board init") break compilation on OMAP2:
>=20
>   LD      .tmp_vmlinux1
> arch/arm/mach-omap2/built-in.o:(.data+0x7ce0): undefined reference to `om=
ap4430_phy_init'
> arch/arm/mach-omap2/built-in.o:(.data+0x7ce4): undefined reference to `om=
ap4430_phy_exit'
> arch/arm/mach-omap2/built-in.o:(.data+0x7ce8): undefined reference to `om=
ap4430_phy_power'
> arch/arm/mach-omap2/built-in.o:(.data+0x7cec): undefined reference to `om=
ap4430_phy_set_clk'
> arch/arm/mach-omap2/built-in.o:(.data+0x7cf0): undefined reference to `om=
ap4430_phy_suspend'
> make: *** [.tmp_vmlinux1] Error 1
>=20
>=20
> Could you please figure out a clean way to fix this for the 3.1 rc series?

Patch attached, if you want to queue it for the merge window.

--=20
balbi

--z3ovhOgMYmj8MRdq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-usb-musb-fix-build-breakage.diff"
Content-Transfer-Encoding: quoted-printable

=46rom 0b355cb203be6efe839f60edfc29c8ccf8048e4a Mon Sep 17 00:00:00 2001
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

Cc: stable@kernel.org
Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/include/plat/usb.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/inc=
lude/plat/usb.h
index 17d3c93..99dd64e 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -103,11 +103,25 @@ extern void usbhs_init(const struct usbhs_omap_board_=
data *pdata);
 extern int omap_usbhs_enable(struct device *dev);
 extern void omap_usbhs_disable(struct device *dev);
=20
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_ARCH_OMAP3)
 extern int omap4430_phy_power(struct device *dev, int ID, int on);
 extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
 extern int omap4430_phy_suspend(struct device *dev, int suspend);
+#else
+static inline int omap4430_phy_power(struct device *d, int i, int o)
+{  return 0;  }
+static inline int omap4430_phy_set_clock(struct device *d, int o)
+{  return 0;  }
+static inline int omap4430_phy_init(struct device *d)
+{  return 0;  }
+static inline int omap4430_phy_exit(struct device *d)
+{  return 0;  }
+static inline int omap4430_phy_suspend(struct device *d, int s)
+{  return 0;  }
+#endif
+
 #endif
=20
 extern void am35x_musb_reset(void);
--=20
1.7.6


--z3ovhOgMYmj8MRdq--

--bJ3jXuwtxrXxD2iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOGXZQAAoJEAv8Txj19kN175kH/3SsmUNK36pGM0phc6yjPwDE
w8dUFvgvpV41eZyGQjvAWA/4ESNS4Dj2TgTMBvO9EuScUKDhg6B1/RLrRuPAvE78
9fSZPK0z6XzqO0vPMBTNvYxBhGjr4PKN0QzYRkJ2+MRPEo2ZNjP2sBAC2hsXD671
fHGZNF6Y5SzYFwSP8xM3Nb5sw1AKIAUrEh25k9niz8Ekqg+4JSg2UFriKt4mQJ/B
Du+uDXK76e9UpsFeTjlCmDU296Y86Xh6H8C4zQIk/oKM40FxLAQCORom0tCTDCyN
j6QrfawRAxjla4O5YigIl79h0C+yv1YnE5w000LuF5Iv5Byt8xXwKAxQ6kqfP5k=
=EumE
-----END PGP SIGNATURE-----

--bJ3jXuwtxrXxD2iT--
