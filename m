From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM/ARM-SoC plans for v3.4 merge window
Date: Thu, 26 Jan 2012 21:23:19 +0000
Message-ID: <20120126212319.GE11941@n2100.arm.linux.org.uk>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk> <20120124095009.GS16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60631 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab2AZVXf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jan 2012 16:23:35 -0500
Content-Disposition: inline
In-Reply-To: <20120124095009.GS16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-sh@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-tegra@vger.kernel.org

On Tue, Jan 24, 2012 at 09:50:09AM +0000, Russell King - ARM Linux wrote:
> On Mon, Jan 23, 2012 at 11:49:02AM +0000, Russell King - ARM Linux wrote:
> > This is an outline of the plan for this cycle, up to the next merge
> > window, agreed between Olof and myself.
> > 
> > As Nicolas' idle changes weren't merged before the last merge window
> > opened, we have decided that Nicolas will resubmit his changes after
> > -rc1 (in other words, now) and they will be merged into both the
> > arm-soc and my trees.
> > 
> > I have at least one other patch which has a high 'will cause horrible
> > conficts' rating (the debug option rearrangement patch), so I'll be
> > including that for the arm-soc tree as well.
> > 
> > However, what this does mean is that Arnd, Olof, and myself will be
> > in for up to three months of merge hell unless people take account of
> > these changes.
> > 
> > Therefore, our plan is to publish this as a baseline, and we'd really
> > appreciate any development submitted after that baseline has been
> > established is based upon those changes and does not conflict with
> > them.  That may mean you have to pull these changes into your tree
> > and merge them into your development work (and fix up any conflicts
> > there yourself.)
> > 
> > Once you've taken these changes into your tree, you must not rebase or
> > modify them.  Changing those commits will cause all hell to break loose,
> > and we'll have to refuse merging your tree (otherwise we'll be in Linus'
> > sights for a roasting at gas mark 2 million.)
> 
> Right, although it's out there - but I'd like to get the AMBA changes
> into it which are already conflicting the Samsung development.  So I'm
> going to hold off officially asking for people to include the baseline
> until this evening.  At that point, I will shut down my 'amba' branch
> and transfer that over; that means I won't be accepting any further
> acks etc for that work.
> 
> If you haven't acked changes in the amba branch (eg, to Versatile,
> Realview etc) then it'll soon be too late...

And we're now there.  So...

Arnd, Olaf,

Please incorporate the latest ARM (for-armsoc branch) changes, which can be found at:

        git://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-arm.git for-armsoc

with SHA1 dcf81c1af839b77b44404453ecae6e5ac5a75f05.

