From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: core/PM architecture: pull request for 2.6.38
Date: Tue, 21 Dec 2010 23:30:54 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012212327580.21915@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41999 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab0LVGaz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Dec 2010 01:30:55 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: khilman@deeprootsystems.com, b-cousson@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Hi Tony,

The following changes since commit b9e7683bbca638967a56e5d7fd4035a947109621:

  Merge branch 'pm-opp' of ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm into omap-for-linus (2010-12-21 17:05:57 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-2.6 integration-2.6.38-for-tony

The patches in this branch have been boot-tested on OMAP OSK5912,
N800, 2430SDP, OMAP3530 Beagle, DM37xx Beagle XM, and OMAP4430 ES2
Panda.

size:
   text	   data	    bss	    dec	    hex	filename
4528257	 260768	 132224	4921249	 4b17a1	vmlinux.omap1.ofl
4528385	 260768	 132224	4921377	 4b1821	vmlinux.omap1.patched
5743833	 474336	5608800	11826969 b47719	vmlinux.omap2plus.ofl
5751589	 474464	5608768	11834821 b495c5	vmlinux.omap2plus.patched


Benoit Cousson (14):
      OMAP4: PRCM: Add SCRM header file
      OMAP4: clock data: Add control for pad_clks_ck and slimbus_clk
      OMAP3: clock data: Add "wkup_clkdm" in sr1_fck and sr2_fck
      OMAP4: hwmod data: Fix hwmod entries order
      OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
      OMAP4: hwmod data: Fix missing address in DMM and EMIF_FW
      OMAP4: hwmod data: Add IVA and DSP
      OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk
      OMAP2430: hwmod data: Use common dev_attr for i2c1 and i2c2
      OMAP2+: hwmod: Make omap_hwmod_register private and remove omap_hwmod_unregister
      OMAP2+: hwmod: Mark functions used only during initialization with __init
      OMAP2+: hwmod: Remove omap_hwmod_mutex
      OMAP2+: hwmod: Add wakeup support for new OMAP4 IPs
      OMAP4: hwmod data: Add SIDLE_SMART_WKUP modes to several IPs

Charulatha V (1):
      OMAP3: clock: Update clock domain name for mcspi fck

Hari Kanigeri (1):
      OMAP4: clocks: add dummy clock for mailbox

Janusz Krzysztofik (1):
      OMAP1: clock_data: use runtime cpu / machine checks

Jon Hunter (1):
      OMAP: clock: fix configuration of J-Type DPLLs to work for OMAP3 and OMAP4

Jonathan Bergsagel (1):
      OMAP4: clock data: Add missing fields in iva_hsd_byp_clk_mux_ck

Kevin Hilman (4):
      OMAP2+: omap_hwmod: fix wakeup enable/disable for consistency
      OMAP2+: powerdomain: add API to get context loss count
      OMAP: PM: implement context loss count APIs
      OMAP: PM noop: implement context loss count for non-omap_devices

Paul Walmsley (31):
      OMAP2+: io: split omap2_init_common_hw()
      OMAP2+: hwmod: allow custom pre-shutdown functions
      OMAP2+: hwmod: add postsetup state
      OMAP2+: hwmod: add support for per-class custom device reset functions
      OMAP2+: hwmod: upgrade per-hwmod mutex to a spinlock
      OMAP2+: hwmod: fix a warning, add some docs, remove unused fields
      OMAP2+: wd_timer: separate watchdog disable code from the rest of mach-omap2/devices.c
      OMAP2+: wd_timer: disable on boot via hwmod postsetup mechanism
      OMAP2+: powerdomains: move powerdomain static data to .c files
      OMAP2+: clockdomains: move clockdomain static data to .c files
      OMAP3: control/PRCM: add omap3_ctrl_write_boot_mode()
      OMAP3: control/PRCM: move CONTROL_PADCONF_SYS_NIRQ save/restore to SCM code
      OMAP4: PRCM: reorganize existing OMAP4 PRCM header files
      OMAP4: PRCM: rename _MOD macros to _INST
      OMAP2/3: PRCM: split OMAP2/3-specific PRCM code into OMAP2/3-specific files
      OMAP3: PRM/CM: separate CM context save/restore; remove PRM context save/restore
      OMAP4: PRCM: add OMAP4-specific accessor/mutator functions
      OMAP4: PRCM: move global reset function for OMAP4 to an OMAP4-specific file
      OMAP2/3: PRM/CM: prefix OMAP2 PRM/CM functions with "omap2_"
      OMAP4: powerdomains: add PRCM partition data; use OMAP4 PRM functions
      OMAP2+: clockdomains: split the clkdm hwsup enable/disable function
      OMAP4: CM instances: add clockdomain register offsets
      OMAP4: clockdomains: add OMAP4 PRCM data and OMAP4 support
      OMAP2/3: clockdomain: remove unneeded .clkstctrl_reg, remove some direct CM register accesses
      OMAP2+: clockdomain: move header file from plat-omap to mach-omap2
      OMAP2+: powerdomain: move header file from plat-omap to mach-omap2
      OMAP3: control/PM: move padconf save code to mach-omap2/control.c
      OMAP2xxx clock: fix dss2_fck recalc to use clksel
      OMAP3: clock: clarify usage of struct clksel_rate.flags and struct omap_clk.cpu
      OMAP3: clock: fix incorrect rate display when switching MPU rate at boot
      OMAP2/3: SRAM: add comment about crashes during a TLB miss

Rajendra Nayak (12):
      OMAP2+: hwmod: Update the sysc_cache in case module context is lost
      OMAP: powerdomain: Move static allocations from powerdomains.h to a .c file
      OMAP: powerdomain: Infrastructure to put arch specific code
      OMAP: powerdomain: Arch specific funcs for state control
      OMAP: powerdomain: Arch specific funcs for logic control
      OMAP: powerdomain: Arch specific funcs for mem control
      OMAP4: clock data: Add SCRM auxiliary clock nodes
      OMAP4: clock data: Export control to enable/disable CORE/PER M3 clocks
      OMAP2+: hwmod: Disable clocks when hwmod enable fails
      OMAP4: PM: Use the low-power state change feature on OMAP4
      OMAP4: PM: Do not assume clkdm supports hw transitions
      OMAP4: powerdomain: l4per pwrdm does not support OFF

Santosh Shilimkar (3):
      OMAP4: powerdomain: Add pwrdm_clear_all_prev_pwrst
      OMAP4: powerdomain: Remove L3INIT_PD OFF state
      OMAP4: clock data: Keep L3INSTR clock domain modulemode under HW control

Thara Gopinath (1):
      OMAP4: clock data: Add missing DPLL x2 clock nodes

 arch/arm/mach-omap1/clock_data.c                   |   17 +-
 arch/arm/mach-omap2/Makefile                       |   48 +-
 arch/arm/mach-omap2/board-2430sdp.c                |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c                |    3 +-
 arch/arm/mach-omap2/board-3630sdp.c                |    5 +-
 arch/arm/mach-omap2/board-4430sdp.c                |    3 +-
 arch/arm/mach-omap2/board-am3517crane.c            |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c              |    4 +-
 arch/arm/mach-omap2/board-apollon.c                |    3 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    3 +-
 arch/arm/mach-omap2/board-cm-t3517.c               |    3 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    5 +-
 arch/arm/mach-omap2/board-generic.c                |    3 +-
 arch/arm/mach-omap2/board-h4.c                     |    3 +-
 arch/arm/mach-omap2/board-igep0020.c               |    4 +-
 arch/arm/mach-omap2/board-igep0030.c               |    4 +-
 arch/arm/mach-omap2/board-ldp.c                    |    3 +-
 arch/arm/mach-omap2/board-n8x0.c                   |    3 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |    5 +-
 arch/arm/mach-omap2/board-omap3evm.c               |    3 +-
 arch/arm/mach-omap2/board-omap3logic.c             |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c           |    5 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c         |    5 +-
 arch/arm/mach-omap2/board-omap4panda.c             |    3 +-
 arch/arm/mach-omap2/board-overo.c                  |    5 +-
 arch/arm/mach-omap2/board-rm680.c                  |    3 +-
 arch/arm/mach-omap2/board-rx51.c                   |    3 +-
 arch/arm/mach-omap2/board-zoom.c                   |    9 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c                |   12 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c            |   10 +-
 arch/arm/mach-omap2/clkt2xxx_osc.c                 |    2 +-
 arch/arm/mach-omap2/clkt2xxx_sys.c                 |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c       |   14 +-
 arch/arm/mach-omap2/clkt_dpll.c                    |    1 -
 arch/arm/mach-omap2/clock.c                        |    6 +-
 arch/arm/mach-omap2/clock.h                        |    1 -
 arch/arm/mach-omap2/clock2420_data.c               |    6 +-
 arch/arm/mach-omap2/clock2430.c                    |    2 +-
 arch/arm/mach-omap2/clock2430_data.c               |    6 +-
 arch/arm/mach-omap2/clock34xx.c                    |    2 +-
 arch/arm/mach-omap2/clock3517.c                    |    2 +-
 arch/arm/mach-omap2/clock3xxx.c                    |    6 +-
 arch/arm/mach-omap2/clock3xxx_data.c               |  218 ++--
 arch/arm/mach-omap2/clock44xx_data.c               |  641 ++++++---
 arch/arm/mach-omap2/clockdomain.c                  |  220 ++--
 .../include/plat => mach-omap2}/clockdomain.h      |   40 +-
 ...clockdomains.h => clockdomains2xxx_3xxx_data.c} |  109 +--
 ...{clockdomains44xx.h => clockdomains44xx_data.c} |  169 ++-
 arch/arm/mach-omap2/cm-regbits-24xx.h              |    7 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h              |   13 +-
 arch/arm/mach-omap2/cm-regbits-44xx.h              |    3 -
 arch/arm/mach-omap2/cm.c                           |   68 -
 arch/arm/mach-omap2/cm.h                           |  137 +--
 arch/arm/mach-omap2/cm1_44xx.h                     |  261 +++
 arch/arm/mach-omap2/cm2_44xx.h                     |  508 ++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |  471 ++++++
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |  147 ++
 arch/arm/mach-omap2/cm44xx.c                       |   52 +
 arch/arm/mach-omap2/cm44xx.h                       |  668 +--------
 arch/arm/mach-omap2/cm4xxx.c                       |   62 -
 arch/arm/mach-omap2/cminst44xx.c                   |  214 +++
 arch/arm/mach-omap2/cminst44xx.h                   |   31 +
 arch/arm/mach-omap2/control.c                      |  111 ++-
 arch/arm/mach-omap2/control.h                      |    2 +
 arch/arm/mach-omap2/cpuidle34xx.c                  |    4 +-
 arch/arm/mach-omap2/devices.c                      |   64 +-
 arch/arm/mach-omap2/dpll3xxx.c                     |   57 +-
 arch/arm/mach-omap2/dsp.c                          |   23 +-
 arch/arm/mach-omap2/io.c                           |   76 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  469 ++++---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    6 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   20 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    6 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         | 1651 ++++++++++++--------
 arch/arm/mach-omap2/pm-debug.c                     |   21 +-
 arch/arm/mach-omap2/pm.c                           |   40 +-
 arch/arm/mach-omap2/pm.h                           |    2 +-
 arch/arm/mach-omap2/pm24xx.c                       |  204 ++--
 arch/arm/mach-omap2/pm34xx.c                       |  170 +--
 arch/arm/mach-omap2/pm44xx.c                       |    2 +-
 arch/arm/mach-omap2/powerdomain-common.c           |  110 ++
 arch/arm/mach-omap2/powerdomain.c                  |  441 ++----
 arch/arm/mach-omap2/powerdomain.h                  |  233 +++
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c         |  242 +++
 arch/arm/mach-omap2/powerdomain44xx.c              |  225 +++
 arch/arm/mach-omap2/powerdomains.h                 |  153 --
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c   |   79 +
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h   |   22 +
 ...{powerdomains24xx.h => powerdomains2xxx_data.c} |   48 +-
 ...{powerdomains34xx.h => powerdomains3xxx_data.c} |   48 +-
 ...{powerdomains44xx.h => powerdomains44xx_data.c} |   92 +-
 arch/arm/mach-omap2/prcm-common.h                  |   85 +-
 arch/arm/mach-omap2/prcm.c                         |  528 +------
 arch/arm/mach-omap2/prcm44xx.h                     |   42 +
 arch/arm/mach-omap2/prcm_mpu44xx.c                 |   45 +
 arch/arm/mach-omap2/prcm_mpu44xx.h                 |  104 ++
 arch/arm/mach-omap2/prm-regbits-24xx.h             |    2 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h             |    8 +-
 arch/arm/mach-omap2/prm-regbits-44xx.h             |    2 -
 arch/arm/mach-omap2/prm.h                          |  369 +-----
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |   64 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h                 |  367 +++++
 arch/arm/mach-omap2/prm44xx.c                      |   81 +-
 arch/arm/mach-omap2/prm44xx.h                      |  766 +++++-----
 arch/arm/mach-omap2/prminst44xx.c                  |   66 +
 arch/arm/mach-omap2/prminst44xx.h                  |   25 +
 arch/arm/mach-omap2/scrm44xx.h                     |  175 +++
 arch/arm/mach-omap2/sdrc.c                         |    2 -
 arch/arm/mach-omap2/sdrc2xxx.c                     |    6 +-
 arch/arm/mach-omap2/serial.c                       |   14 +-
 arch/arm/mach-omap2/sleep34xx.S                    |    4 +-
 arch/arm/mach-omap2/sram242x.S                     |   10 +-
 arch/arm/mach-omap2/sram243x.S                     |   10 +-
 arch/arm/mach-omap2/sram34xx.S                     |    8 +-
 arch/arm/mach-omap2/wd_timer.c                     |   54 +
 arch/arm/mach-omap2/wd_timer.h                     |   17 +
 arch/arm/plat-omap/gpio.c                          |    5 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h      |   20 +-
 arch/arm/plat-omap/include/plat/clock.h            |   16 +-
 arch/arm/plat-omap/include/plat/common.h           |    2 +
 arch/arm/plat-omap/include/plat/gpio.h             |    2 +-
 arch/arm/plat-omap/include/plat/io.h               |    5 +-
 arch/arm/plat-omap/include/plat/omap-pm.h          |    8 +-
 arch/arm/plat-omap/include/plat/omap_device.h      |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |   55 +-
 arch/arm/plat-omap/include/plat/powerdomain.h      |  167 --
 arch/arm/plat-omap/include/plat/prcm.h             |   20 +-
 arch/arm/plat-omap/mcbsp.c                         |   10 +-
 arch/arm/plat-omap/omap-pm-noop.c                  |   67 +-
 arch/arm/plat-omap/omap_device.c                   |   28 +
 arch/arm/plat-omap/sram.c                          |    5 +-
 drivers/staging/tidspbridge/core/_tiomap.h         |   15 +-
 133 files changed, 7324 insertions(+), 4855 deletions(-)
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/clockdomain.h (82%)
 rename arch/arm/mach-omap2/{clockdomains.h => clockdomains2xxx_3xxx_data.c} (87%)
 rename arch/arm/mach-omap2/{clockdomains44xx.h => clockdomains44xx_data.c} (58%)
 delete mode 100644 arch/arm/mach-omap2/cm.c
 create mode 100644 arch/arm/mach-omap2/cm1_44xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_44xx.h
 create mode 100644 arch/arm/mach-omap2/cm2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/cm2xxx_3xxx.h
 create mode 100644 arch/arm/mach-omap2/cm44xx.c
 delete mode 100644 arch/arm/mach-omap2/cm4xxx.c
 create mode 100644 arch/arm/mach-omap2/cminst44xx.c
 create mode 100644 arch/arm/mach-omap2/cminst44xx.h
 create mode 100644 arch/arm/mach-omap2/powerdomain-common.c
 create mode 100644 arch/arm/mach-omap2/powerdomain.h
 create mode 100644 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/powerdomain44xx.c
 delete mode 100644 arch/arm/mach-omap2/powerdomains.h
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.h
 rename arch/arm/mach-omap2/{powerdomains24xx.h => powerdomains2xxx_data.c} (76%)
 rename arch/arm/mach-omap2/{powerdomains34xx.h => powerdomains3xxx_data.c} (89%)
 rename arch/arm/mach-omap2/{powerdomains44xx.h => powerdomains44xx_data.c} (79%)
 create mode 100644 arch/arm/mach-omap2/prcm44xx.h
 create mode 100644 arch/arm/mach-omap2/prcm_mpu44xx.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu44xx.h
 create mode 100644 arch/arm/mach-omap2/prm2xxx_3xxx.h
 create mode 100644 arch/arm/mach-omap2/prminst44xx.c
 create mode 100644 arch/arm/mach-omap2/prminst44xx.h
 create mode 100644 arch/arm/mach-omap2/scrm44xx.h
 create mode 100644 arch/arm/mach-omap2/wd_timer.c
 create mode 100644 arch/arm/mach-omap2/wd_timer.h
 delete mode 100644 arch/arm/plat-omap/include/plat/powerdomain.h


- Paul

