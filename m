From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/11] OMAP fixes from PM branch for .31-rc
Date: Thu, 25 Jun 2009 09:41:53 -0700
Message-ID: <1245948124-24111-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f190.google.com ([209.85.216.190]:49012 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403AbZFYQmM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 12:42:12 -0400
Received: by pxi28 with SMTP id 28so1148479pxi.33
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 09:42:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

This series is a set of fixes/cleanups from the PM branch targeted for
the .31-rc series.

Applies on top of 'omap-fixes' branch of linux-omap.

Kevin Hilman (9):
  OMAP2/3: PM: make PM __init calls static
  OMAP3: PM: CM_REGADDR macros using wrong name
  OMAP3: PM: Ensure PRCM interrupts are cleared at boot
  OMAP3: PM: Clear pending PRCM reset flags on init
  OMAP3: PM: prevent module wakeups from waking IVA2
  OMAP3: PM: Do not build suspend code if SUSPEND is not enabled
  OMAP3: PM: reset USB OTG module on boot
  OMAP4: UART: cleanup special case IRQ handling
  OMAP2/3/4: UART: Allow per-UART disabling wakeup for serial ports

Tero Kristo (2):
  OMAP: SDRC: Add several new register definitions
  OMAP3: Fixed crash bug with serial + suspend

 arch/arm/mach-omap2/cm.h                 |    6 +-
 arch/arm/mach-omap2/pm.h                 |    3 -
 arch/arm/mach-omap2/pm24xx.c             |    2 +-
 arch/arm/mach-omap2/pm34xx.c             |   49 +++++++-
 arch/arm/mach-omap2/serial.c             |  195 ++++++++++++++++++++----------
 arch/arm/mach-omap2/usb-musb.c           |   22 +++-
 arch/arm/plat-omap/include/mach/sdrc.h   |   13 ++
 arch/arm/plat-omap/include/mach/serial.h |    1 +
 8 files changed, 215 insertions(+), 76 deletions(-)

