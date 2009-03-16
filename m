From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/86] OMAP2/3: clock sync with linux-omap
Date: Mon, 16 Mar 2009 11:06:05 -0700
Message-ID: <49BE950D.9060800@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:7988 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbZCPSGL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 14:06:11 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1704364rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 16 Mar 2009 11:06:09 -0700 (PDT)
In-Reply-To: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman wrote:
> This is the series of patches contained in the 'omap-clks3' branch of
> Russell King's git repository[1].  Posted on behalf of Russell who
> had some mail issues in first attempt, and then ran of out time.
> 
> This series is proposed to be merged into the next merge window.

Tested-by: Kevin Hilman <khilman@deeprootsystems.com>

FYI... I've rebased a minimal subset of the PM branch on top of this 
series and have been able to hit full-chip retention in suspend and idle.

I'm OK with this being merged.

Kevin


> Comments to the list appreciated.
> 
> Kevin
> 
> [1] http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
> 
> 
> Daniel Stone (1):
>   [ARM] OMAP2: Fix definition of SGX clock register bits
> 
> Jouni Hogander (2):
>   [ARM] OMAP3: PM: Emu_pwrdm is switched off by hardware even when sdti
>     is in use
>   [ARM] OMAP34XX: Add miscellaneous definitions related to 34xx
> 
> Kevin Hilman (1):
>   [ARM] OMAP2: Implement CPUfreq frequency table based on PRCM table
> 
> Paul Walmsley (34):
>   [ARM] OMAP2/3: Add non-CORE DPLL rate set code and M, N programming
>   [ARM] OMAP: Fix sparse, checkpatch warnings in OMAP2/3 PRCM/PM code
>   [ARM] OMAP24xx clock: add missing SSI L4 interface clock
>   [ARM] OMAP3: move USBHOST SAR handling from clock framework to
>     powerdomain layer
>   [ARM] OMAP3 clock: fix 96MHz clocks
>   [ARM] OMAP: Make dpll4_m4_ck programmable with clk_set_rate()
>   [ARM] OMAP2/3 clockdomains: combine pwrdm, pwrdm_name into union in
>     struct clockdomain
>   [ARM] OMAP2/3 clockdomains: add CM and PRM clkdms
>   [ARM] OMAP3 clock: move sys_clkout2 clk to core_clkdm
>   [ARM] OMAP3 PRCM: add DPLL1-5 powerdomains, clockdomains; mark clocks
>   [ARM] OMAP3 powerdomains: remove RET from SGX power states list
>   [ARM] OMAP2/3 clockdomains: autodeps should respect platform flags
>   [ARM] OMAP3 clock: fix DPLL jitter correction and rate programming
>   [ARM] OMAP3 clock: DPLL{1,2}_FCLK clksel can divide by 4
>   [ARM] OMAP3 clock: convert dpll_data.idlest_bit to idlest_mask
>   [ARM] OMAP3 clock: remove unnecessary dpll_data dereferences
>   [ARM] OMAP3 clock: optimize DPLL rate rounding algorithm
>   [ARM] OMAP3 clock: avoid invalid FREQSEL values during DPLL rate
>     rounding
>   [ARM] OMAP3 clock: disable DPLL autoidle while waiting for DPLL to
>     lock
>   [ARM] OMAP2/3 clock: clean up mach-omap2/clock.c
>   [ARM] OMAP2 PRCM: clean up CM_IDLEST bits
>   [ARM] OMAP2 SDRC: move mach-omap2/memory.h into mach/sdrc.h
>   [ARM] OMAP2 SDRC: rename memory.c to sdrc2xxx.c
>   [ARM] OMAP2 SDRC: separate common OMAP2/3 code from OMAP2xxx code
>   [ARM] OMAP2 SDRC: add SDRAM timing parameter infrastructure
>   [ARM] OMAP3 clock: add omap3_core_dpll_m2_set_rate()
>   [ARM] OMAP2/3 clock: use standard set_rate fn in
>     omap2_clk_arch_init()
>   [ARM] OMAP2/3 clock: don't use a barrier after clk_disable()
>   [ARM] OMAP2xxx clock: consolidate DELAYED_APP clock commits; fix
>     barrier
>   [ARM] OMAP2/3 clock: convert remaining MPU barriers into OCP barriers
>   [ARM] OMAP clock: drop clk_get_usecount()
>   [ARM] OMAP2/3 clock: don't tinker with hardirqs when they are
>     supposed to be disabled
>   [ARM] OMAP3: update ES level flags to discriminate between post-ES2
>     revisions
>   [ARM] OMAP3 powerdomains: make USBTLL SAR only available on ES3.1 and
>     beyond
> 
> Russell King (44):
>   [ARM] omap: remove VIRTUAL_CLOCK
>   [ARM] omap: introduce clock operations structure
>   [ARM] omap: provide a NULL clock operations structure
>   [ARM] omap: kill PARENT_CONTROLS_CLOCK
>   [ARM] omap: add default .ops to all remaining OMAP2 clocks
>   [ARM] omap: eliminate unnecessary conditionals in
>     omap2_clk_wait_ready
>   [ARM] omap: don't use clkops_omap2_dflt_wait for non-ICLK/FCLK clocks
>   [ARM] omap: remove clk->owner
>   [ARM] omap: rearrange clock.h structure order
>   [ARM] omap: remove clk_deny_idle and clk_allow_idle
>   [ARM] omap: provide a standard clk_get_parent() implementation
>   [ARM] omap: move clock propagation into core omap clock code
>   [ARM] omap: remove unnecessary calls to propagate_rate()
>   [ARM] omap: move propagate_rate() calls into generic omap clock code
>   [ARM] omap: handle RATE_CKCTL via .set_rate/.round_rate methods
>   [ARM] omap: ensure devname is set for dummy devices
>   [ARM] omap: allow double-registering of clocks
>   [ARM] omap: convert OMAP1 to use clkdev
>   [ARM] omap: convert OMAP2 to use clkdev
>   [ARM] omap: convert OMAP3 to use clkdev
>   [ARM] omap: remove pre-CLKDEV clk_get/clk_put
>   [ARM] omap: provide a dummy clock node
>   [ARM] omap: watchdog: convert clocks to match by devid and conid
>   [ARM] omap: watchdog: provide a dummy ick for OMAP1
>   [ARM] omap: MMC: convert clocks to match by devid and conid
>   [ARM] omap: MMC: provide a dummy ick for OMAP1
>   [ARM] omap: mcspi: new short connection id names
>   [ARM] omap: mcbsp: convert to use fck/ick clocks directly
>   [ARM] omap: i2c: use short connection ids
>   [ARM] omap: i2c: remove armxor_ck
>   [ARM] omap: i2c: remove conditional ick clocks
>   [ARM] omap: w1: convert omap HDQ clocks to match by devid and conid
>   [ARM] omap: spi: arrange for omap_uwire to use connection ID
>   [ARM] omap: convert omap RNG clocks to match by devid and conid
>   [ARM] omap: omap24xxcam: use short connection IDs for omap2 clocks
>   [ARM] omap: hsmmc: new short connection id names
>   [ARM] omap: clks: call recalc after any rate change
>   [ARM] omap: create a proper tree of clocks
>   [ARM] omap: fix usecount decrement bug
>   [ARM] omap: fix clockdomain enable/disable ordering
>   [ARM] omap: arrange for clock recalc methods to return the rate
>   [ARM] omap: add support for bypassing DPLLs
>   [ARM] omap: ensure that failing power domain lookups produce errors
>   [ARM] omap: clk_set_parent: deny changing parent if clock is enabled
> 
> Sergio Aguirre (1):
>   [ARM] OMAP: Add CSI2 clock struct for handling it with clock API
> 
> Tero Kristo (1):
>   [ARM] OMAP3: PM: Make sure clk_disable_unused() order is correct
> 
> Tomi Valkeinen (1):
>   [ARM] OMAP: wait for pwrdm transition after clk_enable()
> 
> Tony Lindgren (1):
>   [ARM] omap: Fix omap1 clock issues
> 
>  arch/arm/mach-omap1/clock.c                   |  407 ++++++----
>  arch/arm/mach-omap1/clock.h                   |  412 +++-------
>  arch/arm/mach-omap1/mcbsp.c                   |   52 +-
>  arch/arm/mach-omap2/Makefile                  |    6 +-
>  arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
>  arch/arm/mach-omap2/board-apollon.c           |    2 +-
>  arch/arm/mach-omap2/board-generic.c           |    2 +-
>  arch/arm/mach-omap2/board-h4.c                |    2 +-
>  arch/arm/mach-omap2/board-ldp.c               |    2 +-
>  arch/arm/mach-omap2/board-omap3beagle.c       |    2 +-
>  arch/arm/mach-omap2/clock.c                   |  499 +++++++-----
>  arch/arm/mach-omap2/clock.h                   |   24 +-
>  arch/arm/mach-omap2/clock24xx.c               |  377 +++++++--
>  arch/arm/mach-omap2/clock24xx.h               |  525 +++++--------
>  arch/arm/mach-omap2/clock34xx.c               |  582 ++++++++++++--
>  arch/arm/mach-omap2/clock34xx.h               | 1076 +++++++++----------------
>  arch/arm/mach-omap2/clockdomain.c             |   76 +-
>  arch/arm/mach-omap2/clockdomains.h            |  118 ++-
>  arch/arm/mach-omap2/cm-regbits-24xx.h         |   80 ++-
>  arch/arm/mach-omap2/cm-regbits-34xx.h         |  121 +++-
>  arch/arm/mach-omap2/devices.c                 |    5 +-
>  arch/arm/mach-omap2/id.c                      |    7 +-
>  arch/arm/mach-omap2/io.c                      |    8 +-
>  arch/arm/mach-omap2/mcbsp.c                   |   26 -
>  arch/arm/mach-omap2/memory.c                  |  191 -----
>  arch/arm/mach-omap2/memory.h                  |   43 -
>  arch/arm/mach-omap2/pm.c                      |    2 +-
>  arch/arm/mach-omap2/powerdomains.h            |    8 +-
>  arch/arm/mach-omap2/powerdomains34xx.h        |   68 ++-
>  arch/arm/mach-omap2/prcm-common.h             |  198 +++--
>  arch/arm/mach-omap2/prm-regbits-34xx.h        |    9 +
>  arch/arm/mach-omap2/prm.h                     |   24 +-
>  arch/arm/mach-omap2/sdrc.c                    |   93 +++
>  arch/arm/mach-omap2/sdrc2xxx.c                |  163 ++++
>  arch/arm/plat-omap/Kconfig                    |    3 +
>  arch/arm/plat-omap/clock.c                    |  198 ++---
>  arch/arm/plat-omap/common.c                   |    2 +-
>  arch/arm/plat-omap/cpu-omap.c                 |   57 ++-
>  arch/arm/plat-omap/include/mach/clkdev.h      |   13 +
>  arch/arm/plat-omap/include/mach/clock.h       |   80 +-
>  arch/arm/plat-omap/include/mach/clockdomain.h |   24 +-
>  arch/arm/plat-omap/include/mach/common.h      |    2 +-
>  arch/arm/plat-omap/include/mach/cpu.h         |   26 +-
>  arch/arm/plat-omap/include/mach/gpmc.h        |    2 +-
>  arch/arm/plat-omap/include/mach/io.h          |    4 +-
>  arch/arm/plat-omap/include/mach/mcbsp.h       |    6 +-
>  arch/arm/plat-omap/include/mach/pm.h          |   12 -
>  arch/arm/plat-omap/include/mach/powerdomain.h |    5 +-
>  arch/arm/plat-omap/include/mach/prcm.h        |    5 +-
>  arch/arm/plat-omap/include/mach/sdrc.h        |   64 ++-
>  arch/arm/plat-omap/include/mach/system.h      |    4 +-
>  arch/arm/plat-omap/mcbsp.c                    |   90 +--
>  drivers/char/hw_random/omap-rng.c             |    2 +-
>  drivers/i2c/busses/i2c-omap.c                 |   47 +-
>  drivers/media/video/omap24xxcam.c             |    8 +-
>  drivers/mmc/host/omap.c                       |   24 +-
>  drivers/mmc/host/omap_hsmmc.c                 |    4 +-
>  drivers/spi/omap2_mcspi.c                     |    4 +-
>  drivers/spi/omap_uwire.c                      |    9 +-
>  drivers/w1/masters/omap_hdq.c                 |    4 +-
>  drivers/watchdog/omap_wdt.c                   |   94 +--
>  61 files changed, 3275 insertions(+), 2730 deletions(-)
>  delete mode 100644 arch/arm/mach-omap2/memory.c
>  delete mode 100644 arch/arm/mach-omap2/memory.h
>  create mode 100644 arch/arm/mach-omap2/sdrc.c
>  create mode 100644 arch/arm/mach-omap2/sdrc2xxx.c
>  create mode 100644 arch/arm/plat-omap/include/mach/clkdev.h
> 

