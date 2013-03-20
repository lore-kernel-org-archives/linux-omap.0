From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [GIT PULL] ARM: OMAP5: Generic updates and es2 fixes for 3.10
Date: Wed, 20 Mar 2013 14:10:22 +0530
Message-ID: <1363768822-18084-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58635 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab3CTIid (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 04:38:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

Here is the pull request for various OMAP5 generic updates which are posted
earlier on the list. It contains OMAP5 es2 related updates like idcode,
RAM base and couple of initialisation fixes.

The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap5_generic_updates

for you to fetch changes up to ecf51648c192377ea2830101b12fc3017bfd2b0c:

  ARM: OMAP5: clock: No Freqsel on OMAP5 devices too (2013-03-19 12:57:03 +0530)

----------------------------------------------------------------
Rajendra Nayak (1):
      ARM: OMAP5: clock: No Freqsel on OMAP5 devices too

Santosh Shilimkar (6):
      ARM: OMAP5: Update SOC id detection code for ES2
      ARM: OMAP5: timer: Update the clocksource name as per clock data
      ARM: OMAP5: prm: Allow prm init to succeed
      ARM: OMAP5: Update SAR RAM base address
      ARM: OMAP5: Update SAR memory layout for WakeupGen
      ARM: OMAP5: Make errata i688 workaround available

Tero Kristo (1):
      ARM: OMAP5: Reuse prm read_inst/write_inst

 arch/arm/mach-omap2/Kconfig            |    2 +-
 arch/arm/mach-omap2/dpll3xxx.c         |   11 +++++------
 arch/arm/mach-omap2/id.c               |   12 +++++++++---
 arch/arm/mach-omap2/io.c               |    9 +++++++++
 arch/arm/mach-omap2/omap4-common.c     |   10 ++++++++--
 arch/arm/mach-omap2/omap4-sar-layout.h |   14 +++++++-------
 arch/arm/mach-omap2/omap54xx.h         |    1 +
 arch/arm/mach-omap2/prm44xx.c          |    6 +++---
 arch/arm/mach-omap2/soc.h              |    2 ++
 arch/arm/mach-omap2/timer.c            |    5 +++--
 10 files changed, 48 insertions(+), 24 deletions(-)
