From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/4] runtime PM support at the bus level
Date: Thu, 27 May 2010 14:13:15 -0700
Message-ID: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f176.google.com ([209.85.222.176]:64008 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab0E0VNV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:21 -0400
Received: by pzk6 with SMTP id 6so314656pzk.1
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:20 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series introduces runtime PM support at the platform bus level
for OMAP.

In a nutshell, when using the runtime PM API for any device with an
assocated omap_device (and hwmod), the omap device API will be used to
handle the hardware-level power management of that device, including
managing clocks, etc.

Today, most drivers handle this by manually enabling/disabling their
clocks when needed.  With this series (and an omap_device/hwmod for
each device) direct clock managment can be removed from the driver in
favor of using the runtime PM API.

NOTE: the 1st patch is FYI only, it has already been merged into
      mainline for 2.6.35 via the driver core.

This applies on v2.6.34 and has been tested along with Benoit's two
hwmod fixes/cleanup series and the work-in-progress UART and MMC hwmod
conversions and has been tested on OMAP3430 (omap3evm) and OMAP2
(n810).

This series is also available in my git tree as the 'pm-wip/runtime'
branch.

Kevin Hilman (4):
  platform_bus: allow custom extensions to system PM methods
  OMAP: PM: initial runtime PM core support
  OMAP: PM: use omap_device API for suspend/resume
  OMAP: omap_device: add flag to disable automatic bus-level
    suspend/resume

 arch/arm/mach-omap2/Makefile                  |    7 +-
 arch/arm/mach-omap2/pm_bus.c                  |  133 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    5 +
 drivers/base/platform.c                       |    8 +-
 4 files changed, 148 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm_bus.c

