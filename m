From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV4 0/4] OMAP3630 Clock changes
Date: Thu,  7 Jan 2010 13:06:37 +0530
Message-ID: <1262849801-9955-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41060 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756169Ab0AGHd5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 02:33:57 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o077Xrfc010534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 7 Jan 2010 01:33:56 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

THis patch series has Clock changes related to OMAP3630. The major Clock releated changes are 
1. DPLL4 type has changed to j type. 
2. Frequency Selection (FREQSEL) is no longer required for 3630 
3. CLKSEL field width is increased for DPLL4 M2, M3, M4, M5 and M6 
4. DPLL4 M2 o/p can be either 96MHz or 192 Mhz (to support SGX@192). 

This patch series has dependency on Clock framework reorganization available at
http://patchwork.kernel.org/patch/67343
http://patchwork.kernel.org/patch/67344

All the patches have been tested on OMAP3630 ZOOM3 and OMAP3430 ZOOM2 platforms.
Comments adressed in V4:
1. Remove sd_div_mask and dco_sel_mask
2. Remove reference to FREQSEL for 3630
3. Avoid dynamically overwriting Fields in Clock nodes

Vishwanath BS (4):
  introduce DPLL4 Jtype
  Remove FreqSel for 3630
  Introduce 3630 DPLL4 HSDivider changes
  add support for 192Mhz DPLL4M2 output

 arch/arm/mach-omap2/clock.h             |    4 +
 arch/arm/mach-omap2/clock34xx_data.c    |  221 +++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/clock44xx_data.c    |    1 +
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   12 ++
 arch/arm/mach-omap2/dpll.c              |   55 +++++++-
 arch/arm/mach-omap2/id.c                |    3 +
 arch/arm/plat-omap/include/plat/clock.h |    3 +
 arch/arm/plat-omap/include/plat/cpu.h   |    2 +
 8 files changed, 285 insertions(+), 16 deletions(-)


