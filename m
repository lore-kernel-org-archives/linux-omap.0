From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for minimal omap3 support one more time
Date: Fri, 10 Oct 2008 14:35:34 +0300
Message-ID: <20081010113533.GU3044@atomide.com>
References: <1223035779-26306-1-git-send-email-tony@atomide.com> <dbdb2ea60810030852h67b898a8p13b716f2e6c746e6@mail.gmail.com> <20081004070534.GB30190@muru.com> <20081009145436.GI435@flint.arm.linux.org.uk> <20081009151724.GK26230@atomide.com> <20081010073251.GN435@flint.arm.linux.org.uk> <20081010091557.GI3044@atomide.com> <20081010092520.GK3044@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:57857 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859AbYJJLfv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 07:35:51 -0400
Content-Disposition: inline
In-Reply-To: <20081010092520.GK3044@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: twebb <taliaferro62@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [081010 12:41]:
> * Tony Lindgren <tony@atomide.com> [081010 12:15]:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [081010 11:42]:
> > > On Thu, Oct 09, 2008 at 06:17:25PM +0300, Tony Lindgren wrote:
> > > > Sure, I'll post a minimal LDP patch separately tomorrow. I don't have
> > > > an LDP so I can't verify it boots though.
> > > 
> > > Unfortunately, Linus has been unpredictable, and released 2.6.27 last
> > > night, rather than the usual one week after -rc9.
> > > 
> > > What this means is that the merge window is now open, and I shouldn't
> > > be accepting anything else into my kernel tree.
> > > 
> > > However, if you can get LDP in by this evening, I'll pull it into the
> > > tree.  That will be the final devel code merged into my tree for 2.6.28.
> > 
> > Sure. Here's the minimal board patch for LDP with it's defconfig
> > in the following mail. Also added to the omap3-upstream queue.
> 
> Here's the defconfig.

And here's the updated pull request for you with the LDP patches added.

I also changed the title of the Overo patches to say OMAP3 instead of
OMAP2 for consistency.

Note that this will also pull the already posted omap2-upstream as
omap3-upstream is based on that.

Tony


The following changes since commit 56f68556d7bbb51dd158c74deb09c783345bfbbd:
  Russell King (1):
        Merge unstable branch 'omap-rmk'

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap3-upstream

Jouni Hogander (1):
      ARM: OMAP2 Provide function to enable/disable uart clocks

Nishant Kamat (2):
      ARM: OMAP3: Add basic board support for OMAP LDP
      ARM: OMAP3: Add default kernel config for OMAP LDP

Paul Walmsley (2):
      ARM: OMAP2: Fix sparse, checkpatch warnings fro GPMC code, use ioremap
      ARM: OMAP2: Fix sparse, checkpatch warnings in OMAP2/3 IRQ code

Steve Sakoman (2):
      ARM: OMAP3: Add support for the Gumstix Overo board (rev 3)
      ARM: OMAP3: Defconfig for the Gumstix Overo board (rev 3)

Syed Mohammed, Khasim (3):
      ARM: OMAP3: Add minimal omap3430 support
      ARM: OMAP3: Add minimal Beagle board support
      ARM: OMAP3: Add Beagle defconfig

Tony Lindgren (3):
      ARM: OMAP2: Move sleep.S into sleep24xx.S
      ARM: OMAP2: Use omap_globals for CPU detection for multi-omap
      ARM: OMAP2: Misc updates from linux-omap tree

