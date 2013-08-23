From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: miscellaneous PRCM and hwmod updates for
 v3.12
Date: Fri, 23 Aug 2013 19:33:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1308231932400.22768@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38153 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3HWTdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Aug 2013 15:33:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

The following changes since commit b36f4be3de1b123d8601de062e7dbfc904f305fb:

  Linux 3.11-rc6 (2013-08-18 14:36:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.12/omap-prcm-hwmod

for you to fetch changes up to 4514b4d7fcad2a84066c73966c6a7823ea1b3749:

  Merge branches 'hwmod_devel_v3.12', 'prcm_devel_v3.12' and 'am33xx_devel_v3.12' into prcm_a_for_v3.12 (2013-08-23 12:49:48 -0600)

- ----------------------------------------------------------------

Various OMAP PRCM & hwmod fixes and improvements.  Notable changes
include:

- - a fix for OMAP4 PLL locking to avoid a bootloader dependency that
  causes nasty log spew on startup

- - AM33xx DEBUGSS support fixes in hwmod data

- - OMAP5 mailbox support in hwmod data

Basic test logs are here:

http://www.pwsan.com/omap/testlogs/prcm_a_for_v3.12/20130823125002/

Note that the 3530 failure is due to the mysterious transient serial
issue affecting 3530 for several releases now, which causes a log
parsing failure.  PM still seems to work.

- ----------------------------------------------------------------
Aida Mynzhasova (1):
      ARM: OMAP: TI81XX: add always-on powerdomain for TI81XX

Jon Hunter (1):
      ARM: OMAP2+: Only write the sysconfig on idle when necessary

Lokesh Vutla (1):
      ARM: OMAP: AM33xx: clock: Add RNG clock data

Paul Walmsley (1):
      Merge branches 'hwmod_devel_v3.12', 'prcm_devel_v3.12' and 'am33xx_devel_v3.12' into prcm_a_for_v3.12

Rajendra Nayak (1):
      ARM: OMAP4: clock: Lock PLLs in the right sequence

Suman Anna (1):
      ARM: OMAP5: hwmod data: Add mailbox data

Vaibhav Hiremath (1):
      ARM: OMAP: AM33XX: hwmod: Add hwmod data for debugSS

 arch/arm/mach-omap2/cclock33xx_data.c       |  5 +++
 arch/arm/mach-omap2/cclock44xx_data.c       | 20 +++++----
 arch/arm/mach-omap2/omap_hwmod.c            |  4 +-
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c  | 69 ++++++++++++++++++++---------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c  | 42 ++++++++++++++++++
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  8 ++++
 arch/arm/mach-omap2/prcm-common.h           |  1 +
 7 files changed, 118 insertions(+), 31 deletions(-)

vmlinux object size
(delta in bytes from test_v3.11-rc6 (b36f4be3de1b123d8601de062e7dbfc904f305fb)):
   text     data      bss    total  kernel
     -4      -24        0      -28  n800_multi_omap2xxx
    +28        0        0      +28  n800_only_a
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
     -4     +928        0     +924  omap2plus_defconfig
     -4        0        0       -4  omap2plus_defconfig_2430sdp_only
     -4     +928        0     +924  omap2plus_defconfig_cpupm
     -4     +904        0     +900  omap2plus_defconfig_no_pm
     -4        0        0       -4  omap2plus_defconfig_omap2_4_only
     -4     +352        0     +348  omap2plus_defconfig_omap3_4_only
    +16     +192      -16     +192  rmk_omap3430_ldp_allnoconfig
    +32     +256        0     +288  rmk_omap3430_ldp_oldconfig
    +32        0        0      +32  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from test_v3.11-rc6 (b36f4be3de1b123d8601de062e7dbfc904f305fb))
  avail  rsrvd   high  freed  board          kconfig
    -4k     4k      .      .  2430sdp        omap2plus_defconfig
    -4k     4k      .      .  3517evm        omap2plus_defconfig
    -4k     4k      .      .  3530es3beagle  omap2plus_defconfig
    -4k     4k      .      .  3730beaglexm   omap2plus_defconfig
    -4k     4k      .      .  37xxevm        omap2plus_defconfig
    -4k     4k      .      .  am335xbonelt   am33xx_only

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSF7jEAAoJEMePsQ0LvSpLdt0P/jMPV4b9/ZyFHs82JRLKwtKY
e0uGdCr1B1ZNm1BG+zaybDeG3pCWnwucWVrCN6Ezv7RA1REFQnoKE6e2f2TQ7UBS
evb5kRm70A6MKO325Rdr4TcSusm3sNyKcFovs7rrZkjnXwNNDNjtj5VlpWcmEixy
PRxeLSKzCMmobej+fiohCjvAL3CCyihlNL4rfqZBg2zIrQlxOrs6En/c0kOPI7Od
tPxNn+PijqoO8gD3rJaZYKAZ0McoHnWjfReDbNSyUiGZ5nrRAY+83IVc5E6J+oLY
YWU+U+V7AlfpS187T4bbjlZojq1pa2VvW3lGoWdUlevhADtDxzar488DF5GUTN59
dtFTCQTG5e7TkKfHfYNLqffjCmxi9Z4vuV/iUY64YOaJB8VwK6H6it0sZuEFR8mU
60wo5V0/aA0zD12SvdlhszkG1fOpTDRfJcPK2IHfWaRR8uh0vG4DMrAFUqEYbt4P
89eQlWjSqIhgD+pc4rBWopoWYbNkTHZa4GjNpSaLQmo+RCbYho2AztcrPaZfYGW7
gKE1cje1TriyJOEvXJa0TCOBWxANA1PjOyYsn9xbbNxrwjOPsWWxmJ0O42gYmKjo
0FjhLGqzL6cv33KYKhxuHVWPjIH2nfG7/+z1f6t223yC1IHCde3BWT3aCx7wyfhM
Z/2//I/xV7uzYiwq3vJe
=03zX
-----END PGP SIGNATURE-----
