From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] Bridge DVFS cleanups
Date: Wed, 21 Apr 2010 19:17:56 -0500
Message-ID: <1271895479-27744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42735 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab0DVASL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 20:18:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Ramesh Gupta <grgupta@ti.com>

Cleanup Bridge dvfs and Get it functional again.

Some NOTEs for using with bleeding edge kernel branch such as pm-wip-opp:
with linux-omap-pm pm-wip-opp branch, we need to revert commit:
702b94bff3c50542a6e4ab9a4f4cef093262fe65
as a hack to make bridge build with 2.6.34-rc4 kernel, also a io.c
has a conflict with bridge branch esp while doing git merge, but is easy
to fix if you just ensure the dspbridge_reserve_sdram() is called from
omap34xx_map_common_io as a temporary hack untill we do next jump from
.33 to .34 once final version is available.

Sanity Tested on (with few debug pr_errs to confirm transition triggers):
	SDP3430, SDP3630

Deepak Chitriki (1):
  DSPBRIDGE: fix cpufreq_register_notifier usage

Nishanth Menon (2):
  DSPBRIDGE: isolate dependency of mpu freq
  DSPBRIDGE: pm: use pm-wip-opp APIs for opp list

 arch/arm/mach-omap2/dspbridge.c                |  127 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/dspbridge/host_os.h |   14 +++-
 drivers/dsp/bridge/rmgr/drv_interface.c        |   49 +--------
 drivers/dsp/bridge/rmgr/node.c                 |    4 +-
 drivers/dsp/bridge/rmgr/proc.c                 |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c                 |   40 ++++----
 6 files changed, 167 insertions(+), 71 deletions(-)

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Ramesh Gupta <grgupta@ti.com>

Regards,
Nishanth Menon
