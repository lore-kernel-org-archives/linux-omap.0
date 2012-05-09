From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/6] ARM: OMAP4: Add PMU Support
Date: Wed, 9 May 2012 16:33:36 -0500
Message-ID: <1336599216-10826-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57308 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093Ab2EIVds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 17:33:48 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q49LXmN2008989
	for <linux-omap@vger.kernel.org>; Wed, 9 May 2012 16:33:48 -0500
Received: from DLEE74.ent.ti.com (dlee74.ent.ti.com [157.170.170.8])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q49LXmIv012515
	for <linux-omap@vger.kernel.org>; Wed, 9 May 2012 16:33:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

This series adds PMU support for OMAP4 devices. This is based upon Will Deacons
series [1]. This series attempts to fix the management of the EMU power domain
so that PMU can be enabled at runtime and low-power states are not prevented
when PMU is not in-use. The fix is based upon inputs from Benoit, Paul and
Kevin [2].

This series is based upon the latest linux-omap master branch from Tony and has
been tested on a OMAP4460 panda.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git perf/omap4
[2] http://marc.info/?l=oprofile-list&m=133657425417229&w=3

Jon Hunter (4):
  Re-map the CTIs IRQs from MPU to DEBUGSS
  ARM: OMAP4: PMU: Add runtime PM support
  ARM: OMAP4: CLKDM: Update supported transition modes
  ARM: OMAP4: Prevent EMU power domain transitioning to OFF when in-use

Ming Lei (2):
  arm: omap4: create pmu device via hwmod
  arm: omap4: support pmu

 arch/arm/mach-omap2/clockdomain44xx.c       |    7 +-
 arch/arm/mach-omap2/clockdomains44xx_data.c |    2 +-
 arch/arm/mach-omap2/cminst44xx.c            |   14 ---
 arch/arm/mach-omap2/devices.c               |  123 ++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    9 ++-
 arch/arm/plat-omap/include/plat/omap44xx.h  |    3 +
 6 files changed, 135 insertions(+), 23 deletions(-)

-- 
1.7.5.4

