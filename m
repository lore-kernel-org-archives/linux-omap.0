From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.19-rc1
Date: Tue, 6 Jan 2015 15:18:14 -0800
Message-ID: <20150106231814.GC4081@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50505 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbbAFXWD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jan 2015 18:22:03 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.19/fixes-rc1

for you to fetch changes up to 7ac72746aa9bb305fa74b44ec73eae99bbbe9b66:

  ARM: dts: Revert disabling of smc91x for n900 (2015-01-06 08:49:57 -0800)

----------------------------------------------------------------
Fixes for omaps mostly to deal with dra7 timer issues
and hypervisor mode. The other fixes are minor fixes for
various boards. The summary of the fixes is:

- Fix real-time counter rate typos for some frequencies

- Fix counter frequency drift for am572x

- Fix booting of secondary CPU in HYP mode

- Fix n900 board name for legacy user space

- Fix cpufreq in omap2plus_defconfig after Kconfig change

- Fix dra7 qspi partitions

And also, let's re-enable smc91x on some n900 boards that
we have sitting in a few test boot systems after the boot
loader dependencies got fixed.

----------------------------------------------------------------
Lennart Sorensen (3):
      ARM: omap5/dra7xx: Fix frequency typos
      ARM: dra7xx: Fix counter frequency drift for AM572x errata i856
      ARM: omap5/dra7xx: Enable booting secondary CPU in HYP mode

Mugunthan V N (1):
      ARM: dts: dra7-evm: fix qspi device tree partition size

Nishanth Menon (1):
      ARM: omap2plus_defconfig: use CONFIG_CPUFREQ_DT

Tony Lindgren (2):
      ARM: OMAP2+: Fix n900 board name for legacy user space
      ARM: dts: Revert disabling of smc91x for n900

 arch/arm/boot/dts/dra7-evm.dts       | 10 ++++----
 arch/arm/boot/dts/omap3-n900.dts     |  4 +---
 arch/arm/configs/omap2plus_defconfig |  2 +-
 arch/arm/mach-omap2/board-generic.c  | 18 +++++++++++++++
 arch/arm/mach-omap2/common.h         |  1 +
 arch/arm/mach-omap2/control.h        |  4 ++++
 arch/arm/mach-omap2/omap-headsmp.S   | 21 +++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c       | 13 +++++++++--
 arch/arm/mach-omap2/timer.c          | 44 +++++++++++++++++++++++++++++++-----
 9 files changed, 100 insertions(+), 17 deletions(-)