This will update the following files:

 arch/arm/Kconfig.debug                            |  156 ++++++++++----------
 arch/arm/include/asm/system.h                     |    1 +
 arch/arm/kernel/process.c                         |   27 ++--
 arch/arm/mach-at91/at91cap9.c                     |    8 +
 arch/arm/mach-at91/at91rm9200.c                   |   10 ++
 arch/arm/mach-at91/at91sam9260.c                  |    8 +
 arch/arm/mach-at91/at91sam9261.c                  |    8 +
 arch/arm/mach-at91/at91sam9263.c                  |    8 +
 arch/arm/mach-at91/at91sam9g45.c                  |    7 +
 arch/arm/mach-at91/at91sam9rl.c                   |    8 +
 arch/arm/mach-at91/at91x40.c                      |   12 ++
 arch/arm/mach-at91/include/mach/system.h          |   50 -------
 arch/arm/mach-bcmring/core.c                      |   23 +---
 arch/arm/mach-bcmring/include/mach/system.h       |   28 ----
 arch/arm/mach-clps711x/common.c                   |   16 ++
 arch/arm/mach-clps711x/include/mach/system.h      |   35 -----
 arch/arm/mach-cns3xxx/include/mach/system.h       |   25 ----
 arch/arm/mach-davinci/include/mach/system.h       |   21 ---
 arch/arm/mach-dove/include/mach/system.h          |   17 ---
 arch/arm/mach-ebsa110/core.c                      |   25 ++++
 arch/arm/mach-ebsa110/include/mach/system.h       |   37 -----
 arch/arm/mach-ep93xx/core.c                       |   46 +------
 arch/arm/mach-ep93xx/include/mach/system.h        |    7 -
 arch/arm/mach-exynos/common.c                     |   12 --
 arch/arm/mach-exynos/dma.c                        |   38 +-----
 arch/arm/mach-exynos/include/mach/system.h        |   20 ---
 arch/arm/mach-footbridge/include/mach/system.h    |   13 --
 arch/arm/mach-gemini/Makefile                     |    2 +-
 arch/arm/mach-gemini/idle.c                       |   29 ++++
 arch/arm/mach-gemini/include/mach/system.h        |   14 --
 arch/arm/mach-gemini/irq.c                        |    4 +-
 arch/arm/mach-h720x/common.c                      |   18 +++
 arch/arm/mach-h720x/include/mach/system.h         |   27 ----
 arch/arm/mach-highbank/include/mach/system.h      |   24 ---
 arch/arm/mach-imx/mm-imx3.c                       |   52 ++++----
 arch/arm/mach-imx/pm-imx27.c                      |    3 +-
 arch/arm/mach-integrator/core.c                   |   70 ++--------
 arch/arm/mach-integrator/impd1.c                  |    9 +-
 arch/arm/mach-integrator/include/mach/system.h    |   33 -----
 arch/arm/mach-integrator/integrator_cp.c          |   49 ++------
 arch/arm/mach-iop13xx/include/mach/system.h       |   13 --
 arch/arm/mach-iop32x/include/mach/system.h        |   13 --
 arch/arm/mach-iop33x/include/mach/system.h        |   13 --
 arch/arm/mach-ixp2000/include/mach/system.h       |   14 --
 arch/arm/mach-ixp23xx/core.c                      |    3 +
 arch/arm/mach-ixp23xx/include/mach/system.h       |   16 --
 arch/arm/mach-ixp4xx/common.c                     |    6 +
 arch/arm/mach-ixp4xx/include/mach/system.h        |   19 ---
 arch/arm/mach-kirkwood/include/mach/system.h      |   17 ---
 arch/arm/mach-ks8695/include/mach/system.h        |   27 ----
 arch/arm/mach-lpc32xx/include/mach/system.h       |   27 ----
 arch/arm/mach-lpc32xx/phy3250.c                   |   32 +----
 arch/arm/mach-mmp/include/mach/system.h           |   16 --
 arch/arm/mach-msm/idle.S                          |   36 -----
 arch/arm/mach-msm/idle.c                          |   49 +++++++
 arch/arm/mach-msm/include/mach/system.h           |    1 -
 arch/arm/mach-mv78xx0/include/mach/system.h       |   17 ---
 arch/arm/mach-mx5/mm.c                            |   28 ++---
 arch/arm/mach-mxs/devices.c                       |    8 +-
 arch/arm/mach-mxs/devices/amba-duart.c            |    2 +-
 arch/arm/mach-mxs/include/mach/system.h           |   25 ----
 arch/arm/mach-mxs/pm.c                            |    3 +-
 arch/arm/mach-netx/fb.c                           |   13 +--
 arch/arm/mach-netx/include/mach/system.h          |   28 ----
 arch/arm/mach-nomadik/board-nhk8815.c             |   17 +--
 arch/arm/mach-nomadik/cpu-8815.c                  |    9 +-
 arch/arm/mach-nomadik/include/mach/system.h       |   32 -----
 arch/arm/mach-omap1/include/mach/system.h         |    5 -
 arch/arm/mach-omap1/pm.c                          |   19 +--
 arch/arm/mach-omap2/emu.c                         |   26 +---
 arch/arm/mach-omap2/include/mach/system.h         |    5 -
 arch/arm/mach-omap2/pm24xx.c                      |    4 +-
 arch/arm/mach-omap2/pm34xx.c                      |    6 +-
 arch/arm/mach-omap2/pm44xx.c                      |    8 +-
 arch/arm/mach-omap2/prm_common.c                  |    1 -
 arch/arm/mach-orion5x/include/mach/system.h       |   19 ---
 arch/arm/mach-picoxcell/include/mach/system.h     |   26 ----
 arch/arm/mach-pnx4008/include/mach/system.h       |   29 ----
 arch/arm/mach-prima2/include/mach/system.h        |   17 ---
 arch/arm/mach-pxa/include/mach/system.h           |   15 --
 arch/arm/mach-realview/core.h                     |   20 +--
 arch/arm/mach-realview/include/mach/irqs-pb1176.h |    2 +-
 arch/arm/mach-realview/include/mach/system.h      |   33 -----
 arch/arm/mach-realview/realview_eb.c              |   78 +++++-----
 arch/arm/mach-realview/realview_pb1176.c          |   78 +++++-----
 arch/arm/mach-realview/realview_pb11mp.c          |   78 +++++-----
 arch/arm/mach-realview/realview_pba8.c            |   78 +++++-----
 arch/arm/mach-realview/realview_pbx.c             |   78 +++++-----
 arch/arm/mach-rpc/include/mach/system.h           |   13 --
 arch/arm/mach-s3c2410/include/mach/system.h       |   54 -------
 arch/arm/mach-s3c2412/s3c2412.c                   |    4 +-
 arch/arm/mach-s3c2416/s3c2416.c                   |    3 -
 arch/arm/mach-s3c64xx/include/mach/system.h       |   19 ---
 arch/arm/mach-s5p64x0/common.c                    |   15 +--
 arch/arm/mach-s5p64x0/dma.c                       |   22 +---
 arch/arm/mach-s5p64x0/include/mach/system.h       |   21 ---
 arch/arm/mach-s5pc100/common.c                    |   12 --
 arch/arm/mach-s5pc100/dma.c                       |   38 +-----
 arch/arm/mach-s5pc100/include/mach/system.h       |   19 ---
 arch/arm/mach-s5pv210/common.c                    |   12 --
 arch/arm/mach-s5pv210/dma.c                       |   38 +-----
 arch/arm/mach-s5pv210/include/mach/system.h       |   21 ---
 arch/arm/mach-sa1100/include/mach/system.h        |    9 --
 arch/arm/mach-shark/core.c                        |    6 +
 arch/arm/mach-shark/include/mach/system.h         |   13 --
 arch/arm/mach-shmobile/include/mach/system.h      |    5 -
 arch/arm/mach-spear3xx/include/mach/system.h      |   19 ---
 arch/arm/mach-spear3xx/spear300.c                 |   14 +--
 arch/arm/mach-spear3xx/spear3xx.c                 |   27 +---
 arch/arm/mach-spear6xx/include/mach/system.h      |   19 ---
 arch/arm/mach-spear6xx/spear6xx.c                 |   10 +-
 arch/arm/mach-tegra/common.c                      |    3 +-
 arch/arm/mach-tegra/include/mach/system.h         |   28 ----
 arch/arm/mach-u300/core.c                         |   85 ++---------
 arch/arm/mach-u300/include/mach/system.h          |   14 --
 arch/arm/mach-ux500/devices-common.c              |   13 +--
 arch/arm/mach-ux500/include/mach/system.h         |   20 ---
 arch/arm/mach-versatile/core.c                    |   70 +++++-----
 arch/arm/mach-versatile/core.h                    |   20 +--
 arch/arm/mach-versatile/include/mach/system.h     |   33 -----
 arch/arm/mach-versatile/versatile_pb.c            |   18 ++--
 arch/arm/mach-vexpress/core.h                     |   17 ---
 arch/arm/mach-vexpress/ct-ca9x4.c                 |    8 +-
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |    2 +-
 arch/arm/mach-vexpress/include/mach/system.h      |   33 -----
 arch/arm/mach-vexpress/v2m.c                      |   20 ++--
 arch/arm/mach-vt8500/include/mach/system.h        |    5 -
 arch/arm/mach-w90x900/dev.c                       |    1 +
 arch/arm/mach-w90x900/include/mach/system.h       |   19 ---
 arch/arm/mach-zynq/include/mach/system.h          |   23 ---
 arch/arm/plat-mxc/include/mach/system.h           |   25 ----
 arch/arm/plat-omap/include/plat/system.h          |   15 --
 arch/arm/plat-s3c24xx/cpu.c                       |   27 ++++
 arch/arm/plat-spear/include/plat/system.h         |   26 ----
 drivers/amba/bus.c                                |  105 +++++++++++----
 drivers/mmc/host/mmci.c                           |    2 +-
 drivers/of/platform.c                             |    6 +-
 include/linux/amba/bus.h                          |   36 +++++
 138 files changed, 893 insertions(+), 2303 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/system.h
 delete mode 100644 arch/arm/mach-bcmring/include/mach/system.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/system.h
 delete mode 100644 arch/arm/mach-cns3xxx/include/mach/system.h
 delete mode 100644 arch/arm/mach-davinci/include/mach/system.h
 delete mode 100644 arch/arm/mach-dove/include/mach/system.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/system.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-exynos/include/mach/system.h
 delete mode 100644 arch/arm/mach-footbridge/include/mach/system.h
 create mode 100644 arch/arm/mach-gemini/idle.c
 delete mode 100644 arch/arm/mach-h720x/include/mach/system.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/system.h
 delete mode 100644 arch/arm/mach-integrator/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop13xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/system.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp2000/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp23xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/system.h
 delete mode 100644 arch/arm/mach-ks8695/include/mach/system.h
 delete mode 100644 arch/arm/mach-lpc32xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/system.h
 delete mode 100644 arch/arm/mach-msm/idle.S
 create mode 100644 arch/arm/mach-msm/idle.c
 delete mode 100644 arch/arm/mach-mv78xx0/include/mach/system.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/system.h
 delete mode 100644 arch/arm/mach-netx/include/mach/system.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/system.h
 delete mode 100644 arch/arm/mach-omap1/include/mach/system.h
 delete mode 100644 arch/arm/mach-omap2/include/mach/system.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/system.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 delete mode 100644 arch/arm/mach-pnx4008/include/mach/system.h
 delete mode 100644 arch/arm/mach-prima2/include/mach/system.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/system.h
 delete mode 100644 arch/arm/mach-realview/include/mach/system.h
 delete mode 100644 arch/arm/mach-rpc/include/mach/system.h
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/system.h
 delete mode 100644 arch/arm/mach-s3c64xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5p64x0/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5pc100/include/mach/system.h
 delete mode 100644 arch/arm/mach-s5pv210/include/mach/system.h
 delete mode 100644 arch/arm/mach-sa1100/include/mach/system.h
 delete mode 100644 arch/arm/mach-shark/include/mach/system.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/system.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/system.h
 delete mode 100644 arch/arm/mach-u300/include/mach/system.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/system.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/system.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/system.h
 delete mode 100644 arch/arm/mach-w90x900/include/mach/system.h
 delete mode 100644 arch/arm/mach-zynq/include/mach/system.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/system.h
 delete mode 100644 arch/arm/plat-omap/include/plat/system.h
 delete mode 100644 arch/arm/plat-spear/include/plat/system.h

