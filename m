From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/28] OMAP3: PM: base OFF-mode support
Date: Thu,  1 Oct 2009 16:58:30 -0700
Message-ID: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbZJAX64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:58:56 -0400
Received: by pxi9 with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Thus begins the next round of patches from the PM branch to be
submitted for 2.6.33.  It primarily consists of context save and
restore for the core HW blocks, but not the drivers.

I have a little cleanup of changelogs and some possible combining of
patches to do before the final submission, but wanted to post these
one more time to linux-omap for review before queuing for upstream.

Kevin


Aaro Koskinen (2):
  OMAP: PM: Clear DMA channel state after a wakeup
  OMAP3: PM: Fix INTC context save/restore

Jouni Hogander (1):
  OMAP3: PM: Save and restore also CM_CLKSEL1_PLL_IVA2

Juha Yrjola (1):
  OMAP: Store reboot mode in scratchpad on OMAP34xx

Kalle Jokiniemi (4):
  OMAP3: PM: Fix secure SRAM context save/restore
  ARM: OMAP: Add missing SMS_SYSCONFIG save/restore
  OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
  PM: Disable usb host HW save and restore

Peter 'p2' De Schrijver (1):
  OMAP3: PM: Wait for SDRC ready iso a blind delay

Rajendra Nayak (11):
  OMAP3: PM: GPMC context save/restore
  OMAP3: PM: GPIO context save/restore
  OMAP3: PM: INTC context save/restore
  OMAP3: PM: PRCM context save/restore
  OMAP3: PM: Populate scratchpad contents
  OMAP3: PM: SCM context save/restore
  OMAP3: PM: SRAM restore function
  OMAP3: PM: handle PER/NEON/CORE in idle
  OMAP3: PM: Restore MMU table entry
  OMAP3: PM: MPU off-mode support
  OMAP3: PM: CORE domain off-mode support

Tero Kristo (8):
  OMAP: PM: DMA context save / restore
  OMAP: PM: off-mode support for DMA on EMU/HS devices
  OMAP3 PM: off-mode support for HS/EMU devices
  OMAP3: PM: save secure RAM only during init
  OMAP3: PM: Enable SDRAM auto-refresh during sleep
  PM: Added three PLL registers to the PRCM context save
  PM: Changed secure RAM storage size from 0x8000 to 0x803F
  OMAP3: PM: SDRC auto-refresh workaround for off-mode

 arch/arm/mach-omap2/control.c             |  364 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.c                |   93 +++++++
 arch/arm/mach-omap2/irq.c                 |   66 +++++
 arch/arm/mach-omap2/pm.h                  |    3 +
 arch/arm/mach-omap2/pm34xx.c              |  276 +++++++++++++++++++-
 arch/arm/mach-omap2/powerdomains34xx.h    |    8 +-
 arch/arm/mach-omap2/prcm.c                |  402 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/sdrc.c                |   27 ++
 arch/arm/mach-omap2/sleep34xx.S           |  218 ++++++++++++++--
 arch/arm/plat-omap/dma.c                  |   62 +++++-
 arch/arm/plat-omap/gpio.c                 |   92 +++++++
 arch/arm/plat-omap/include/mach/control.h |   15 +
 arch/arm/plat-omap/include/mach/dma.h     |    5 +
 arch/arm/plat-omap/include/mach/gpio.h    |    3 +-
 arch/arm/plat-omap/include/mach/gpmc.h    |    3 +
 arch/arm/plat-omap/include/mach/irqs.h    |    5 +
 arch/arm/plat-omap/include/mach/prcm.h    |    5 +
 arch/arm/plat-omap/include/mach/sdrc.h    |    2 +
 arch/arm/plat-omap/include/mach/sram.h    |    2 +
 arch/arm/plat-omap/sram.c                 |    6 +-
 20 files changed, 1615 insertions(+), 42 deletions(-)
 mode change 100644 => 100755 arch/arm/plat-omap/include/mach/dma.h

