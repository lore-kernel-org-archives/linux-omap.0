From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/7] ARM: OMAP2+: Misc cleanup
Date: Wed, 2 May 2012 15:18:06 +0530
Message-ID: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42379 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab2EBJs0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 May 2012 05:48:26 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This series has some miscellianeous clean up patches which help to add future
OMAP2+ device support with bit less changes. It is a preparatory series for
adding minimal OMAP5 support.

Boot tested on below platforms:
- OMAP2430 SDP
- OMAP3430 SDP
- OMAP4430 SDP

Thanks for Tony and Benoit for these suggestions.

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:
  git://gitorious.org/omap-sw-develoment/linux-omap-dev.git for_3.5/omap_misc_cleanup

R Sricharan (1):
  ARM: OMAP4+: Add prm and cm base init function.

Santosh Shilimkar (6):
  ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4 only builds.
  ARM: OMAP2+: Clean up wrapping multiple objects in Makefile
  ARM: OMAP4: Remove un-used WakeupGen register defines.
  ARM: OMAP: dma: Make use of cpu_class_is_omap2() to avoid future
    patching.
  ARM: All OMAP2PLUS machines use omap2 directory so just add one entry
  ARM: OMAP4: Reduce the static IO mapping

 arch/arm/Makefile                                 |    4 +-
 arch/arm/mach-omap2/Makefile                      |  163 ++++++++++-----------
 arch/arm/mach-omap2/cminst44xx.c                  |   28 +++--
 arch/arm/mach-omap2/common.c                      |    1 +
 arch/arm/mach-omap2/common.h                      |    1 +
 arch/arm/mach-omap2/dma.c                         |    2 +-
 arch/arm/mach-omap2/include/mach/omap-wakeupgen.h |    8 -
 arch/arm/mach-omap2/io.c                          |   30 ----
 arch/arm/mach-omap2/iomap.h                       |   28 ----
 arch/arm/mach-omap2/prcm-common.h                 |   13 ++
 arch/arm/mach-omap2/prcm.c                        |    8 +
 arch/arm/mach-omap2/prminst44xx.c                 |   27 ++--
 arch/arm/plat-omap/dma.c                          |    4 +-
 13 files changed, 139 insertions(+), 178 deletions(-)

-- 
1.7.5.4

