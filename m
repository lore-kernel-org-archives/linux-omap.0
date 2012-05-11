From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 0/2] ARM: omap: dmtimer: fix incorrect TCRR value in posted mode
Date: Fri, 11 May 2012 19:23:16 +0530
Message-ID: <1336744398-23803-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34623 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab2EKNxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 09:53:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com, santosh.shilimkar@ti.com, khilman@ti.com, b-cousson@ti.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Timers in PER domain periodically report old time from TCRR in posted mode
unless ICLK >= 4 * FCLK. The problem is addressed in the following manner:

Patch 1: Adds ick alias in the clkdev table so that dmtimer code can
extract the iclk rate using clk_get_rate().

Patch 2: The final logic added in omap_dm_timer_prepare() where timer is
set to non-posted mode if iclk < 4*fclk.

Rajendra Nayak (1):
  ARM: omap: hwmod: Add an 'ick' clkdev alias

Tarun Kanti DebBarma (1):
  ARM: omap: dmtimer: set non-posted mode if iclk less than 4*fck

 arch/arm/plat-omap/dmtimer.c     |   12 ++++++++++++
 arch/arm/plat-omap/omap_device.c |    3 +++
 2 files changed, 15 insertions(+), 0 deletions(-)

