From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/21] OMAP: update PM infrastructure
Date: Wed,  4 Feb 2009 18:05:46 -0800
Message-ID: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f21.google.com ([209.85.217.21]:64350 "EHLO
	mail-gx0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbZBECGN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:06:13 -0500
Received: by gxk14 with SMTP id 14so2466369gxk.13
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:06:11 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Here is a first pass at updating the core PM code for OMAP.
High-level summary of this series:

- sync up PM core code from linux-omap
- updated PM debug infrastructure
- UART idle and off-mode support for PM development using serial console

Applies on top of the recent OMAP clock framework series from
Paul Walmsley.

Tested on 3430SDP and Beagle and am able to hit full-chip retention in
idle and in suspend.

This series is also available in the 'staging/pm-upstream' branch of
my linux-omap-pm git tree[1]

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
--

Jouni Hogander (2):
  OMAP: Add new function to check wether there is irq pending
  OMAP: UART: Add sysfs interface for adjusting UART sleep timeout

Kalle Jokiniemi (1):
  OMAP3: PM: SmartReflex driver integration

Kevin Hilman (8):
  OMAP2/3: PM: push core PM code from linux-omap
  OMAP: Kconfig: move GP timer selection alongside other timer options
  OMAP: dmtimer: enable all timers to be wakeup events
  OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
  OMAP3: PM: UART: disable clocks when idle and off-mode support
  OMAP3: PM: Force IVA2 into idle during bootup
  OMAP3: PM: Add D2D clocks and auto-idle setup to PRCM init
  OMAP3: PM: D2D clockdomain supports SW supervised transitions

Peter 'p2' De Schrijver (8):
  OMAP: PM counter infrastructure.
  OMAP: PM: Hook into PM counters
  OMAP: PM: Add closures to clkdm_for_each and pwrdm_for_each.
  OMAP: PM: Add pm-debug counters
  OMAP: PM debug: make powerdomains use PM-debug counters
  OMAP: PM: Add definitions for ETK pads and observability registers
  OMAP: Debug observability and ETK padconf implementation
  OMAP: Add debug observablity (debobs) Kconfig item

Tero Kristo (2):
  OMAP: PM debug: do not print out status for meta powerdomains (dpll*)
  OMAP: PM debug: Add PRCM register dump support

 arch/arm/mach-omap2/Kconfig                   |    2 +-
 arch/arm/mach-omap2/Makefile                  |    7 +
 arch/arm/mach-omap2/clock.c                   |    2 +
 arch/arm/mach-omap2/clock34xx.h               |   38 ++-
 arch/arm/mach-omap2/clockdomain.c             |   10 +-
 arch/arm/mach-omap2/clockdomains.h            |    2 +-
 arch/arm/mach-omap2/cm-regbits-34xx.h         |   14 +
 arch/arm/mach-omap2/debobs.c                  |  239 ++++++++
 arch/arm/mach-omap2/irq.c                     |   17 +-
 arch/arm/mach-omap2/pm-debug.c                |  539 +++++++++++++++++
 arch/arm/mach-omap2/pm.c                      |  154 +++---
 arch/arm/mach-omap2/pm.h                      |   40 ++
 arch/arm/mach-omap2/pm24xx.c                  |  559 ++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c                  |  763 +++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.c             |  110 ++++-
 arch/arm/mach-omap2/prcm-common.h             |    2 +
 arch/arm/mach-omap2/prm-regbits-34xx.h        |   20 +-
 arch/arm/mach-omap2/serial.c                  |  431 +++++++++++++-
 arch/arm/mach-omap2/sleep34xx.S               |  544 ++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.c             |  762 ++++++++++++++++++++++++
 arch/arm/mach-omap2/smartreflex.h             |  259 +++++++++
 arch/arm/plat-omap/Kconfig                    |   53 ++
 arch/arm/plat-omap/dmtimer.c                  |    6 +-
 arch/arm/plat-omap/include/mach/clockdomain.h |    3 +-
 arch/arm/plat-omap/include/mach/common.h      |    2 -
 arch/arm/plat-omap/include/mach/control.h     |   74 +++-
 arch/arm/plat-omap/include/mach/debobs.h      |    7 +
 arch/arm/plat-omap/include/mach/irqs.h        |    1 +
 arch/arm/plat-omap/include/mach/omap34xx.h    |    3 +-
 arch/arm/plat-omap/include/mach/pm.h          |   77 +--
 arch/arm/plat-omap/include/mach/powerdomain.h |   15 +-
 arch/arm/plat-omap/include/mach/serial.h      |    9 +
 include/linux/serial_reg.h                    |    1 +
 33 files changed, 4570 insertions(+), 195 deletions(-)
 create mode 100644 arch/arm/mach-omap2/debobs.c
 create mode 100755 arch/arm/mach-omap2/pm-debug.c
 create mode 100755 arch/arm/mach-omap2/pm.h
 create mode 100644 arch/arm/mach-omap2/pm24xx.c
 create mode 100644 arch/arm/mach-omap2/pm34xx.c
 create mode 100644 arch/arm/mach-omap2/sleep34xx.S
 create mode 100644 arch/arm/mach-omap2/smartreflex.c
 create mode 100644 arch/arm/mach-omap2/smartreflex.h
 create mode 100644 arch/arm/plat-omap/include/mach/debobs.h

