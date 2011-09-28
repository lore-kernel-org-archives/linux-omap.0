From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] dmtimer changes for v3.2 merge window
Date: Wed, 28 Sep 2011 15:02:37 -0700
Message-ID: <20110928220237.GE6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Arnd,

Please pull omap dmtimer changes from:

git://github.com/tmlind/linux.git dmtimer

This series completes the system timer separation from the
driver like features. It also adds support for v2 ip that is
available for some timers starting with omap4.

After this series arch/arm/plat-omap/dmtimer.c could be
moved to live under drivers somewhere, but there is still
discussion going on which features should be supported in
a generic way.

This series depends on the cleanup you pulled earlier.
As this series adds some new features like runtime PM suppport,
I've kept it separate from cleanup.

Regards,

Tony


The following changes since commit ceb1c532ba6220900e61ec7073a9234661efa450:
  Tony Lindgren (1):
        Merge branch 'omap_chip_remove_cleanup_3.2' of git://git.pwsan.com/linux-2.6 into cleanup

are available in the git repository at:

  git://github.com/tmlind/linux.git dmtimer

Tarun Kanti DebBarma (8):
      ARM: OMAP2+: dmtimer: add device names to flck nodes
      ARM: OMAP1: dmtimer: conversion to platform devices
      ARM: OMAP2+: dmtimer: convert to platform devices
      ARM: OMAP: dmtimer: platform driver
      ARM: OMAP: dmtimer: switch-over to platform device driver
      ARM: OMAP: dmtimer: pm_runtime support
      ARM: OMAP: dmtimer: low-power mode support
      ARM: OMAP: dmtimer: add error handling to export APIs

Tony Lindgren (2):
      ARM: OMAP: Add support for dmtimer v2 ip
      ARM: OMAP: dmtimer: skip reserved timers

 arch/arm/mach-omap1/Makefile               |    2 +-
 arch/arm/mach-omap1/timer.c                |  173 +++++++
 arch/arm/mach-omap2/clock2420_data.c       |   48 ++
 arch/arm/mach-omap2/clock2430_data.c       |   48 ++
 arch/arm/mach-omap2/clock3xxx_data.c       |   36 ++
 arch/arm/mach-omap2/clock44xx_data.c       |   33 ++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   22 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   22 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   22 +
 arch/arm/mach-omap2/timer.c                |  194 +++++++-
 arch/arm/plat-omap/dmtimer.c               |  713 ++++++++++++++++------------
 arch/arm/plat-omap/include/plat/dmtimer.h  |  233 +++++++---
 13 files changed, 1185 insertions(+), 388 deletions(-)
 create mode 100644 arch/arm/mach-omap1/timer.c
