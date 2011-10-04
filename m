From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/2] ARM: OMAP2+: timer fixes / cleanup
Date: Tue, 4 Oct 2011 23:20:39 +0200
Message-ID: <1317763241-21422-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59467 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558Ab1JDVUy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 17:20:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: khilman@ti.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tarun.kanti@ti.com, Benoit Cousson <b-cousson@ti.com>

Hi Tony,

Here is the series to fix the warning and remove the redundant
latency structure that be removed since the timer runtime PM
adaptation was just pulled.

I was just able to test that on OMAP4.

Patches are based on Kevin's for_3.2/omap_device-2 branch
and are available here:
git://gitorious.org/omap-pm/linux.git for_3.2/timer_fixes

Regards,
Benoit


Benoit Cousson (2):
  ARM: OMAP2+: clock data: Remove redundant timer clkdev
  ARM: OMAP2+: timer: Remove omap_device_pm_latency

 arch/arm/mach-omap2/clock2420_data.c |   12 ------------
 arch/arm/mach-omap2/clock2430_data.c |   12 ------------
 arch/arm/mach-omap2/clock3xxx_data.c |   12 ------------
 arch/arm/mach-omap2/clock44xx_data.c |   11 -----------
 arch/arm/mach-omap2/timer.c          |   12 +-----------
 5 files changed, 1 insertions(+), 58 deletions(-)

