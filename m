From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod: second set of fixes for 3.4-rc
Date: Fri, 13 Apr 2012 06:25:52 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1204130624110.25832@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49038 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab2DMMZx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Apr 2012 08:25:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-fixes-b-for-3.4rc

for you to fetch changes up to 1f5e6247ca99287bac87aff4971a7eee9c2b223a:

  ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface (2012-04-13 05:28:34 -0600)

- ----------------------------------------------------------------
A few OMAP hwmod fixes against v3.4-rc2.  One of them is a reversion
of a previous v3.4-rc patch that caused some regressions, and upon
further review, appears not to be necessary.  The other two are fairly
minor.

- ----------------------------------------------------------------

This series has been boot-tested on N800, OMAP35xx BeagleBoard, and OMAP4430
ES2 Pandaboard.  System suspend and dynamic retention idle have also been
tested on OMAP35xx Beagleboard.


- - Paul

object size (delta in bytes from v3.4-rc2):
 text 	 data 	  bss 	total 	kernel
    0 	    0 	    0 	    0 	5912osk_testconfig/vmlinux
 +100 	    0 	    0 	 +100 	n800_multi_omap2xxx/vmlinux
 +100 	    0 	    0 	 +100 	n800_testconfig/vmlinux
    0 	    0 	    0 	    0 	omap1_defconfig/vmlinux
 +100 	    0 	    0 	 +100 	omap2_4_testconfig/vmlinux
  +68 	    0 	    0 	  +68 	omap2plus_defconfig/vmlinux
 +132 	    0 	    0 	 +132 	omap2plus_no_pm/vmlinux
 +132 	    0 	    0 	 +132 	omap3_4_testconfig/vmlinux
 +132 	    0 	    0 	 +132 	omap3_testconfig/vmlinux
  +68 	    0 	    0 	  +68 	omap4_testconfig/vmlinux


Archit Taneja (1):
      ARM: OMAP2/3: VENC hwmods: Remove OCPIF_SWSUP_IDLE flag from VENC slave interface

Fernando Guzman Lugo (1):
      ARM: OMAP2+: hwmod: add softreset delay field and OMAP4 data

Paul Walmsley (1):
      ARM: OMAP2+: hwmod: Revert "ARM: OMAP2+: hwmod: Make omap_hwmod_softreset wait for reset status"

 arch/arm/mach-omap2/omap_hwmod.c             |   17 +++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    9 +++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +++-
 6 files changed, 27 insertions(+), 6 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPiBrNAAoJEMePsQ0LvSpLJeIP/jo4mDqo05sk6K5df0g4QFq0
egCOeQo5lFR844/M5lqfkJ9Ieo5+OcMXa98nDSQgmlKZ21Cb3x/ReOoqwkU2ZYMu
O0m5NPoYJfOE6h0KgJZXmGYGizGgl25W/cyfbrQ77nvuzG+hPU+W9d4Ia1UMhc0b
kobEdkls4wwD831ApwqRDi0FXwyhYzODX0W+RqtNDRTnY1y5ASipowtl86FYnZhd
lP9LnJ8kUR629iy1o4efhLey0XyDWBTIv7L0WS5I6TI1wRYr2kowCJcvmLpNkbUQ
4hVk8piHhntjSUFmjaNU/1IEGfs4oMQxkWUemAqYzkqa17DUXOCpHSYQHB99/OhR
JijS6nGPEKYhNjuGktWqEce4rn0f+/Cjy82sKM4RgCuTsb95ed1YlbEs8fygIrqI
PO+vDgOWF9RQXhR/HdQn2b7z7JfYCjxGdV9Y5y75UqknMcc+bKtN15c/UyAU4MOA
djHlh/W6iPnS5fq7xBobJMVRmJWy5MQ69Q9z740XLIM9vgQDdD0ot0mUgM9jQ7uL
2o0uA42UAI/eBOdka5FAqAOWKfn4op+TQk+DLxoF7saYYIxXL2WsjegV/7J4wm2u
b2afmgk79XYUlSIfOfybK+TnSO0lIZB8nqvM5q3pIR2BhmGK0MNDDX+6vVRjKGGU
gCzDnH9iJlkpEdZwaoYB
=tZhb
-----END PGP SIGNATURE-----
