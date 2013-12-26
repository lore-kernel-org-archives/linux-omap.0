From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod data: a few more fixes for v3.13-rc
Date: Thu, 26 Dec 2013 10:26:37 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1312261025340.15949@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42240 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3LZK0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Dec 2013 05:26:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 374b105797c3d4f29c685f3be535c35f5689b30e:

  Linux 3.13-rc3 (2013-12-06 09:34:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13-rc/hwmod-fixes-b

for you to fetch changes up to 6d4c88304794442055eaea1c07f3c7b988b8c924:

  ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in irq data (2013-12-25 21:41:27 -0700)

- ----------------------------------------------------------------
A few OMAP hwmod fixes for v3.13-rc.  One patch fixes some IRQ
problems with GPMC, RNG, and ISP/IVA MMUs on OMAP2/3.  The other fixes
some problems with DEBUG_LL on DRA7xx.

Basic build, boot, and PM test logs are available here:

http://www.pwsan.com/omap/testlogs/hwmod_fixes_b_v3.13-rc/20131226021920/

- ----------------------------------------------------------------
Rajendra Nayak (1):
      ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL

Suman Anna (1):
      ARM: OMAP2+: hwmod_data: fix missing OMAP_INTC_START in irq data

 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c | 4 ++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         | 6 +++---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)



vmlinux object size
(delta in bytes from test_v3.13-rc3 (374b105797c3d4f29c685f3be535c35f5689b30e)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
      0        0        0        0  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0        0        0        0  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
      0        0        0        0  omap2plus_defconfig_n800_only_a
      0        0        0        0  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0        0        0        0  omap2plus_defconfig_omap3_4_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
      0        0        0        0  rmk_omap4430_sdp_allnoconfig
      0        0        0        0  rmk_omap4430_sdp_oldnoconfig

Boot-time memory difference
(delta in bytes from test_v3.13-rc3 (374b105797c3d4f29c685f3be535c35f5689b30e))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSvAQQAAoJEMePsQ0LvSpLGJQP/2A1HM+I/Wy5Qe8q1yt9yCfj
tkurkBgHUsdJv0rZjHN7cbLlyBV0yZ2OmKVi813drOeVo6/YfkFHwloJTLDe9h67
VLher5mFQmvB0IaSxpFmiRSg5UPtEovAMDs7jf6RD4woU4/8CQi9Jgbp04GnO6ro
PVIDpKZFZG7ce/JR7pab5rNsx8i59KxdquHJWJeOVynY9BZvhB9Sx7EdRMV6uqYm
9rVYU35uSeS4M7sUuEm44LZtcs8VoSLRINS3j0B2JROR29q57FCb0PRL7fW0kGOF
0ixNmXuWm5STKe7JnDjw9RwanV9XR0spGkdHUUEsvY1o55il+TouHJvTEPsrutoC
l/CaezQrzQldr7JdSgKIdkJDnBPFD+Ri4Bt8zZzMVI+/Xj/BvBU54k+9RihXJPUZ
BZz7KE9N/iAJ7uDuQITY5BlmaGLo3mXXEBtG5ws8hQcaOqZ/wQbKAB6e8qM71FTU
VhJ5WAA5uP84gkh/hJ2pZZYtJLslG9QHPjLg8NzuYwC/WCnsTkyrVG68Ns/j8Vbo
FP01VfkGZsV2zA6vvWadXmqseN1jq6lg89pKwp31aZziqmz76cD6kV+CPCataYPq
BcNDbQZ21mtnRLUdM2NldrV44U/Lk7GDVZUM+2L+JNBZGpE22UdcIwc4JJPvuOsx
xGnYkOgdtP5ZblgY0ioB
=z30o
-----END PGP SIGNATURE-----