through these changes:

Nicolas Pitre (23):
      ARM: OMAP1: Fix pm_idle during suspend
      ARM: clean up idle handlers
      ARM: OMAP: convert idle handlers from pm_idle to arm_pm_idle
      ARM: mach-s5pv210: use standard arch_idle()
      ARM: mach-s5pc100: use standard arch_idle()
      ARM: mach-s5p64x0: move idle handler from pm_idle to arm_pm_idle
      ARM: mach-exynos: use standard arch_idle()
      ARM: mach-at91: move special idle code out of line
      ARM: mach-clps711x: move special idle code out of line
      ARM: mach-ebsa110: move special idle code out of line
      ARM: mach-gemini: move special idle code out of line
      ARM: mach-h720x: move special idle code out of line
      ARM: s3c24xx: move special idle code to out of line
      ARM: plat-mxc: hook special idle handlers to arm_pm_idle
      ARM: mach-msm: hook special idle handlers to arm_pm_idle
      ARM: mach-ixp23xx: properly disable CPU idle call
      ARM: mach-ixp4xx: properly disable CPU idle call
      ARM: mach-shark: properly disable CPU idle call
      ARM: mach-w90x900: properly disable CPU idle call
      ARM: mach-s3c64xx: use standard arch_idle() implementation
      ARM: mach-tegra: properly disable CPU idle call
      ARM: substitute arch_idle()
      ARM: big removal of now unused arch_idle()

