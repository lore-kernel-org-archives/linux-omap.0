From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/7] OMAP4: Add modulemode support to hwmod framework (part 2)
Date: Mon, 27 Jun 2011 18:33:04 +0200
Message-ID: <1309192391-12410-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40849 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665Ab1F0Qdu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Jun 2011 12:33:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is the second part of the modulemode series. 
The goal here is to do the cleanup on the clock nodes and PRCM macros
that are not needed anymore by the hwmod data.
Some macros are still needed because of clock data. It should be removed
once the clock data will be cleaned.

Moreover, in order to get rid of static clkdev, omap_device is trying to
create dynamically an "fck" alias if a main_clk is defined in hwmod data.

As usual, because of drivers non-adapted to pm_runtime, some temp hacks
are needed for both MMC and timer1.
If the drivers are fixes before these series, these temp patches could be
dropped.

The series is based on for_3.0.1/5_hwmod_clkdm_fixes and tested
on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
are definitively needed.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.0.1/6_hwmod_modulemode

Regards,
Benoit


Benoit Cousson (7):
  OMAP: hwmod: Add warnings if enable failed
  OMAP: omap_device: Create clkdev entry for hwmod main_clk
  OMAP4: hwmod data: TEMP: Do not idle MMC1 & MMC2 after boot
  OMAP4: hwmod data: Replace main_clk with the real input clock
  OMAP4: clock data: Remove leaf clock nodes
  OMAP4: hwmod data: TEMP: Fix timer1 main_clk
  OMAP4: prcm: Remove macros with absolute address

 arch/arm/mach-omap2/clock44xx_data.c       | 1730 ++++++++--------------------
 arch/arm/mach-omap2/cm1_44xx.h             |   24 -
 arch/arm/mach-omap2/cm2_44xx.h             |   55 -
 arch/arm/mach-omap2/omap_hwmod.c           |    2 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  111 +-
 arch/arm/mach-omap2/prm44xx.h              |  269 -----
 arch/arm/plat-omap/omap_device.c           |   84 +-
 7 files changed, 610 insertions(+), 1665 deletions(-)

