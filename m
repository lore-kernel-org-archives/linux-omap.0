From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/8] misc patches
Date: Thu,  7 Jan 2010 19:00:21 -0600
Message-ID: <1262912421-29946-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41950 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab0AHAvO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 19:51:14 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Next set of patches to be applied on top of sync point.

Highlights:

*** Ioctl numbers has changed, this will require an update
    on libbridge and clients accesing directly to the driver ***

- IO_ADDRESS is replaced for ioremap.
- DMM table is increased to hold up to 256 MB (in pages).

Fernando Guzman Lugo (1):
  DSPBRIDGE: change to cpufreq_register_notifier for OPP changes

Hari Kanigeri (1):
  DSPBRIDGE: Increased DMM size to 256MB

Omar Ramirez Luna (6):
  DSPBRIDGE: Cleanup SSI handling - remove IO_ADDRESS
  DSPBRIDGE: sysfs entry for global driver state
  DSPBRIDGE: Remove unused hDrvObject in bridge_[open|release]
  DSPBRIDGE: Use dspbridge to initialize platform data
  DSPBRIDGE: Fix header locations mach to plat
  DSPBRIDGE: Use _IOxx macro to define ioctls

 arch/arm/mach-omap2/Makefile                    |    4 +-
 arch/arm/mach-omap2/dspbridge.c                 |    2 +-
 arch/arm/plat-omap/include/dspbridge/dmm.h      |    2 +-
 arch/arm/plat-omap/include/dspbridge/drv.h      |    7 +
 arch/arm/plat-omap/include/dspbridge/host_os.h  |    2 +-
 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |  144 ++++++++++-------------
 drivers/dsp/bridge/Kconfig                      |    2 +-
 drivers/dsp/bridge/pmgr/dmm.c                   |    8 +-
 drivers/dsp/bridge/pmgr/wcd.c                   |  128 ++++++++++----------
 drivers/dsp/bridge/rmgr/drv_interface.c         |  137 +++++++++++++++++-----
 drivers/dsp/bridge/services/clk.c               |   30 +++---
 drivers/dsp/bridge/wmd/tiomap3430.c             |    2 +-
 12 files changed, 271 insertions(+), 197 deletions(-)

