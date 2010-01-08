From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 00/13] OMAP PM fixes for 2.6.33-rc
Date: Fri,  8 Jan 2010 09:59:18 -0800
Message-ID: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:51031 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab0AHR7e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:34 -0500
Received: by pxi4 with SMTP id 4so2222956pxi.33
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:33 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here's a set of fixes from the OMAP PM brach intended for 2.6.33-rc.
This series applies on top Tony's omap-fixes-for-linus branch.

They can be also viewed/pulled from:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-fixes

Kevin Hilman (1):
  OMAP: timekeeping: time should not stop during suspend

Manjunatha GK (1):
  OMAP3: PM debug: fix build error when !CONFIG_DEBUG_FS

Peter Ujfalusi (1):
  OMAP3: PM: Enable wake-up from McBSP2, 3 and 4 modules

Roel Kluin (1):
  OMAP: omap3_pm_get_suspend_state() error ignored in
    pwrdm_suspend_get()

Sanjeev Premi (1):
  OMAP3: PM: Remove duplicate code blocks

Sripathy, Vishwanath (1):
  OMAP3: PM: Removing redundant and potentially dangerous PRCM
    configration

Tero Kristo (7):
  OMAP2/3: DMTIMER: Clear pending interrupts when stopping a timer
  OMAP3: PM: Ack pending interrupts before entering suspend
  OMAP3: PM: Enable system control module autoidle
  OMAP3: PM: Disable interrupt controller AUTOIDLE before WFI
  OMAP3: CPUidle: Fixed timer resolution
  OMAP3: Fixed ARM aux ctrl register save/restore
  OMAP3: PM: Force write last pad config register into save area

 arch/arm/mach-omap2/cpuidle34xx.c      |    2 +-
 arch/arm/mach-omap2/irq.c              |   18 +++++++++++++
 arch/arm/mach-omap2/pm-debug.c         |    8 +++---
 arch/arm/mach-omap2/pm.h               |    8 ++++-
 arch/arm/mach-omap2/pm34xx.c           |   43 ++++++++++++++++---------------
 arch/arm/mach-omap2/prcm.c             |   11 --------
 arch/arm/mach-omap2/sleep34xx.S        |   13 ++++++---
 arch/arm/plat-omap/common.c            |   26 +++++++++++++++++++
 arch/arm/plat-omap/dmtimer.c           |   10 +++++++
 arch/arm/plat-omap/include/plat/irqs.h |    3 ++
 10 files changed, 99 insertions(+), 43 deletions(-)

