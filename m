From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 0/3] Prepare for GPMC driver conversion
Date: Mon, 11 Jun 2012 19:31:01 +0530
Message-ID: <cover.1339419244.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48358 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754501Ab2FKOQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jun 2012 10:16:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Afzal Mohammed <afzal@ti.com>

Hi,

Objective of this series is to make things easy for GPMC driver
conversion series by separating out more things from driver
conversion series.

This series,
1. Unifies NAND platform initialization functions
2. Cleans up OneNAND platform code a little
3. Handles additional timings in Kernel

This series is based on 3.5-rc1 & made on top of
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69501.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg69881.html

Regards
Afzal

Afzal Mohammed (3):
  ARM: OMAP2+: nand: unify init functions
  ARM: OMAP2+: onenand: cleanup for gpmc driver conversion
  ARM: OMAP2+: gpmc: handle additional timings

 arch/arm/mach-omap2/board-devkit8000.c     |    8 +++--
 arch/arm/mach-omap2/board-flash.c          |   45 ++++++++++++++-------------
 arch/arm/mach-omap2/board-flash.h          |    6 ++--
 arch/arm/mach-omap2/board-igep0020.c       |    2 +-
 arch/arm/mach-omap2/board-ldp.c            |    4 +--
 arch/arm/mach-omap2/board-omap3beagle.c    |    8 +++--
 arch/arm/mach-omap2/board-omap3touchbook.c |    8 +++--
 arch/arm/mach-omap2/board-overo.c          |    7 +++--
 arch/arm/mach-omap2/board-zoom.c           |    5 +--
 arch/arm/mach-omap2/common-board-devices.c |   46 ----------------------------
 arch/arm/mach-omap2/common-board-devices.h |    1 -
 arch/arm/mach-omap2/gpmc-onenand.c         |   24 ++++++---------
 arch/arm/mach-omap2/gpmc.c                 |    6 ++++
 arch/arm/plat-omap/include/plat/gpmc.h     |    6 ++++
 14 files changed, 77 insertions(+), 99 deletions(-)

-- 
1.7.10.2

