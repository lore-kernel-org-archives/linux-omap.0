From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap non critical fixes for v3.10 merge window
Date: Tue, 2 Apr 2013 10:29:10 -0700
Message-ID: <38953.3166577623$1364923783@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50850 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761429Ab3DBR3P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Apr 2013 13:29:15 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-non-critical-signed

for you to fetch changes up to 105612489bf59386b46b3f9f034e03f70e57aee6:

  Merge branch 'for_3.10/omap5_generic_updates' of git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux into omap-for-v3.10/fixes-non-critical (2013-04-01 09:30:47 -0700)

----------------------------------------------------------------

Non critical omap fixes for v3.10 merge window. A big chunk
of these fixes are needed to support omap5 es2 version that includes
PM features while the earlier version es1 did not.

----------------------------------------------------------------
Paul Bolle (3):
      ARM: OMAP: fix typo "CONFIG_SMC91x_MODULE"
      ARM: OMAP1: remove "config MACH_OMAP_HTCWIZARD"
      ARM: OMAP2+: fix typo "CONFIG_BRIDGE_DVFS"

Paul Walmsley (1):
      ARM: OMAP2+: powerdomain: avoid testing whether an unsigned char is less than 0

Rajendra Nayak (3):
      ARM: OMAP5: clock: No Freqsel on OMAP5 devices too
      ARM: OMAP2+: hwmod: Remove unused _HWMOD_WAKEUP_ENABLED flag
      ARM: OMAP: dpll: enable bypass clock only when attempting dpll bypass

Santosh Shilimkar (6):
      ARM: OMAP5: Update SOC id detection code for ES2
      ARM: OMAP5: timer: Update the clocksource name as per clock data
      ARM: OMAP5: prm: Allow prm init to succeed
      ARM: OMAP5: Update SAR RAM base address
      ARM: OMAP5: Update SAR memory layout for WakeupGen
      ARM: OMAP5: Make errata i688 workaround available

Tero Kristo (1):
      ARM: OMAP5: Reuse prm read_inst/write_inst

Tony Lindgren (2):
      Merge tag 'omap-devel-b-for-3.10' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.10/fixes-non-critical
      Merge branch 'for_3.10/omap5_generic_updates' of git://git.kernel.org/.../ssantosh/linux into omap-for-v3.10/fixes-non-critical

Vaibhav Hiremath (2):
      ARM: OMAP2+: AM33xx: hwmod: Add missing sysc definition to wdt1 entry
      ARM: OMAP2+: am335x: Change the wdt1 func clk src to per_32k clk

 arch/arm/mach-omap1/Kconfig                |  6 ------
 arch/arm/mach-omap2/Kconfig                |  2 +-
 arch/arm/mach-omap2/board-2430sdp.c        |  2 +-
 arch/arm/mach-omap2/board-h4.c             |  2 +-
 arch/arm/mach-omap2/cclock33xx_data.c      |  8 ++++++++
 arch/arm/mach-omap2/dpll3xxx.c             | 30 ++++++++++++++----------------
 arch/arm/mach-omap2/dsp.c                  |  4 ++--
 arch/arm/mach-omap2/id.c                   | 12 +++++++++---
 arch/arm/mach-omap2/io.c                   |  9 +++++++++
 arch/arm/mach-omap2/omap4-common.c         | 10 ++++++++--
 arch/arm/mach-omap2/omap4-sar-layout.h     | 14 +++++++-------
 arch/arm/mach-omap2/omap54xx.h             |  1 +
 arch/arm/mach-omap2/omap_hwmod.c           |  4 ----
 arch/arm/mach-omap2/omap_hwmod.h           |  6 ++----
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 15 +++++++++++++++
 arch/arm/mach-omap2/powerdomain.c          | 18 ++++++++----------
 arch/arm/mach-omap2/prm44xx.c              |  6 +++---
 arch/arm/mach-omap2/soc.h                  |  2 ++
 arch/arm/mach-omap2/timer.c                |  5 +++--
 19 files changed, 94 insertions(+), 62 deletions(-)
