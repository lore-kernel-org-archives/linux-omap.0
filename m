From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 0/4] OMAP3: PM: Smartreflex clean up patches against PM tree
Date: Sat, 29 May 2010 22:16:50 +0530
Message-ID: <1275151614-16634-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41728 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0E2QrD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 12:47:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch series does clean up of Kevin Hilman's PM tree
so that the earlier Smartreflex series against lo-master can
be applied seamlessly. This patch sereis also does some
smartreflex related code changes in the cpuidle and dvfs
code which exists only in the pm tree and not on lo-master.

This patch series has been tested in conjunction with the
the Smartreflex series posted against the lo-master on
OMAP3430 SDP, OMAP3630SDP and ZOOM3 using omap3_pm_defconfig.

Thara Gopinath (4):
  OMAP3: PM: Cleaning up of smartreflex code.
  OMAP3: PM: Disabling Smartreflex across both frequency and voltage
    scaling during DVFS.
  OMAP3: PM: Removing voltage related code from the generic pm code.
  OMAP3: PM: Enabling Smartreflex Class 3 driver by default in pm
    defconfig

 arch/arm/configs/omap3_pm_defconfig       |    1 +
 arch/arm/mach-omap2/Makefile              |    1 -
 arch/arm/mach-omap2/board-3430sdp.c       |    5 +-
 arch/arm/mach-omap2/pm.h                  |   25 -
 arch/arm/mach-omap2/pm34xx.c              |   94 +---
 arch/arm/mach-omap2/prm-regbits-34xx.h    |    8 +-
 arch/arm/mach-omap2/resource34xx.c        |   29 +-
 arch/arm/mach-omap2/resource34xx.h        |    1 -
 arch/arm/mach-omap2/smartreflex.c         | 1043 -----------------------------
 arch/arm/mach-omap2/smartreflex.h         |  256 -------
 arch/arm/plat-omap/Kconfig                |   31 -
 arch/arm/plat-omap/include/plat/control.h |    9 -
 12 files changed, 25 insertions(+), 1478 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/smartreflex.c
 delete mode 100644 arch/arm/mach-omap2/smartreflex.h

