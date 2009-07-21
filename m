From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/14] OMAP PM fixes for .31-rc series
Date: Tue, 21 Jul 2009 15:08:26 -0700
Message-ID: <1248214120-18886-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:42991 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbZGUWIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Jul 2009 18:08:42 -0400
Received: by pzk42 with SMTP id 42so701151pzk.33
        for <linux-omap@vger.kernel.org>; Tue, 21 Jul 2009 15:08:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Also available here as a v2.6.31-rc3 based branch from:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-upstream/fixes

Eero Nurkkala (1):
  OMAP: PM: CPUfreq: obey min/max settings of policy

Jouni Hogander (1):
  OMAP3: PM: Fix wrong sequence in suspend.

Kevin Hilman (11):
  OMAP2/3: PM: make PM __init calls static
  OMAP3: PM: CM_REGADDR macros using wrong name
  OMAP3: PM: Ensure PRCM interrupts are cleared at boot
  OMAP3: PM: Clear pending PRCM reset flags on init
  OMAP3: PM: prevent module wakeups from waking IVA2
  OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
  OMAP4: UART: cleanup special case IRQ handling
  OMAP2/3/4: UART: Allow per-UART disabling wakeup for serial ports
  OMAP2/3/4: UART: allow in-order port traversal
  OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask
  OMAP3: Overo: add missing pen-down GPIO definition

Tero Kristo (1):
  OMAP3: Fixed crash bug with serial + suspend

 arch/arm/mach-omap2/board-overo.c        |    1 +
 arch/arm/mach-omap2/cm.h                 |    6 +-
 arch/arm/mach-omap2/pm.h                 |    3 -
 arch/arm/mach-omap2/pm24xx.c             |    2 +-
 arch/arm/mach-omap2/pm34xx.c             |   51 +++++++-
 arch/arm/mach-omap2/serial.c             |  197 ++++++++++++++++++++----------
 arch/arm/plat-omap/cpu-omap.c            |    8 +-
 arch/arm/plat-omap/gpio.c                |    6 +
 arch/arm/plat-omap/include/mach/serial.h |    1 +
 9 files changed, 197 insertions(+), 78 deletions(-)

