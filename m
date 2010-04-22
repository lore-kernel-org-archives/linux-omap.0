From: Charulatha V <charu@ti.com>
Subject: [PATCH 00/09] OMAP:GPIO:Implement GPIO in HWMOD way
Date: Thu, 22 Apr 2010 21:25:11 +0530
Message-ID: <1271951720-21714-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34502 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755910Ab0DVPzX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 11:55:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch series implements GPIO as an early platform driver.
It makes OMAP2PLUS specific GPIO to get adapted to HWMOD FW.
OMAP1 specific GPIO is implemented as early platform device.

This patch series is created on "origin/pm-wip/hwmods". In addition,
the following patches are required to avoid compilation and
boottime errors:
1. i2c-omap: Fix reg_shift init (by Tony Lindgren)
2. OMAP:GPIO:hwmod: Fix mmc compile errors (by Charulatha V)
3. OMAP: DSS2: VRAM: Fix early_param for vram (by Thomas Weber)

This patch series is tested on OMAP3430 SDP board. It would be of
great help if someone could test the same on OMAP1 and OMAP2 boards.

Charulatha V (9):
  OMAP:GPIO: Modify init() in preparation for platform device
    implementation
  OMAP:GPIO: Introduce support for OMAP15xx chip specific GPIO
  OMAP:GPIO: Introduce support for OMAP16xx chip specific GPIO
  OMAP:GPIO: Introduce support for OMAP7xx chip specific GPIO
  OMAP:GPIO: Introduce support for OMAP2PLUS chip specific GPIO
  OMAP:GPIO:hwmod: add GPIO hwmods for OMAP3
  OMAP:GPIO:hwmod: add GPIO hwmods for OMAP2420
  OMAP:GPIO:hwmod: add GPIO hwmods for OMAP2430
  OMAP:GPIO: Implement GPIO as a platform device

 arch/arm/mach-omap1/Makefile               |    6 +
 arch/arm/mach-omap1/clock_data.c           |    2 +-
 arch/arm/mach-omap1/gpio15xx.c             |  102 +++++
 arch/arm/mach-omap1/gpio16xx.c             |  196 +++++++++
 arch/arm/mach-omap1/gpio7xx.c              |  258 +++++++++++
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/clock2420_data.c       |   10 +-
 arch/arm/mach-omap2/clock2430_data.c       |   14 +-
 arch/arm/mach-omap2/clock3xxx_data.c       |   24 +-
 arch/arm/mach-omap2/clock44xx_data.c       |   24 +-
 arch/arm/mach-omap2/gpio.c                 |  101 +++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |  215 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |  262 ++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  346 +++++++++++++++-
 arch/arm/plat-omap/gpio.c                  |  640 +++++++++++-----------------
 arch/arm/plat-omap/include/plat/gpio.h     |   89 ++++-
 16 files changed, 1863 insertions(+), 428 deletions(-)
 create mode 100644 arch/arm/mach-omap1/gpio15xx.c
 create mode 100644 arch/arm/mach-omap1/gpio16xx.c
 create mode 100644 arch/arm/mach-omap1/gpio7xx.c
 create mode 100644 arch/arm/mach-omap2/gpio.c

