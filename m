From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: [PATCH 0/4] OMAP3: Clock changes for OMAP3630
Date: Wed, 18 Nov 2009 19:43:56 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA7510C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60309 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbZKRONy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 09:13:54 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAIEDw52021634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 08:14:00 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAIEDvJJ001220
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 19:43:57 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

This patch set introduces clock changes for OMAP3630. Major changes in OMAP3630 w.r.t clock are
1. Introduction of j type dpll4
2. CLKSEL filed width is increased by 1 bit for DPLL4M3, M4, M5 and M6
3. SGX can be run at 192Mhz

Patch set has been created for linux-omap-pm tree

Richard Woodruff (1):
  OMAP3:clk - introduce DPLL4 jtype support

Vishwanath BS (3):
  OMAP3:clk - Clock Type change for OMAP3 Clocks
  OMAP3:clk - correct width for CLKSEL Fields
  OMAP3:clk - add support for 192Mhz sgx clock

 arch/arm/mach-omap2/clock.h             |   12 +-
 arch/arm/mach-omap2/clock34xx.c         |  438 ++++++++++++++++++-------------
 arch/arm/mach-omap2/clock34xx.h         |  244 +++++++++++------
 arch/arm/mach-omap2/cm-regbits-34xx.h   |   11 +
 arch/arm/mach-omap2/id.c                |    4 +-
 arch/arm/plat-omap/include/plat/clock.h |    9 +-
 arch/arm/plat-omap/include/plat/cpu.h   |    3 +-
 7 files changed, 441 insertions(+), 280 deletions(-)

