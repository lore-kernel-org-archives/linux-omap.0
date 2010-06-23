From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/13] OMAP: CM, hwmod, omap_device fixes and updates
Date: Wed, 23 Jun 2010 16:42:30 -0700
Message-ID: <1277336563-24988-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:42006 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab0FWXmq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:42:46 -0400
Received: by pxi7 with SMTP id 7so469497pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:42:45 -0700 (PDT)
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
  OMAP: omap_device: add flag to disable automatic bus-level
    suspend/resume
  OMAP: create omap_devices for MPU, DSP, L3
  OMAP: hwmod data: add class for DSP hwmods
  OMAP3: hwmod data: add data for OMAP3 IVA2

Rajendra Nayak (1):
  OMAP4: hwmod: Enable omap_device build for OMAP4

 arch/arm/mach-omap2/cm.c                      |    6 +-
 arch/arm/mach-omap2/devices.c                 |    2 +
 arch/arm/mach-omap2/io.c                      |   55 ++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod.c              |   60 +++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c    |   15 ++++---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c    |   15 ++++---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c    |   51 ++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod_common_data.c  |    3 +
 arch/arm/mach-omap2/omap_hwmod_common_data.h  |    1 +
 arch/arm/plat-omap/Makefile                   |    1 +
 arch/arm/plat-omap/include/plat/common.h      |    4 ++
 arch/arm/plat-omap/include/plat/omap_device.h |    5 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 arch/arm/plat-omap/omap_device.c              |    8 +++-
 14 files changed, 194 insertions(+), 34 deletions(-)

