From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] pm-next: misc. PM updates for 2.6.37
Date: Thu, 23 Sep 2010 17:24:43 -0700
Message-ID: <87iq1wm1is.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:53056 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756232Ab0IXAYs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 20:24:48 -0400
Received: by pzk34 with SMTP id 34so484859pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 17:24:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony,

Please pull the misc PM updates below for 2.6.37.

Note that this pull request should've come before the pm-runtime one
since the pm-runtime branch has some a build dependency on the omap_device
patches in this series.

Thanks,

Kevin


The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:

  Linux 2.6.36-rc5 (2010-09-20 16:56:53 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-next

Benoit Cousson (2):
      OMAP4: hwmod: Add initial data for OMAP4430 ES1 & ES2
      OMAP4: pm: Change l3_main to l3_main_1 during bus device init

Kevin Hilman (5):
      OMAP3: PM: whitespace cleanup around IO wakeup enable
      OMAP3: PM: move device-specific special cases from PM core into CPUidle
      Revert "OMAP: omap_device: add omap_device_is_valid()"
      OMAP: omap_device: make all devices a child of a new parent device
      OMAP: GPIO: ensure debounce clocks are disabled during idle/suspend

Paul Walmsley (1):
      OMAP clockdomain: initialize clockdomain registers when the clockdomain layer starts

Santosh Shilimkar (3):
      omap: pm-debug: Move common debug code to pm-debug.c
      omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
      omap: pm: Move set_pwrdm_state routine to common pm.c

Thara Gopinath (2):
      OMAP: PM debugfs removing OMAP3 hardcodings.
      OMAP4: pm.c extensions for OMAP4 support

 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/clockdomain.c             |  110 +-----
 arch/arm/mach-omap2/cpuidle34xx.c             |   58 +++-
 arch/arm/mach-omap2/io.c                      |    7 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c    |  482 +++++++++++++++++++++++++
 arch/arm/mach-omap2/pm-debug.c                |   42 ++-
 arch/arm/mach-omap2/pm.c                      |   75 ++++-
 arch/arm/mach-omap2/pm.h                      |    4 +-
 arch/arm/mach-omap2/pm34xx.c                  |   99 +-----
 arch/arm/plat-omap/Makefile                   |    2 +-
 arch/arm/plat-omap/gpio.c                     |    6 +-
 arch/arm/plat-omap/include/plat/common.h      |    3 +-
 arch/arm/plat-omap/include/plat/omap_device.h |    4 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    1 +
 arch/arm/plat-omap/omap_device.c              |   32 +-
 15 files changed, 696 insertions(+), 230 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_44xx_data.c
