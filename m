From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/6] ARM: OMAP2+: some PM fixes and cleanup for 3.9
Date: Fri, 23 Nov 2012 20:42:31 -0700
Message-ID: <20121124033809.24638.11090.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57016 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab2KXDoP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 22:44:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Several OMAP2+ power management fixes, optimizations, and cleanup,
intended for 3.9.  This series is a prerequisite for the functional
powerdomain conversion series.


- Paul

---

vmlinux object size
(delta in bytes from TEST_cleanup-prcm_c9d501e5_v3.7-rc (c9d501e5cb0238910337213e12a09127221c35d8)):
   text     data      bss    total  kernel
      0        0        0        0  am33xx_only
    +56        0        0      +56  n800_multi_omap2xxx
    +56        0        0      +56  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +160        0        0     +160  omap2plus_defconfig
    +88        0        0      +88  omap2plus_defconfig_2430sdp_only
   +108        0        0     +108  omap2plus_defconfig_cpupm
   +160        0        0     +160  omap2plus_defconfig_no_pm
    +32        0        0      +32  omap2plus_defconfig_omap2_4_only
    -84        0        0      -84  omap2plus_defconfig_omap3_4_only
   +304        0      -48     +256  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
   +304        0      -48     +256  rmk_omap4430_sdp_allnoconfig
    -48        0        0      -48  rmk_omap4430_sdp_oldconfig


Jean Pihet (1):
      ARM: OMAP2+: powerdomain: fix powerdomain trace integration

Paul Walmsley (5):
      ARM: OMAP2xxx: powerdomain: core powerdomain missing logic retention states
      ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return values
      ARM: OMAP3xxx: CPUIdle: simplify the PER next-state code
      ARM: OMAP3xxx: CPUIdle: optimize __omap3_enter_idle()
      ARM: OMAP4: MPUSS PM: remove unnecessary shim functions for powerdomain control


 arch/arm/mach-omap2/cpuidle34xx.c           |   79 ++++++++++++++----------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c   |   43 ++-----------
 arch/arm/mach-omap2/powerdomain.c           |    7 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c |    1 
 arch/arm/mach-omap2/prm2xxx.c               |   88 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c          |   22 -------
 arch/arm/mach-omap2/prm3xxx.c               |   28 ++++++++-
 7 files changed, 166 insertions(+), 102 deletions(-)

