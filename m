From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/3] dspbridge-pm patches
Date: Fri, 15 Jan 2010 20:01:44 -0600
Message-ID: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39276 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932328Ab0APBwB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Jan 2010 20:52:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

This set of patches is required to compile dspbridge branch against
pm branch.

Current set fixes:
- compilation issues due to header migration from mach to plat.
- Bridge DVFS migration to cpufreq_register_notifier.
- Fix initializaton of platform data DVFS functions because of EXPORT_SYMBOL
  removal.

dspbridge-pm is currently based on pm-2.6.32.

Fernando Guzman Lugo (1):
  DSPBRIDGE: change to cpufreq_register_notifier for OPP changes

Omar Ramirez Luna (2):
  DSPBRIDGE: Fix header locations mach to plat
  DSPBRIDGE: Use dspbridge to initialize platform data

 arch/arm/mach-omap2/Makefile                   |    4 ++-
 arch/arm/mach-omap2/dspbridge.c                |    2 +-
 arch/arm/plat-omap/include/dspbridge/host_os.h |    2 +-
 drivers/dsp/bridge/Kconfig                     |    2 +-
 drivers/dsp/bridge/rmgr/drv_interface.c        |   25 ++++++++++++++---------
 drivers/dsp/bridge/wmd/tiomap3430.c            |    2 +-
 6 files changed, 22 insertions(+), 15 deletions(-)