Vikram Pandita (1):
      ARM: OMAP2: Add pinmux support for omap34xx

 arch/arm/Makefile                                  |    1 +
 arch/arm/configs/omap3_beagle_defconfig            | 1321 ++++++++++++++
 arch/arm/configs/omap_ldp_defconfig                | 1044 +++++++++++
 arch/arm/configs/overo_defconfig                   | 1885 ++++++++++++++++++++
 arch/arm/mach-omap1/devices.c                      |    2 +-
 arch/arm/mach-omap2/Kconfig                        |   22 +-
 arch/arm/mach-omap2/Makefile                       |    9 +-
 arch/arm/mach-omap2/board-ldp.c                    |   86 +
 arch/arm/mach-omap2/board-omap3beagle.c            |  244 +++
 arch/arm/mach-omap2/board-overo.c                  |  242 +++
 arch/arm/mach-omap2/clock.h                        |    1 +
 arch/arm/mach-omap2/devices.c                      |  225 ++-
 arch/arm/mach-omap2/gpmc.c                         |   86 +-
 arch/arm/mach-omap2/id.c                           |   39 +-
 arch/arm/mach-omap2/io.c                           |  145 ++-
 arch/arm/mach-omap2/irq.c                          |   79 +-
 arch/arm/mach-omap2/memory.c                       |   14 +
 arch/arm/mach-omap2/memory.h                       |    7 +
 arch/arm/mach-omap2/mux.c                          |  245 +++-
 arch/arm/mach-omap2/serial.c                       |  100 +-
 arch/arm/mach-omap2/{sleep.S => sleep24xx.S}       |   32 +-
 arch/arm/mach-omap2/sram34xx.S                     |  179 ++
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-omap/Kconfig                         |    9 +-
 arch/arm/plat-omap/common.c                        |    4 +
 arch/arm/plat-omap/devices.c                       |   26 +-
 arch/arm/plat-omap/include/mach/board-2430sdp.h    |    6 +-
 arch/arm/plat-omap/include/mach/board-apollon.h    |    6 +
 arch/arm/plat-omap/include/mach/board-h4.h         |    5 +-
 arch/arm/plat-omap/include/mach/board-ldp.h        |   36 +
 .../arm/plat-omap/include/mach/board-omap3beagle.h |   33 +
 arch/arm/plat-omap/include/mach/board-overo.h      |   26 +
 arch/arm/plat-omap/include/mach/board.h            |    2 +
 arch/arm/plat-omap/include/mach/common.h           |    3 +
 arch/arm/plat-omap/include/mach/control.h          |   17 +-
 arch/arm/plat-omap/include/mach/cpu.h              |    5 +
 arch/arm/plat-omap/include/mach/debug-macro.S      |   12 +
 arch/arm/plat-omap/include/mach/entry-macro.S      |   12 +-
 arch/arm/plat-omap/include/mach/gpio.h             |    2 +
 arch/arm/plat-omap/include/mach/gpmc.h             |   12 +
 arch/arm/plat-omap/include/mach/hardware.h         |   10 +-
 arch/arm/plat-omap/include/mach/io.h               |    3 -
 arch/arm/plat-omap/include/mach/irqs.h             |   41 +
 arch/arm/plat-omap/include/mach/mcbsp.h            |    2 +-
 arch/arm/plat-omap/include/mach/memory.h           |    2 +-
 arch/arm/plat-omap/include/mach/mux.h              |  180 ++-
 arch/arm/plat-omap/include/mach/omap1510.h         |    2 +
 arch/arm/plat-omap/include/mach/omap16xx.h         |    7 +-
 arch/arm/plat-omap/include/mach/omap24xx.h         |    2 +-
 arch/arm/plat-omap/include/mach/omapfb.h           |    3 +
 arch/arm/plat-omap/include/mach/pm.h               |    3 +-
 arch/arm/plat-omap/include/mach/sdrc.h             |    2 +
 arch/arm/plat-omap/include/mach/serial.h           |    6 +
 arch/arm/plat-omap/include/mach/sram.h             |   10 +
 arch/arm/plat-omap/include/mach/system.h           |    2 +-
 arch/arm/plat-omap/io.c                            |   32 +-
 arch/arm/plat-omap/sram.c                          |   53 +-
 57 files changed, 6261 insertions(+), 325 deletions(-)
 create mode 100644 arch/arm/configs/omap3_beagle_defconfig
 create mode 100644 arch/arm/configs/omap_ldp_defconfig
 create mode 100644 arch/arm/configs/overo_defconfig
 create mode 100644 arch/arm/mach-omap2/board-ldp.c
 create mode 100644 arch/arm/mach-omap2/board-omap3beagle.c
 create mode 100644 arch/arm/mach-omap2/board-overo.c
 rename arch/arm/mach-omap2/{sleep.S => sleep24xx.S} (85%)
 create mode 100644 arch/arm/mach-omap2/sram34xx.S
 create mode 100644 arch/arm/plat-omap/include/mach/board-ldp.h
 create mode 100644 arch/arm/plat-omap/include/mach/board-omap3beagle.h
 create mode 100644 arch/arm/plat-omap/include/mach/board-overo.h
