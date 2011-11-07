From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [GIT PULL] omap fixes for v3.2 merge window breakage
Date: Mon, 7 Nov 2011 21:29:19 +0000
Message-ID: <20111107212919.GI15294@n2100.arm.linux.org.uk>
References: <20111107204929.GZ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42974 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab1KGV3c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 16:29:32 -0500
Content-Disposition: inline
In-Reply-To: <20111107204929.GZ31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Arnd,

Don't pull this - there's yet more crap in OMAP to be fixed before
these go to mainline.  OMAP3 is severely broken at the moment with,
to put it bluntly, totally fucked up OMAP hwmod code, and should be
fixed *now* by folk before this pull request.

The fixes are damned trivial I expect even Tony can fix it without
reference to Paul.

On Mon, Nov 07, 2011 at 12:49:29PM -0800, Tony Lindgren wrote:
> Hi Arnd,
> 
> Please pull omap fixes from:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> This contains the pending fixes I've found in my inbox.
> Some of these I would have sent earlier, but was waiting
> for the DT branch merge to clear first.
> 
> This series fixes all the arch/arm/*omap*/ build warnings finally,
> looks like there's one new one for hwspinlock that already has
> a fix queued elsewhere.
> 
> Some patches also remove some dead code, so ideally these should
> get merged early on during the merge cycle. Overall a negative
> negative diffstat anyways ;)
> 
> Also not that I applied two trivial patches today to fix the
> remaining modsplit related build issues.
> 
> Regards,
> 
> Tony
> 
> 
> The following changes since commit 32aaeffbd4a7457bf2f7448b33b5946ff2a960eb:
>   Linus Torvalds (1):
>         Merge branch 'modsplit-Oct31_2011' of git://git.kernel.org/.../paulg/linux
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes
> 
> Abhilash K V (1):
>       ARM: OMAP: AM35x: remove hwmods that aren't generic
> 
> Archit Taneja (1):
>       ARM: OMAP: ctrl: Fix CONTROL_DSIPHY register fields
> 
> Axel Lin (3):
>       ARM: OMAP2+: l3-noc: Include linux/module.h
>       ARM: OMAP: dmtimer: Include linux/module.h
>       ARM: OMAP: omap_device: Include linux/export.h
> 
> Balaji T K (2):
>       ARM: OMAP4: hsmmc: Fix Pbias configuration on regulator OFF
>       ARM: OMAP4: hsmmc: configure SDMMC1_DR0 properly
> 
> Benoit Cousson (2):
>       ARM: OMAP2+: clock data: Remove redundant timer clkdev
>       ARM: OMAP2+: timer: Remove omap_device_pm_latency
> 
> Bjarne Steinsbo (1):
>       ARM: OMAP: usb: musb: OMAP: Delete unused function
> 
> Charulatha V (1):
>       ARM: OMAP3: PM: fix pwrdm_post_transition call sequence
> 
> Jarkko Nikula (2):
>       MAINTAINERS: Update linux-omap git repository
>       ARM: OMAP1: Remove unused omap-alsa.h
> 
> Jon Hunter (3):
>       ARM: OMAP3+: dpll: use DPLLs recalc function instead of omap2_get_dpll_rate
>       ARM: OMAP4: clock: Add missing clock divider for OCP_ABE_ICLK
>       ARM: OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices
> 
> Laurent Pinchart (1):
>       ARM: OMAP: I2C: Fix omap_register_i2c_bus() return value on success
> 
> Mike Turquette (3):
>       ARM: OMAP4: clock: round_rate and recalc functions for DPLL_ABE
>       ARM: OMAP3+: dpll: use DPLL's round_rate when setting rate
>       ARM: OMAP3+: dpll: assign clk rate from rounded rate during rate set
> 
> Paul Walmsley (4):
>       ARM: OMAP4460: Clock: Adding support for 4460 specific clocks
>       ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control detection
>       ARM: OMAP3: PM: restrict erratum i443 handling to OMAP3430 only
>       ARM: OMAP3: hwmod: fix variant registration and remove SmartReflex from common list
> 
> Peter Ujfalusi (1):
>       ARM: OMAP2+: devices: Fixes for McPDM
> 
> Sanjeev Premi (1):
>       ARM: OMAP: Fix errors and warnings when building for one board
> 
> Thomas Weber (1):
>       ARM: OMAP: Devkit8000: Remove double omap_mux_init_gpio
> 
> Tomi Valkeinen (1):
>       ARM: OMAP: change get_context_loss_count ret value to int
> 
> Tony Lindgren (7):
>       Merge branch 'omap_clock_fixes_3.2' of git://git.pwsan.com/linux-2.6 into fixes
>       Merge branch 'prcm_scm_misc_fixes_3.2' of git://git.pwsan.com/linux-2.6 into fixes
>       Merge branch 'for_3.2/pm-cleanup-2' of git://github.com/khilman/linux-omap-pm into fixes
>       ARM: OMAP1: Fix warnings about enabling 32 KiHz timer
>       ARM: OMAP2: Fix H4 matrix keyboard warning
>       ARM: OMAP: Fix export.h or module.h includes
>       Merge branch 'fixes-modulesplit' into fixes
> 
>  MAINTAINERS                                        |    2 +-
>  arch/arm/mach-omap1/board-palmz71.c                |    1 -
>  arch/arm/mach-omap1/pm.c                           |    2 +-
>  arch/arm/mach-omap2/board-devkit8000.c             |    1 -
>  arch/arm/mach-omap2/board-generic.c                |    8 ++
>  arch/arm/mach-omap2/board-h4.c                     |  122 +++++++++++---------
>  arch/arm/mach-omap2/clkt_dpll.c                    |   51 ++++++---
>  arch/arm/mach-omap2/clock.h                        |    2 +
>  arch/arm/mach-omap2/clock2420_data.c               |   12 --
>  arch/arm/mach-omap2/clock2430_data.c               |   12 --
>  arch/arm/mach-omap2/clock3xxx_data.c               |   12 --
>  arch/arm/mach-omap2/clock44xx.h                    |    7 +
>  arch/arm/mach-omap2/clock44xx_data.c               |   43 ++++---
>  arch/arm/mach-omap2/devices.c                      |   17 +---
>  arch/arm/mach-omap2/dpll3xxx.c                     |    9 +-
>  arch/arm/mach-omap2/dpll44xx.c                     |   69 +++++++++++
>  arch/arm/mach-omap2/dsp.c                          |    1 +
>  arch/arm/mach-omap2/hsmmc.c                        |   16 +--
>  arch/arm/mach-omap2/id.c                           |    5 +-
>  .../include/mach/ctrl_module_pad_core_44xx.h       |    8 +-
>  arch/arm/mach-omap2/io.c                           |    6 +
>  arch/arm/mach-omap2/mailbox.c                      |    1 +
>  arch/arm/mach-omap2/omap-iommu.c                   |    1 +
>  arch/arm/mach-omap2/omap_hwmod.c                   |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   17 ++-
>  arch/arm/mach-omap2/omap_l3_noc.c                  |    1 +
>  arch/arm/mach-omap2/pm34xx.c                       |   70 ++++++-----
>  arch/arm/mach-omap2/powerdomain.c                  |   14 ++-
>  arch/arm/mach-omap2/powerdomain.h                  |    2 +-
>  arch/arm/mach-omap2/smartreflex.c                  |    1 +
>  arch/arm/mach-omap2/timer.c                        |   12 +--
>  arch/arm/mach-omap2/usb-musb.c                     |   38 ------
>  arch/arm/plat-omap/dmtimer.c                       |    1 +
>  arch/arm/plat-omap/i2c.c                           |    2 +-
>  arch/arm/plat-omap/include/plat/cpu.h              |   17 ++-
>  arch/arm/plat-omap/include/plat/dmtimer.h          |    4 +-
>  arch/arm/plat-omap/include/plat/omap-alsa.h        |  123 --------------------
>  arch/arm/plat-omap/include/plat/omap-pm.h          |    4 +-
>  arch/arm/plat-omap/include/plat/omap_device.h      |    2 +-
>  arch/arm/plat-omap/include/plat/omap_hwmod.h       |    2 +-
>  arch/arm/plat-omap/omap-pm-noop.c                  |   24 +++-
>  arch/arm/plat-omap/omap_device.c                   |    3 +-
>  42 files changed, 345 insertions(+), 402 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/include/plat/omap-alsa.h
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
