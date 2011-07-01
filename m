From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/7] OMAP4: Add 4460 base support
Date: Fri, 1 Jul 2011 07:37:54 +0530
Message-ID: <1309486081-8257-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54648 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab1GACIO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 22:08:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

This series adds base support needed to be able
to boot on a OMAP4460 device.
Patches are based on Benoit's for_3.0.1/7_hwmod_modulemode
branch and boot tested on both 4460sdp as well as 4430sdp.

Aneesh V (2):
  OMAP: ID: introduce chip detection for OMAP4460
  OMAP4: ID: add omap_has_feature for max freq supported

Rajendra Nayak (5):
  OMAP4: PRCM: OMAP4460 specific PRM and CM register bitshifts
  OMAP4: clocks: Update the clock tree with 4460 clock nodes
  OMAP4: powerdomain: Reuse on 4460 using CHIP_IS_44XX
  OMAP4: clockdomain: Reuse on 4460 using CHIP_IS_44XX
  4460sdp/blaze/panda: hwmod: Prevent gpio1 reset during hwmod init

 arch/arm/mach-omap2/board-4430sdp.c           |   14 ++
 arch/arm/mach-omap2/board-omap4panda.c        |   14 ++
 arch/arm/mach-omap2/clock44xx_data.c          |   39 +++++
 arch/arm/mach-omap2/clockdomains44xx_data.c   |  200 ++++++++++++------------
 arch/arm/mach-omap2/cm-regbits-44xx.h         |   36 +++++
 arch/arm/mach-omap2/id.c                      |   44 +++++-
 arch/arm/mach-omap2/powerdomains44xx_data.c   |   30 ++--
 arch/arm/mach-omap2/prm-regbits-44xx.h        |    8 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +-
 arch/arm/plat-omap/include/plat/clock.h       |    3 +-
 arch/arm/plat-omap/include/plat/cpu.h         |   32 ++++-
 11 files changed, 301 insertions(+), 121 deletions(-)

-- 
1.7.4.1

