From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2 v2] DSPBRIDGE: cleanup OPP handling
Date: Tue,  2 Feb 2010 01:17:24 -0600
Message-ID: <1265095046-25253-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38753 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755417Ab0BBHRd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Feb 2010 02:17:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Revision 2 of the series for DSPBridge OPP handling cleanup

Nishanth Menon (2):
  DSPBRIDGE: remove dependency of mpu freq
  DSPBRIDGE: pm: use old implementation for opps

Note: I have dropped the following patch from this rev of series
as pm-wip-opp is little unknown at the moment.

  DSPBRIDGE: pm: use pm-wip-opp APIs for opp list [RFC]

 arch/arm/mach-omap2/dspbridge.c                |  125 ++++++++++++++++++++++++
 arch/arm/plat-omap/include/dspbridge/host_os.h |   13 +++-
 drivers/dsp/bridge/rmgr/drv_interface.c        |   38 -------
 drivers/dsp/bridge/rmgr/node.c                 |    4 +-
 drivers/dsp/bridge/rmgr/proc.c                 |    4 +-
 drivers/dsp/bridge/wmd/io_sm.c                 |   20 ++---
 6 files changed, 148 insertions(+), 56 deletions(-)

Cc: Ameya Palande <ameya.palande@nokia.com>
Cc: Deepak Chitriki <deepak.chitriki@ti.com>
Cc: Felipe Contreras <felipe.contreras@nokia.com>
Cc: Hiroshi Doyu <hiroshi.doyu@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Regards,
Nishanth Menon
