From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: standardize integration for AES & SHA/MD5
 IP blocks for 3.10
Date: Sat, 30 Mar 2013 22:47:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1303302244540.6436@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35510 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab3C3WrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Mar 2013 18:47:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 78e52e026d288aad88b46bff0d94b05e145c4583:

  ARM: OMAP2+: clock data: Remove CK_* flags (2013-03-18 09:57:39 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-a-for-3.10

for you to fetch changes up to 1cb804b93f506dfba5fd684a8ea63706aaa8e709:

  ARM: AM33XX: hwmod: Update and uncomment AES0 module data (2013-03-30 15:52:17 -0600)

- ----------------------------------------------------------------
For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
code and data to use hwmod and omap_device. This is a prerequisite for
moving the hwmod code out of arch/arm.

Basic test logs are available at:

   http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.10/20130330155313/

- ----------------------------------------------------------------
vmlinux object size
(delta in bytes from jk_clock_flags_cleanup_3.10 (78e52e026d288aad88b46bff0d94b05e145c4583)):
   text     data      bss    total  kernel
   +152     +640        0     +792  n800_multi_omap2xxx
   +152     +576        0     +728  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
  +4264    +2232        0    +6496  omap2plus_defconfig
   +168    +2232        0    +2400  omap2plus_defconfig_cpupm
   +168    +2232        0    +2400  omap2plus_defconfig_no_pm
   +160     +672        0     +832  omap2plus_defconfig_omap2_4_only
   +168    +1560        0    +1728  omap2plus_defconfig_omap3_4_only
   +316    +2056     -136    +2236  rmk_omap3430_ldp_allnoconfig
   +152    +1576        0    +1728  rmk_omap3430_ldp_oldconfig
   +316    +2056     -136    +2236  rmk_omap4430_sdp_allnoconfig
   +144     +848        0     +992  rmk_omap4430_sdp_oldconfig

Boot-time memory difference
(delta in bytes from jk_clock_flags_cleanup_3.10 (78e52e026d288aad88b46bff0d94b05e145c4583))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2430sdp        omap2plus_defconfig
    -4k     4k      .      .  3517evm        omap2plus_defconfig
    -4k     4k      .      .  3530es3beagle  omap2plus_defconfig
    -4k     4k      .      .  3730beaglexm   omap2plus_defconfig
    -4k     4k      .      .  37xxevm        omap2plus_defconfig
    -4k     4k      .      .  4430es2panda   omap2plus_defconfig
    -4k     4k      .      .  4460pandaes    omap2plus_defconfig

Mark A. Greer (13):
      ARM: OMAP2xxx: hwmod: Convert SHAM crypto device data to hwmod
      ARM: OMAP2xxx: hwmod: Add DMA support for SHAM module
      ARM: OMAP3xxx: hwmod: Convert SHAM crypto device data to hwmod
      ARM: OMAP2+: Remove unnecessary message when no SHA IP is present
      ARM: OMAP2+: Only manually add hwmod data when DT not used.
      ARM: AM33XX: Add sha0 crypto clock data
      ARM: AM33XX: hwmod: Update and uncomment SHA0 module data
      ARM: OMAP2xxx: hwmod: Convert AES crypto devcie data to hwmod
      ARM: OMAP3xxx: hwmod: Convert AES crypto device data to hwmod
      ARM: OMAP2+: Remove unnecessary message when no AES IP is present
      ARM: OMAP2+: Only manually add hwmod data when DT not used.
      ARM: AM33XX: Add aes0 crypto clock data
      ARM: AM33XX: hwmod: Update and uncomment AES0 module data

 arch/arm/mach-omap2/cclock2430_data.c              |    4 +-
 arch/arm/mach-omap2/cclock33xx_data.c              |   10 ++
 arch/arm/mach-omap2/cclock3xxx_data.c              |    2 +
 arch/arm/mach-omap2/devices.c                      |  149 +++--------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   36 ++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   81 +++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   92 +++++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  172 +++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
 11 files changed, 401 insertions(+), 153 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRV2q6AAoJEMePsQ0LvSpLye8P/0L3LTVp4sN2G+mQjVI7Zrkd
t3GIwVJmnquh1zXlkRUjO4zFUeFN6zjnZFeCWO3kfsgppbzNJo2Z5o/CyvdehB4D
mJpactIkYIOteZNW/tGJ91nXUow784552qXZaIiv9Ydxi3yMkEFU2UuusB6eHeWq
22V8gVR3r7pFu0dOcAubcaebjJiBkcX5TMqMlhO0TCQCyKRChQbeZUyCw5/1hJDA
+KqdlUpw21VJhcXAhL+4AuDPXA1GSFKl4KYtdeO9ajBGAopQk7XRPyqPDlZjInXR
034BLk2WnzN3XmCq3d5b4fbrLY/Mh+G6N8f1iM++Z4vgj5h4QwsGa1UvsSRcVTFR
RaQbzIFmBiwPidjXWYe2Em1JcAUTf9QM6vUalxl7mFMdXc4y+DjkSGiMdMkW6o1d
YKUKodjVLbwu8ZUDcsFn6ki1pWpx+M5lKl4DHR737fpTcJggTNMGi/fiOputvsXd
fbIhj4+T/+9/wzh7HXt0SgGHPswJ5QA3s5UMvZRVcHFHftkoEkyhLTp41It6a0VI
gtbtHDODK7zW8V8xTz34Hj9Vra+IsJZZj6Z9F6bcv2EDNlZkTMBvQUsrSdDIqFGr
Z2GSYcae5FKeib2hcee+Fv7qURGkqP329nXKmNKHFcqHV3atkxTJHnquRWNehqxy
8aQ0aNKw9K6bTmTKl3Ct
=DiqN
-----END PGP SIGNATURE-----
