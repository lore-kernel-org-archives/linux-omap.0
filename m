From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.3-rc1
Date: Fri, 27 Jan 2012 10:16:19 -0800
Message-ID: <20120127181619.GB9339@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:40588 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab2A0SQW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 13:16:22 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull omap fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Regards,

Tony


The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:
  Linus Torvalds (1):
        Linux 3.3-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes

Cousson, Benoit (1):
      i2c: OMAP: Fix OMAP1 build error

Felipe Contreras (2):
      ARM: OMAP2: fix omap3 touchbook kconfig warning
      ARM: OMAP2: fix regulator warnings

Grazvydas Ignotas (2):
      ARM: OMAP: fix erroneous mmc2 clock change on mmc3 setup
      ARM: OMAP: fix MMC2 loopback clock handling

Ilya Yanok (1):
      ARM: OMAP3: hwmod data: register dss hwmods after dss_core

Julia Lawall (2):
      ARM: OMAP2+: arch/arm/mach-omap2/devices.c: introduce missing kfree
      ARM: OMAP2+: arch/arm/mach-omap2/smartreflex.c: add missing iounmap

Paul Walmsley (2):
      ARM: OMAP2+: io: fix compilation breakage on 2420-only configs
      ARM: OMAP2/3: PRM: fix missing plat/irqs.h build breakage

Peter Ujfalusi (1):
      ARM: OMAP4: hwmod data: Add names for DMIC memory address space

Tomi Valkeinen (2):
      ARM: OMAP2+: hwmod data: split omap2/3 dispc hwmod class
      ARM: OMAP3: hwmod data: add SYSC_HAS_ENAWAKEUP for dispc

Tony Lindgren (1):
      Merge branch 'omap_fixes_a_3.3rc' of git://git.pwsan.com/linux-2.6 into fixes

Vaibhav Hiremath (1):
      ARM: OMAP2+: timer: Fix crash due to wrong arg to __omap_dm_timer_read_counter

Yegor Yefremov (1):
      ARM: OMAP2+: GPMC: fix device size setup

 arch/arm/mach-omap2/Kconfig                        |   11 ++--
 arch/arm/mach-omap2/devices.c                      |    1 +
 arch/arm/mach-omap2/gpmc.c                         |    6 ++
 arch/arm/mach-omap2/hsmmc.c                        |   16 +++---
 arch/arm/mach-omap2/io.c                           |    4 +-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |   21 --------
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   22 ++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 +++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    2 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |    1 +
 arch/arm/mach-omap2/smartreflex.c                  |    2 +-
 arch/arm/mach-omap2/timer.c                        |    2 +-
 drivers/i2c/busses/i2c-omap.c                      |    2 +-
 13 files changed, 98 insertions(+), 46 deletions(-)
