From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] few fixes for the v3.19 merge window
Date: Wed, 10 Dec 2014 12:57:52 -0800
Message-ID: <20141210205752.GB12921@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36340 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933226AbaLJU7k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2014 15:59:40 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit a0e4467726cd26bacb16f13d207ffcfa82ffc07d:

  Merge tag 'asm-generic-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic (2014-12-09 17:25:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/fixes-for-merge-window

for you to fetch changes up to 661ea91b676bcca137c1c3fe838997925ce98060:

  ARM: omap2plus_defconfig: Enable AHCI_PLATFORM driver (2014-12-10 09:33:50 -0800)

----------------------------------------------------------------
Fixes for a few issues found that would be good to get
into -rc1:

- Update SoC revision detection for am43x es1.2

- Fix regression with GPMC timings on 2430sdp for some versions
  of u-boot

- Fix dra7 watchdog compatible property

- Fix am437x-sk-evm LCD timings

- Fix dra7 DSS clock muxing

- Fix dra7-evm voltages

- Remove a unused function prototype for am33xx_clk_init

- Enable AHCI in the omap2plus_defconfig

----------------------------------------------------------------
Felipe Balbi (1):
      ARM: dts: am437x-sk: fix lcd enable pin mux data

Johan Hovold (1):
      ARM: OMAP2+: clock: remove unused function prototype

Lokesh Vutla (2):
      ARM: dts: DRA7: wdt: Fix compatible property for watchdog node
      ARM: OMAP2+: AM43x: Add ID for ES1.2

Ravikumar Kattekola (2):
      ARM: dts: dra7-evm: Fix typo in SMPS6 (VDD_GPU) max voltage
      ARM: dts: dra7-evm: Update SMPS7 (VDD_CORE) max voltage to match DM

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable AHCI_PLATFORM driver

Tomi Valkeinen (2):
      ARM: dts: dra7: fix DSS PLL clock mux registers
      ARM: dts: am437x-sk-evm.dts: fix LCD timings

Tony Lindgren (2):
      Merge branch 'omap-for-v3.19/fixes-not-urgent' into omap-for-v3.19/fixes
      ARM: dts: Fix gpmc regression for omap 2430sdp smc91x

 arch/arm/boot/dts/am437x-sk-evm.dts  | 15 +++++++--------
 arch/arm/boot/dts/dra7-evm.dts       |  4 ++--
 arch/arm/boot/dts/dra7.dtsi          |  2 +-
 arch/arm/boot/dts/dra72-evm.dts      |  2 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi |  6 +++---
 arch/arm/boot/dts/omap2430-sdp.dts   | 32 ++++++++++++++++----------------
 arch/arm/configs/omap2plus_defconfig |  2 ++
 arch/arm/mach-omap2/clock.h          |  2 --
 arch/arm/mach-omap2/id.c             |  8 ++++++--
 arch/arm/mach-omap2/soc.h            |  1 +
 10 files changed, 39 insertions(+), 35 deletions(-)
