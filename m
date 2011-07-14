From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/6] OMAP3+ Clock Fixes
Date: Thu, 14 Jul 2011 18:24:17 -0500
Message-ID: <1310685857-3211-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52546 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558Ab1GNXYU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jul 2011 19:24:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

Various clock fixes for OMAP3 and OMAP4 devices.
Plus one debug patch (if anyone is interested).

Jon Hunter (4):
  OMAP4: Add missing clock divider for OCP_ABE_ICLK
  OMAP3+: use DPLLs recalc function instead of omap2_get_dpll_rate
  OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices
  OMAP: Add debugfs node to show the summary of all clocks

Mike Turquette (2):
  OMAP4: Clock: round_rate and recalc functions for DPLL_ABE
  OMAP3+: use DPLL's round_rate when setting rate

 arch/arm/mach-omap2/clkt_dpll.c      |   51 +++++++++++++++++++++++----------
 arch/arm/mach-omap2/clock.h          |    2 +
 arch/arm/mach-omap2/clock44xx.h      |    1 +
 arch/arm/mach-omap2/clock44xx_data.c |   20 +++++++++++--
 arch/arm/mach-omap2/dpll3xxx.c       |    6 ++--
 arch/arm/mach-omap2/dpll44xx.c       |   45 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/clock.c           |   39 ++++++++++++++++++++++++++
 7 files changed, 142 insertions(+), 22 deletions(-)

-- 
1.7.4.1

