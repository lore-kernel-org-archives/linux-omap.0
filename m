From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH 0/2] OMAP3: Dynamic Calculation of SDRC stall latency during DVFS
Date: Thu, 11 Mar 2010 17:04:55 +0530
Message-ID: <1268307297-23330-1-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33526 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab0CKL2o (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Mar 2010 06:28:44 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2BBSfHM005821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 11 Mar 2010 05:28:43 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@ti.com>

The patch has the changes to calculate the dpll3 clock stabilization
delay dynamically. The SRAM delay is calibrated during bootup using the
gptimers and used while calculating the stabilization delay. By using
the dynamic method the dependency on the type of cache being used is
removed.

Formula to calculate the DVFS latency for 3430 and 3630 are different.
The second patch implements the formula for later.

Below is the summery of the comments from the commumnity, 
those are addressed by these patches:

1. Subject of the patch mentioned as OMAP3: SDRC: instead of OMAP3: PM.
2. The first available dmtimer is requested dynamically instead of statically 
   requesting a dmtimer. Thus hardcoding is avoided.
3. Excluded use of direct physical address of dmtimer. Instead used dmtimer APIs.
3. Only the counter loop is run in ASM.
4. Restructuring of formula for DVFS latency for 3430.
5. Adding new implementation for DVFS latency for 3630.

Teerth Reddy (1):
  OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
Pramod Gurav (2):
  OMAP3630: SDRC: Change in DVFS Latency Formula for OMAP3630

 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   83 ++++++++++++++++++++++++++++----
 arch/arm/mach-omap2/clock34xx.h        |    2 +
 arch/arm/mach-omap2/clock3xxx_data.c   |   12 +++++
 arch/arm/mach-omap2/sram34xx.S         |   11 ++++
 arch/arm/plat-omap/include/plat/sram.h |    4 ++
 arch/arm/plat-omap/sram.c              |   49 +++++++++++++++++++
 6 files changed, 151 insertions(+), 10 deletions(-)

