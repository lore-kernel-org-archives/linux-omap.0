From: Tony Lindgren <tony@atomide.com>
Subject: git-pull-request for omap2-upstream branch for next merge window
	(Was: [PATCH 00/16] Omap2 patches for post 2.6.26)
Date: Sat, 23 Aug 2008 16:37:12 -0700
Message-ID: <20080823233711.GM4713@atomide.com>
References: <20080819212300.GF17034@flint.arm.linux.org.uk> <20080820072310.GA28862@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51535 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYHWXhX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 19:37:23 -0400
Content-Disposition: inline
In-Reply-To: <20080820072310.GA28862@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080820 00:23]:
> Hi,
> 
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080820 00:23]:
> > On Fri, Jun 06, 2008 at 06:47:41PM -0700, Tony Lindgren wrote:
> > > This patch series contains various omap2 patchs from linux-omap tree.
> > > Big chunk of the patches still improve the clock code. Also more
> > > clean-up to allow compiling omap2 and omap3 support into the same
> > > kernel. The patch also adds core omap3430 support, but no board
> > > files or PM at at this point.
> > 
> > Apart from the comments I've made, the rest seem "fine" as far as I can
> > tell.

<snip>

Here's the pull request for you assuming your don't have other comments.

I'll be out of town next week, so if there are other comments I won't
be able to refresh the patches until I get back.

Regards,

Tony


The following changes since commit dcac5512382d8df4476ce2e9c13e9540b3801d32:
  Russell King (1):
        Merge branch 'omap2-clock' of git://git.kernel.org/.../tmlind/linux-omap-2.6.git

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap2-upstream

Jouni Hogander (1):
      ARM: OMAP2 Provide function to enable/disable uart clocks

Kevin Hilman (1):
      ARM: OMAP2: Implement CPUfreq frequency table based on PRCM table

Paul Walmsley (6):
      ARM: OMAP2: Add non-CORE DPLL rate set code and M,N programming
      ARM: OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
      ARM: OMAP2: Move sys_clkout2 clk to core_clkdm
      ARM: OMAP2: Add missing SSI L4 interface clock
      ARM: OMAP2: Fix sparse, checkpatch warnings fro GPMC code
      ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code

Syed Mohammed Khasim (1):
      ARM: OMAP2: Add minimal omap3430 support

Tony Lindgren (5):
      ARM: OMAP2: Move sleep.S into sleep24xx.S
      ARM: OMAP2: Remove OMAP_PRM_REGADDR
      ARM: OMAP2: Remove OMAP_CM_REGADDR
      ARM: OMAP2: Use omap_globals for CPU detection for multi-omap
      ARM: OMAP2: Misc updates from linux-omap tree

Vikram Pandita (1):
      ARM: OMAP2: Add pinmux support for omap34xx

 arch/arm/mach-omap1/devices.c                   |    2 +-
 arch/arm/mach-omap2/Kconfig                     |   12 +-
 arch/arm/mach-omap2/Makefile                    |    6 +-
 arch/arm/mach-omap2/clock.c                     |  124 ++++----
 arch/arm/mach-omap2/clock.h                     |    3 +-
 arch/arm/mach-omap2/clock24xx.c                 |  148 ++++++--
 arch/arm/mach-omap2/clock24xx.h                 |  335 ++++++++++--------
 arch/arm/mach-omap2/clock34xx.c                 |  141 ++++++++-
 arch/arm/mach-omap2/clock34xx.h                 |  431 ++++++++++++-----------
 arch/arm/mach-omap2/cm-regbits-34xx.h           |    7 +
 arch/arm/mach-omap2/cm.h                        |   17 +-
 arch/arm/mach-omap2/devices.c                   |  229 ++++++++++--
 arch/arm/mach-omap2/gpmc.c                      |   70 +++--
 arch/arm/mach-omap2/id.c                        |   67 +++-
 arch/arm/mach-omap2/io.c                        |  147 ++++++--
 arch/arm/mach-omap2/irq.c                       |   66 ++--
 arch/arm/mach-omap2/memory.c                    |    3 +-
 arch/arm/mach-omap2/memory.h                    |    7 +
 arch/arm/mach-omap2/mux.c                       |  186 ++++++++++-
 arch/arm/mach-omap2/pm.c                        |    4 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h          |    9 +
 arch/arm/mach-omap2/prm.h                       |  166 ++++-----
 arch/arm/mach-omap2/serial.c                    |  112 +++----
 arch/arm/mach-omap2/{sleep.S => sleep24xx.S}    |   32 +-
 arch/arm/mach-omap2/sram242x.S                  |    5 +
 arch/arm/mach-omap2/sram243x.S                  |    5 +
 arch/arm/plat-omap/Kconfig                      |    9 +-
 arch/arm/plat-omap/common.c                     |    5 +
 arch/arm/plat-omap/cpu-omap.c                   |   57 +++-
 arch/arm/plat-omap/devices.c                    |  116 +++++--
 arch/arm/plat-omap/include/mach/board-2430sdp.h |    6 +-
 arch/arm/plat-omap/include/mach/board-apollon.h |    6 +
 arch/arm/plat-omap/include/mach/board-h4.h      |    5 +-
 arch/arm/plat-omap/include/mach/board.h         |    2 +
 arch/arm/plat-omap/include/mach/clock.h         |   11 +-
 arch/arm/plat-omap/include/mach/common.h        |    8 +
 arch/arm/plat-omap/include/mach/control.h       |   17 +-
 arch/arm/plat-omap/include/mach/cpu.h           |    5 +
 arch/arm/plat-omap/include/mach/debug-macro.S   |   12 +
 arch/arm/plat-omap/include/mach/entry-macro.S   |   12 +-
 arch/arm/plat-omap/include/mach/gpio.h          |    2 +
 arch/arm/plat-omap/include/mach/gpmc.h          |    7 +
 arch/arm/plat-omap/include/mach/hardware.h      |    2 +-
 arch/arm/plat-omap/include/mach/io.h            |   57 +++
 arch/arm/plat-omap/include/mach/irqs.h          |   71 ++++
 arch/arm/plat-omap/include/mach/mcbsp.h         |    2 +-
 arch/arm/plat-omap/include/mach/memory.h        |    2 +-
 arch/arm/plat-omap/include/mach/mmc.h           |    4 +
 arch/arm/plat-omap/include/mach/mux.h           |  147 +++++++-
 arch/arm/plat-omap/include/mach/omap1510.h      |    2 +
 arch/arm/plat-omap/include/mach/omap16xx.h      |    7 +-
 arch/arm/plat-omap/include/mach/omap24xx.h      |    2 +-
 arch/arm/plat-omap/include/mach/omapfb.h        |    3 +
 arch/arm/plat-omap/include/mach/pm.h            |    3 +-
 arch/arm/plat-omap/include/mach/powerdomain.h   |    1 +
 arch/arm/plat-omap/include/mach/prcm.h          |    5 +-
 arch/arm/plat-omap/include/mach/sdrc.h          |    2 +
 arch/arm/plat-omap/include/mach/serial.h        |    6 +
 arch/arm/plat-omap/include/mach/system.h        |    6 +-
 59 files changed, 2071 insertions(+), 865 deletions(-)
 rename arch/arm/mach-omap2/{sleep.S => sleep24xx.S} (85%)
