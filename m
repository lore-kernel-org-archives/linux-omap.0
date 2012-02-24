From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 0/6] Fix issues around twl4030-gpio used as a module
Date: Fri, 24 Feb 2012 15:28:51 +0530
Message-ID: <1330077537-19618-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60381 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792Ab2BXJ7I (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Feb 2012 04:59:08 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Hi Tony,

This series is based on top of 'hsmmc' branch in linux-omap
on top of commit '0e91c8ddf0e0932da59ec1d116e34049791b0e73' as
requested by you.

This mainly splits omap_hsmmc_late_init() into omap_hsmmc_deferred_add()
and omap_hsmmc_deferred_del() and adds .teardown hooks in all omap3 boards
to handle issues around multiple twl4030-gpio module insmod/unbind/bind
as reported by Russell.

In the process this series adds an api to unregister an
omap_device, makes mmc driver work with hotpluggable devices
and also removes 'deferred' flag for a few mmc devices on some
boards which are not really dependent on twl4030-gpio for card
detect as reported by Igor.

I have tested this series on omap3 beagle, with twl4030-gpio built
in, as well as twl4030-gpio built as a module and by doing multiple
insmod/unbind/bind sequence. I have tested card-detect to work fine
on beagle too.

regards,
Rajendra

Rajendra Nayak (6):
  ARM: OMAP: omap_device: Add omap_device_unregister()
  mmc: omap_hsmmc: Make the driver support hotpluggable devices
  mmc: omap_hsmmc: If probe fails, give our error messages
  ARM: OMAP3: Make only mmc devices using gpio_cd as deferred
  ARM: OMAP3: Modify omap_hsmmc_late_init to handle deleting mmc
    devices
  ARM: OMAP3: Use .teardown of twl4030-gpio to clean board requests

 arch/arm/mach-omap2/board-3430sdp.c           |   15 ++++-
 arch/arm/mach-omap2/board-cm-t35.c            |   15 ++++-
 arch/arm/mach-omap2/board-devkit8000.c        |   15 ++++-
 arch/arm/mach-omap2/board-igep0020.c          |   18 ++++-
 arch/arm/mach-omap2/board-ldp.c               |   13 ++++
 arch/arm/mach-omap2/board-omap3beagle.c       |   17 ++++-
 arch/arm/mach-omap2/board-omap3evm.c          |   16 ++++-
 arch/arm/mach-omap2/board-omap3pandora.c      |   14 +++-
 arch/arm/mach-omap2/board-omap3stalker.c      |   16 ++++-
 arch/arm/mach-omap2/board-omap3touchbook.c    |   15 ++++-
 arch/arm/mach-omap2/board-overo.c             |   11 +++-
 arch/arm/mach-omap2/board-rx51-peripherals.c  |   11 +++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   14 +++-
 arch/arm/mach-omap2/hsmmc.c                   |   93 ++++++++++++-------------
 arch/arm/mach-omap2/hsmmc.h                   |    9 ++-
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/omap_device.c              |   20 +++++-
 drivers/mmc/host/omap_hsmmc.c                 |   11 ++--
 18 files changed, 249 insertions(+), 75 deletions(-)

