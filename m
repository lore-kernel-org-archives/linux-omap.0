From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 00/13] OMAP: CM, hwmod, omap_device fixes and updates
Date: Thu, 24 Jun 2010 16:44:31 -0700
Message-ID: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57989 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab0FXXoq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Jun 2010 19:44:46 -0400
Received: by pwj8 with SMTP id 8so2080998pwj.19
        for <linux-omap@vger.kernel.org>; Thu, 24 Jun 2010 16:44:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

This is a series of fixes & updates mostly to hwmod and omap_device
that are required for the on-going hwmod conversions and runtime PM
conversion of drivers.

While some of these are fixes, they are not urgent for 2.6.35 and can
wait until the next merge window.

This series applies on top of the runtime PM series just posted and is
also available as the pm-wip/hwmods branch of my linux-omap-pm git
tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

This has been tested with various hwmod & runtime PM conversions
(UART, MMC, dmtimer) on OMAP2, OMAP3 and OMAP4.

Kevin

Benoit Cousson (2):
  OMAP: hwmod: Fix the missing braces
  OMAP2&3: hwmod: Remove _hwmod prefix in name string

Kevin Hilman (10):
  OMAP24xx: CM: fix mask used for checking IDLEST status
  OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
  OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't have IDLEST
  OMAP: hwmod: add non-locking versions of enable and idle functions
  OMAP: hwmod: don't auto-disable hwmod when !CONFIG_PM_RUNTIME
  OMAP: omap_device: ensure hwmod tracks attached omap_device pointer
  OMAP: create omap_devices for MPU, DSP, L3
  OMAP: hwmod data: add class for IVA hwmods
  OMAP2&3: hwmod: Replace l3 -> l3_main
  OMAP3: hwmod data: add data for OMAP3 IVA2

Rajendra Nayak (1):
  OMAP4: hwmod: Enable omap_device build for OMAP4

 arch/arm/mach-omap2/cm.c                     |    6 +-
 arch/arm/mach-omap2/devices.c                |    2 +
 arch/arm/mach-omap2/io.c                     |   58 ++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod.c             |   47 ++++++++++----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |   49 +++++++-------
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |   49 +++++++-------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   92 ++++++++++++++++++--------
 arch/arm/mach-omap2/omap_hwmod_common_data.c |    3 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h |    1 +
 arch/arm/plat-omap/Makefile                  |    1 +
 arch/arm/plat-omap/include/plat/common.h     |    4 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 arch/arm/plat-omap/omap_device.c             |    8 ++-
 13 files changed, 228 insertions(+), 94 deletions(-)

