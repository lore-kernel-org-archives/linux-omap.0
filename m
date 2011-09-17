From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap cleanup part1 for v3.2 merge window
Date: Fri, 16 Sep 2011 18:46:23 -0700
Message-ID: <20110917014623.GC2937@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:27687 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751732Ab1IQBq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 21:46:26 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull the first part of omap cleanup from:

git://github.com/tmlind/linux.git cleanup

This series cleans up early_init functions and removes
CHIP_IS macro usage. This makes it easier to have SoC
specific init functions so adding support for new omap
variants does not require patching all over the place.

Regards,

Tony


The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:
  Linus Torvalds (1):
        Linux 3.1-rc6

are available in the git repository at:

  git://github.com/tmlind/linux.git cleanup

Paul Walmsley (12):
      OMAP3: id: remove identification codes that only correspond to marketing names
      OMAP3: id: remove useless strcpy()s
      OMAP3: id: use explicit omap_revision codes for 3505/3517 ES levels
      OMAP3: id: add fallthrough warning; fix some CodingStyle issues
      OMAP3: id: remove duplicate code for testing SoC ES level
      OMAP2+: id: remove OMAP_REVBITS_* macros
      OMAP: clockdomain: split clkdm_init()
      OMAP: clockdomain code/data: remove omap_chip bitmask from struct clockdomain
      OMAP: powerdomain: split pwrdm_init() into two functions
      OMAP: powerdomain: remove omap_chip bitmasks
      OMAP2+: hwmod: remove OMAP_CHIP*
      OMAP: id: remove OMAP_CHIP declarations, code

Tony Lindgren (4):
      omap2+: Use Kconfig symbol in Makefile instead of obj-y
      ARM: OMAP: Move omap2_init_common_devices out of init_early
      ARM: OMAP: Introduce SoC specific early_init
      Merge branch 'omap_chip_remove_cleanup_3.2' of git://git.pwsan.com/linux-2.6 into cleanup

 arch/arm/mach-omap2/Makefile                     |   81 +--
 arch/arm/mach-omap2/board-2430sdp.c              |    9 +-
 arch/arm/mach-omap2/board-3430sdp.c              |    9 +-
 arch/arm/mach-omap2/board-3630sdp.c              |   11 +-
 arch/arm/mach-omap2/board-4430sdp.c              |    9 +-
 arch/arm/mach-omap2/board-am3517crane.c          |    9 +-
 arch/arm/mach-omap2/board-am3517evm.c            |    8 +-
 arch/arm/mach-omap2/board-apollon.c              |    9 +-
 arch/arm/mach-omap2/board-cm-t35.c               |   13 +-
 arch/arm/mach-omap2/board-cm-t3517.c             |    9 +-
 arch/arm/mach-omap2/board-devkit8000.c           |   12 +-
 arch/arm/mach-omap2/board-generic.c              |    2 +-
 arch/arm/mach-omap2/board-h4.c                   |    9 +-
 arch/arm/mach-omap2/board-igep0020.c             |   13 +-
 arch/arm/mach-omap2/board-ldp.c                  |    9 +-
 arch/arm/mach-omap2/board-n8x0.c                 |   13 +-
 arch/arm/mach-omap2/board-omap3beagle.c          |    4 +-
 arch/arm/mach-omap2/board-omap3evm.c             |    9 +-
 arch/arm/mach-omap2/board-omap3logic.c           |   11 +-
 arch/arm/mach-omap2/board-omap3pandora.c         |   11 +-
 arch/arm/mach-omap2/board-omap3stalker.c         |    9 +-
 arch/arm/mach-omap2/board-omap3touchbook.c       |   11 +-
 arch/arm/mach-omap2/board-omap4panda.c           |    9 +-
 arch/arm/mach-omap2/board-overo.c                |   11 +-
 arch/arm/mach-omap2/board-rm680.c                |   17 +-
 arch/arm/mach-omap2/board-rx51.c                 |   17 +-
 arch/arm/mach-omap2/board-ti8168evm.c            |    9 +-
 arch/arm/mach-omap2/board-zoom.c                 |   23 +-
 arch/arm/mach-omap2/clock3xxx_data.c             |   11 +-
 arch/arm/mach-omap2/clockdomain.c                |  147 +++--
 arch/arm/mach-omap2/clockdomain.h                |   22 +-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |    4 -
 arch/arm/mach-omap2/clockdomain44xx.c            |    2 -
 arch/arm/mach-omap2/clockdomains2420_data.c      |  154 +++++
 arch/arm/mach-omap2/clockdomains2430_data.c      |  181 +++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |  803 +---------------------
 arch/arm/mach-omap2/clockdomains3xxx_data.c      |  398 +++++++++++
 arch/arm/mach-omap2/clockdomains44xx_data.c      |  409 +++---------
 arch/arm/mach-omap2/id.c                         |  191 ++----
 arch/arm/mach-omap2/io.c                         |   52 ++-
 arch/arm/mach-omap2/omap_hwmod.c                 |    3 -
 arch/arm/mach-omap2/omap_hwmod_2420_data.c       |   37 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c       |   45 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c       |  169 +++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c       |   82 ---
 arch/arm/mach-omap2/powerdomain-common.c         |    7 +-
 arch/arm/mach-omap2/powerdomain.c                |   87 ++-
 arch/arm/mach-omap2/powerdomain.h                |    9 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   19 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   44 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   81 ++-
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   20 +-
 arch/arm/plat-omap/include/plat/clock.h          |    2 -
 arch/arm/plat-omap/include/plat/common.h         |    9 +
 arch/arm/plat-omap/include/plat/cpu.h            |  108 +---
 arch/arm/plat-omap/include/plat/io.h             |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    2 -
 57 files changed, 1430 insertions(+), 2036 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains2420_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains2430_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains3xxx_data.c
