From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] ARM: OMAP2+: some more hwmod & clock patches for
 v3.19
Date: Fri, 21 Nov 2014 19:18:06 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411211917280.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:55545 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaKUTSH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 Nov 2014 14:18:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 79005fbd3e1d671d08c45c9140ee9826efdc367c:

  ARM: OMAP2+: hwmod: drop unnecessary list initialization (2014-11-13 09:36:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19/omap-b2

for you to fetch changes up to 1f074f996482220f90fbe3dcfafeb3db46ec748a:

  Merge branch 'adc-support-v3.19' into omap-b-for-v3.19 (2014-11-21 11:05:05 -0700)

- ----------------------------------------------------------------
Several more OMAP patches targeted for v3.19. They include:

- - OMAP4/5: DSS hwmod cleanup patches from Tomi Valkeinen.
- - DRA7xx: hwmod data support for UARTs 7 through 10.
- - AM43xx: hwmod data support for the onboard ADC.

Basic build, boot, and PM test reports are here:

http://www.pwsan.com/omap/testlogs/omap-b-for-v3.19/20141121110550/

Note that I cannot test the DRA7xx or AM43xx patches, since I do not have
these boards.

- ----------------------------------------------------------------
Ambresh K (1):
      ARM: DRA7: hwmod data: Add missing UART hwmod data

Paul Walmsley (2):
      Merge branch 'dra7xx-uart-hwmod-v3.19' into omap-b-for-v3.19
      Merge branch 'adc-support-v3.19' into omap-b-for-v3.19

Tomi Valkeinen (6):
      ARM: OMAP2+: hwmod: add parent_hwmod support
      ARM: OMAP5: hwmod: set DSS submodule parent hwmods
      ARM: OMAP4: hwmod: set DSS submodule parent hwmods
      ARM: OMAP4: hwmod: use MODULEMODE properly
      ARM: OMAP4: fix RFBI iclk
      ARM: dts: omap4.dtsi: remove dss_fck

Vignesh R (1):
      ARM: OMAP2+: hwmod: AM43x: add hwmod support for ADC on AM43xx

 arch/arm/boot/dts/omap4.dtsi               |   2 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi     |   8 ---
 arch/arm/mach-omap2/omap_hwmod.c           |  22 +++++++
 arch/arm/mach-omap2/omap_hwmod.h           |   8 +++
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |  39 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  25 +++++---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |   5 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 100 +++++++++++++++++++++++++++++
 8 files changed, 191 insertions(+), 18 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUb4+tAAoJEMePsQ0LvSpL1a8P+gI4wOY+CbUF77ya5r40nVsR
zkfYpzEZUaNXWXxB2muPuJIEbv3GEU/ytiyDzApKfnILbIuOnHtUPl+du6mivr88
v5SeRSOUDPldvv0pEzB+QM9u0ugheWbBTTYwIRoUPvy2Ns2wj7lr6rRmu56aRhSe
+a4uryYUidSeVNS7ssw5n6L2eTLe2dQZvrn6TF/LewRQ8TbmjCNPESfvsEPBGyW6
mNNbO4dT0fLHQqki+lHDiEMe3LD+vrzYJpyrluDXLw9eJdVLKqg08klPUEFGiNRU
zKcaqebrqqQRwrjrr3MygxgtXDQ9rgBSiW6jRXMe9bXdXnnQeEga0yOLd37pWMIz
JXh9AhBW+lLCWqydr+/z/KlnEY/1VyXa6u8tIAX4Egzv2oIMnwzrZfjNtMGykFk3
2pczwb5Ftync/D/80QsR/iwqiNd6rzfDMz+1ALNO5ywuhFrYlCVFgPRfxayLfsbl
FSIv8QzJ6vPiRebIfZGoGWddnKnnSBItJgqJuk1lqHbSjrB+o+ODRUGuaKRO1ZYJ
ZM7Ar9AMuhw8Zwv23RZfgvsgqG4PGc2gnACy1B9iW7xzVHAdQ/b4rG9DI9whfpQ0
BewTTEvRmVx9xXJnyAPnsQIK8wodG7i0M7j3eWUSnGmYVR3SOYwssJspwzSIzhMC
JwqOODpI8W9/oMyd+RUB
=GlT7
-----END PGP SIGNATURE-----
