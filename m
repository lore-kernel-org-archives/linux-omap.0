From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/4] OMAP4: Add modulemode support to hwmod framework (part 2)
Date: Fri, 1 Jul 2011 23:54:23 +0200
Message-ID: <1309557267-27165-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33141 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757740Ab1GAVyg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 17:54:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is the second part of the modulemode series. 
The goal here is to do the cleanup on the clock nodes and PRCM macros
that are not needed anymore by the hwmod data.
Some macros are still needed because of clock data. It should be removed
once the clock data will be cleaned.

Since the MMC pm_runtime is done, we can drop the TEMP hacks.

The series is based on for_3.1/6_hwmod_clkdm_fixes and tested
on OMAP4430 ES2.1 + SDP. It should not affect OMAP2 & 3, but some testing
are definitively needed.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.1/7_hwmod_modulemode

Regards,
Benoit


Changes since v1:
    - Drop MMC TEMP hacks
    - Move omap_device patch to standalone patch
    - Add a hwmod GPMC fix to replace the one in the clock data

Benoit Cousson (4):
  OMAP4: hwmod data: Add GPMC
  OMAP4: hwmod data: Replace main_clk with the real input clock
  OMAP4: clock data: Remove leaf clock nodes
  OMAP4: prcm: Remove macros with absolute address

 arch/arm/mach-omap2/clock44xx_data.c       | 1723 +++++++++-------------------
 arch/arm/mach-omap2/cm1_44xx.h             |   24 -
 arch/arm/mach-omap2/cm2_44xx.h             |   55 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  175 ++-
 arch/arm/mach-omap2/prm44xx.h              |  269 -----
 5 files changed, 636 insertions(+), 1610 deletions(-)

