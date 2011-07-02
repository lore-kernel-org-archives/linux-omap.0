From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/6] OMAP4: Add 4460 base support
Date: Sat, 2 Jul 2011 08:00:20 +0530
Message-ID: <1309573826-10615-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42723 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833Ab1GBCbZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 22:31:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

This series adds base support needed to be able
to boot on a OMAP4460 device.
Patches are based on 
git://gitorious.org/omap-pm/linux.git for_3.1/7_hwmod_modulemode
and boot tested on 4430sdp and 4460sdp boards.
The series updates the prcm/clock and clockdomain/powerdomain
data files which are also cleaned up/fixed by the various series
posted by Benoit, and hence the dependency.

Changes since v1:
1. Removed the minor issues in the ID detection patches 
2. Dropped '4460sdp/blaze/panda: hwmod: Prevent gpio1 reset during hwmod init'
since the right way to fix it is to do a lazy-disable in hmwod as suggested 
by Tony.
For now, with this patch dropped and until the lazy-disable for hwmod
gets in, 4460 based devices can only boot reliably at OPP50 on MPU.

Aneesh V (2):
  OMAP: ID: introduce chip detection for OMAP4460
  OMAP4: ID: add omap_has_feature for max freq supported

Rajendra Nayak (4):
  OMAP4: PRCM: OMAP4460 specific PRM and CM register bitshifts
  OMAP4: clocks: Update the clock tree with 4460 clock nodes
  OMAP4: powerdomain: Reuse on 4460 using CHIP_IS_44XX
  OMAP4: clockdomain: Reuse on 4460 using CHIP_IS_44XX

 arch/arm/mach-omap2/clock44xx_data.c          |   39 +++++
 arch/arm/mach-omap2/clockdomains44xx_data.c   |  200 ++++++++++++------------
 arch/arm/mach-omap2/cm-regbits-44xx.h         |   36 +++++
 arch/arm/mach-omap2/id.c                      |   53 ++++++-
 arch/arm/mach-omap2/powerdomains44xx_data.c   |   32 ++--
 arch/arm/mach-omap2/prm-regbits-44xx.h        |    8 +
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +-
 arch/arm/plat-omap/include/plat/clock.h       |    3 +-
 arch/arm/plat-omap/include/plat/cpu.h         |   36 ++++-
 9 files changed, 279 insertions(+), 130 deletions(-)

-- 
1.7.4.1

