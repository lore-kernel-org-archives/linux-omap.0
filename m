From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2: add AM43xx hwmod and PRCM support
Date: Wed, 16 Oct 2013 21:46:24 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1310162145180.6538@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60998 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755825Ab3JPVqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 17:46:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit ace1e3ec4a2540c783e65884bb7be9cd45a0a295:

  ARM: AM33xx: hwmod: Add RNG module data (2013-10-09 09:02:51 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.13/am43xx-support

for you to fetch changes up to 70b0d5f5838e0c9dfecabefe4ff43b5a2e7c1e8b:

  ARM: OMAP2: hwmod: Add qspi data for am437x. (2013-10-15 23:49:43 -0600)

- ----------------------------------------------------------------
Add hwmod and PRCM data for the TI AM43xx family of SoCs.

Under normal circumstances, these patches would not be merged.
The hwmod and PRCM data should be moved out either to DT data or
to drivers/.  Also, the current implementation trades off lines
of diff by dynamically rewriting static data at runtime, which is
a bad practice - it causes future maintenance headaches.
However, after speaking with my upstream, it sounds like it's
better to merge these patches in their current state, due to long
term considerations.

Basic test logs are here:

http://www.pwsan.com/omap/testlogs/am43xx_support_v3.13/20131015213706/

Due to the lack of an AM43xx board and any available public
documentation, it's impossible for me to review or test that
platform in any meaningful way.  But at least the tests above
verify that the patches don't affect existing platforms -
particularly AM33xx.

- ----------------------------------------------------------------
Afzal Mohammed (7):
      ARM: OMAP2+: hwmod: AM335x/AM43x: move common data
      ARM: OMAP2+: hwmod: AM335x: runtime register update
      ARM: OMAP2+: hwmod: AM335x: remove static register offs
      ARM: OMAP2+: PRCM: AM43x definitions
      ARM: OMAP2+: hwmod: AM43x support
      ARM: OMAP2+: hwmod: AM43x operations
      ARM: OMAP2+: AM43x: PRCM kbuild

Ambresh K (3):
      ARM: OMAP2+: PM: AM43x powerdomain data
      ARM: OMAP2+: CM: AM43x clockdomain data
      ARM: OMAP2+: AM43x PRCM init

Ankur Kishore (1):
      ARM: OMAP2+: CM: cm_inst offset s16->u16

George Cherian (1):
      ARM: OMAP2+: hwmod: Add USB hwmod data for AM437x.

Sourav Poddar (1):
      ARM: OMAP2: hwmod: Add qspi data for am437x.

 arch/arm/mach-omap2/Makefile                       |    9 +-
 arch/arm/mach-omap2/clockdomain.h                  |    4 +-
 arch/arm/mach-omap2/clockdomains43xx_data.c        |  196 ++
 arch/arm/mach-omap2/cm33xx.c                       |   16 +-
 arch/arm/mach-omap2/cm33xx.h                       |   12 +-
 arch/arm/mach-omap2/cminst44xx.c                   |   29 +-
 arch/arm/mach-omap2/cminst44xx.h                   |   26 +-
 arch/arm/mach-omap2/io.c                           |    6 +
 arch/arm/mach-omap2/omap_hwmod.c                   |    8 +
 arch/arm/mach-omap2/omap_hwmod.h                   |    1 +
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  163 ++
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  643 ++++++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 1469 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 2263 ++------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  758 +++++++
 arch/arm/mach-omap2/powerdomain.h                  |    1 +
 arch/arm/mach-omap2/powerdomains43xx_data.c        |  136 ++
 arch/arm/mach-omap2/prcm43xx.h                     |  146 ++
 18 files changed, 3728 insertions(+), 2158 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_43xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains43xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm43xx.h

vmlinux object size
(delta in bytes from prcm_fixes_v3.13 (ace1e3ec4a2540c783e65884bb7be9cd45a0a295)):
   text     data      bss    total  kernel
      0        0        0        0  omap1_defconfig
      0        0        0        0  omap1_defconfig_1510innovator_only
      0        0        0        0  omap1_defconfig_5912osk_only
  +1436      +88        0    +1524  omap2plus_defconfig
      0        0        0        0  omap2plus_defconfig_2430sdp_only
  +1500      +64        0    +1564  omap2plus_defconfig_cpupm
      0        0        0        0  omap2plus_defconfig_n800_multi_omap2xxx
      0        0        0        0  omap2plus_defconfig_n800_only_a
  +1436      +88        0    +1524  omap2plus_defconfig_no_pm
  +1436      +64        0    +1500  omap2plus_defconfig_omap2_4_only
  +1428      +56        0    +1484  omap2plus_defconfig_omap3_4_only
      0        0        0        0  rmk_omap3430_ldp_allnoconfig
      0        0        0        0  rmk_omap3430_ldp_oldconfig
      0      +64        0      +64  rmk_omap4430_sdp_allnoconfig

Boot-time memory difference
(delta in bytes from prcm_fixes_v3.13 (ace1e3ec4a2540c783e65884bb7be9cd45a0a295))
  avail  rsrvd   high  freed  board          kconfig
    -8k     8k      .      .  am335xbone     omap2plus_defconfig_am33xx_only
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSXwjfAAoJEMePsQ0LvSpLXE0P/3LcE5xgvbGgd4NFqIAgbMr6
FoMFkCrl6UB2IIErv/OVDc/e9Uk0UqLUPnqsYT/YtRGyiADWDG9jaLgVC34oQwxF
3Wlw+995SiAY9tl5T7/0i94jG3DbP9lfxOYT/f6DKWyju33DRaJ5dk1z3RlZmmhz
dtqTYyBLYo/JSXPLU9dD74hJpM21/5yB/9dWVi2PCbLVWd2WCQXs89SdpjkxYls3
zIbIPBPDJ5e6B3/U6r2AMMIk5mqtVMKxVyAPUVAYfmApdG1nqLEwjJi7V8aOa3mR
kL0bBlMVTd3q8hP3pfYq66yyEZ3RjFW9Z1NcedoE86+d+QVcLgMAq/mZVGejWi2j
5YQmd5km52kKaaS5arTLf2X7fs2N/pvsDUy7hOJZloaUKozvckzV/gGQS9zNuDTt
mgbqdMHOpfms1/ObpW6B94KZRqyd7Uz+wnwYMwcR/ceb2xVXsxPXDca0Kf9N8o95
QvDfUM/LH7nXB1Im4gO8poSqGHBe0cPQhTr1bKn3RtvYWU8kMUFV0+WDKG5eSr4g
I3cFC/lSmwFgkvcAGs98mOmTilakVDMUYTorpzwuGf3BMAuVXsT/RfD30UztAGsQ
iDw0XWdi76u2i80DRhXIEcfhCKle9QFqv3qV6e1CPnxlqnqm0X68kLvJSjEA5O2+
YRZwSYti1ayKR0Ud0A1e
=0AaK
-----END PGP SIGNATURE-----
