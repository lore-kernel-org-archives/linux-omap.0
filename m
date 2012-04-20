From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 0/4] ARM: OMAP2+: dmtimer: cleanup related to devm API and clk usage
Date: Fri, 20 Apr 2012 18:09:19 +0530
Message-ID: <1334925563-20768-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57647 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751415Ab2DTMjh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 08:39:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

The devm API usage in probe() simplifies error handling operation.
Since iclk is not used in the driver it is removed from wherever
not needed.
Corrected the timer fck name mis-match between clock44xx_data.c and
omap_hwmod_44xx_data.c.
Added omap_hwmod_get_main_clk() API. There is no more need to construct
clock names using sprintf() to be used in clk_get() during initialization.

Reference:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
Commit: e816b57a337ea3b755de72bec38c10c864f23015 (Linux 3.4-rc3)

Series is available here for reference:
git://gitorious.org/~tarunkanti/omap-sw-develoment/tarunkantis-linux-omap-dev dmtimer_cleanup_for_3.5

Tested on following platforms:
OMAP5, OMAP4430SDP, OMAP3430SDP, OMAP2430SDP.
Could not test on OMAP2420 due to unavailability of board.

v2:
- Use devm_request_and_ioremap() instead of request_mem_region() and ioremap()
- Add omap_hwmod_get_main_clk() API
- Reverted changes of clock names from OMAP2 and OMAP3 platforms  

Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Tarun Kanti DebBarma (4):
  ARM: OMAP: dmtimer: use devm_ API and do some cleanup in probe()
  ARM: OMAP2+: hwmod: add omap_hwmod_get_main_clk() API
  ARM: OMAP2+: dmtimer: cleanup iclk usage
  ARM: OMAP2+: dmtimer: cleanup fclk usage

 arch/arm/mach-omap2/clock44xx_data.c         |   33 ++++++-----------
 arch/arm/mach-omap2/omap_hwmod.c             |   15 ++++++++
 arch/arm/mach-omap2/timer.c                  |   10 +-----
 arch/arm/plat-omap/dmtimer.c                 |   51 ++++++++------------------
 arch/arm/plat-omap/include/plat/dmtimer.h    |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 6 files changed, 46 insertions(+), 67 deletions(-)

