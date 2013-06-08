From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: hwmod/PRCM: add OMAP5 data
Date: Sat, 8 Jun 2013 20:05:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1306082003200.7001@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:52218 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab3FHUFh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 16:05:37 -0400
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

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.11

for you to fetch changes up to e4020aa9a8f37d860024fe8a8c8441f003606d2b:

  ARM: OMAP5: Enable build and frameowrk initialisations (2013-06-08 12:00:05 -0600)

- ----------------------------------------------------------------
Add support for the OMAP5 SoC family.

As part of the transition to DT, no board files will be used
for OMAP5.  The hwmod data is gradually being transitioned
away from arch/arm/mach-omap2: IRQ, DMA, and memory map data
has been moved to DT.  Hopefully the dev_attr and clock role
data will be the next step.

Basic test logs are available here, although not for OMAP5,
since I don't have an OMAP5 board:
http://www.pwsan.com/omap/testlogs/omap5_v3.10/20130608130949/

- ----------------------------------------------------------------
Benoit Cousson (7):
      ARM: OMAP5: PRM: Add OMAP54XX register and bitfield files
      ARM: OMAP5: CM: Add OMAP54XX register and bitfield files
      ARM: OMAP5: PRCM: Add OMAP54XX local MPU PRCM registers
      ARM: OMAP5: SCRM: Add OMAP54XX header file.
      ARM: OMAP5: clockdomain data: Add OMAP54XX data and update the header
      ARM: OMAP5: powerdomain data: Add OMAP54XX data and update the header
      ARM: OMAP5: hwmod data: Create initial OMAP5 SOC hwmod data

Santosh Shilimkar (5):
      ARM: OMAP4+: PRM: Move function prototypes to common header for re-use
      ARM: OMAP4+: CM: Move function prototypes to common header for re-use
      ARM: OMAP4+: PRCM MPU: Move function prototypes to common header for re-use
      ARM: OMAP5: voltagedomain data: Add OMAP5 voltage domain data
      ARM: OMAP5: Enable build and frameowrk initialisations

 arch/arm/mach-omap2/Makefile                  |    4 +
 arch/arm/mach-omap2/clockdomain.h             |    1 +
 arch/arm/mach-omap2/clockdomains54xx_data.c   |  464 +++++
 arch/arm/mach-omap2/cm-regbits-54xx.h         | 1737 ++++++++++++++++
 arch/arm/mach-omap2/cm1_44xx.h                |    7 +-
 arch/arm/mach-omap2/cm1_54xx.h                |  213 ++
 arch/arm/mach-omap2/cm2_44xx.h                |    7 +-
 arch/arm/mach-omap2/cm2_54xx.h                |  389 ++++
 arch/arm/mach-omap2/cm_44xx_54xx.h            |   36 +
 arch/arm/mach-omap2/io.c                      |    6 +
 arch/arm/mach-omap2/omap_hwmod.h              |    1 +
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c    | 2151 ++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h             |    1 +
 arch/arm/mach-omap2/powerdomains54xx_data.c   |  331 +++
 arch/arm/mach-omap2/prcm44xx.h                |    6 +
 arch/arm/mach-omap2/prcm_mpu44xx.h            |   14 +-
 arch/arm/mach-omap2/prcm_mpu54xx.h            |   87 +
 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h      |   36 +
 arch/arm/mach-omap2/prm-regbits-54xx.h        | 2701 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h                 |   33 +-
 arch/arm/mach-omap2/prm44xx_54xx.h            |   58 +
 arch/arm/mach-omap2/prm54xx.h                 |  421 ++++
 arch/arm/mach-omap2/scrm54xx.h                |  231 +++
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains54xx_data.c |  102 +
 25 files changed, 8983 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_54xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_54xx.h
 create mode 100644 arch/arm/mach-omap2/cm_44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_54xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains54xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu54xx.h
 create mode 100644 arch/arm/mach-omap2/prcm_mpu_44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/prm-regbits-54xx.h
 create mode 100644 arch/arm/mach-omap2/prm44xx_54xx.h
 create mode 100644 arch/arm/mach-omap2/prm54xx.h
 create mode 100644 arch/arm/mach-omap2/scrm54xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains54xx_data.c

vmlinux object size
(delta in bytes from test_v3.10-rc4 (d683b96b072dc4680fc74964eca77e6a23d1fa6e)):
   text     data      bss    total  kernel
      0        0        0        0  am33xx_only
      0        0        0        0  n800_multi_omap2xxx
      0        0        0        0  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
  +8400   +19856      +64   +28320  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
  +4304   +19888        0   +24192  omap2plus_defconfig_cpupm
  +4304   +19216        0   +23520  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0        0        0        0  omap2plus_defconfig_omap3_4_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
      0        0        0        0  rmk_omap4430_sdp_allnoconfig
      0        0        0        0  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from test_v3.10-rc4 (d683b96b072dc4680fc74964eca77e6a23d1fa6e))
  avail  rsrvd   high  freed  board          kconfig
   -28k    28k      .      .  2430sdp        omap2plus_defconfig
   -28k    28k      .      .  3517evm        omap2plus_defconfig
   -28k    28k      .      .  3530es3beagle  omap2plus_defconfig
   -28k    28k      .      .  3730beaglexm   omap2plus_defconfig
   -28k    28k      .      .  4430es2panda   omap2plus_defconfig
   -28k    28k      .      .  4460pandaes    omap2plus_defconfig

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRs430AAoJEMePsQ0LvSpLbToQALJiLerTnNzfXarzbh5WCVsa
6y8tSuLRYK3HExtQdR8KCLM/RDQw2J/8CRZqFD0QOy0lv+rHbOP85lCaFFNfd3Hj
G2M60ibMSotkLTUQZvK3nDXiI7BqZFwkr+OTJK3OhTWrasfI9RFl7ld9/DU/YiK+
gJmwOyHvhUUGLQp09IRyG9vX4bq/OvCxdLLU3LAsu8/eu9FYqz+kvnBabAEKzOat
p6RDuHodWjeP5I0R10yNI+qSj0K487FLf2RwyntbsSiijx9jHH3/4Iv8Y0dYZI11
EtpMJcejlf6Cnz00ctbQXmBIzN28l1XLhD3zB9DyjjXY0AUJpsJONGq/EhFeVXFL
uERhsYAzNd9VGEi8xrL6GISVNLrNPxsgtzoN96cpM0Zz4YzOPa0kVb2Oq9NMCuj6
CBBfl3ASkTXc3e8SQ/1UUE81YLw1YYDM59x9mITZ11Isc8E4OMT8LvXZk4piV45j
RSmwBqdDjXczRiZAue8aljrnumWAKDkpyM7FPlwTD4YxvzzILrnwP+hWp0wtNC6w
hPB4pr8I5aoCeO+q0iHNcVMFsiMmEpxIuz2O+9wjmN5twYB+IDUfXhJKt2HePjmF
rl6T3FYqZiuOF2dld8gR9IjQygR3W4gKAAoJfzcql5AOpQaSMCakq1iW+LQoU04W
39dHL83bUff1AWO72JL9
=Ebq7
-----END PGP SIGNATURE-----
