From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 00/12] ARM: OMAP2+: powerdomain updates after the functional
 power state conversion
Date: Sun, 09 Dec 2012 13:02:57 -0700
Message-ID: <20121209200108.3196.12452.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40182 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab2LIUFG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 9 Dec 2012 15:05:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

OMAP powerdomain code updates, implemented on top of the
functional power state conversion series.  This series fixes the powerdomain
handling for OMAP2xxx, adds caching for the powerdomain next-power-state
and previous-power-state register bitfields, and some cleanup that's
intended to make it easier to move the powerdomain code out to drivers/.

- Paul

---

vmlinux object size
(delta in bytes from TEST_func_powerstates_devel_3.9 (6d8345f4177c976eca1a1368cdd68e95f80c3f27)):
   text     data      bss    total  kernel
    -68      +48        0      -20  am33xx_only
   -136      +48        0      -88  n800_multi_omap2xxx
   -128      +48        0      -80  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
    -32     +368        0     +336  omap2plus_defconfig
    +20      +16        0      +36  omap2plus_defconfig_2430sdp_only
    -32     +432        0     +400  omap2plus_defconfig_cpupm
   +572     +192        0     +764  omap2plus_defconfig_no_pm
    -20     +208        0     +188  omap2plus_defconfig_omap2_4_only
    -84     +304        0     +220  omap2plus_defconfig_omap3_4_only
   +708     +200     -104     +804  rmk_omap3430_ldp_allnoconfig
   +352     +128        0     +480  rmk_omap3430_ldp_oldconfig
   +708     +200     -104     +804  rmk_omap4430_sdp_allnoconfig
   -164       +8        0     -156  rmk_omap4430_sdp_oldconfig

Paul Walmsley (12):
      ARM: OMAP2+: powerdomain: consolidate arch_pwrdm check code
      ARM: OMAP2+: PM/powerdomain: move the power state time tracking into the powerdomain code
      ARM: OMAP2+: powerdomain: split pwrdm_state_switch()
      ARM: OMAP2+: PM: clean up some debugfs functions
      ARM: OMAP2+: powerdomain: remove some redundant checks; add some notes
      ARM: OMAP2+: CM: use the cached copy of the clockdomain's hwsup state
      ARM: OMAP2+: powerdomain: cache the powerdomain next power state
      ARM: OMAP2+: powerdomain: cache the powerdomain's previous power state
      ARM: OMAP2+: powerdomain: skip register reads for powerdomains known to be on
      ARM: OMAP2+: powerdomain: skip previous-power-state read if next_pwrst is ON
      ARM: OMAP2xxx: powerdomain: add previous power state tracking
      ARM: OMAP2xxx: PM: add pwrdm_(pre|post)_transition() calls to the 2xxx PM code


 arch/arm/mach-omap2/clockdomain.c           |   18 +
 arch/arm/mach-omap2/clockdomain.h           |    2 
 arch/arm/mach-omap2/cm2xxx.c                |   19 -
 arch/arm/mach-omap2/cm3xxx.c                |   14 -
 arch/arm/mach-omap2/pm-debug.c              |  101 --------
 arch/arm/mach-omap2/pm.h                    |    6 
 arch/arm/mach-omap2/pm24xx.c                |    8 +
 arch/arm/mach-omap2/powerdomain.c           |  352 +++++++++++++++++++--------
 arch/arm/mach-omap2/powerdomain.h           |   40 +++
 arch/arm/mach-omap2/powerdomains2xxx_data.c |    2 
 arch/arm/mach-omap2/powerdomains33xx_data.c |    3 
 arch/arm/mach-omap2/powerdomains3xxx_data.c |    9 -
 arch/arm/mach-omap2/powerdomains44xx_data.c |    5 
 arch/arm/mach-omap2/prm2xxx.c               |   12 +
 14 files changed, 347 insertions(+), 244 deletions(-)

