From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: some clock & hwmod changes for v3.11
Date: Sun, 9 Jun 2013 09:11:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306090909190.20050@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:53409 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057Ab3FIJLO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Jun 2013 05:11:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  http://git.kernel.org/cgit/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-b-for-3.11

for you to fetch changes up to 563ce4d51a555b45f5d43ff9cf127da8dac9f64d:

  ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK (2013-06-09 01:12:32 -0600)

- ----------------------------------------------------------------
A few OMAP clock & hwmod changes for v3.11.

Basic test logs are here:

http://www.pwsan.com/omap/testlogs/prcm_devel_v3.11/20130609020805/

- ----------------------------------------------------------------
Philip Avinash (1):
      ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK

Roger Quadros (1):
      ARM: OMAP3: clock data: get rid of unused USB host clock aliases and dummies

Vaibhav Hiremath (1):
      ARM: OMAP2+: AM33xx: Add missing reset status info to GFX hwmod

 arch/arm/mach-omap2/cclock33xx_data.c      |   30 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cclock3xxx_data.c      |   11 ----------
 arch/arm/mach-omap2/control.h              |    8 ++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 ++-
 4 files changed, 40 insertions(+), 12 deletions(-)

vmlinux object size
(delta in bytes from test_v3.10-rc4 (d683b96b072dc4680fc74964eca77e6a23d1fa6e)):
   text     data      bss    total  kernel
      0     +448        0     +448  am33xx_only
      0        0        0        0  n800_multi_omap2xxx
      0        0        0        0  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
  +4096     +192        0    +4288  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0     +192        0     +192  omap2plus_defconfig_cpupm
      0     +192        0     +192  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0     +192        0     +192  omap2plus_defconfig_omap3_4_only
   +176     +128     -176     +128  rmk_omap3430_ldp_allnoconfig
      0     +192        0     +192  rmk_omap3430_ldp_oldconfig
   +176     +128     -176     +128  rmk_omap4430_sdp_allnoconfig
      0     +448        0     +448  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.10-rc4 (d683b96b072dc4680fc74964eca77e6a23d1fa6e))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRtEYNAAoJEMePsQ0LvSpLgmMP/3Vq6DDNCTz6ZjsLG4AugQTc
gdiQwk6RVYOUarJyNnQRPYNeHU3WiRL+v6K8bla577vseQEJ8qiomo0u/KMMDHAa
AC++j7eGxcW7S4rakp6raU+ObRWMllqV3YhGVoGq69Sc/GYADPkOXuB1wdUTVk/6
JXJKwE2/lh6/bDRHZzMr3oyXLEj+iNd3O1Yqc2HpBCYEPg+7U5HLCMBVGM2j8Trn
2sNv6A8CfzKdmrOF+HBDurdESvbWfdm0dUO0hXAa4dc/L63SSiu4+Y9l+MWAmw02
+CDdaHKfhRZXdj4jbwleZpgjeF5HYWWSTBEt9pnhS/qzV2zhZHjwBvdoq2e5aJeM
Nxg3gegQMeqsMjeDAG9NpAASDSVBrKYh+/fdhUBf87EdpQZHfvgK13LKjfeNrljN
YTMLa9A9IdHGWLe9MWiZfFaNlCnazb2Zu5c+i1XYZNS8puucKLaGu87Y7QEptPb9
a67Xqj8dyGWw/cgsxXRCyoXfmpUxigwoSQq3RuUQ/ukyu6JX5veusFW1FWMRtWXp
PA0sjwnEgAiwEpMmnJ4oTC1TzCOhaa7Pl6X8DlYMBkjiIHSjE/MCvG/1PuoXYoJa
6E0qv9dK302iIbWpA/msVFuhAJ9lrDQHP5PWZQALrbI9uF2aVrp8ursI80N3XoPz
ZIsWRfwCRbjesLdEWJUX
=uJ2F
-----END PGP SIGNATURE-----
