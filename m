From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/7] DSPBRIDGE: latest set of patches
Date: Wed, 17 Jun 2009 12:36:05 -0500
Message-ID: <1245260172-23008-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58456 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757509AbZFQRbf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2009 13:31:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

These are the latest set of patches for d.o-z dspbridge.

Fernando Guzman Lugo (2):
  DSPBRIDGE: Allow separate load/run addresses for Dynamic Loader
  DSPBRIDGE: Reset MMU and DSP on board stop

Hari Kanigeri (3):
  DSPBRIDGE: Handle properly user space pointers
  DSPBRIDGE: Increased DMM size to 256MB
  DSPBRIDGE: Keep DMM resources for other nodes on PROC_Detach

Omar Ramirez Luna (2):
  DSPBRIDGE: Removing UTIL module
  DSPBRIDGE: Shared memory size increased to 5MB

 arch/arm/plat-omap/include/dspbridge/dmm.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/util.h |  122 ----------------------
 drivers/dsp/bridge/pmgr/cmm.c               |    2 +-
 drivers/dsp/bridge/pmgr/dbll.c              |   17 +++-
 drivers/dsp/bridge/pmgr/dev.c               |    1 -
 drivers/dsp/bridge/pmgr/dmm.c               |    8 +-
 drivers/dsp/bridge/pmgr/wcd.c               |  148 ++++++++++++++++++++-------
 drivers/dsp/bridge/rmgr/drv_interface.c     |    2 +-
 drivers/dsp/bridge/rmgr/proc.c              |    4 +-
 drivers/dsp/bridge/services/clk.c           |    2 -
 drivers/dsp/bridge/services/services.c      |   15 +--
 drivers/dsp/bridge/wmd/tiomap3430.c         |    6 +-
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c     |    1 -
 drivers/dsp/bridge/wmd/tiomap_io.c          |    1 -
 14 files changed, 138 insertions(+), 193 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/dspbridge/util.h

