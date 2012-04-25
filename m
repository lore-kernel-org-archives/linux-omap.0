From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V5 0/3] ARM: OMAP: Make OMAP clocksource source selection runtime
Date: Wed, 25 Apr 2012 19:28:57 +0530
Message-ID: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35189 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756754Ab2DYOFJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 10:05:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, santosh.shilimkar@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Current OMAP code supports couple of clocksource options based
on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)

This patch series cleans up the existing 32k-sync timer implementation
without any major code changes, uses kernel parameter to override
the default clocksource of "counter_32k", also in order to support
some OMAP based derivative SoCs like AM33XX which doesn't have
32K sync-timer hardware IP, adds hwmod lookup for omap2+
devices, and if lookup fails then fall back to gp-timer.

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
Changes from V4 (No Code Change at all):
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg67019.html
	- Updated commit description as per Tony's comment

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
  ARM: OMAP2/3: Add idle_st bits for ST_32KSYNC timer to prcm-common
    header
  ARM: OMAP2/3: hwmod data: Add 32k-sync timer data to hwmod database
  ARM: OMAP: Make OMAP clocksource source selection using kernel param

 arch/arm/mach-omap1/timer32k.c                     |    6 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   19 ++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   19 ++++
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |   19 ++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    4 +
 arch/arm/mach-omap2/timer.c                        |   99 ++++++++++++++----
 arch/arm/plat-omap/counter_32k.c                   |  108 ++++++++++----------
 arch/arm/plat-omap/include/plat/common.h           |    2 +-
 10 files changed, 254 insertions(+), 77 deletions(-)

