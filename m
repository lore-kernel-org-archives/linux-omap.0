From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/9] Minor powerdomain/clockdomain/SDRC patches for 2.6.33
Date: Thu, 03 Dec 2009 06:45:30 -0700
Message-ID: <20091203134321.16229.87539.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48949 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbZLCNwW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Dec 2009 08:52:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

This series contains some powerdomain, clockdomain, and SDRC patches
intended for 2.6.33.  There's not much of great importance here;
perhaps the most notable patch is "OMAP3: SDRC: Place SDRC AC timing
and MR changes in CORE DVFS SRAM code behind Kconfig", which can reduce
lockups on systems with many active initiators during CORE DVFS, but has
the downside of reducing SDRAM performance.


- Paul

---

Paul Walmsley (7):
      OMAP2/3 PRCM: don't export prm_*(), cm_*() functions
      OMAP clockdomain/powerdomain: remove CONFIG_OMAP_DEBUG_{CLOCK,POWER}DOMAIN
      OMAP clockdomain/powerdomain: optimize out sleepdep code on OMAP24xx
      OMAP powerdomain/PM: use symbolic constants for the max number of power states
      OMAP powerdomain: rearrange struct powerdomain to save some memory
      OMAP3: SDRC: Place SDRC AC timing and MR changes in CORE DVFS SRAM code behind Kconfig
      OMAP clock/hwmod: fix off-by-one errors

Roel Kluin (1):
      OMAP2/3 powerdomain: return errors rather than returning the output of IS_ERR()

Thara Gopinath (1):
      OMAP3: PM: Fix for MPU power domain MEM BANK position


 arch/arm/mach-omap2/Kconfig                   |   13 +++++
 arch/arm/mach-omap2/clockdomain.c             |    6 +-
 arch/arm/mach-omap2/cm.c                      |    7 ++-
 arch/arm/mach-omap2/omap_hwmod.c              |   13 ++---
 arch/arm/mach-omap2/pm-debug.c                |    4 +-
 arch/arm/mach-omap2/powerdomain.c             |   36 ++++++++-------
 arch/arm/mach-omap2/powerdomains34xx.h        |    1 
 arch/arm/mach-omap2/prcm.c                    |   11 +---
 arch/arm/mach-omap2/sram34xx.S                |   19 +++++++-
 arch/arm/plat-omap/Kconfig                    |   62 ++++++++-----------------
 arch/arm/plat-omap/include/plat/common.h      |   20 ++++++++
 arch/arm/plat-omap/include/plat/powerdomain.h |   17 ++++---
 12 files changed, 117 insertions(+), 92 deletions(-)


