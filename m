From: Pramod Gurav <pramod.gurav@ti.com>
Subject: [PATCH V4 0/2] OMAP3: Dynamic Calculation of SDRC stall latency during DVFS
Date: Fri,  2 Apr 2010 01:16:54 +0800
Message-ID: <1270142216-18118-1-git-send-email-pramod.gurav@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55329 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755426Ab0DALjf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Apr 2010 07:39:35 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o31BdWWJ005372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 1 Apr 2010 06:39:34 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Pramod Gurav <pramod.gurav@ti.com>

From: Pramod Gurav <pramod.gurav@ti.com> 

The patch has the changes to calculate the dpll3 clock stabilization
delay dynamically. The SRAM delay is calibrated during bootup using the
gptimers and used while calculating the stabilization delay. By using
the dynamic method the dependency on the type of cache being used is
removed.

Formula to calculate the DVFS latency for 3430 and 3630 are different.
The second patch implements the formula for later.

This Version of patches adds optimisation to the formula implementation.

Teerth Reddy (1):
  OMAP3: SDRC: Dynamic Calculation of SDRC stall latency during DVFS
Pramod Gurav (1):
  OMAP3630 SDRC: Change in DVFS Latency Formula for OMAP3630

 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |   71 +++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/clock34xx.h        |    2 +
 arch/arm/mach-omap2/clock3xxx.c        |    2 +-
 arch/arm/mach-omap2/clock3xxx.h        |    1 +
 arch/arm/mach-omap2/clock3xxx_data.c   |   13 ++++++
 arch/arm/mach-omap2/sram34xx.S         |    8 ++++
 arch/arm/plat-omap/include/plat/sram.h |    4 ++
 arch/arm/plat-omap/sram.c              |   51 +++++++++++++++++++++++
 8 files changed, 140 insertions(+), 12 deletions(-)

