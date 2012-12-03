From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 0/4] ARM: OMAP4: Clock fixes
Date: Mon, 3 Dec 2012 14:41:11 -0600
Message-ID: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50254 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab2LCUlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Dec 2012 15:41:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Fixes included, fixing up timer clock aliases for v3.8 and working
around ABE DPLL issue seen with latest u-boot bootloader (v2012.10).

Testing includes:
- Boot testing on OMAP4460 Panda and verifying that all dmtimers are
  working.

V2 changes:
- Updated series to latest ARM-SoC for-next branch that includes common
  clock updates for OMAP4.
- Added new function table for non-M4X DPLLs which is now required after
  enhancing support for OMAP4 DPLLs for 4X multiplier.

Jon Hunter (4):
  ARM: OMAP4: Update timer clock aliases
  ARM: OMAP4: Add function table for non-M4X dplls
  ARM: OMAP4: Enhance support for DPLLs with 4X multiplier
  ARM: OMAP4460: Workaround ABE DPLL failing to turn-on

 arch/arm/mach-omap2/cclock44xx_data.c |   49 ++++++++++++++++++++-----
 arch/arm/mach-omap2/clock.h           |   10 ++++++
 arch/arm/mach-omap2/dpll3xxx.c        |   46 ++++++++++++++++--------
 arch/arm/mach-omap2/dpll44xx.c        |   64 ++++++++++++++++++++++++++++-----
 4 files changed, 138 insertions(+), 31 deletions(-)

-- 
1.7.9.5

