From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v3 0/3] Prepare for OMAP2+ movement to Common Clk
Date: Mon, 2 Jul 2012 15:54:26 +0530
Message-ID: <1341224669-15231-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60311 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932938Ab2GBKYy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 06:24:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

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
and 4430 Panda. Patches apply on 3.5-rc5.

Rajendra Nayak (3):
  ARM: omap: clk: add clk_prepare and clk_unprepare
  ARM: omap: hwmod: get rid of all omap_clk_get_by_name usage
  ARM: omap: clk: Remove all direct dereferencing of struct clk

 arch/arm/mach-omap2/board-apollon.c          |    4 +-
 arch/arm/mach-omap2/board-h4.c               |    6 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/clkt2xxx_apll.c          |    2 +-
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    4 +-
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c       |   20 +++---
 arch/arm/mach-omap2/clkt_clksel.c            |   89 ++++++++++++++++---------
 arch/arm/mach-omap2/clkt_dpll.c              |   26 ++++---
 arch/arm/mach-omap2/clock.c                  |   11 ++-
 arch/arm/mach-omap2/clock2420_data.c         |   17 +++++
 arch/arm/mach-omap2/clock2430_data.c         |   21 ++++++
 arch/arm/mach-omap2/clock3xxx.c              |    8 +-
 arch/arm/mach-omap2/clock3xxx_data.c         |   24 +++++++
 arch/arm/mach-omap2/clock44xx_data.c         |   17 +++++
 arch/arm/mach-omap2/display.c                |    4 +-
 arch/arm/mach-omap2/dpll3xxx.c               |   45 ++++++++------
 arch/arm/mach-omap2/gpmc.c                   |    2 +-
 arch/arm/mach-omap2/omap_hwmod.c             |   21 ++++---
 arch/arm/mach-omap2/pm.c                     |    2 +-
 arch/arm/mach-omap2/pm24xx.c                 |    2 +
 arch/arm/mach-omap2/usb-fs.c                 |    4 +-
 arch/arm/plat-omap/include/plat/clock.h      |    4 +
 arch/arm/plat-omap/omap_device.c             |    6 +-
 23 files changed, 235 insertions(+), 106 deletions(-)

