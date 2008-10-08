From: Tony Lindgren <tony@atomide.com>
Subject: git-pull request for omap2 changes (Re: [PATCH 0/0] Refreshed
	omap2 patches, v3)
Date: Wed, 8 Oct 2008 10:42:59 +0300
Message-ID: <20081008074257.GC30831@atomide.com>
References: <1223035009-23866-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:53763 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbYJHHkB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 03:40:01 -0400
Content-Disposition: inline
In-Reply-To: <1223035009-23866-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [081003 14:54]:
> Hi all,
> 
> Here are the refreshed omap2 patches that are still remaining
> from the earlier series [1] before the header move and other
> omap changes in Russell's devel branch.
> 
> Some of the patches have been moved to Paul Walmsley's queue [2],
> and some to new omap3 queue, and some patches have been updated
> to merge in some new additions and fixes.
> 
> I'll repost the omap3 queue shortly following these patches.
> 
> Regards,
> 
> Tony
> 
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/10390
> [2] http://thread.gmane.org/gmane.linux.ports.arm.omap/12320

Here's the pull request for this series:

The following changes since commit 56f68556d7bbb51dd158c74deb09c783345bfbbd:
  Russell King (1):
        Merge unstable branch 'omap-rmk'

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap2-upstream

Jouni Hogander (1):
      ARM: OMAP2 Provide function to enable/disable uart clocks

Paul Walmsley (2):
      ARM: OMAP2: Fix sparse, checkpatch warnings fro GPMC code, use ioremap
      ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code

Tony Lindgren (3):
      ARM: OMAP2: Move sleep.S into sleep24xx.S
      ARM: OMAP2: Use omap_globals for CPU detection for multi-omap
      ARM: OMAP2: Misc updates from linux-omap tree

Vikram Pandita (1):
      ARM: OMAP2: Add pinmux support for omap34xx

 arch/arm/mach-omap1/devices.c                   |    2 +-
 arch/arm/mach-omap2/Makefile                    |    5 +-
 arch/arm/mach-omap2/clock.h                     |    1 +
 arch/arm/mach-omap2/devices.c                   |  226 ++++++++++++++++++-----
 arch/arm/mach-omap2/gpmc.c                      |   81 ++++++---
 arch/arm/mach-omap2/id.c                        |   39 +++--
 arch/arm/mach-omap2/io.c                        |   19 +-
 arch/arm/mach-omap2/irq.c                       |   77 +++++----
 arch/arm/mach-omap2/memory.h                    |    7 +
 arch/arm/mach-omap2/mux.c                       |  202 +++++++++++++++++++-
 arch/arm/mach-omap2/serial.c                    |  100 ++++------
 arch/arm/mach-omap2/{sleep.S => sleep24xx.S}    |   32 ++--
 arch/arm/plat-omap/common.c                     |    4 +
 arch/arm/plat-omap/devices.c                    |   11 +-
 arch/arm/plat-omap/include/mach/board-2430sdp.h |    6 +-
 arch/arm/plat-omap/include/mach/board-apollon.h |    6 +
 arch/arm/plat-omap/include/mach/board-h4.h      |    5 +-
 arch/arm/plat-omap/include/mach/board.h         |    2 +
 arch/arm/plat-omap/include/mach/common.h        |    3 +
 arch/arm/plat-omap/include/mach/control.h       |   17 ++-
 arch/arm/plat-omap/include/mach/cpu.h           |    5 +
 arch/arm/plat-omap/include/mach/gpio.h          |    2 +
 arch/arm/plat-omap/include/mach/gpmc.h          |    8 +
 arch/arm/plat-omap/include/mach/hardware.h      |    2 +-
 arch/arm/plat-omap/include/mach/irqs.h          |    6 +
 arch/arm/plat-omap/include/mach/mux.h           |  156 +++++++++++++++-
 arch/arm/plat-omap/include/mach/omap1510.h      |    2 +
 arch/arm/plat-omap/include/mach/omap16xx.h      |    7 +-
 arch/arm/plat-omap/include/mach/omap24xx.h      |    1 +
 arch/arm/plat-omap/include/mach/omapfb.h        |    3 +
 arch/arm/plat-omap/include/mach/pm.h            |    3 +-
 arch/arm/plat-omap/include/mach/sdrc.h          |    2 +
 arch/arm/plat-omap/include/mach/serial.h        |    6 +
 33 files changed, 799 insertions(+), 249 deletions(-)
 rename arch/arm/mach-omap2/{sleep.S => sleep24xx.S} (85%)
