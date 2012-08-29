From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v4 0/3] Prepare for OMAP2+ movement to Common Clk
Date: Wed, 29 Aug 2012 14:26:13 +0530
Message-ID: <1346230576-20004-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37999 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab2H2I4k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 04:56:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Changes in v4:
* Added *hack* comments around clk_prepare usage in hwmod
rebased on 3.6-rc

Changes in v3:
* Fixed various checkpatch warning/errors as reported by Paul W.

Changes in v2:
* Dropped all driver clk_prepare/clk_unprepare changes, will be
  sent seperately to respective lists

This is a preparatory series for the OMAP Common Clk
conversion. They mostly add clk_prepare/clk_unprepare
in OMAP platform code. Also gets rid of omap_clk_get_by_name
and uses clk_get, and removes all direct 'struct clk'
dereferrencing and uses helpers similar to what is provided
by Common Clk.

Patches are boot tested on OMAP2430sdp, 3630 Beagle-Xm
and 4430/4460 Panda and suspend tested on 3630 Beagle-Xm
and 4430 Panda. Patches apply on 3.6-rc3.

Rajendra Nayak (3):
  ARM: omap: clk: add clk_prepare and clk_unprepare
  ARM: omap: hwmod: get rid of all omap_clk_get_by_name usage
  ARM: OMAP2+: clock: Remove all direct dereferencing of struct clk

 arch/arm/mach-omap2/board-apollon.c          |    4 +-
 arch/arm/mach-omap2/board-h4.c               |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c          |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   10 ++-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |   20 +++---
 arch/arm/mach-omap2/clkt_clksel.c            |   91 ++++++++++++++++----------
 arch/arm/mach-omap2/clkt_dpll.c              |   26 ++++----
 arch/arm/mach-omap2/clock.c                  |   11 ++--
 arch/arm/mach-omap2/clock2420_data.c         |   17 +++++
 arch/arm/mach-omap2/clock2430_data.c         |   21 ++++++
 arch/arm/mach-omap2/clock3xxx.c              |    8 +--
 arch/arm/mach-omap2/clock3xxx_data.c         |   23 +++++++
 arch/arm/mach-omap2/clock44xx_data.c         |    6 ++
 arch/arm/mach-omap2/display.c                |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c               |   48 ++++++++------
 arch/arm/mach-omap2/gpmc.c                   |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   45 ++++++++++---
 arch/arm/mach-omap2/pm.c                     |    2 +-
 arch/arm/plat-omap/clock.c                   |   27 --------
 arch/arm/plat-omap/include/plat/clock.h      |    5 ++
 arch/arm/plat-omap/omap_device.c             |    6 +-
 22 files changed, 251 insertions(+), 135 deletions(-)

-- 
1.7.9.5

