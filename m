From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/9] OMAP3: PM: introduce support for 3630 OPPs
Date: Wed, 11 Nov 2009 23:45:12 -0600
Message-ID: <1258004721-7315-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46912 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZKLFpi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 00:45:38 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAC5jiVY023143
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 23:45:44 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>


Hi,
This patch series is based on previous discussions:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17632.html

I have modified the initial patch From Sanjeev:
http://patchwork.kernel.org/patch/50998/

Other than these, we cannot use the old VDDx_MAX based usage
anymore as 3630 OPPs are now different and runtime handling
is a must-have, hence introducing these accessor functions is not
avoidable.

The changes are incremental and tries to avoid intrusive change
as much as possible. 3630 testing can only happen once the clock
tree relevant changes are also pushed in.. but most of the relevant
APIs have been exercised on 3430 itself as just the size of the OPP
table varies b/w 3630 and 3430.

The OPP accessor functions introduced in this series is hopefully
a start for us to optimize this heavily used path.

Finally, I have only done limited testing of SR, as it is still in
my TODO list to revamp SR in the form of a v5 patch next time I get
some bandwidth.

An alternate approach for detecting 3630 OPP is using FEATURES
instead of detecting the cpu_type as I have implemented in this series.

Nishanth Menon (9):
  omap3: pm: introduce enabled flag to omap_opp
  omap3: pm: introduce opp accessor functions
  omap3: pm: srf: introduce accessor function
  omap3: pm: use opp accessor functions for omap-target
  omap3: pm: sr: replace get_opp with freq_to_opp
  omap3: clk: use pm accessor functions for cpufreq table
  omap3: pm: remove VDDx_MIN/MAX macros
  omap3: pm: introduce dynamic OPP
  omap3: pm: introduce 3630 opps

 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    2 +
 arch/arm/mach-omap2/board-zoom2.c          |    2 +
 arch/arm/mach-omap2/clock34xx.c            |   46 +++++---
 arch/arm/mach-omap2/omap3-opp.h            |   49 ++------
 arch/arm/mach-omap2/pm.c                   |  160 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h                   |    8 ++
 arch/arm/mach-omap2/pm34xx.c               |  122 +++++++++++++++++++
 arch/arm/mach-omap2/resource34xx.c         |  174 +++++++++++++++++----------
 arch/arm/mach-omap2/smartreflex.c          |   36 ++-----
 arch/arm/plat-omap/cpu-omap.c              |   12 +--
 arch/arm/plat-omap/include/plat/omap-pm.h  |  111 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap34xx.h |    5 -
 15 files changed, 573 insertions(+), 157 deletions(-)

Regards,
Nishanth Menon
