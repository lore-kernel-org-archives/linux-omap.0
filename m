From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/7] omap hsmmc init cleanup and section warning fixes for v3.4 merge window
Date: Thu, 23 Feb 2012 17:10:40 +0530
Message-ID: <1329997247-27342-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42579 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab2BWLk4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 06:40:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Re-sending as these patches did not make it to the lists due to
issues with my 'git send-email'

Hi Tony,

This is a re-spin of your series to fix up the section
mismatch warnings noted by Russell with omap2_hsmmc_init().
The previous series had an issue around multiple insmod/rmmod
of the twl4030 gpio driver when built as a module as reported
by Russell again.

There were 2 issues, one with gpio_requests failing as they were
never freed on the module unload/unbind. The other was with the
mmc devices being registered again. I have fixed both these issues
in this series, mainly by having a .teardown hook for twl4030 gpio
driver populated from all OMAP3 board files, which release all the
requested gpios and also unregister the mmc omap/platform device.

regards,
Rajendra

Ohad Ben-Cohen (1):
  ARM: OMAP: omap_device: Expose omap_device_{alloc, delete, register}

Rajendra Nayak (4):
  ARM: OMAP: omap_device: Add omap_device_unregister()
  mmc: omap_hsmmc: Make the driver support hotpluggable devices
  mmc: omap_hsmmc: If probe fails, give our error messages
  ARM: OMAP3: Use .teardown of twl4030-gpio to clean board requests

Tony Lindgren (2):
  ARM: OMAP2+: Split omap2_hsmmc_init() to properly support I2C GPIO
    pins
  ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux related functions as
    __init

 arch/arm/mach-omap2/board-2430sdp.c           |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c           |   22 +++-
 arch/arm/mach-omap2/board-4430sdp.c           |    4 +-
 arch/arm/mach-omap2/board-am3517evm.c         |    2 +-
 arch/arm/mach-omap2/board-cm-t35.c            |   18 +++-
 arch/arm/mach-omap2/board-devkit8000.c        |   17 +++-
 arch/arm/mach-omap2/board-flash.c             |    2 +-
 arch/arm/mach-omap2/board-igep0020.c          |   25 ++++-
 arch/arm/mach-omap2/board-ldp.c               |   11 ++-
 arch/arm/mach-omap2/board-omap3beagle.c       |   25 ++++-
 arch/arm/mach-omap2/board-omap3evm.c          |   22 +++-
 arch/arm/mach-omap2/board-omap3logic.c        |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c      |   22 +++-
 arch/arm/mach-omap2/board-omap3stalker.c      |   28 ++++--
 arch/arm/mach-omap2/board-omap3touchbook.c    |   30 ++++--
 arch/arm/mach-omap2/board-omap4panda.c        |    6 +-
 arch/arm/mach-omap2/board-overo.c             |   13 +++-
 arch/arm/mach-omap2/board-rm680.c             |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c  |   10 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   18 +++-
 arch/arm/mach-omap2/display.c                 |    8 +-
 arch/arm/mach-omap2/hsmmc.c                   |  130 +++++++++++++++++++------
 arch/arm/mach-omap2/hsmmc.h                   |   17 +++-
 arch/arm/mach-omap2/mux.c                     |   14 ++--
 arch/arm/plat-omap/include/plat/omap_device.h |    8 ++
 arch/arm/plat-omap/omap_device.c              |   33 ++++---
 drivers/mmc/host/omap_hsmmc.c                 |   11 +-
 27 files changed, 372 insertions(+), 130 deletions(-)

