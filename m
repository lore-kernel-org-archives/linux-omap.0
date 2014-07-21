From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap soc clean-up for v3.17 merge window
Date: Mon, 21 Jul 2014 05:30:01 -0700
Message-ID: <20140721123000.GB18374@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40907 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755108AbaGUMb1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Jul 2014 08:31:27 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit cd3de83f147601356395b57a8673e9c5ff1e59d1:

  Linux 3.16-rc4 (2014-07-06 12:37:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/soc-cleanup

for you to fetch changes up to 3db53918e306d3960bf9e12eea8b2fd3f7d0fd62:

  Merge tag 'for-v3.17/omap-clock-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.17/soc (2014-07-21 00:35:38 -0700)

----------------------------------------------------------------

SoC specific omap clean-up for v3.17 merge window:

- Changes to PRM and clock related code to help move
  things to drivers

- Removal of unused ctrl module defines that no longer
  are needed with things moving to .dts files and
  drivers

----------------------------------------------------------------
Joachim Eastwood (1):
      ARM: OMAP4: Ctrl module register define diet

Tero Kristo (22):
      ARM: OMAP3: PRM: move prcm wakeup helper to prm driver
      ARM: OMAP3: PRM: move iva reset to PRM driver
      ARM: OMAP3: PRM: move modem reset to PRM driver
      ARM: OMAP3: PRM: add API for checking and clearing cold reset status
      ARM: OMAP3: PRM: add API for saving PRM scratchpad contents
      ARM: OMAP24xx: PRM: add API for clearing wakeup status bits
      ARM: OMAP3: PRM: move PRM init code from PM core to the driver
      ARM: OMAP3: control: add API for setting up the modem pads
      ARM: OMAP3: PRM: move modem reset and iva2 idle to PRM driver
      ARM: OMAP3: control: isolate control module init to its own function
      ARM: OMAP4+: clock: remove DEFINE_CLK_OMAP_HSDIVIDER macro
      ARM: OMAP4+: dpll: remove cpu_is_omap44xx checks
      ARM: OMAP4+: dpll44xx: remove cm-regbits-44xx.h and clock44xx.h includes
      ARM: OMAP2+: clock: introduce ti_clk_features flags
      ARM: OMAP2+: clock: add fint values to the ti_clk_features struct
      ARM: OMAP2+: clock/dpll: add private API for checking if DPLL is in bypass
      ARM: OMAP2+: clock/dpll: convert bypass check to use clk_features
      ARM: OMAP2+: clock/dpll: add jitter correction behind clk_features
      ARM: OMAP2+: clock/interface: add a clk_features definition for idlest value
      ARM: OMAP2+: clock/dpll: remove unused header includes from clkt_dpll.c
      ARM: OMAP2+: clock/dpll: remove unused header includes from dpll3xxx.c
      ARM: OMAP2+: clock/interface: remove some headers from clkt_iclk.c file

Tony Lindgren (2):
      Merge branch 'for-v3.17/cm-prm-cleanup' of https://github.com/t-kristo/linux-pm into omap-for-v3.17/soc
      Merge tag 'for-v3.17/omap-clock-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.17/soc

 arch/arm/mach-omap2/clkt_dpll.c                 |   98 +-
 arch/arm/mach-omap2/clkt_iclk.c                 |    8 +-
 arch/arm/mach-omap2/clock.c                     |   76 +-
 arch/arm/mach-omap2/clock.h                     |   44 +-
 arch/arm/mach-omap2/control.c                   |   60 +-
 arch/arm/mach-omap2/control.h                   |   40 +-
 arch/arm/mach-omap2/ctrl_module_core_44xx.h     |  392 -------
 arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h | 1409 -----------------------
 arch/arm/mach-omap2/ctrl_module_pad_wkup_44xx.h |  236 ----
 arch/arm/mach-omap2/dpll3xxx.c                  |    7 +-
 arch/arm/mach-omap2/dpll44xx.c                  |   19 +-
 arch/arm/mach-omap2/io.c                        |    2 +
 arch/arm/mach-omap2/pm24xx.c                    |   31 +-
 arch/arm/mach-omap2/pm34xx.c                    |  218 +---
 arch/arm/mach-omap2/prm2xxx.c                   |   18 +
 arch/arm/mach-omap2/prm2xxx.h                   |    1 +
 arch/arm/mach-omap2/prm3xxx.c                   |  233 ++++
 arch/arm/mach-omap2/prm3xxx.h                   |    6 +
 18 files changed, 516 insertions(+), 2382 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_core_44xx.h
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_pad_core_44xx.h
 delete mode 100644 arch/arm/mach-omap2/ctrl_module_pad_wkup_44xx.h
