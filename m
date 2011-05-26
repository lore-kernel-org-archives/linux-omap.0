From: Nishanth Menon <nm@ti.com>
Subject: [RFC][PATCH 0/9] OMAP4: Add 4460 base support
Date: Wed, 25 May 2011 18:56:47 -0700
Message-ID: <1306375016-707-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:41267 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757270Ab1EZB5H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 21:57:07 -0400
Received: by ywa6 with SMTP id 6so177767ywa.16
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 18:57:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>


Hi,
Here is the initial RFC providing base support for OMAP4460, This series
based on v2.6.39 tag boots up on SDP4460:
http://pastebin.pandaboard.org/index.php/view/28646263

Aneesh V (2):
  OMAP: ID: introduce chip detection for OMAP4460
  OMAP4: HWMOD: make current hwmods common for 4460 and 4430

Moiz Sonasath (1):
  OMAP4460: HWMOD: DO not reset GPIO1 during HWMOD init

Rajendra Nayak (6):
  OMAP4: clocks: distinguish 4430 and 4460
  OMAP4: PRM: OMAP4460 specific PRM and CM register bitshifts
  OMAP4: clocks: Update the clock tree with 4460 clock nodes
  OMAP4: powerdomain: Update MPU powerdomain for 4460
  OMAP4: clockdomain: Use CHIP_IS_44XX to reuse all CD's on 4460
  OMAP4460: dpll: Support MPU frequencies > 1 Ghz

 arch/arm/mach-omap2/clock44xx_data.c          |  676 +++++++++++++------------
 arch/arm/mach-omap2/clockdomains44xx_data.c   |  200 ++++----
 arch/arm/mach-omap2/cm-regbits-44xx.h         |   32 ++
 arch/arm/mach-omap2/dpll3xxx.c                |   58 +++
 arch/arm/mach-omap2/id.c                      |   19 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  187 ++++---
 arch/arm/mach-omap2/powerdomains44xx_data.c   |   53 ++-
 arch/arm/mach-omap2/prm-regbits-44xx.h        |   10 +-
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +
 arch/arm/plat-omap/include/plat/clock.h       |    2 +
 arch/arm/plat-omap/include/plat/cpu.h         |   12 +
 11 files changed, 718 insertions(+), 533 deletions(-)

Regards,
Nishanth Menon
