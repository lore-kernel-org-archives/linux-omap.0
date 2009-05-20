From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 00/13] OMAP2/3: PM sync-up
Date: Wed, 20 May 2009 16:19:23 -0700
Message-ID: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f171.google.com ([209.85.216.171]:43119 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346AbZETXTh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:19:37 -0400
Received: by pxi1 with SMTP id 1so365239pxi.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:19:38 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

This series is intended to push the core PM support from linux-omap
into mainline.  

Upon review/acceptance, Tony will merge into his for-next branch for
the next merge window so all OMAP stuff can come from one place.

In addition to the linux-omap PM core sync, several OMAP3 init fixes
are required to ensure that the chip can hit full-chip retention on
idle and suspend.

Currently based on Tony's omap3-upstream branch.  Compile tested on
OMAP2, Boot tested on OMAP3430SDP and can hit full-chip retention in
suspend and in idle.

Changes since v1:
 - updated "push core PM" patch with review comments
   - dropped all /sys/power/* knobs
   - will use hlt_counter when it's exported to platform code
   - dropped save/restore of abort mode regs in favor of cpu_init()
 - MUSB idle patch fixed to work even when MUSB not enabled in Kconfig
 - 2 new patches
   - added UART-specific timeout feature under uart platform device.
     this replaces the need for /sys/power/clocks_off_while_idle   
   - revert of irq_chip->disable patch which is the wrong solution
     for the bug it was trying to fix

Jouni Hogander (2):
  OMAP: Add new function to check wether there is irq pending
  OMAP: UART: Add sysfs interface for adjusting UART sleep timeout

Kevin Hilman (10):
  Revert "ARM: OMAP: Mask interrupts when disabling interrupts, v2"
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

 arch/arm/mach-omap2/Makefile              |    5 +-
 arch/arm/mach-omap2/clock34xx.c           |    3 +
 arch/arm/mach-omap2/clock34xx.h           |   33 ++-
 arch/arm/mach-omap2/clockdomains.h        |    2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h     |   14 +
 arch/arm/mach-omap2/irq.c                 |   18 +-
 arch/arm/mach-omap2/pm-debug.c            |  152 ++++++
 arch/arm/mach-omap2/pm.c                  |  134 +++----
 arch/arm/mach-omap2/pm.h                  |   40 ++
 arch/arm/mach-omap2/pm24xx.c              |  549 ++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c              |  710 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm-common.h         |    2 +
 arch/arm/mach-omap2/prm.h                 |    2 +
 arch/arm/mach-omap2/sdrc.c                |    5 +-
 arch/arm/mach-omap2/serial.c              |  437 +++++++++++++++++-
 arch/arm/mach-omap2/sleep24xx.S           |    1 -
 arch/arm/mach-omap2/sleep34xx.S           |  436 ++++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c            |   21 +-
 arch/arm/plat-omap/Kconfig                |    2 +-
 arch/arm/plat-omap/common.c               |    1 -
 arch/arm/plat-omap/include/mach/common.h  |    2 -
 arch/arm/plat-omap/include/mach/control.h |   13 +
 arch/arm/plat-omap/include/mach/irqs.h    |    1 +
 arch/arm/plat-omap/include/mach/pm.h      |  345 --------------
 arch/arm/plat-omap/include/mach/serial.h  |    9 +
 arch/arm/plat-omap/include/mach/usb.h     |    6 -
 drivers/mtd/onenand/omap2.c               |    1 -
 27 files changed, 2475 insertions(+), 469 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm-debug.c
 create mode 100644 arch/arm/mach-omap2/pm.h
 create mode 100644 arch/arm/mach-omap2/pm24xx.c
 create mode 100644 arch/arm/mach-omap2/pm34xx.c
 create mode 100644 arch/arm/mach-omap2/sleep34xx.S
 delete mode 100644 arch/arm/plat-omap/include/mach/pm.h

