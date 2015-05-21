From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2.1/2] fixed up omap1 sparse irq support for v4.2
Date: Thu, 21 May 2015 15:59:38 -0700
Message-ID: <20150521225938.GY10274@atomide.com>
References: <pull-1432161303-403113>
 <pull-1432161303-403113-2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52937 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbbEUW7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 May 2015 18:59:40 -0400
Content-Disposition: inline
In-Reply-To: <pull-1432161303-403113-2>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Here's this pull request updated for the randconfig errors found
by Arnd.

The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/omap1-v2

for you to fetch changes up to 7bf15c4360b384e34d685616a77a8abf7dd8aea5:

  ARM: OMAP1: Fix section mismatch warnings for omap_cfg_reg (2015-05-21 14:50:23 -0700)

----------------------------------------------------------------
Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
to making omap1 support multiarch. After this series we still need to
make omap1 use the common clock framework and fix up the drivers to not
rely on includes from mach and plat directories.

Note that this branch depends on a GPIO driver fix in v4.1-rc3
d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").

----------------------------------------------------------------
Tony Lindgren (6):
      ARM: OMAP1: Move UART defines to prepare for sparse IRQ
      ARM: OMAP1: Switch to use generic irqchip in preparation for sparse IRQ
      ARM: omap1: Switch to use MULTI_IRQ
      ARM: OMAP1: Change interrupt numbering for sparse IRQ
      ARM: OMAP1: Fix randconfig builds if ARCH_OMAP15XX not selected
      ARM: OMAP1: Fix section mismatch warnings for omap_cfg_reg

 arch/arm/Kconfig                               |   2 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S    |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c          |   1 +
 arch/arm/mach-omap1/board-fsample.c            |   1 +
 arch/arm/mach-omap1/board-generic.c            |   1 +
 arch/arm/mach-omap1/board-h2.c                 |   1 +
 arch/arm/mach-omap1/board-h3-mmc.c             |   1 +
 arch/arm/mach-omap1/board-h3.c                 |   1 +
 arch/arm/mach-omap1/board-htcherald.c          |   1 +
 arch/arm/mach-omap1/board-innovator.c          |   1 +
 arch/arm/mach-omap1/board-nokia770.c           |   1 +
 arch/arm/mach-omap1/board-osk.c                |   1 +
 arch/arm/mach-omap1/board-palmte.c             |   1 +
 arch/arm/mach-omap1/board-palmtt.c             |   1 +
 arch/arm/mach-omap1/board-palmz71.c            |   1 +
 arch/arm/mach-omap1/board-perseus2.c           |   1 +
 arch/arm/mach-omap1/board-sx1.c                |   1 +
 arch/arm/mach-omap1/board-voiceblue.c          |   1 +
 arch/arm/mach-omap1/common.h                   |   7 +-
 arch/arm/mach-omap1/dma.c                      |   2 +-
 arch/arm/mach-omap1/gpio16xx.c                 |   2 +
 arch/arm/mach-omap1/gpio7xx.c                  |   2 +
 arch/arm/mach-omap1/i2c.c                      |   3 +-
 arch/arm/mach-omap1/include/mach/entry-macro.S |  39 ------
 arch/arm/mach-omap1/include/mach/irqs.h        | 124 ++++++++++---------
 arch/arm/mach-omap1/include/mach/memory.h      |   4 +-
 arch/arm/mach-omap1/include/mach/serial.h      |   5 -
 arch/arm/mach-omap1/include/mach/soc.h         |   4 +
 arch/arm/mach-omap1/irq.c                      | 157 +++++++++++++++----------
 arch/arm/mach-omap1/mux.c                      |   8 +-
 arch/arm/mach-omap1/pm.c                       |   1 +
 arch/arm/mach-omap1/serial.c                   |   1 +
 arch/arm/mach-omap1/timer.c                    |   4 +-
 arch/arm/plat-omap/dma.c                       |   4 +
 include/uapi/linux/serial_reg.h                |   3 +
 35 files changed, 206 insertions(+), 185 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/entry-macro.S
