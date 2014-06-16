From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod code and data changes for early
 v3.16-rc
Date: Mon, 16 Jun 2014 03:18:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406160317120.659@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34252 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbaFPDS0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jun 2014 23:18:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit abf04af74a9f27a65172a43b43ccabcbc2bbdc39:

  Merge tag 'scsi-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2014-06-14 19:49:48 -0500)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.16-rc/omap-fixes-a

for you to fetch changes up to bf32c4ad9924e2d60a23de4a3c074f806bf2ef05:

  ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods (2014-06-15 20:12:52 -0600)

- ----------------------------------------------------------------
Two OMAP hwmod patches for early v3.16-rc kernels.

There's one OMAP SoC integration fix for the AM43xx SoC, without
which, IP blocks can't be placed into hard-reset.

There is also one OMAP5 SoC data addition patch that should have gone
in for v3.16. Normally I wouldn't send this as part of an -rc series,
since it's not technically a fix. But I'd like to make an exception in
this case because:

- - it's intended to go in very early in the v3.16-rc series (or even
pre-rc1);

- - it's a fairly small change;

- - the impact is limited to a single SoC and a single device;

- - the only reason that it didn't go in earlier is because it "slipped
through the cracks," rather than for any technical reason.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/hwmod-a-v3.16-rc/20140615201307/

- ----------------------------------------------------------------
Dave Gerlach (1):
      ARM: OMAP2+: hwmod: Change hardreset soc_ops for AM43XX

Keshava Munegowda (1):
      ARM: OMAP5: hwmod: Add ocp2scp3 and sata hwmods

 arch/arm/mach-omap2/Makefile               |  6 ++-
 arch/arm/mach-omap2/cm33xx.h               |  2 +-
 arch/arm/mach-omap2/omap_hwmod.c           |  6 +--
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 73 ++++++++++++++++++++++++++++++
 4 files changed, 81 insertions(+), 6 deletions(-)


vmlinux object size
(delta in bytes from temp_base_for_hwmod-a-v3.16-rc (abf04af74a9f27a65172a43b43ccabcbc2bbdc39)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
    -28     +416        0     +388  multi_v7_defconfig
    -28     +392        0     +364  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0        0        0        0  omap2plus_defconfig_am33xx_only
  +6492     +128        0    +6620  omap2plus_defconfig_am43xx_only
    -28     +448        0     +420  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_dra7xx_only
      0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
      0       -8        0       -8  omap2plus_defconfig_n800_only_a
    -28     +448        0     +420  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0        0        0        0  omap2plus_defconfig_omap3_4_only
      0     +448        0     +448  omap2plus_defconfig_omap5_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
      0        0        0        0  rmk_omap4430_sdp_allnoconfig
      0        0        0        0  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from temp_base_for_hwmod-a-v3.16-rc (abf04af74a9f27a65172a43b43ccabcbc2bbdc39))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  4460pandaes    omap2plus_defconfig

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTnmGQAAoJEMePsQ0LvSpL6EgP/2RLO1wzsjZP8tcZnWGjLMuE
jQUFi3G6eOIA0O64GA/q6XuNghKDIzGQ/w7MK94IS3W/VCkCrmYUrMfOpp66baIJ
EKAHzLE2LTp7paeS2dNGNRl9GcYDNTiXZ3YJq5AZo3nR7QI6QlrF/UolyG/wlPjs
epz9H7J1ijpcOMVhadixS3sYYxmUjhECgRWbeLKYc2qdpXNQ+XMaIyLBxpIEjIGb
u07cmEFxT0PHbpCrKrc6PCrMc2LtLieSCZVLsFrNVm4vlY7rrIjkE7HtHE4wyI+J
OM8hCs65nCKu7e9TOi2UkIF30BQiYYioBN4pLcIjVQoPnwrnJD465GWLtXQy9rFi
H7sb+wSgRWcDYo1u8a/w3Qw99If7X6TJDP5AOlcdMlR0MufSnCSs9ItjMRuRJk/B
TIyiCZdRFUXeVquPxdGSbkgJTDpmif9n10M10zw0bRUNakd3L/zyqRkqaylOQBhm
KnyklnPpukqersExvDJJQO6mPVn/98g8AI1Lb/+JFLCgd5181gunRnlSB058ZXTS
jCdvUJHkwat3lIa6iWmIG3LID4V3uQpHh3QhKOZjt5IqtNgEpwj5kCD4lupZRv95
9B8KSL+2ZDrkI1mxl+Tq9OBi0UyW953vcXZLbXbDkl0TXmAB4wEdc6ODgOvkOmCq
aDCWJgfiL2jUyEJGSVhH
=ZW+p
-----END PGP SIGNATURE-----
