From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP AM33xx: fixes and IP block integration support
 for 3.9
Date: Fri, 8 Feb 2013 17:21:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081720360.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50435 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946769Ab3BHRVo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 12:21:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.9

for you to fetch changes up to 169c82a294e3722eb1e82b7dac58b35fe2119b80:

  ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug (2013-02-08 08:21:13 -0700)

- ----------------------------------------------------------------
Fixes and IP block support for the TI AM33xx family of SoCs.  These
are prerequisites for power management and some PWM driver changes.

Basic test logs are available from:

   http://www.pwsan.com/omap/testlogs/am33xx_fixes_a_3.9/20130208084835/

although it must be noted that I am unable to test these patches on
AM33xx due to an unknown problem with v3.8-rc kernels:

   http://www.mail-archive.com/linux-omap@vger.kernel.org/msg83525.html

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
   text     data      bss    total  kernel
      0    +1568        0    +1568  am33xx_only
      0        0        0        0  n800_multi_omap2xxx
      0        0        0        0  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
      0    +1504        0    +1504  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
      0    +1504        0    +1504  omap2plus_defconfig_cpupm
    -64    +1504        0    +1440  omap2plus_defconfig_no_pm
      0        0        0        0  omap2plus_defconfig_omap2_4_only
      0    +1504        0    +1504  omap2plus_defconfig_omap3_4_only
    +40    +1312      -72    +1280  rmk_omap3430_ldp_allnoconfig
  +4064    +1504        0    +5568  rmk_omap3430_ldp_oldconfig
    +40    +1312      -72    +1280  rmk_omap4430_sdp_allnoconfig
      0    +1312        0    +1312  rmk_omap4430_sdp_oldconfig


Hebbar Gururaja (2):
      ARM: OMAP2+: AM33xx: hwmod: add missing HWMOD_NO_IDLEST flags
      ARM: OMAP2: am33xx-hwmod: Fix "register offset NULL check" bug

Philip Avinash (2):
      ARM: OMAP: AM33xx hwmod: Corrects PWM subsystem HWMOD entries
      ARM: OMAP: AM33xx hwmod: Add parent-child relationship for PWM subsystem

Vaibhav Bedia (8):
      ARM: OMAP2+: AM33XX: CM: Get rid of unnecessary header inclusions
      ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
      ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
      ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
      ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
      ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset status bit
      ARM: OMAP2+: AM33XX: Update the hardreset API
      ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3

 arch/arm/boot/dts/am33xx.dtsi              |   14 +
 arch/arm/mach-omap2/cm33xx.c               |    3 -
 arch/arm/mach-omap2/cm33xx.h               |    9 +-
 arch/arm/mach-omap2/omap_hwmod.c           |    5 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  443 +++++++++++++++++-----------
 arch/arm/mach-omap2/prm33xx.c              |   11 +-
 arch/arm/mach-omap2/prm33xx.h              |    4 +-
 7 files changed, 306 insertions(+), 183 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFTPTAAoJEMePsQ0LvSpLx1oP/RunMNdyrCfobJgPLmnTzWJ5
K4M2WSPaffqC8CwKye97ZknrWAe1Z1EIO0N4f3t85B1aILIUGJKdYS/f5FRLENRV
I21OhYoVAhCCi/J8BefaLsp0R5znMuSGOFvTqyZDoSOFmiiG9ti5pJKwtqozi5w4
YwmInpNB2vNngHyz1WkGKkcYAtd3VEXa7GbhnRyaEZqlV6UQZVm1T3owlEJw5F+K
SCJMM6NEb9bIsBAI+zIuUB+pK0NkOFX7JLe71XtI34eJi0fsCg7xxT1/rcUz4syr
3uij66VwBh8CRX+nIQj6lmbFedKbgPke8EvmKFDhnG0v3NCJE+4+xeSM3kxld+zO
YZ8j+xHX2duR3CYr+pDHG8SQlaNytoP8akotJR0FskNGaOhyBrFvJhfFX43+ILnE
/OQFWbggaBAUC1xkYc6D5SebOg4p21RHD2alc99i9S4SNkc5fNCJvv98ac6OBTGo
BW+4s7txxw3wt6znxFK1eTWcoegP/9vPf9dphRjudvZIhxk1HN9aADj/6qG11Qzy
uZ31WI2dQXNUvkbTr8m0Dovtv1X+2woWlOO4orWWOfNjiS1KJXCvxkw2pFwS3Rte
t2wTPu3m1vd3+0BBAWJ3Y1iJIocCRWJeweqLHb3Vlpohb3ye4UCDwhEPglB+mZo6
GjN2e/hzd6tyCpGfR0gc
=w+TP
-----END PGP SIGNATURE-----
