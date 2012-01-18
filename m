From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH 0/5] arm:omap1/2/3/4: 32k sync timer cleanup
Date: Wed, 18 Jan 2012 16:58:01 +0530
Message-ID: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50688 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607Ab2ARL2h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 06:28:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: johnstul@us.ibm.com, tglx@linutronix.de, balbi@ti.com, linux-arm-kernel@lists.infradead.org, tony@atomide.com, b-cousson@ti.com, khilman@ti.com, paul@pwsan.com, Vaibhav Hiremath <hvaibhav@ti.com>

This patch series is built on top of older version submitted
earlier during 2010 timeframe by 'Felipe Balbi' -

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg37403.html

Changes from earlier submitted version:
	- hwmod cleanup: Since 2010 there has been some changes happened
	  in hwmod interface, migrated to the latest version.
	- wrong hwmod info: the previous version had some issues with newly
	  added 32k-counter hwmod data, like, base_addr,
	  idle_st bit position. So corrected these errors.
	- In omap-32k platform driver, replaced
	  clocksource_register => clocksource_register_hz
	- Merged patches into more logical grouping

NOTE: Patch series has been tested on AM37xEVM, AM3517EVM, AM335xEVM,
      with/without kernel parameter "clocksource=".

The reason why I am submitting this patch-series as a RFC version is,

I am struggling to convince myself and find answers for -

	- Do we really required platform_driver approach here?
	- Can we simply cleaup the existing plat-omap/counter_32k.c
	  file and add hwmod lookup to make decesion whether the
	  module is present or not on the current device?
	- what about existing mmio driver/api? we can avoid some
	  code duplication here.

So I decided to start with RFC with the existing (already submitted)
approach and get the expert peoples view on this.
Based on feedback I will submit next version.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Vaibhav Hiremath (5):
  arm:omap1/2/3/4:Convert 32k-Sync clocksource driver to
    platform_driver
  arm:omap2/3: Add idle_st bits for ST_32KSYNC timer
  arm:omap1/2/3/4: Add 32k counter data to hwmod database
  arm:omap1/2/3/4: Add platform hookup code for counter-32k driver
  arm:omap1/2/3: Change dev name for sync_32k_ick clk to
    omap-counter-32k

 arch/arm/mach-omap1/devices.c              |   24 +++
 arch/arm/mach-omap2/clock2420_data.c       |    2 +-
 arch/arm/mach-omap2/clock2430_data.c       |    2 +-
 arch/arm/mach-omap2/clock3xxx_data.c       |    2 +-
 arch/arm/mach-omap2/devices.c              |   25 ++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   53 +++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   52 +++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   51 +++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
 arch/arm/mach-omap2/prcm-common.h          |    4 +
 arch/arm/mach-omap2/timer.c                |   17 ---
 arch/arm/plat-omap/Makefile                |    2 +-
 arch/arm/plat-omap/counter_32k.c           |  154 --------------------
 drivers/clocksource/Makefile               |    1 +
 drivers/clocksource/omap-32k.c             |  210 ++++++++++++++++++++++++++++
 include/linux/clocksource.h                |    1 +
 16 files changed, 426 insertions(+), 176 deletions(-)
 delete mode 100644 arch/arm/plat-omap/counter_32k.c
 create mode 100644 drivers/clocksource/omap-32k.c

