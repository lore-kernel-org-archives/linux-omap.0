From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] OMAP: core/clock: patches for 2.6.39
Date: Thu, 10 Mar 2011 16:47:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103101644320.19559@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33678 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab1CJXrl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Mar 2011 18:47:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Tony,

Here are some OMAP core and clock-related patches for 2.6.39.

The following changes since commit 0dde52a9f5330eec240660191a94b51bd911ffcd:

  Merge branch 'omap-l3-for-next' of git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base into omap-for-linus (2011-03-09 13:15:49 -0800)

are available in the git repository at:

  git://git.pwsan.com/linux-integration integration-2.6.39-for-tony

Avinash.H.M (1):
      omap: hwmod: add syss reset done flags to omap2, omap3 hwmods

Benoit Cousson (3):
      omap4: clockdomain: Fix the CPUx domain name
      OMAP3: hwmod data: Fix incorrect SmartReflex -> L4 CORE interconnect links
      OMAP3: hwmod data: Remove masters port links for interconnects.

Felipe Balbi (1):
      OMAP: clock: fix compile warning

Kishon Vijay Abraham I (1):
      OMAP2+: hwmod: add API to handle autoidle mode

Paul Walmsley (34):
      OMAP2+: clock: autoidle as many clocks as possible if CONFIG_OMAP_RESET_CLOCKS
      OMAP2+: clock: disable autoidle on all clocks during clock init
      MMC: omap_hsmmc: enable interface clock before calling mmc_host_enable()
      OMAP2/3: WKUP powerdomain: mark as being always on
      OMAP2+: powerdomain: fix bank power state bitfields
      OMAP2+: powerdomain: add pwrdm_can_ever_lose_context()
      OMAP2: clock: add DPLL autoidle support
      OMAP2xxx: clock: add clockfw autoidle support for APLLs
      OMAP2+: clock: comment that osc_ck/osc_sys_ck should use clockfw autoidle control
      OMAP2+: clock: add interface clock type code with autoidle support
      OMAP2420: clock: add sdrc_ick
      OMAP2420: clock: use autoidle clkops for all autoidle-controllable interface clocks
      OMAP2430/3xxx: clock: add modem clock autoidle support
      OMAP2430: clock: use autoidle clkops for all autoidle-controllable interface clocks
      OMAP3: clock: use autoidle clkops for all autoidle-controllable interface clocks
      OMAP2/3: PM: remove manual CM_AUTOIDLE bit setting in mach-omap2/pm*xx.c
      OMAP: smartreflex: move plat/smartreflex.h to mach-omap2/smartreflex.h
      OMAP: voltage: move plat/voltage.h to mach-omap2/voltage.h
      OMAP2+: voltage: reorganize, split code from data
      OMAP2xxx: clock: fix parents for L3-derived clocks
      OMAP2xxx: clock: fix low-frequency oscillator clock rate
      OMAP2xxx: clock: fix interface clocks and clockdomains for modules in the WKUP domain
      OMAP: clock: bail out early if arch_clock functions not implemented
      OMAP2+: clock: remove the DPLL rate tolerance code
      OMAP2xxx: clock: remove dsp_irate_ick
      OMAP2xxx: clock: fix clockdomains on gpt7_ick, 2430 mmchs2_fck clocks
      OMAP2xxx: clock data: clean up some comments
      MAINTAINERS: add entry for OMAP powerdomain/clockdomain per-SoC layer support
      OMAP2+: hwmod: fix a documentation bug with HWMOD_NO_OCP_AUTOIDLE
      OMAP2+: hwmod: allow board files to prevent devices from being reset upon init
      OMAP2+: clockdomain: add flag that will block autodeps from being added for a clockdomain
      Merge remote branches 'remotes/origin/pwrdm_clkdm_b_2.6.39', 'remotes/origin/pwrdm_add_can_lose_context_fns_2.6.39', 'remotes/origin/omap_device_a_2.6.39', 'remotes/origin/mmc_a_2.6.39', 'remotes/origin/hwmod_b_2.6.39', 'remotes/origin/dmtimer_a_2.6.39', 'remotes/origin/pwrdm_clkdm_a_2.6.39', 'remotes/origin/clkdm_statdep_omap4_2.6.39', 'remotes/origin/clk_a_2.6.39', 'remotes/origin/clk_autoidle_a_2.6.39', 'remotes/origin/clk_autoidle_b_2.6.39', 'remotes/origin/clk_b_2.6.39', 'remotes/origin/clk_clkdm_a_2.6.39', 'remotes/origin/misc_a_2.6.39' and 'remotes/origin/for_2.6.39/omap3_hwmod_data' into tmp-integration-2.6.39-20110310-018
      Merge remote branch 'remotes/origin/hwmod_a_2.6.39' into tmp-integration-2.6.39-20110310-018
      Merge remote branch 'remotes/origin/voltage_split_2.6.39' into tmp-integration-2.6.39-20110310-018

