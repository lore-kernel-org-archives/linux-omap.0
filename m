From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [GIT PULL] ARM: OMAP2+: Generic cleanups for 3.10
Date: Wed, 20 Mar 2013 14:09:49 +0530
Message-ID: <1363768789-17929-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53450 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab3CTIiB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Mar 2013 04:38:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Tony,

Here is the pull request for various OMAP cleanups and fixes which are posted
earlier on the list. It contains OMAP4 smp cleanup, removal of unwanted static
deps from OMAP4, RAM offset consolidation and fiq tuple cleanup. 


The following changes since commit a937536b868b8369b98967929045f1df54234323:

  Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux.git for_3.10/omap_generic_cleanup

for you to fetch changes up to 37e1f64c3bc2b3455a9688de8527a341847b3ad9:

  ARM: OMAP4: Fix the init code to have OMAP4460 errata available in DT build (2013-03-19 12:57:30 +0530)

----------------------------------------------------------------
Santosh Shilimkar (8):
      ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable] tuple
      ARM: OMAP4+: Remove the un-necessary cache flush from hotplug code
      ARM: OMAP4+: Remove un-necessary cacheflush in secondary CPU boot path
      ARM: OMAP4+: Remove out of placed smp_wmb() in secondary wakeup code
      ARM: OMAP4+: Move the CPU wakeup prepare code under smp_prepare_cpus()
      ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU since errata fix exist now
      ARM: OMAP4: PM: Now remove L4 per clockdomain static depedency with MPU
      ARM: OMAP4: Fix the init code to have OMAP4460 errata available in DT build

Tero Kristo (1):
      ARM: OMAP4+: Use common scratchpad SAR RAM offsets for all architectures

 arch/arm/mach-omap2/cpuidle34xx.c      |    3 --
 arch/arm/mach-omap2/cpuidle44xx.c      |    7 ----
 arch/arm/mach-omap2/omap-hotplug.c     |    6 ----
 arch/arm/mach-omap2/omap-smp.c         |   57 +++++++++++---------------------
 arch/arm/mach-omap2/omap4-common.c     |   16 +++++++++
 arch/arm/mach-omap2/omap4-sar-layout.h |   14 ++++----
 arch/arm/mach-omap2/pm24xx.c           |   11 ++----
 arch/arm/mach-omap2/pm34xx.c           |    9 +----
 arch/arm/mach-omap2/pm44xx.c           |   20 +++--------
 9 files changed, 51 insertions(+), 92 deletions(-)
