From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2+: dmtimer: cleanup related to devm API and clk usage
Date: Mon, 16 Apr 2012 17:55:22 +0530
Message-ID: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37476 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188Ab2DPMZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 08:25:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

The devm API usage in probe() simplifies error handling operation.
Since iclk is not used in the driver it is removed from wherever
not needed. The fclk naming is made uniform as per OMAP4 platform,
viz. "timer1_fck", "timer2_fck", ... in all relevant places which
include hwmod database. With this change there is no more need to
construct clock names using sprintf() to be used in clk_get()
during initialization. Instead we can use oh->main_clk directly.

Reference:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)

Series is available here for reference:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev dmtimer_cleanup_for_3.5

Tested on following platforms:
OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
Could not test on OMAP2420 due to unavailability of board.

Tarun Kanti DebBarma (3):
  ARM: OMAP: dmtimer: Use devm_ API and do some cleanup in probe()
  ARM: OMAP2+: dmtimer: cleanup iclk usage
  ARM: OMAP2+: dmtimer: cleanup fclk usage

 arch/arm/mach-omap2/clock2420_data.c       |   72 ++++++++++++++--------------
 arch/arm/mach-omap2/clock2430_data.c       |   72 ++++++++++++++--------------
 arch/arm/mach-omap2/clock3xxx_data.c       |   72 ++++++++++++++--------------
 arch/arm/mach-omap2/clock44xx_data.c       |   33 ++++--------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   24 +++++-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   24 +++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   24 +++++-----
 arch/arm/mach-omap2/timer.c                |   10 +----
 arch/arm/plat-omap/dmtimer.c               |   51 +++++++------------
 arch/arm/plat-omap/include/plat/dmtimer.h  |    2 +-
 10 files changed, 176 insertions(+), 208 deletions(-)

