From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] omap:pm: cleanup omap3_[mpu|dsp|l3]_rate_table
Date: Sat, 19 Dec 2009 18:40:51 +0530
Message-ID: <1261228253-30283-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47253 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbZLSNLD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Dec 2009 08:11:03 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin h <khilman@deeprootsystems.com>
Cc: linux omap <linux-omap@vger.kernel.org>, Romit Dasgupta <romit@ti.com>, Ambresh k <ambresh@ti.com>, Nishanth Menon <nm@ti.com>

With the pm-wip-opp branch, we can do further cleanups
with the omap2_init_common_hw

Since the inits of mpu_opps etc are happening at
omap3_pm_init_opp_table, we can just quit doing a double init

Nishanth Menon (2):
  io: remove redundant params in omap2_init_common_hw
  omap3: pm: remove omap3_[mpu|dsp|l3]_rate_tables

 arch/arm/mach-omap2/board-3430sdp.c      |    3 +--
 arch/arm/mach-omap2/board-3630sdp.c      |    4 +---
 arch/arm/mach-omap2/board-apollon.c      |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c       |    3 +--
 arch/arm/mach-omap2/board-generic.c      |    2 +-
 arch/arm/mach-omap2/board-h4.c           |    2 +-
 arch/arm/mach-omap2/board-ldp.c          |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c  |    3 +--
 arch/arm/mach-omap2/board-omap3evm.c     |    3 +--
 arch/arm/mach-omap2/board-omap3pandora.c |    3 +--
 arch/arm/mach-omap2/board-overo.c        |    2 +-
 arch/arm/mach-omap2/board-rx51.c         |    5 +----
 arch/arm/mach-omap2/board-zoom2.c        |    3 +--
 arch/arm/mach-omap2/board-zoom3.c        |    4 +---
 arch/arm/mach-omap2/io.c                 |    5 +----
 arch/arm/mach-omap2/pm34xx.c             |   15 +++------------
 arch/arm/plat-omap/include/plat/io.h     |    5 +----
 17 files changed, 19 insertions(+), 47 deletions(-)

Regards,
Nishanth Menon
PS: my vacation is on for the next 2 weeks, see you all next year.
happy hacking..
