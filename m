From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for minimal omap3 support (Re: [PATCH 0/0] Add
	minimal omap34xx support)
Date: Wed, 8 Oct 2008 10:50:01 +0300
Message-ID: <20081008075000.GD30831@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58740 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbYJHHrJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 03:47:09 -0400
Content-Disposition: inline
In-Reply-To: <1223035779-26306-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [081003 15:06]:
> Hi all,
> 
> Here are few patches to add minimal omap34xx support, and
> board files for Beagle and Overo boards.
> 
> The minimal omap34xx support patch was previously posted here
> with the omap2 patches, this patch has some additions, such
> as sram support.
> 
> For folks who are wondering what the Beagle and Overo boards
> are, here are some links:
> 
> http://beagleboard.org/
> http://www.gumstix.net/Overo/cat/Overo/115.html

Here's the pull request for this series. Note that this depends
on the earlies omap2-upstream series.

The following changes since commit 684ae84fa8ebff956e7b9fc91bcaa1d0805da4d8:
  Paul Walmsley (1):
        ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap3-upstream

Steve Sakoman (2):
      ARM: OMAP2: Add support for the Gumstix Overo board (rev 3)
      ARM: OMAP2: Defconfig for the Gumstix Overo board (rev 3)

Syed Mohammed, Khasim (1):
      ARM: OMAP3: Add minimal Beagle board support

Tony Lindgren (2):
      ARM: OMAP3: Add minimal omap3430 support
      ARM: OMAP3: Add Beagle defconfig

 arch/arm/Makefile                                  |    1 +
 arch/arm/configs/omap3_beagle_defconfig            | 1321 ++++++++++++++
 arch/arm/configs/overo_defconfig                   | 1885 ++++++++++++++++++++
 arch/arm/mach-omap2/Kconfig                        |   18 +-
 arch/arm/mach-omap2/Makefile                       |    3 +
 arch/arm/mach-omap2/board-omap3beagle.c            |  244 +++
 arch/arm/mach-omap2/board-overo.c                  |  242 +++
 arch/arm/mach-omap2/gpmc.c                         |    5 +
 arch/arm/mach-omap2/io.c                           |  126 ++-
 arch/arm/mach-omap2/irq.c                          |    2 +
 arch/arm/mach-omap2/memory.c                       |   14 +
 arch/arm/mach-omap2/mux.c                          |   67 +-
 arch/arm/mach-omap2/sram34xx.S                     |  179 ++
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-omap/Kconfig                         |    9 +-
 arch/arm/plat-omap/devices.c                       |   15 +-
 .../arm/plat-omap/include/mach/board-omap3beagle.h |   33 +
 arch/arm/plat-omap/include/mach/board-overo.h      |   26 +
 arch/arm/plat-omap/include/mach/debug-macro.S      |   12 +
 arch/arm/plat-omap/include/mach/entry-macro.S      |   12 +-
 arch/arm/plat-omap/include/mach/gpmc.h             |    4 +
 arch/arm/plat-omap/include/mach/hardware.h         |    4 +
 arch/arm/plat-omap/include/mach/io.h               |    3 -
 arch/arm/plat-omap/include/mach/irqs.h             |   35 +
 arch/arm/plat-omap/include/mach/mcbsp.h            |    2 +-
 arch/arm/plat-omap/include/mach/memory.h           |    2 +-
 arch/arm/plat-omap/include/mach/mux.h              |   26 +-
 arch/arm/plat-omap/include/mach/omap24xx.h         |    1 -
 arch/arm/plat-omap/include/mach/sdrc.h             |    4 +-
 arch/arm/plat-omap/include/mach/sram.h             |   10 +
 arch/arm/plat-omap/include/mach/system.h           |    2 +-
 arch/arm/plat-omap/io.c                            |   32 +-
 arch/arm/plat-omap/sram.c                          |   53 +-
 33 files changed, 4303 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/configs/omap3_beagle_defconfig
 create mode 100644 arch/arm/configs/overo_defconfig
 create mode 100644 arch/arm/mach-omap2/board-omap3beagle.c
 create mode 100644 arch/arm/mach-omap2/board-overo.c
 create mode 100644 arch/arm/mach-omap2/sram34xx.S
 create mode 100644 arch/arm/plat-omap/include/mach/board-omap3beagle.h
 create mode 100644 arch/arm/plat-omap/include/mach/board-overo.h
