From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/10] ARM: OMAP2+: second set of PM fixes and cleanup for
 3.9
Date: Sat, 08 Dec 2012 18:23:34 -0700
Message-ID: <20121209011755.19716.25244.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38987 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756440Ab2LIBYb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Dec 2012 20:24:31 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Several more OMAP2+ power management fixes, optimizations, and
cleanup, intended for 3.9.  This series is also a prerequisite for the
functional powerdomain conversion series.

I'll plan to bundle these patches together into a pull request with the first
set of 3.9 PM patches, sent earlier.

- Paul

---

vmlinux object size
(delta in bytes from TEST_pm_cleanup_fixes_a_3.9 (8f5e20850396fc60fd4ee01f586705033902bb53)):
   text     data      bss    total  kernel
   +460     -368        0      +92  am33xx_only
   +200     -464        0     -264  n800_multi_omap2xxx
   +192     -144        0      +48  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +296    -1816        0    -1520  omap2plus_defconfig
   +272     -176        0      +96  omap2plus_defconfig_2430sdp_only
   +232    -1816        0    -1584  omap2plus_defconfig_cpupm
   +280    -1520        0    -1240  omap2plus_defconfig_no_pm
  +4388    -1016        0    +3372  omap2plus_defconfig_omap2_4_only
   +468     -952        0     -484  omap2plus_defconfig_omap3_4_only
   +700     -584     -144      -28  rmk_omap3430_ldp_allnoconfig
   +452     -648        0     -196  rmk_omap3430_ldp_oldconfig
   +700     -584     -144      -28  rmk_omap4430_sdp_allnoconfig
   +424     -328        0      +96  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from TEST_pm_cleanup_fixes_a_3.9 (8f5e20850396fc60fd4ee01f586705033902bb53))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  2430sdp        omap2plus_defconfig
     4k    -4k      .      .  3517evm        omap2plus_defconfig
     4k    -4k      .      .  3530es3beagle  omap2plus_defconfig
     4k    -4k      .      .  3730beaglexm   omap2plus_defconfig
     4k    -4k      .      .  37xxevm        omap2plus_defconfig
     4k    -4k      .      .  4430es2panda   omap2plus_defconfig
     4k    -4k      .      .  cmt3517        omap2plus_defconfig

Paul Walmsley (10):
      ARM: OMAP3/4: cpuidle: fix sparse and checkpatch warnings
      ARM: OMAP2+: clockdomain: add pwrdm_state_switch() call to clkdm_sleep()
      ARM: OMAP2xxx: PM: clean up some crufty powerstate programming code
      ARM: OMAP2: PM/powerdomain: drop unnecessary pwrdm_wait_transition()
      ARM: OMAP2+: PM/powerdomain: move omap_set_pwrdm_state() to powerdomain code
      ARM: OMAP2+: powerdomain/clockdomain: add a per-powerdomain spinlock
      ARM: OMAP2xxx: CM: remove autodep handling
      ARM: OMAP2+: clockdomain: work on wkdep/sleepdep functions
      ARM: OMAP2+: clockdomain: convert existing atomic usecounts into spinlock-protected shorts/ints
      ARM: OMAP2+: powerdomain: fix whitespace, improve flag comments


 arch/arm/mach-omap2/clockdomain-powerdomain.h    |   22 +
 arch/arm/mach-omap2/clockdomain.c                |  550 +++++++++++++++-------
 arch/arm/mach-omap2/clockdomain.h                |   17 -
 arch/arm/mach-omap2/cm2xxx.c                     |   33 -
 arch/arm/mach-omap2/cm3xxx.c                     |   14 -
 arch/arm/mach-omap2/cminst44xx.c                 |    2 
 arch/arm/mach-omap2/cpuidle34xx.c                |   14 -
 arch/arm/mach-omap2/cpuidle44xx.c                |   28 +
 arch/arm/mach-omap2/pm-debug.c                   |    6 
 arch/arm/mach-omap2/pm.c                         |   65 ---
 arch/arm/mach-omap2/pm.h                         |    1 
 arch/arm/mach-omap2/pm24xx.c                     |   30 -
 arch/arm/mach-omap2/powerdomain-clockdomain.h    |   27 +
 arch/arm/mach-omap2/powerdomain.c                |  176 +++++--
 arch/arm/mach-omap2/powerdomain.h                |   42 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    4 
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    8 
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   44 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |    3 
 19 files changed, 661 insertions(+), 425 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain-powerdomain.h
 create mode 100644 arch/arm/mach-omap2/powerdomain-clockdomain.h

