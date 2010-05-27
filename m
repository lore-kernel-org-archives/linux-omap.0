From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/5] OMAP2/3: misc. hwmod fixes
Date: Thu, 27 May 2010 14:13:31 -0700
Message-ID: <1274994816-30335-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61906 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571Ab0E0VNi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 May 2010 17:13:38 -0400
Received: by mail-pv0-f174.google.com with SMTP id 11so82342pvg.19
        for <linux-omap@vger.kernel.org>; Thu, 27 May 2010 14:13:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series is a set of misc. hwmod fixes needed for functioning
runtime PM on OMAP2 and OMAP3.  These were used to get an
omap_device/hwmod-based runtime PM working an tested on OMAP3430
(omap3evm) and OMAP2 (n810)

All of these have been previously posted in various forms, but here
they are all collected into one place.

This series is also available in the pm-wip/hwmods branch of my git
tree.

This series applies on top of Benoit's two fixup/cleanup series that
Paul has accepted.

Kevin Hilman (5):
  OMAP: hwmod: allow idle after HWMOD_INIT_NO_IDLE
  OMAP: hwmod: if IDLEST fields are not set, use module defaults
  OMAP: hwmod: add option for no locking in idle/enable paths
  OMAP24xx: CM: fix mask used for checking IDLEST status
  OMAP2/3: hwmod: L3 and L4 CORE/PER/WKUP hwmods don't have IDLEST

 arch/arm/mach-omap2/cm.c                     |    6 ++--
 arch/arm/mach-omap2/omap_hwmod.c             |   33 ++++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    9 ++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    9 ++++--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |   12 ++++++---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 6 files changed, 52 insertions(+), 18 deletions(-)

