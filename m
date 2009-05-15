From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/11] OMAP2/3: PM sync-up
Date: Fri, 15 May 2009 11:40:40 -0700
Message-ID: <1242412851-16606-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f115.google.com ([209.85.222.115]:64443 "EHLO
	mail-pz0-f115.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbZEOSkw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 14:40:52 -0400
Received: by pzk13 with SMTP id 13so1205834pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 15 May 2009 11:40:53 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

This series is intended to push the core PM support from linux-omap
into mainline.  It applies on top of Tony's two recent series:

- [PATCH 0/8] Omap fixes for 2.6.30-rc5
- [PATCH 0/5] More omap header clean-up for the merge window after 2.6.30

Upon review/acceptance, Tony will merge into is for-next branch so
all OMAP stuff can come from one place.

In addition to the linux-omap sync, several OMAP3 init fixes are
required to ensure that the chip can hit full-chip retention
on idle and suspend.

Compile tested on OMAP2, Boot tested on OMAP3430SDP and can
hit full-chip retention in suspend and in idle.

Jouni Hogander (1):
  OMAP: Add new function to check wether there is irq pending

Kevin Hilman (9):
  OMAP2/3: PM: push core PM code from linux-omap
  OMAP3: PM: Force IVA2 into idle during bootup
  OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
  OMAP3: PM: UART: disable clocks when idle and off-mode support
  OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
  OMAP3: PM: D2D clockdomain supports SW supervised transitions
  OMAP3: PM: Ensure PRCM interrupts are cleared at boot
  OMAP3: PM: Clear pending PRCM reset flags on init
  OMAP3: PM: prevent module wakeups from waking IVA2

Peter 'p2' De Schrijver (1):
  OMAP3: PM: Ensure MUSB block can idle when driver not loaded

 arch/arm/mach-omap2/Makefile              |    3 +
 arch/arm/mach-omap2/clock34xx.c           |    3 +
 arch/arm/mach-omap2/clock34xx.h           |   33 ++-
 arch/arm/mach-omap2/clockdomains.h        |    2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 +
 arch/arm/mach-omap2/irq.c                 |   17 +-
 arch/arm/mach-omap2/pm-debug.c            |  152 ++++++
 arch/arm/mach-omap2/pm.c                  |  155 ++++---
 arch/arm/mach-omap2/pm.h                  |   53 +++
 arch/arm/mach-omap2/pm24xx.c              |  558 ++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |  711 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h         |    2 +
 arch/arm/mach-omap2/prm.h                 |    2 +
 arch/arm/mach-omap2/sdrc.c                |    5 +-
 arch/arm/mach-omap2/serial.c              |  391 +++++++++++++++-
 arch/arm/mach-omap2/sleep24xx.S           |    1 -
 arch/arm/mach-omap2/sleep34xx.S           |  543 ++++++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c            |    7 +-
 arch/arm/plat-omap/Kconfig                |    2 +-
 arch/arm/plat-omap/common.c               |    1 -
 arch/arm/plat-omap/include/mach/common.h  |    2 -
 arch/arm/plat-omap/include/mach/control.h |   13 +
 arch/arm/plat-omap/include/mach/irqs.h    |    1 +
 arch/arm/plat-omap/include/mach/pm.h      |  345 --------------
 arch/arm/plat-omap/include/mach/serial.h  |    9 +
 drivers/mtd/onenand/omap2.c               |    1 -
 26 files changed, 2570 insertions(+), 456 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm-debug.c
 create mode 100644 arch/arm/mach-omap2/pm.h
 create mode 100644 arch/arm/mach-omap2/pm24xx.c
 create mode 100644 arch/arm/mach-omap2/pm34xx.c
 create mode 100644 arch/arm/mach-omap2/sleep34xx.S
 delete mode 100644 arch/arm/plat-omap/include/mach/pm.h

