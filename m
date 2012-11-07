From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 0/3] ARM: OMAP4: Clock fixes
Date: Wed, 7 Nov 2012 12:42:59 -0600
Message-ID: <1352313782-21602-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34767 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754235Ab2KGSnJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 13:43:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Fixes included, fixing up timer clock aliases for v3.8 and working
around ABE DPLL issue seen with latest u-boot bootloader (v2012.10).

Testing includes:
- Boot testing on OMAP3430 Beagle, OMAP4430 Panda and OMAP4460 Panda
- Boot tested with device-tree on OMAP4430 Panda and OMAP4460 Panda
  and validated that all timers are working.
- Suspend testing on OMAP3430 Beagle and OMAP4430 Panda (suspend not
  functional on OMAP4460 Panda prior to this series and so could not
  be tested).
- Core retention validated on OMAP3430 Beagle.

Jon Hunter (3):
  ARM: OMAP4: Update timer clock aliases
  ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
  ARM: OMAP4460: Workaround ABE DPLL failing to turn-on

 arch/arm/mach-omap2/clock44xx_data.c    |   32 ++++++++++++++--
 arch/arm/mach-omap2/dpll3xxx.c          |   46 +++++++++++++++-------
 arch/arm/mach-omap2/dpll44xx.c          |   63 ++++++++++++++++++++++++++-----
 arch/arm/plat-omap/include/plat/clock.h |   10 +++++
 4 files changed, 124 insertions(+), 27 deletions(-)

-- 
1.7.9.5

