From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/9] ARM: OMAP: Static deps, fiq, omap-smp cleanup
Date: Wed, 20 Feb 2013 20:48:38 +0530
Message-ID: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46953 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933505Ab3BTPRh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Feb 2013 10:17:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This series tries to clean-up the some of the areas like OMAP4 static
deps, FIQ usage in OMAP code, SMP code. The patches are self explanatory 
and quite independent but since I had them mantained in a branch, am
sending them together not to loose track of them.

They have been tested on OMAP4 and OMAP3 devices for boot, suspend and
CPUIDLE. OMAP1 patch isn't tested but I don't expect it to cause any
breakage since it is just cleaning up the bogus fiq use.

Santosh Shilimkar (8):
  ARM: OMAP1: PM: Remove bogus fiq_[enable/disable] tuple
  ARM: OMAP2+: PM: Remove bogus fiq_[enable/disable] tuple
  ARM: OMAP4+: Remove the un-necessary cache flush from hotplug code
  ARM: OMAP4+: Remove un-necessary cacheflush in secondary CPU boot
    path
  ARM: OMAP4+: Remove out of placed smp_wmb() in secondary wakeup code
  ARM: OMAP4+: Move the CPU wakeup prepare code under
    smp_prepare_cpus()
  ARM: OMAP4: PM: Remove L4 wakeup depedency with MPU since errata fix
    exist now
  ARM: OMAP4: PM: Now remove L4 per clockdomain static depedency with
    MPU

Tero Kristo (1):
  ARM: OMAP4+: Use common scratchpad SAR RAM offsets for all
    architectures

 arch/arm/mach-omap1/pm.c               |    6 ----
 arch/arm/mach-omap2/cpuidle34xx.c      |    4 ---
 arch/arm/mach-omap2/cpuidle44xx.c      |    7 ----
 arch/arm/mach-omap2/omap-hotplug.c     |    6 ----
 arch/arm/mach-omap2/omap-smp.c         |   57 +++++++++++---------------------
 arch/arm/mach-omap2/omap4-sar-layout.h |   14 ++++----
 arch/arm/mach-omap2/pm24xx.c           |   11 ++----
 arch/arm/mach-omap2/pm34xx.c           |    9 +----
 arch/arm/mach-omap2/pm44xx.c           |   20 +++--------
 9 files changed, 35 insertions(+), 99 deletions(-)

-- 
1.7.9.5

