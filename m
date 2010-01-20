From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] DSPBRIDGE: cleanup OPP handling
Date: Wed, 20 Jan 2010 16:19:10 -0600
Message-ID: <1264025953-4620-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54964 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab0ATWTR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 17:19:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Ameya Palande <ameya.palande@nokia.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Applies on DSPbridge branch:
this is a two patch series of which patch 2/2 is provided as two options:
a) using legacy implementation
b) cleaner one using pm-wip-opp APIs.

only (b) has been tested on a 3630 platform.

Nishanth Menon (2):
  DSPBRIDGE: remove dependency of mpu freq
  DSPBRIDGE: pm: use old implementation for opps
	OR
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
