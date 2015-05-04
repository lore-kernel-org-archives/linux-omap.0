From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Enable SPARSE_IRQ for omap1
Date: Mon,  4 May 2015 12:52:18 -0700
Message-ID: <1430769142-3921-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftx-008-i771.relay.mailchannels.net ([50.61.143.71]:32559 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbbEDTwd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 May 2015 15:52:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Hi all,

Here are few patches to enable SPARSE_IRQ on omap1.

Note that after this set removing the users for irqs.h
and making omap1 use the clock framework are needed to
get close to multiarch booting on omap1.

These are against v4.1-rc1, and also require the MPUIO fix:

[PATCH] gpio: omap: Fix regression for MPUIO interrupts

Regards,

Tony

Tony Lindgren (4):
  ARM: OMAP1: Move UART defines to prepare for sparse IRQ
  ARM: OMAP1: Switch to use generic irqchip in preparation for sparse
    IRQ
  ARM: omap1: Switch to use MULTI_IRQ
  ARM: OMAP1: Change interrupt numbering for sparse IRQ

 arch/arm/Kconfig                               |   2 +
 arch/arm/mach-omap1/ams-delta-fiq-handler.S    |   3 +-
 arch/arm/mach-omap1/board-ams-delta.c          |   1 +
 arch/arm/mach-omap1/board-fsample.c            |   1 +
 arch/arm/mach-omap1/board-generic.c            |   1 +
 arch/arm/mach-omap1/board-h2.c                 |   1 +
 arch/arm/mach-omap1/board-h3.c                 |   1 +
 arch/arm/mach-omap1/board-htcherald.c          |   1 +
 arch/arm/mach-omap1/board-innovator.c          |   1 +
 arch/arm/mach-omap1/board-nokia770.c           |   1 +
 arch/arm/mach-omap1/board-osk.c                |   1 +
 arch/arm/mach-omap1/board-palmte.c             |   1 +
 arch/arm/mach-omap1/board-palmtt.c             |   1 +
 arch/arm/mach-omap1/board-palmz71.c            |   1 +
 arch/arm/mach-omap1/board-perseus2.c           |   1 +
 arch/arm/mach-omap1/board-sx1.c                |   1 +
 arch/arm/mach-omap1/board-voiceblue.c          |   1 +
 arch/arm/mach-omap1/common.h                   |   5 +-
 arch/arm/mach-omap1/dma.c                      |   2 +-
 arch/arm/mach-omap1/i2c.c                      |   3 +-
 arch/arm/mach-omap1/include/mach/entry-macro.S |  39 ------
 arch/arm/mach-omap1/include/mach/irqs.h        | 124 ++++++++++---------
 arch/arm/mach-omap1/include/mach/serial.h      |   5 -
 arch/arm/mach-omap1/include/mach/soc.h         |   4 +
 arch/arm/mach-omap1/irq.c                      | 157 +++++++++++++++----------
 arch/arm/mach-omap1/timer.c                    |   4 +-
 arch/arm/plat-omap/dma.c                       |   4 +
 include/uapi/linux/serial_reg.h                |   3 +
 28 files changed, 190 insertions(+), 180 deletions(-)
 delete mode 100644 arch/arm/mach-omap1/include/mach/entry-macro.S

-- 
2.1.4

