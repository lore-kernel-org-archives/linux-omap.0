From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2 0/4] OMAP3: Clock changes for OMAP3630
Date: Fri, 20 Nov 2009 20:58:53 +0530
Message-ID: <1258730937-1962-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39953 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752945AbZKTP17 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 10:27:59 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKFS24H012808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 09:28:04 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, vishwanath.bs@ti.com

This patch set introduces clock changes for OMAP3630. Major changes in OMAP3630 w.r.t clock are 1. Introduction of j type dpll4 2. CLKSEL filed width is increased by 1 bit for DPLL4M3, M4, M5 and M6 3. SGX can be run at 192Mhz

Patch set has been created for linux-omap-pm tree
V1: Initital Patch Series
V2: Fixed Line wrap issue and incorporated comments for adding 192MHz Feature

Richard Woodruff (1):
  OMAP3: introduce DPLL4 Jtype

Vishwanath BS (3):
  OMAP3: Clock Type change for OMAP3 Clocks
  OMAP3: Correct width for CLKSEL Fields
  OMAP3: add support for 192Mhz sgx clock

 arch/arm/mach-omap2/clock.h             |   15 +-
 arch/arm/mach-omap2/clock34xx.c         |  445 ++++++++++++++++++-------------
 arch/arm/mach-omap2/clock34xx.h         |  244 +++++++++++------
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   11 +
 arch/arm/mach-omap2/id.c                |    7 +-
 arch/arm/plat-omap/include/plat/clock.h |    9 +-
 arch/arm/plat-omap/include/plat/cpu.h   |    4 +
 7 files changed, 456 insertions(+), 279 deletions(-)

