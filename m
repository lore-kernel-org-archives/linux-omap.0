From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 0/6] misc patches
Date: Mon, 11 Jan 2010 14:12:40 -0600
Message-ID: <1263240766-13000-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33336 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754005Ab0AKUDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 15:03:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishant Menon <nm@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

Ioctl numbers has changed, this will require an update
on libbridge and clients accesing directly to the driver

- IO_ADDRESS is replaced for ioremap.

*v2
- dropped from the series:
	DSPBRIDGE: Increased DMM size to 256MB
	DSPBRIDGE: sysfs entry for global driver state
- will be kept in bridge-pm
	DSPBRIDGE: Use dspbridge to initialize platform data
	DSPBRIDGE: change to cpufreq_register_notifier for OPP changes
	DSPBRIDGE: Fix header locations mach to plat
- previously acked
	DSPBRIDGE: Remove unused hDrvObject in bridge_[open|release]

Omar Ramirez Luna (6):
  DSPBRIDGE: replace IO_ADDRESS with ioremap
  DSPBRIDGE: Replace magic numbers in SSI configuration
  DSPBRIDGE: Mark unused ioctls as deprecated
  DSPBRIDGE: remove ioctl runtime check
  DSPBRIDGE: Rename pResult to result for WCD_CallDevIOCtl
  DSPBRIDGE: Use _IOxx macro to define ioctls

 arch/arm/plat-omap/include/dspbridge/wcdioctl.h |  167 +++++++++--------
 drivers/dsp/bridge/pmgr/wcd.c                   |  228 +++++++++++++----------
 drivers/dsp/bridge/rmgr/drv_interface.c         |    3 -
 drivers/dsp/bridge/services/clk.c               |   23 ++-
 4 files changed, 234 insertions(+), 187 deletions(-)

CC: Nishant Menon <nm@ti.com>
CC: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
CC: Ameya Palande <ameya.palande@nokia.com>
CC: Felipe Contreras <felipe.contreras@gmail.com>
