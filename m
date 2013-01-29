From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: powerdomain & clockdomain cleanup and fixes
 for 3.9
Date: Tue, 29 Jan 2013 22:36:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1301292235330.11442@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:41063 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3A2WhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jan 2013 17:37:00 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-b-for-3.9

for you to fetch changes up to 562e54d13b6e0b17f72c9e629e1fd0b71e2a8a36:

  ARM: OMAP2+: powerdomain: fix whitespace, improve flag comments (2013-01-29 14:59:58 -0700)

- ----------------------------------------------------------------
Several OMAP2+ power management fixes, optimizations, and cleanup.
This series is a prerequisite for the functional powerdomain
conversion series.

Basic test logs for this branch are here:

    http://www.pwsan.com/omap/testlogs/pm_cleanup_fixes_3.9/20130129150017/

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.8-rc5 (949db153b6466c6f7cad5a427ecea94985927311)):
   text     data      bss    total  kernel
   +452     -400        0      +52  am33xx_only
   +372     -464        0      -92  n800_multi_omap2xxx
   +404     -144        0     +260  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
    +64    -1784        0    -1720  omap2plus_defconfig
   +232     -208        0      +24  omap2plus_defconfig_2430sdp_only
    +12    -1792        0    -1780  omap2plus_defconfig_cpupm
    +48    -1576        0    -1528  omap2plus_defconfig_no_pm
    +60    -1016        0     -956  omap2plus_defconfig_omap2_4_only
   +300    -1336        0    -1036  omap2plus_defconfig_omap3_4_only
   +636     -560     -144      -68  rmk_omap3430_ldp_allnoconfig
   +420     -616        0     -196  rmk_omap3430_ldp_oldconfig
   +636     -560     -144      -68  rmk_omap4430_sdp_allnoconfig
   +344     -328        0      +16  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.8-rc5 (949db153b6466c6f7cad5a427ecea94985927311))
  avail  rsrvd   high  freed  board          kconfig
     4k    -4k      .      .  2430sdp        omap2plus_defconfig
     4k    -4k      .      .  3530es3beagle  omap2plus_defconfig
     4k    -4k      .      .  3730beaglexm   omap2plus_defconfig
     4k    -4k      .      .  37xxevm        omap2plus_defconfig
     4k    -4k      .      .  4430es2panda   omap2plus_defconfig
     4k    -4k      .      .  4460pandaes    omap2plus_defconfig
     4k    -4k      .      .  cmt3517        omap2plus_defconfig

Jean Pihet (1):
      ARM: OMAP2+: powerdomain: fix powerdomain trace integration

Paul Walmsley (13):
      ARM: OMAP2xxx: powerdomain: core powerdomain missing logic retention states
      ARM: OMAP3xxx: CPUIdle: simplify the PER next-state code
      ARM: OMAP3xxx: CPUIdle: optimize __omap3_enter_idle()
      ARM: OMAP4: MPUSS PM: remove unnecessary shim functions for powerdomain control
      ARM: OMAP2+: clockdomain: add pwrdm_state_switch() call to clkdm_sleep()
      ARM: OMAP2xxx: PM: clean up some crufty powerstate programming code
      ARM: OMAP2: PM/powerdomain: drop unnecessary pwrdm_wait_transition()
      ARM: OMAP2+: PM/powerdomain: move omap_set_pwrdm_state() to powerdomain code
      ARM: OMAP2+: powerdomain/clockdomain: add a per-powerdomain spinlock
      ARM: OMAP2xxx: CM: remove autodep handling
      ARM: OMAP2+: clockdomain: work on wkdep/sleepdep functions
      ARM: OMAP2+: clockdomain: convert existing atomic usecounts into spinlock-protected shorts/ints
      ARM: OMAP2+: powerdomain: fix whitespace, improve flag comments

 arch/arm/mach-omap2/clockdomain.c                |  569 ++++++++++++++--------
 arch/arm/mach-omap2/clockdomain.h                |   17 +-
 arch/arm/mach-omap2/cm2xxx.c                     |   33 +-
 arch/arm/mach-omap2/cm3xxx.c                     |   14 +-
 arch/arm/mach-omap2/cminst44xx.c                 |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c                |   79 +--
 arch/arm/mach-omap2/omap-mpuss-lowpower.c        |   44 +-
 arch/arm/mach-omap2/pm-debug.c                   |    6 +-
 arch/arm/mach-omap2/pm.c                         |   65 +--
 arch/arm/mach-omap2/pm.h                         |    1 -
 arch/arm/mach-omap2/pm24xx.c                     |   30 +-
 arch/arm/mach-omap2/powerdomain.c                |  232 +++++++--
 arch/arm/mach-omap2/powerdomain.h                |   52 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    4 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    9 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   44 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c               |    3 +-
 17 files changed, 710 insertions(+), 494 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCE2vAAoJEMePsQ0LvSpLKI0P/3fFmnbbsOvjLL5J2i0TK8gL
rtfy5pOlx2k9GVAx98j5JsJMSHQfdUQ7xZ4yY1AtLrr76pY6df9cSL9hDB/Sfcf8
sqDITtL+POzZIRxtmwnffmvkNJ1hqhbOt0vg4Qlu2mSjTpdfZweDcqKD9u393Wp9
pkFLfvb/+boCdHGj/0v7Tzidi1TLSPV2ezdHY6gPwB+uM2pMO1Zw746cCxHpz16v
4tcGCZ9NKj4iMQJzJG/rdI1oIPrQ735jXZgZhF+BsXEZ7GyKymlWhLZ9iLF7gMPa
p4s2TKE0GoObYeWB1n2lRoWBNOxVfPJGt1ZOJfSEM2kw/S2X0HnEwHJCss1LKhPb
MzJAXhflhVMqb+wZglUF29xIQD7yv71cgdWWdXe3pdAhs7ivqiwhAMpWvl8HHVZO
Y+ASmuQBvzHPtu1GmRv+gXlBRoLUsyuZfTlhyCX7hHGx7beZ3L0TngAlVbAL6F9J
Y0l5vbcjPep8PIa20Wlx3mHw3yTPVBo6NLo5av5ZOW1uo1g3ve94tpb8KAqNyOaN
eBnKhHgLgZHRFV5V0FInWhdPVHqGDFFVT5QtL/1/lMBxe7oOlTvFM3qiFyGRZsI7
R/ur+i0XNt+LFPRNdSY1kCF5BubJZlDCtFeJg1/99IAMa/64ofVEOW+C5+TGf8jV
Bs4eluyYc1agVkfuZfye
=XH66
-----END PGP SIGNATURE-----
