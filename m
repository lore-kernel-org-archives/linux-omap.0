From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: hwmod changes for v3.13
Date: Fri, 11 Oct 2013 17:00:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310111659500.27397@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57821 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab3JKRAw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 13:00:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/hwmod

for you to fetch changes up to ace1e3ec4a2540c783e65884bb7be9cd45a0a295:

  ARM: AM33xx: hwmod: Add RNG module data (2013-10-09 09:02:51 -0600)

- ----------------------------------------------------------------
Some OMAP hwmod changes for 3.13.  Significant changes here include:

- - support for moving some of the hwmod flags to DT data

- - support for the SSI, hardware spinlock, USB host/TLL, and RNG IP
  blocks for various OMAPs

- - a fix that again decouples hwmod data changes from unrelated DT data
  patchsets

Basic test logs are available at:

http://www.pwsan.com/omap/testlogs/prcm_fixes_v3.13/20131009094936/

The summary reports that the 4460varsomom boots are failing, but this looks
incorrect - it's probably a bug in the validation scripts here.

- ----------------------------------------------------------------
Lokesh Vutla (1):
      ARM: AM33xx: hwmod: Add RNG module data

Rajendra Nayak (2):
      ARM: OMAP2+: hwmod: cleanup HWMOD_INIT_NO_RESET usage
      ARM: OMAP2+: hwmod: Extract no-idle and no-reset info from DT

Roger Quadros (1):
      ARM: OMAP5: hwmod data: Add USB Host and TLL modules

Sebastian Reichel (1):
      ARM: OMAP2+: hwmod data: Add SSI information

Suman Anna (3):
      ARM: OMAP2+: hwmod: check for module address space during init
      ARM: OMAP5: hwmod data: Add spinlock data
      ARM: AM33xx: hwmod_data: add the sysc configuration for spinlock

 arch/arm/mach-omap2/omap_hwmod.c           |  49 +++++---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  67 +++++++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  48 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   6 +-
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 185 ++++++++++++++++++++++++++++-
 5 files changed, 325 insertions(+), 30 deletions(-)

vmlinux object size
(delta in bytes from test_v3.12-rc4 (d0e639c9e06d44e713170031fe05fb60ebe680af)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
   +140    +1144        0    +1284  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
   +140    +1168        0    +1308  omap2plus_defconfig_cpupm
   +120        0        0     +120  omap2plus_defconfig_n800_multi_omap2xxx
   +120        0        0     +120  omap2plus_defconfig_n800_only_a
   +140    +1176        0    +1316  omap2plus_defconfig_no_pm
  +4236     +912        0    +5148  omap2plus_defconfig_omap2_4_only
  +4236    +1176        0    +5412  omap2plus_defconfig_omap3_4_only
   +228     +184      -96     +316  rmk_omap3430_ldp_allnoconfig
   +124     +264        0     +388  rmk_omap3430_ldp_oldconfig
   +228       -4      -96     +128  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.12-rc4 (d0e639c9e06d44e713170031fe05fb60ebe680af))
  avail  rsrvd   high  freed  board          kconfig
  (no differences)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSWC5wAAoJEMePsQ0LvSpLs+EP/0XG+FsqgeKnTYCpDtMQahPn
kJqMMs4NYjt/zJ0IBHKQ2M0r2QxwvewKOEhyBdP9Z/v5rAbDp8qujSlTJv+Txt8I
lowbWCqo1UbpdZHTCb6wf4P50F4s/dfsgIBopVsfnI/UBuALMo+ZzpHSfDIAtkMi
aFPEn4tkrDFv/N5jxcF4l+KB6XJumRYv0rK2B+wYxhl0v3szSfpSFCVomjCxgGdw
qd/X4CBf/ot3v5F5ePWK8EUHI/nO0xEYnuMNhoK4r3zFYBG+HLrHAW/XECqL/8iT
Hcng4PggPLvV3FehsNHJWgNRmW2aiXZbPRS3Zvf0GjxUaQb1GVwz+hJj821rFl2Y
AQnDUUmb5c+gvfYlPFrR/VzckZsn14nxnYwZl8gZqFVQbRjyUskBkHRKjKtDsQDW
K62aCwbKVsAhyhPmjUUYwmjPM01k/slFvlFAr/puT9Uv6fSIFV2zaAdikOexFY+0
oeTsW94l5POJ24KpfwGY5812KbAyjpulJuFMus4IKFiaZQ5ElEiPAipQJzV1Qv6S
FEtzR0BEipXUT5Jp3hKGVbLcJdmJwGpBPhnoXtYGMlAezcq0Hoy5g0hMEPDaY8XW
nEJgJdVUlj6Jp6Jva7R5uxAfJxctoXBh1YOBS4HfkT+VP7K1IC4JBpx7mLhThYW6
oFHHRoVthqB0nyF/axHS
=pWEm
-----END PGP SIGNATURE-----
