From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/12] ARM: OMAP2+: powerdomain/PM: convert to functional
 power states
Date: Sun, 09 Dec 2012 10:52:49 -0700
Message-ID: <20121209174545.6933.59371.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:39965 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528Ab2LIRyn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 12:54:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

This series converts the OMAP2+ powerdomain and PM code to use
"functional power states" - high-level power states such as "OSWR",
which reflect changes in multiple underlying registers, rather than
expecting high-level PM code to program the registers directly.  This
is intended to reduce the complexity of the high-level PM code and to
make it easier to implement register caching of the various
powerdomain registers, some of which are quite slow to access.


- Paul

---

vmlinux object size
(delta in bytes from TEST_pm_cleanup_fixes_b_3.9 (2f8d7b1f0048df431ca226d81c5c27c4dd21953b)):
   text     data      bss    total  kernel
   +456      -56        0     +400  am33xx_only
   +448      -96        0     +352  n800_multi_omap2xxx
   +448      -96        0     +352  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
  +1180     -744        0     +436  omap2plus_defconfig
   +584      -72        0     +512  omap2plus_defconfig_2430sdp_only
  +1244     -808        0     +436  omap2plus_defconfig_cpupm
   +976    -1224        0     -248  omap2plus_defconfig_no_pm
   +844     -408        0     +436  omap2plus_defconfig_omap2_4_only
  +1088     -624        0     +464  omap2plus_defconfig_omap3_4_only
  +1292    -1232     -352     -292  rmk_omap3430_ldp_allnoconfig
   +916     -720        0     +196  rmk_omap3430_ldp_oldconfig
  +1292    -1232     -352     -292  rmk_omap4430_sdp_allnoconfig
   +840     -392        0     +448  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from TEST_pm_cleanup_fixes_b_3.9 (2f8d7b1f0048df431ca226d81c5c27c4dd21953b))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  2430sdp        omap2plus_defconfig
    -8k     8k      .      .  3517evm        omap2plus_defconfig
    -8k     8k      .      .  3530es3beagle  omap2plus_defconfig
    -8k     8k      .      .  3730beaglexm   omap2plus_defconfig
    -8k     8k      .      .  37xxevm        omap2plus_defconfig
    -8k     8k      .      .  4430es2panda   omap2plus_defconfig
    -8k     8k      .      .  4460pandaes    omap2plus_defconfig
    -8k     8k      .      .  cmt3517        omap2plus_defconfig

Jean Pihet (6):
      ARM: OMAP2+: PM: introduce power domains functional states
      ARM: OMAP2+: PM debug: trace the functional power domains states
      ARM: OMAP2xxx: PM: convert to use the functional power states API
      ARM: OMAP3xxx: PM: convert to use the functional power states API
      ARM: OMAP44xx: PM: convert to use the functional power states API
      ARM: OMAP2+: PM: use power domain functional state in stats counters

Paul Walmsley (6):
      ARM: OMAP2+: powerdomain: add functions that report on powerdomain capabilities
      ARM: OMAP2+: powerdomain: drop many low-level powerdomain funcs
      ARM: OMAP2+: powerdomain: add ability to test for supported power states
      ARM: OMAP2+: powerdomain/PM: only program supported power states
      ARM: OMAP2+: powerdomain: program memory bank next-power-state upon init
      ARM: OMAP2+: powerdomain: assume memory bank power states follow powerdomain


 arch/arm/mach-omap2/common.h              |    7 
 arch/arm/mach-omap2/cpuidle34xx.c         |   95 +-
 arch/arm/mach-omap2/cpuidle44xx.c         |   32 -
 arch/arm/mach-omap2/omap-hotplug.c        |    2 
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   69 +-
 arch/arm/mach-omap2/pm-debug.c            |   46 -
 arch/arm/mach-omap2/pm.h                  |    2 
 arch/arm/mach-omap2/pm24xx.c              |   33 -
 arch/arm/mach-omap2/pm34xx.c              |  188 +++-
 arch/arm/mach-omap2/pm44xx.c              |   47 +
 arch/arm/mach-omap2/powerdomain.c         | 1235 +++++++++++++++++------------
 arch/arm/mach-omap2/powerdomain.h         |   69 +-
 12 files changed, 1040 insertions(+), 785 deletions(-)

