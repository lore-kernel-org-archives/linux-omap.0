From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: some more hwmod & clock patches for v3.19
Date: Thu, 20 Nov 2014 17:27:46 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411201726290.9204@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38853 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbaKTR1r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Nov 2014 12:27:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 79005fbd3e1d671d08c45c9140ee9826efdc367c:

  ARM: OMAP2+: hwmod: drop unnecessary list initialization (2014-11-13 09:36:55 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19/omap-b

for you to fetch changes up to eb039a175163ebc2df4612c4a5393143017ce473:

  Merge branch 'dra7xx-uart-hwmod-v3.19' into omap-b-for-v3.19 (2014-11-20 01:50:32 -0700)

- ----------------------------------------------------------------
Several more OMAP patches targeted for v3.19.  They include:

- - OMAP4/5: DSS hwmod cleanup patches from Tomi Valkeinen.
- - DRA7xx: hwmod data support for UARTs 7 through 10.

Basic build, boot, and PM test reports are here:

http://www.pwsan.com/omap/testlogs/omap-b-for-v3.19/20141120015256/

Note that I cannot test the DRA7xx patches in any way, since I do not have
a DRA7xx board.

- ----------------------------------------------------------------
Ambresh K (1):
      ARM: DRA7: hwmod data: Add missing UART hwmod data

Paul Walmsley (1):
      Merge branch 'dra7xx-uart-hwmod-v3.19' into omap-b-for-v3.19

Tomi Valkeinen (6):
      ARM: OMAP2+: hwmod: add parent_hwmod support
      ARM: OMAP5: hwmod: set DSS submodule parent hwmods
      ARM: OMAP4: hwmod: set DSS submodule parent hwmods
      ARM: OMAP4: hwmod: use MODULEMODE properly
      ARM: OMAP4: fix RFBI iclk
      ARM: dts: omap4.dtsi: remove dss_fck

 arch/arm/boot/dts/omap4.dtsi               |   2 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi     |   8 ---
 arch/arm/mach-omap2/omap_hwmod.c           |  22 +++++++
 arch/arm/mach-omap2/omap_hwmod.h           |   8 +++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  25 +++++---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |   5 ++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 100 +++++++++++++++++++++++++++++
 7 files changed, 152 insertions(+), 18 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUbiQwAAoJEMePsQ0LvSpL1ScP/AsalZD18RBF9M9KKbdmbBLj
hyeapk+7jkBS3ZOIinbOqJkK2hPQahf7tA8GHsgmlaU/EQJNzaTmXEN+ka9Om0nJ
pZXpo87rsmJCqZaamxk66PXOStZXw2P+fDZSkxJFXK7rZrXH19BEvpxbwKtaEYMx
Xv2TdaUvcgOJR2Sh4s2C9fxLYmuUzbMsdTYyPyKO/UL5WUteTk1UpR0dkEbYYOS3
HBBX4kpxwijfi8SMI+A/+EYwUw8lc7qvMeOk3vC14xn6IitB0dH6ZNCmTm5IJK6+
kn7AJnYlMcPVwEvK0bbUVMhjtxx2foceTb5rkhIBGfW1GWx22r75wD+Kv+bekwrQ
XCPcImj8PfKstKZqmnHP82i2sJxpiE5nwiqQNoGgRz9YE/x6MTu/xGR4uUoTOg86
LSVm+HM/dLd99+DyWIgDwj9zwluZYGcLrBSYjiUAnxhOVtb6MaGVQSQ819gv75ep
l1eINopMGYnLHq/GwEPzsJ0zA4gEWylLJJ+JB0cc7RpL9M9c5R+1sxwn4Sv80bly
+StV0fKBtEo8f/FEonhbc3Du8iVKN297fsM4TFp2hCYnghCGVLyTrEfKpwlZb3YK
I7LSLpJFq7rCkFqt0de2T5jKx2C1LNaZ+7rLfjpQejWTj9wRenGKE3hwV11UQj/q
ng7oGIaPepOB2Z78FXex
=cDw/
-----END PGP SIGNATURE-----