Rajendra Nayak (18):
      OMAP: powerdomain: remove unused func declaration
      OMAP: clockdomain: Infrastructure to put arch specific code
      OMAP: clockdomain: Arch specific funcs to handle deps
      OMAP: clockdomain: Arch specific funcs for sleep/wakeup of clkdm
      OMAP: clockdomain: Arch specific funcs for hwsup control of clkdm
      OMAP: clockdomain: Arch specific funcs for clkdm_clk_enable/disable
      OMAP4: clockdomain: Add clkdm static dependency srcs
      OMAP4: CM: Add CM accesor api for bitwise control
      OMAP4: clockdomain: Add wkup/sleep dependency support
      OMAP4: clockdomain: Remove pr_errs' stating unsupported wkdep
      omap: clock: Check for enable/disable ops support
      omap3: dpll: Populate clkops for dpll1_ck
      OMAP: clock: Add allow_idle/deny_idle support in clkops
      OMAP3/4: DPLL: Add allow_idle/deny_idle support for all DPLL's
      OMAP4: DPLL: Add dpll api to control GATE_CTRL
      omap4: dpll: Enable auto gate control for all MX postdividers
      OMAP2+: omap_device/clock: Do not expect an entry in clkdev for opt_clks
      OMAP2+: hwmod: Fix what _init_clock returns

Sanjeev Premi (1):
      omap2/3: clockdomains: fix compile-time warnings

Santosh Shilimkar (1):
      omap4: powerdomain: Use intended PWRSTS_* flags instead of values

Tarun Kanti DebBarma (1):
      OMAP2+: hwmod: fix incorrect computation of autoidle_mask

Tero Kristo (1):
      omap2/3: dmtimer: Enable autoidle

