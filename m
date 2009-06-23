From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Omap header cleanup for merge window after 2.6.31
Date: Tue, 23 Jun 2009 17:52:45 +0300
Message-ID: <20090623145054.5476.64968.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54899 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbZFWOws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 10:52:48 -0400
Received: from muru.com ([72.249.23.125] helo=[127.0.0.1])
	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1MJ7Mf-0001SB-3C
	for linux-omap@vger.kernel.org; Tue, 23 Jun 2009 14:52:51 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi all,

Here are some patches to remove ifdefs from io.h. More clean-up coming,
at least the omap1 specific registers should be moved away from hardware.h.

Regards,

Tony

---

Tony Lindgren (3):
      OMAP: Remove ifdefs for io.h
      OMAP: Rename OMAP_MPUIO_BASE to OMAP1_MPUIO_BASE
      OMAP: Remove OMAP_IO_ADDRESS, use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS instead


 arch/arm/mach-omap1/devices.c                 |    2 -
 arch/arm/mach-omap1/io.c                      |    6 +-
 arch/arm/mach-omap1/pm.h                      |    4 +
 arch/arm/mach-omap1/serial.c                  |    6 +-
 arch/arm/mach-omap1/sram.S                    |   12 ++-
 arch/arm/mach-omap1/time.c                    |    4 +
 arch/arm/mach-omap2/board-4430sdp.c           |    4 +
 arch/arm/mach-omap2/cm.h                      |    6 +-
 arch/arm/mach-omap2/omap-smp.c                |    2 -
 arch/arm/mach-omap2/pm-debug.c                |    2 -
 arch/arm/mach-omap2/prm.h                     |    6 +-
 arch/arm/mach-omap2/sdrc.h                    |    6 +-
 arch/arm/mach-omap2/serial.c                  |    6 +-
 arch/arm/mach-omap2/sram242x.S                |    4 +
 arch/arm/mach-omap2/sram243x.S                |    4 +
 arch/arm/mach-omap2/timer-gp.c                |    2 -
 arch/arm/plat-omap/dma.c                      |    8 +-
 arch/arm/plat-omap/dmtimer.c                  |    5 +
 arch/arm/plat-omap/gpio.c                     |   88 +++++++++++------------
 arch/arm/plat-omap/include/mach/control.h     |   12 ++-
 arch/arm/plat-omap/include/mach/entry-macro.S |    8 +-
 arch/arm/plat-omap/include/mach/gpio.h        |    2 -
 arch/arm/plat-omap/include/mach/io.h          |   97 ++++++++++++-------------
 arch/arm/plat-omap/include/mach/mtd-xip.h     |    2 -
 arch/arm/plat-omap/include/mach/omap44xx.h    |    8 +-
 arch/arm/plat-omap/include/mach/sdrc.h        |    6 +-
 arch/arm/plat-omap/io.c                       |   62 +++++++++++++++-
 arch/arm/plat-omap/sram.c                     |   20 +++--
 drivers/input/keyboard/omap-keypad.c          |   22 +++---
 drivers/mtd/nand/ams-delta.c                  |    8 +-
 drivers/video/omap/dispc.c                    |    6 +-
 31 files changed, 245 insertions(+), 185 deletions(-)

-- 
Signature
