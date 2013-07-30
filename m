From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod fixes for v3.11-rc
Date: Tue, 30 Jul 2013 11:46:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1307301146110.4505@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38959 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3G3Lqh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Jul 2013 07:46:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.11-rc/omap-fixes-b

for you to fetch changes up to 50c2a3a1518befe992f868fc1fd867bdad9776ad:

  ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space (2013-07-30 05:13:37 -0600)

- ----------------------------------------------------------------
Some OMAP hwmod fixes for v3.11-rc.  Mostly intended to fix an earlyprintk
regression and an AM33xx cpgmac power management regression.

Basic build, boot, and PM tests are available here:

http://www.pwsan.com/omap/testlogs/hwmod_fixes_a_v3.11-rc/20130730042132/

The tests include temporary fixes for the unrelated 2430SDP and OMAP3
boot regressions, which are not part of this signed tag.

- ----------------------------------------------------------------
Afzal Mohammed (2):
      ARM: OMAP2+: hwmod: rt address space index for DT
      ARM: OMAP2+: hwmod: AM335x: fix cpgmac address space

Rajendra Nayak (3):
      ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with DEBUG_LL
      ARM: OMAP2+: Avoid idling memory controllers with no drivers
      ARM: OMAP2+: Sync hwmod state with the pm_runtime and omap_device state

 arch/arm/mach-omap2/omap_device.c                  | 18 ++++++++
 arch/arm/mach-omap2/omap_hwmod.c                   |  2 +-
 arch/arm/mach-omap2/omap_hwmod.h                   | 50 ++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |  6 +--
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  3 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  9 ++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |  5 +--
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |  3 +-
 arch/arm/mach-omap2/serial.c                       | 11 -----
 9 files changed, 83 insertions(+), 24 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJR96GBAAoJEMePsQ0LvSpLnDcP/Aw52rbj9buMgOsD9vcuL/N/
7pthVnpdCZXoammCy42QaiBFrB56rhSP25MwCdsj1wThLDvcGDRWaplzHOUQvf8g
K0t2aDzIjXlZZ4sGj16/3gX97RvDM+648skmReEISWpl0J93XRcb+8hwHh3GT7CA
agnM8uWKBfBn8k453CGx24qCuo3Pa/XhCuqgSYqsRBuLyXDl9QuAgyrDE7GOGtET
c1CapT7skrJGQKIg7ZuAN3P4iY2UwohL9kA3Fa5cGuIdDl31SKvK22ESnPrFOPX/
qJW+Bkw72j8PI68hVOIkUw2SDsjyIYXQ+fXKi3alLu98WMaA7e84KeC7Xo3yT9l5
Y7DkdsTCoLVirwVsiJx05ohPYkfs0NMJDS9pT28h2WQfmQxny5gEBAXXSyPk/mtG
Cltc0gcDqlGO6MWh0PrpKU6TXR1aAN/QUK1n7EBTLtwNu+nFEArtn0g4WkqQlfrq
yfLppVzDHUJnPe816g7DLt32V2qMLPJaPppC90pX+6G2+8+BampbL5Fj9OQ9tR2Q
KDwT60kcKtq7xDD4po+W7c1lMBLcVlVbHMCjk4kbPvbI0NF8NBMyAcXYjgMVJmu0
BYBrp7M8WYRkon9XsYjlyBaGYrJ4IeLSW4TwxH48Ma/xPnatEFRkynvKVgFGZFi8
wogioQkMcv84GA3e6VmT
=Qr73
-----END PGP SIGNATURE-----
