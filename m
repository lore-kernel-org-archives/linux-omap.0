From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 00/12] Omap fixes for 2.6.33-rc3
Date: Wed, 06 Jan 2010 16:18:30 -0800
Message-ID: <20100107001728.21352.38471.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54139 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755569Ab0AGASd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:18:33 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some omap fixes for review.

Regards,

Tony

---

Alexander Shishkin (1):
      omap2/3: make serial_in_override() address the right uart port

Cory Maccarrone (2):
      omap: gpio: Simultaneously requested rising and falling edge
      omap1: Add 7xx clocks and pin muxes for SPI

Janusz Krzysztofik (1):
      omap: McBSP: Fix possible port lockout

Roel Kluin (3):
      omap: &&/|| confusion in iommu_put()
      omap3: add missing parentheses
      omap3: add missing parentheses

Tony Lindgren (3):
      omap: Remove uninitialized warning for gpio.c
      omap1: Fix compile for omap1_bl.c
      omap3: Fix booting if package is uninitialized

Vaibhav Hiremath (1):
      omap3: EVM: Choose OMAP_PACKAGE_CBB

Vimal Singh (1):
      omap2/3: ZOOM: Correcting key mapping for few keys


 arch/arm/mach-omap1/clock_data.c             |    4 ++
 arch/arm/mach-omap1/devices.c                |   35 ++++++++++++++
 arch/arm/mach-omap1/mux.c                    |    8 +++
 arch/arm/mach-omap2/Kconfig                  |    1 
 arch/arm/mach-omap2/board-zoom-peripherals.c |    8 ++-
 arch/arm/mach-omap2/mux.c                    |    6 ++
 arch/arm/mach-omap2/pm34xx.c                 |    4 +-
 arch/arm/mach-omap2/serial.c                 |   12 ++++-
 arch/arm/plat-omap/gpio.c                    |   63 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/board.h      |    1 
 arch/arm/plat-omap/include/plat/control.h    |    2 -
 arch/arm/plat-omap/include/plat/mux.h        |    8 +++
 arch/arm/plat-omap/include/plat/omap7xx.h    |    3 +
 arch/arm/plat-omap/iommu.c                   |    2 -
 arch/arm/plat-omap/mcbsp.c                   |   20 +++++++-
 drivers/video/backlight/omap1_bl.c           |    2 -
 16 files changed, 159 insertions(+), 20 deletions(-)

-- 
Signature
