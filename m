From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 0/3] ARM: OMAP: Make OMAP clocksource source selection runtime
Date: Fri, 30 Mar 2012 19:24:12 +0530
Message-ID: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46633 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759966Ab2C3OFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Mar 2012 10:05:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tom.leiming@gmail.com, Vaibhav Hiremath <hvaibhav@ti.com>

Current OMAP code supports couple of clocksource options based
on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz)

This patch series cleans up the existing 32k-sync timer implementation
without any major code change, in order to enable runtime selection between
32k sync-timer and gptimer and adds hwmod lookup for omap2+ devices,
if lookup fails then fall back to gp-timer.

With this, we should be able to support multi-omap boot
including devices with/without 32k-sync timer.
For example, AM33xx device doesn't have 32k-sync timer available,
which breaks multi-omap boot.

This patch-series has been boot tested on AM37xEVM platform, it
would be helpful if somebody help me to validate it on OMAP1/2
platforms.

Changes from previous submissions:
==================================

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
  ARM: OMAP2+: hwmod data: Add 32k-sync timer data to hwmod database
  ARM: OMAP: Make OMAP clocksource source selection runtime

 arch/arm/mach-omap1/timer32k.c             |    6 ++-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   53 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/mach-omap2/prcm-common.h          |    4 +
 arch/arm/mach-omap2/timer.c                |   45 ++++++++------
 arch/arm/plat-omap/counter_32k.c           |   86 ++++++++++++----------------
 arch/arm/plat-omap/include/plat/common.h   |    2 +-
 9 files changed, 229 insertions(+), 72 deletions(-)

