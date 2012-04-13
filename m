From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 0/3] ARM: OMAP: Make OMAP clocksource source selection runtime
Date: Fri, 13 Apr 2012 15:09:04 +0530
Message-ID: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46968 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932798Ab2DMJj2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Apr 2012 05:39:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

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

History:
========
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
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   54 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_common_data.h       |    1 +
 arch/arm/mach-omap2/prcm-common.h                  |    4 +
 arch/arm/mach-omap2/timer.c                        |  100 +++++++++++++++-----
 arch/arm/plat-omap/counter_32k.c                   |   85 +++++++----------
 arch/arm/plat-omap/include/plat/common.h           |    2 +-
 10 files changed, 236 insertions(+), 73 deletions(-)

