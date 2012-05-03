From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V7 0/3] ARM: OMAP: Make OMAP clocksource source selection runtime
Date: Thu, 3 May 2012 13:28:58 +0530
Message-ID: <1336031941-23651-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48361 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab2ECH7N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:59:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Current OMAP code supports couple of clocksource options based
on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)

This patch series cleans up the existing 32k-sync timer implementation,
movind SoC init code to respective files (mach-omap1/timer32k.c and
mach-omap2/timer.c) and uses kernel parameter to override the default
clocksource of "counter_32k", also in order to support some OMAP based
derivative SoCs like AM33XX which doesn't have 32K sync-timer hardware IP,
adds hwmod lookup for omap2+ devices, and if lookup fails then
fall back to gp-timer.

if(use_gptimer_clksrc == true)
	gptimer clocksource init;
else if (counter_32 init == false)
	/* Fallback to gptimer */
	gptimer clocksource init(;

With this, we should be able to support multi-omap boot
including devices with/without 32k-sync timer.

This patch-series has been boot tested on AM37xEVM platform, it
would be helpful if somebody help me to validate it on OMAP1/2
platforms.

The patches are also available at (based on linux-omap/master) -
https://github.com/hvaibhav/am335x-linux   32ksync-timer-cleanup

History:
========
Changes from V6:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67623.html
	- Changed Patch2/3 descrption to add affected kernel parameter
	- Warning Fix: Added missing inline prefix to omap_32k_timer_init()
	- Added Acked-by and Tested-by from Kevin Hilman

Changes from V5:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67163.html
	- 2 of the original patch-series (1/3 and 2/3) has already been
	  accepted and queued by Paul, so removing them.
	  Also, add 2 new patches,
		- OMAP2 timer32k cleanup, check for return values.
		- Changed name of system timers, "gp timer" => "gp_timer".
	- Moved SoC specific init code to respective files
	  (mach-omap1/timer32k.c and mach-omap2/timer.c)

Changes from V4:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67019.html
	- Fix the possible bug, leftover the cnt addr argument to
	  clocksource_mmio_init().

Changes from V3:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg66462.html
	- Fixed all review comments from Kevin H
		* Moved counter_32k CR register offset handling to
		  counter_32k.c file, so now, calling funtion don't have
		  to maintain or add offset to base addr.
		* Added comment for function omap_init_clocksource_32k()
		* Used resource_size() for calculate size
		* Convert WARN_ON to pr_warn

Changes from V2:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/092037.html
	- Added early_param support to read clocksource selection
	  from user through kernel parameter ("clocksource=")
	- Converted to ocp_if changes from Paul

Changes from V1:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/081037.html
	- Based on Tony's comment, added pbase & size argument to
	  omap_init_clocksource_32k(), to avoid cpu_is_xxx() check.
	- Added commit description based on discussion on list
	  (Thanks to Santosh here)
	- Reorder patch sequence


Vaibhav Hiremath (3):
  ARM: OMAP1: FIX: check possible error condition in timer_init
  ARM: OMAP2+: Replace space=>underscore in the name field of system
    timers
  ARM: OMAP: Make OMAP clocksource source selection using kernel param

 arch/arm/mach-omap1/common.h             |   10 ++-
 arch/arm/mach-omap1/time.c               |   16 +----
 arch/arm/mach-omap1/timer32k.c           |   28 ++++++-
 arch/arm/mach-omap2/timer.c              |  118 +++++++++++++++++++++++------
 arch/arm/plat-omap/counter_32k.c         |   91 ++++++++++-------------
 arch/arm/plat-omap/include/plat/common.h |    2 +-
 6 files changed, 167 insertions(+), 98 deletions(-)

