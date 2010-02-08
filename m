From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV6 0/4] OMAP3630 Clock Changes
Date: Mon,  8 Feb 2010 19:50:52 +0530
Message-ID: <1265638852-30770-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47007 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab0BHOQV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Feb 2010 09:16:21 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o18EGICH031475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 8 Feb 2010 08:16:20 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

THis patch series has Clock changes related to OMAP3630. The major Clock releated changes are 
1. DPLL4 type has changed to j type. 
2. Frequency Selection (FREQSEL) is no longer required for 3630 
3. CLKSEL field width is increased for DPLL4 M2, M3, M4, M5 and M6 
4. DPLL4 M2 o/p can be either 96MHz or 192 Mhz (to support SGX@192). 

All the patches have been tested on OMAP3630 ZOOM3 and OMAP3430 ZOOM2 platforms.
Comments adressed in V4:
1. Remove sd_div_mask and dco_sel_mask
2. Remove reference to FREQSEL for 3630
3. Avoid dynamically overwriting Fields in Clock nodes

Comments Addressed in V5:
1. Comments from Eduardo Valentin, cosmetic changes and splitting of the patch for freqsel changes
2. Comments from Paul regarding updation of Clock nodes 

Comments Addressed in V6:
1. Cosmetic changes based on Comments from Alex and Paul

Vishwanath BS (4):
  OMAP3: introduce DPLL4 Jtype
  OMAP3: Remove FreqSel for 3630
  OMAP3: Introduce 3630 DPLL4 HSDivider changes
  OMAP3: add support for 192Mhz DPLL4M2 output

 arch/arm/mach-omap2/clock.h             |    4 +
 arch/arm/mach-omap2/clock34xx_data.c    |  240 ++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/clock44xx_data.c    |    1 +
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   12 ++
 arch/arm/mach-omap2/dpll3xxx.c          |   58 +++++++-
 arch/arm/mach-omap2/id.c                |    3 +
 arch/arm/plat-omap/include/plat/clock.h |   10 +-
 arch/arm/plat-omap/include/plat/cpu.h   |    2 +
 8 files changed, 306 insertions(+), 24 deletions(-)

