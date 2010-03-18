From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH 0/2] OMAP3: Dynamic Calculation of SDRC stall latency during DVFS
Date: Thu, 18 Mar 2010 10:25:46 +0530
Message-ID: <1268888148-10983-1-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45976 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288Ab0CREtO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Mar 2010 00:49:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2I4nAVd017561
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 17 Mar 2010 23:49:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@ti.com>

The patch has the changes to calculate the dpll3 clock stabilization delay 
dynamically. The SRAM delay is calibrated during bootup using the gptimers
and used while calculating the stabilization delay. By using the dynamic 
method the dependency on the type of cache being used is removed.

To calculate the dpll3 M2 clock stabilization delay dynamically and wait
time for L3 M2 clock stabilization are different for 3430 & 3630 and is as
follows:
3430: 4*REFCLK + 8*CLKOUTX2
3630: 2*SYS_CLK + 10*CLKOUTX2
REFCLK & CLKOUTX2 are derived from M, N, M2  and DPLL reference clock.

Incase of 3430 a 2usec and 3630 1usec buffer time is added for safety.

Below is the summery of the comments from the commumnity, those are addressed 
in this version of patch:
1. Change in ASM code to reduce overhead of a instruction
2. Replaced magic numbers with proper macros
3. Code style changes

Teerth Reddy (1):
  OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
Pramod Gurav (2):
  OMAP3630 SDRC: Change in DVFS Latency Formula for OMAP3630

 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   80 ++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/clock34xx.h        |    2 +
 arch/arm/mach-omap2/clock3xxx.c        |    2 +-
 arch/arm/mach-omap2/clock3xxx.h        |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c   |   13 +++++
 arch/arm/mach-omap2/sram34xx.S         |    8 +++
 arch/arm/plat-omap/include/plat/sram.h |    4 ++
 arch/arm/plat-omap/sram.c              |   51 ++++++++++++++++++++
 8 files changed, 150 insertions(+), 11 deletions(-)

