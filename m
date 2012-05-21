From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 0/4] OMAP4: CPUidle: Add coupled idle support
Date: Mon, 21 May 2012 13:02:35 +0530
Message-ID: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38024 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065Ab2EUHcz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 03:32:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ccross@android.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Kevin,

Now Colin's v3 [1] is apearing in Len Brown's next branch, I have rebased
OMAP4 support against it. I need to pick up couple of fixes [2] posted on
top of v3 [1] version and arm-soc 'omap/cpuidle-cleanup' branch lined up
for 3.5.

This series adds the coupled cpuidle support for OMAP4 and also removes
the hard dependency of off-lining CPU1 to trigger deeper CPU C-states.
It has been build tested for all OMAP builds and functionally tested
on OMAP4430 SDP.

I have put together a branch with:
1) Len Brown's 'next'
	: git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux 
2) ARM-SOC 'omap/cpuidle-cleanup'
	: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
3) Two couple_idle_fixes picked up from [2]

And same is available:

git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
for_3.5/omap4_couple_idle

Kevin Hilman (1):
  ARM: OMAP4: CPUidle: add synchronization for coupled idle states

Santosh Shilimkar (3):
  ARM: OMAP: timer: allow gp timer clock-event to be used on both cpus
  ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP
    cpuidle.
  ARM: OMAP4: CPUidle: Open broadcast clock-event device.

 arch/arm/mach-omap2/Kconfig       |    1 +
 arch/arm/mach-omap2/cpuidle44xx.c |  141 +++++++++++++++++++++++++------------
 arch/arm/mach-omap2/timer.c       |    4 +-
 3 files changed, 101 insertions(+), 45 deletions(-)

Regards
Santosh

[1] [PATCHv3 0/4] coupled cpuidle state support
 https://lkml.org/lkml/2012/5/19/24

[2] [PATCH 0/2] bug fixes for coupled cpuidle
 https://lkml.org/lkml/2012/5/18/379

-- 
1.7.5.4

