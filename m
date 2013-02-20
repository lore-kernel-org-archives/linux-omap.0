From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/8] ARM: OMAP5: Few updates discovered with es2.0
Date: Wed, 20 Feb 2013 20:57:06 +0530
Message-ID: <1361374034-21831-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933698Ab3BTPZy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:25:54 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Here are few OMAP5 updates discovered during es2.0 silicon validation.
Tested on OMAP5430 and OMAP5432 devices after applying out of tree
datafiles for OMAP5.

Rajendra Nayak (1):
  ARM: OMAP5: clock: No Freqsel on OMAP5 devices

Santosh Shilimkar (6):
  ARM: OMAP5: Update SOC id detection code for ES2
  ARM: OMAP5: timer: Update the clocksource name as per clock data
  ARM: OMAP5: prm: Allow prm init to success on OMAP5 SOCs
  ARM: OMAP5: Update SAR RAM base address
  ARM: OMAP5: Update SAR memory layout for WakeupGen
  ARM: OMAP5: Make errata i688 workaround available

Tero Kristo (1):
  ARM: OMAP5: Reuse prm read_inst/write_inst

 arch/arm/mach-omap2/Kconfig            |    2 +-
 arch/arm/mach-omap2/dpll3xxx.c         |    6 ++++--
 arch/arm/mach-omap2/id.c               |   16 +++++++++++++---
 arch/arm/mach-omap2/io.c               |    9 +++++++++
 arch/arm/mach-omap2/omap4-common.c     |   10 ++++++++--
 arch/arm/mach-omap2/omap4-sar-layout.h |   14 +++++++-------
 arch/arm/mach-omap2/omap54xx.h         |    1 +
 arch/arm/mach-omap2/prm44xx.c          |    6 +++---
 arch/arm/mach-omap2/soc.h              |    2 ++
 arch/arm/mach-omap2/timer.c            |    5 +++--
 10 files changed, 51 insertions(+), 20 deletions(-)

-- 
1.7.9.5