Russell King (34):
      ARM: debug: arrange Kconfig options more logically
      Merge branches 'debug' and 'idle' into for-armsoc
      ARM: amba: add amba_device allocation/add/put functions
      ARM: amba: of: convert to use amba_device_alloc
      ARM: amba: ux500: convert to use amba_device_alloc
      ARM: amba: integrator: convert to use amba_device_alloc
      ARM: amba: mxs: convert to use amba_device_alloc
      ARM: amba: make irq 0 invalid
      ARM: amba: ux500: get rid of NO_IRQ
      ARM: amba: get rid of NO_IRQ initializers
      ARM: amba: samsung: get rid of NO_IRQ initializers
      ARM: amba: integrator/realview/versatile/vexpress: get rid of NO_IRQ initializers
      ARM: amba: lpc32xx: get rid of NO_IRQ initializers
      ARM: amba: mxs: get rid of NO_IRQ initializers
      ARM: amba: nomadik: get rid of NO_IRQ initializers
      ARM: amba: netx: get rid of NO_IRQ initializers
      ARM: amba: spear: get rid of NO_IRQ initializers
      ARM: amba: u300: get rid of NO_IRQ initializers
      ARM: amba: make use of -1 IRQs warn
      ARM: amba: provide common initializers for static amba devices
      ARM: amba: vexpress: get rid of private platform amba_device initializer
      ARM: amba: versatile: get rid of private platform amba_device initializer
      ARM: amba: realview: get rid of private platform amba_device initializer
      ARM: amba: integrator: use common amba device initializers
      ARM: amba: omap2: use common amba device initializers
      ARM: amba: ep93xx: use common amba device initializers
      ARM: amba: bcmring: use common amba device initializers
      ARM: amba: netx: use common amba device initializers
      ARM: amba: lpc32xx: use common amba device initializers
      ARM: amba: u300: use common amba device initializers
      ARM: amba: nomadik: use common amba device initializers
      ARM: amba: spear: use common amba device initializers
      ARM: amba: samsung: use common amba device initializers
      Merge branch 'amba' into for-armsoc

Will Deacon (1):
      ARM: 7300/1: realview: fix definition of GPIO0 interrupt on PB1176 to match TRM

Thanks.