omar ramirez (1):
      OMAP2+: hwmod: use status bit info for reset line

 MAINTAINERS                                        |   10 +
 arch/arm/mach-omap2/Makefile                       |   32 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c                |   24 +
 arch/arm/mach-omap2/clkt2xxx_dpll.c                |   63 ++
 arch/arm/mach-omap2/clkt2xxx_osc.c                 |   14 +
 arch/arm/mach-omap2/clkt_dpll.c                    |   91 +--
 arch/arm/mach-omap2/clkt_iclk.c                    |   82 ++
 arch/arm/mach-omap2/clock.c                        |   28 +-
 arch/arm/mach-omap2/clock.h                        |   21 +-
 arch/arm/mach-omap2/clock2420_data.c               |  221 +++--
 arch/arm/mach-omap2/clock2430_data.c               |  232 +++---
 arch/arm/mach-omap2/clock2xxx.h                    |    4 +-
 arch/arm/mach-omap2/clock34xx.c                    |   29 +-
 arch/arm/mach-omap2/clock34xx.h                    |    5 +-
 arch/arm/mach-omap2/clock3517.c                    |    4 +-
 arch/arm/mach-omap2/clock3xxx.c                    |    3 -
 arch/arm/mach-omap2/clock3xxx_data.c               |  165 ++--
 arch/arm/mach-omap2/clock44xx_data.c               |   57 +-
 arch/arm/mach-omap2/clock_common_data.c            |    6 +
 arch/arm/mach-omap2/clockdomain.c                  |  439 +++------
 arch/arm/mach-omap2/clockdomain.h                  |   70 ++-
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c         |  274 ++++++
 arch/arm/mach-omap2/clockdomain44xx.c              |  137 +++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c   |   12 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c        |  396 ++++++++-
 arch/arm/mach-omap2/cm-regbits-24xx.h              |    3 +
 arch/arm/mach-omap2/cm2xxx_3xxx.c                  |   69 ++
 arch/arm/mach-omap2/cm2xxx_3xxx.h                  |    8 +
 arch/arm/mach-omap2/cm44xx.h                       |    1 +
 arch/arm/mach-omap2/cminst44xx.c                   |   21 +
 arch/arm/mach-omap2/cminst44xx.h                   |    6 +
 arch/arm/mach-omap2/cpuidle34xx.c                  |    4 +-
 arch/arm/mach-omap2/dpll44xx.c                     |   84 ++
 arch/arm/mach-omap2/io.c                           |    6 +-
 arch/arm/mach-omap2/omap_hwmod.c                   |  157 +++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   11 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   12 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   42 +-
 arch/arm/mach-omap2/omap_opp_data.h                |   24 +
 arch/arm/mach-omap2/omap_twl.c                     |    2 +-
 arch/arm/mach-omap2/opp3xxx_data.c                 |   66 ++-
 arch/arm/mach-omap2/opp4xxx_data.c                 |   43 +-
 arch/arm/mach-omap2/pm.c                           |    8 +-
 arch/arm/mach-omap2/pm24xx.c                       |   77 +--
 arch/arm/mach-omap2/pm34xx.c                       |  128 +---
 arch/arm/mach-omap2/powerdomain.c                  |   43 +-
 arch/arm/mach-omap2/powerdomain.h                  |   19 +-
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c   |    9 +-
 arch/arm/mach-omap2/powerdomains2xxx_data.c        |   18 +-
 arch/arm/mach-omap2/powerdomains3xxx_data.c        |   38 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c        |   88 +-
 arch/arm/mach-omap2/prcm_mpu44xx.h                 |    4 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.c                 |   18 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h                 |    5 +-
 arch/arm/mach-omap2/smartreflex-class3.c           |    2 +-
 arch/arm/mach-omap2/smartreflex.c                  |    2 +-
 .../include/plat => mach-omap2}/smartreflex.h      |    3 +-
 arch/arm/mach-omap2/sr_device.c                    |    4 +-
 arch/arm/mach-omap2/vc.h                           |   83 ++
 arch/arm/mach-omap2/vc3xxx_data.c                  |   63 ++
 arch/arm/mach-omap2/vc44xx_data.c                  |   75 ++
 arch/arm/mach-omap2/voltage.c                      | 1020 ++++++--------------
 .../include/plat => mach-omap2}/voltage.h          |   89 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c      |   95 ++
 arch/arm/mach-omap2/voltagedomains44xx_data.c      |  102 ++
 arch/arm/mach-omap2/vp.h                           |  143 +++
 arch/arm/mach-omap2/vp3xxx_data.c                  |   82 ++
 arch/arm/mach-omap2/vp44xx_data.c                  |  100 ++
 arch/arm/plat-omap/clock.c                         |   99 ++-
 arch/arm/plat-omap/dmtimer.c                       |    4 +
 arch/arm/plat-omap/include/plat/clock.h            |   27 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h       |    8 +-
 arch/arm/plat-omap/omap_device.c                   |   36 +-
 drivers/mmc/host/omap_hsmmc.c                      |    6 +-
 74 files changed, 3533 insertions(+), 1943 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clkt2xxx_dpll.c
 create mode 100644 arch/arm/mach-omap2/clkt_iclk.c
 create mode 100644 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c
 create mode 100644 arch/arm/mach-omap2/clockdomain44xx.c
 create mode 100644 arch/arm/mach-omap2/dpll44xx.c
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/smartreflex.h (99%)
 create mode 100644 arch/arm/mach-omap2/vc.h
 create mode 100644 arch/arm/mach-omap2/vc3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/vc44xx_data.c
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/voltage.h (63%)
 create mode 100644 arch/arm/mach-omap2/voltagedomains3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/voltagedomains44xx_data.c
 create mode 100644 arch/arm/mach-omap2/vp.h
 create mode 100644 arch/arm/mach-omap2/vp3xxx_data.c
 create mode 100644 arch/arm/mach-omap2/vp44xx_data.c



- Paul
