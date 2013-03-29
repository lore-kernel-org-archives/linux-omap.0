From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: AM33xx: Add sysconf info to wdt1 hwmod data
Date: Fri, 29 Mar 2013 22:40:15 +0530
Message-ID: <1364577017-22562-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57399 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756389Ab3C2RS3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Mar 2013 13:18:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, paul@pwsan.com, tony@atomide.com, santosh.shilimkar@ti.com, benoit.cousson@linaro.org, Vaibhav Hiremath <hvaibhav@ti.com>

With the recent submitted patch from Santosh Shilimkar,
"ARM: OMAP2+: hwmod: Don't call _init_mpu_rt_base if no sysc"
(commit: 4a98c2d89), kernel is crashing while accessing wdt1 module
without sysconf information, so add sysconf information to
the wdt1 hwmod data.

And also switch wdt1 parent clock to PRCM generated
32K clock-source during boot-time, as default On-Chip 32K RC Osc clock
is not an accurate by design.

Vaibhav Hiremath (2):
  ARM: OMAP2+: AM33xx: hwmod: Add missing sysc definition to wdt1 entry
  ARM: OMAP2+: am335x: Change the wdt1 func clk src to per_32k clk

 arch/arm/mach-omap2/cclock33xx_data.c      |    8 ++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   15 +++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

