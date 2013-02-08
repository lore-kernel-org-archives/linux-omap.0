From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: standardize integration for AES & SHA/MD5
 IP blocks for 3.9
Date: Fri, 8 Feb 2013 17:53:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081752190.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50600 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946833Ab3BHRxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 12:53:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:

  Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-c-for-3.9

for you to fetch changes up to e6d231f899c1625a88dd369ab973dced4b49ee45:

  ARM: AM33XX: hwmod: Update and uncomment AES0 module data (2013-02-08 09:28:59 -0700)

- ----------------------------------------------------------------
For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
code and data to use hwmod and omap_device.  This is a prerequisite for moving
the hwmod code out of arch/arm.

Basic test logs are available at:

    http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.9/20130208093215/

- ----------------------------------------------------------------

vmlinux object size
(delta in bytes from test_v3.8-rc6 (88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7)):
   text     data      bss    total  kernel
   +184     +904        0    +1088  am33xx_only
   +184     +616        0     +800  n800_multi_omap2xxx
   +184     +552        0     +736  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +196    +2176        0    +2372  omap2plus_defconfig
   +184     +616        0     +800  omap2plus_defconfig_2430sdp_only
   +196    +2168        0    +2364  omap2plus_defconfig_cpupm
  +4292    +2176        0    +6468  omap2plus_defconfig_no_pm
   +184     +616        0     +800  omap2plus_defconfig_omap2_4_only
   +196    +1600        0    +1796  omap2plus_defconfig_omap3_4_only
   +336    +1968     -128    +2176  rmk_omap3430_ldp_allnoconfig
  +4276    +1512        0    +5788  rmk_omap3430_ldp_oldconfig
   +336    +1968     -128    +2176  rmk_omap4430_sdp_allnoconfig
   +168     +856        0    +1024  rmk_omap4430_sdp_oldconfig

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
 arch/arm/mach-omap2/cclock3xxx_data.c              |    4 +-
 arch/arm/mach-omap2/devices.c                      |  149 +++--------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    2 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |    2 +
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |   36 ++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   81 +++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   92 +++++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  172 +++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    4 +
 11 files changed, 402 insertions(+), 154 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFTsrAAoJEMePsQ0LvSpLAKAQAJeqQeyztIQTa38n2PyDpVvr
I1sYP+61f6oxAYcHvqnUs476C6/ct2JNPvofyAneGDzG5Qi98+P9c6BnMwVr76ni
8ncgZN8XvoTnH9pll8+KAtsh6ydxmjmsad+2EUvJQxv4X99tvN/8iFntZuwNz8eR
Jw4HdOZoxdVHvbZmOMwfR+Nb7T2kOQpCv5yUendvaZbrD0/uGDFB+cssvqd/xpOs
ARgDvzxzKAAzJQZwIqejasSxMCH2Xn6q8UbfcwRAZcripjCRBL1eJHaluY8P853p
4rCPZSDISuIKIVIJvdeoTfnvinzdbOmdsZ4W7QixFyfbfiFyJTrV6Oyj28dFvfeu
4SGD6g/QVNTMFFIgMV6w1JaR2wA/Z0uEfidrmx8KcRGc+bZq7MvUKXm2JMwrYqkC
xEZWcVNc+ZYNR+9PEBWWQIzifYmMOsrmH5qWgneNv0Vh9sAZdU2ZRPDGWpmxsnYA
oiDu/tWXnO0Fn2mEcGvtdKF2ByK6vWVPS8zfJybmxI/th1beavYZrVy1JVu5dGbk
8hwY6E239ddvqLMSHzj6ZzUbjkhZTuYj/Zk8aTd9ZcclJybKaax9/L2r1uDco2LB
y2fuIJrSs1MwI7TC9YPdu3rIciPdJnBoAoySwW91EB9IYpIJYEvgjO5FjMcddP6n
ST1u2JGzuZuS2iWZqiEe
=pmIz
-----END PGP SIGNATURE-----
