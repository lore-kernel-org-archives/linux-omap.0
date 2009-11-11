From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT] pull request: PM off-mode for 2.6.33
Date: Wed, 11 Nov 2009 15:01:30 -0800
Message-ID: <877htw1x9x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51241 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759543AbZKKXB1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:01:27 -0500
Received: by yxe17 with SMTP id 17so1432686yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:01:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony,

Here's a pull request for the PM off-mode support already reviewed on
the list.

Kevin


The following changes since commit 774facda20d2f8f0f61fa312d8028dad18ac5ee4:
  Tony Lindgren (1):
        Merge branch '7xx-iosplit-plat' with omap-fixes

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-upstream/pm-off

Aaro Koskinen (2):
      OMAP: PM: Clear DMA channel state after a wakeup
      OMAP3: PM: Fix INTC context save/restore

Jouni Hogander (1):
      OMAP3: PM: Save and restore also CM_CLKSEL1_PLL_IVA2

Juha Yrjola (1):
      OMAP: Store reboot mode in scratchpad on OMAP34xx

Kalle Jokiniemi (5):
      OMAP3: PM: Fix secure SRAM context save/restore
      ARM: OMAP: SMS: save/restore of SMS_SYSCONFIG for off-mode
      OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
      PM: Disable usb host HW save and restore
      OMAP3: PM: Enable IO-CHAIN wakeup

Kevin Hilman (3):
      OMAP3: PM debug: allow runtime toggle of PM features
      PM debug: allow configurable wakeup from suspend on OMAP GPtimer
      OMAP3: PM: decouple PER and CORE context save and restore

Peter 'p2' De Schrijver (1):
      OMAP3: PM: Wait for SDRC ready iso a blind delay

Rajendra Nayak (12):
      OMAP3: PM: GPMC context save/restore
      OMAP3: PM: GPIO context save/restore
      OMAP3: PM: INTC context save/restore
      OMAP3: PM: PRCM context save/restore
      OMAP3: PM: Populate scratchpad contents
      OMAP3: PM: SCM context save/restore
      OMAP3: PM: restore SRAM functions after off-mode.
      OMAP3: PM: handle PER/NEON/CORE in idle
      OMAP3: PM: Restore MMU table entry
      OMAP3: PM: MPU off-mode support
      OMAP3: PM: CORE domain off-mode support
      OMAP3: PM: Program SDRC to send self refresh on timeout of AUTO_CNT

Tero Kristo (7):
      OMAP: PM: DMA context save/restore for off-mode support
      OMAP3 PM: off-mode support for HS/EMU devices
      OMAP3: PM: save secure RAM only during init
      OMAP3: PM: Enable SDRAM auto-refresh during sleep
      OMAP3: PM: SDRC auto-refresh workaround for off-mode
      OMAP3: PM: Prevent PER from going OFF when CORE is going INA
      OMAP3: PM: MPU and CORE should stay awake if there is CAM domain ACTIVE

 arch/arm/mach-omap2/control.c             |  381 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/gpmc.c                |   98 +++++++-
 arch/arm/mach-omap2/irq.c                 |   66 +++++
 arch/arm/mach-omap2/pm-debug.c            |   29 ++
 arch/arm/mach-omap2/pm.h                  |   10 +
 arch/arm/mach-omap2/pm34xx.c              |  362 +++++++++++++++++++++++++-
 arch/arm/mach-omap2/powerdomains34xx.h    |    8 +-
 arch/arm/mach-omap2/prcm.c                |  407 ++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm-regbits-34xx.h    |    2 +
 arch/arm/mach-omap2/sdrc.c                |   27 ++
 arch/arm/mach-omap2/serial.c              |    2 -
 arch/arm/mach-omap2/sleep34xx.S           |  218 ++++++++++++++--
 arch/arm/mach-omap2/timer-gp.c            |    2 +
 arch/arm/plat-omap/dma.c                  |   48 ++++-
 arch/arm/plat-omap/gpio.c                 |   92 +++++++
 arch/arm/plat-omap/include/plat/control.h |   62 +++++-
 arch/arm/plat-omap/include/plat/dma.h     |    5 +
 arch/arm/plat-omap/include/plat/gpio.h    |    3 +-
 arch/arm/plat-omap/include/plat/gpmc.h    |    3 +
 arch/arm/plat-omap/include/plat/irqs.h    |    5 +
 arch/arm/plat-omap/include/plat/prcm.h    |    6 +-
 arch/arm/plat-omap/include/plat/sdrc.h    |    8 +
 arch/arm/plat-omap/include/plat/sram.h    |    7 +
 arch/arm/plat-omap/sram.c                 |    8 +-
 24 files changed, 1809 insertions(+), 50 deletions(-)
