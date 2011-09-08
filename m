From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/8] OMAP3/4: Misc fixes and clean-up
Date: Thu, 8 Sep 2011 10:51:59 +0530
Message-ID: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36642 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1IHFWT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 01:22:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The series contains few fixes and clean-up for OMAP.
Briefly,
- HWMOD fix for the address space count
- Improving the L3 register accesses
- Bug fix in the L3 error handler
- Sparce warning and indentation fixes in L3 error handler
- Print master id in case of L3 custom errors for better debug.
- Adding local time clock node for the CPUfreq and time re-calibration
- Fix in the address overlap for emif and emulation domain.

The series is tested on OMAP4430 SDP and OMAP4430 beagle and SDP.

The following changes since commit c6a389f123b9f68d605bb7e0f9b32ec1e3e14132:

  Linux 3.1-rc4 (2011-08-28 21:16:01 -0700)

are available in the git repository at:
  git://gitorious.org/omap-sw-develoment/linux-omap-dev.git v3.1-rc4-omap-misc

Santosh Shilimkar (2):
      OMAP4: clock: Add CPU local timer clock node.
      OMAP4: Fix the emif and dmm virtual mapping

Todd Poynor (2):
      OMAP: Improve register access in L3 Error handler.
      OMAP: Fix a BUG in l3 error handler.

sricharan (4):
      OMAP: hwmod: Fix the addr spaces count API.
      OMAP: Fix indentation issues in l3 error handler.
      OMAP: Fix sparse warnings in l3 error handler.
      OMAP: Print Initiator name for l3 custom error.

 arch/arm/mach-omap2/clock44xx_data.c |    9 ++
 arch/arm/mach-omap2/omap_hwmod.c     |    8 +-
 arch/arm/mach-omap2/omap_l3_noc.c    |  130 ++++++++++----------
 arch/arm/mach-omap2/omap_l3_noc.h    |  224 +++++++++++++++++++---------------
 arch/arm/mach-omap2/omap_l3_smx.c    |   91 +++++++-------
 arch/arm/mach-omap2/omap_l3_smx.h    |  164 ++++++++++++------------
 arch/arm/plat-omap/include/plat/io.h |    4 +-
 7 files changed, 336 insertions(+), 294 deletions(-)
