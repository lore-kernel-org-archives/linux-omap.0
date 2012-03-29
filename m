From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 0/4] ARM: OMAP: boards: changes to support dynamic irq alloc
Date: Thu, 29 Mar 2012 15:31:53 +0530
Message-ID: <1333015317-11866-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35722 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961Ab2C2KCQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Mar 2012 06:02:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: olof@lixom.net, tony@atomide.com, khilman@ti.com, b-cousson@ti.com, grant.likely@secretlab.ca, dmitry.torokhov@gmail.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

These four patches incorporate changes to OMAP1 and OMAP2 platforms
board files whereby older references to OMAP_GPIO_IRQ macro are
now replaced with gpio_to_irq(), thereby getting rid of static
irq references.

Reference: git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git omap/dt
Commit: fde7d9049e55ab85a390be7f415d74c9f62dd0f9

Test info:
OMAP1 Platforms:
Boot test on OMAP1710 H3.

OMAP2PLUS Platforms:
Boot test on OMAP2430SDP, OMAP3430SDP, OMAP3630-ZOOM3, OMAP4430-SDP.

v3:
Avoid accessing devices using device array index. Consider following list:

static struct platform_device *h2_devices[] __initdata = {
        &h2_nor_device,
        &h2_nand_device,
        &h2_smc91x_device,
        &h2_irda_device,
        &h2_kp_device,
        &h2_lcd_device,
};

static void __init h2_init(void)
{
[...]
       h2_devices[2]->resource[1].start = gpio_to_irq(0);
       h2_devices[2]->resource[1].end = gpio_to_irq(0);
[...]
}

The above implementation is immune to failure if someone inserts new device
in the list before h2_smc91x_device. In order to avoid such a problem access
the devices directly like this:

       h2_smc91x_resources[1].start = gpio_to_irq(0);
       h2_smc91x_resources[1].end = gpio_to_irq(0);

Similar change incorporated for all the boards wherever applicable.

v2:
- Modified the patch subjects as per convention.
- Added a new patch to remove OMAP_GPIO_IRQ from ams_delta_serio driver.
- Added a new patch to remove OMAP_GPIO_IRQ macro definition.

Tarun Kanti DebBarma (4):
  ARM: OMAP1: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
  ARM: OMAP2+: boards: Fix OMAP_GPIO_IRQ usage with gpio_to_irq()
  drivers: input: Fix OMAP_GPIO_IRQ with gpio_to_irq() in
    ams_delta_serio_exit()
  ARM: OMAP: Remove OMAP_GPIO_IRQ macro definition

 arch/arm/mach-omap1/board-h2.c               |    8 ++++----
 arch/arm/mach-omap1/board-h3.c               |    9 ++++-----
 arch/arm/mach-omap1/board-htcherald.c        |    6 +++---
 arch/arm/mach-omap1/board-innovator.c        |    4 ++--
 arch/arm/mach-omap1/board-nokia770.c         |    2 +-
 arch/arm/mach-omap1/board-osk.c              |   12 ++++++------
 arch/arm/mach-omap1/board-palmte.c           |    2 +-
 arch/arm/mach-omap1/board-palmtt.c           |    2 +-
 arch/arm/mach-omap1/board-palmz71.c          |    2 +-
 arch/arm/mach-omap1/board-voiceblue.c        |   16 +++++++---------
 arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
 arch/arm/mach-omap2/board-apollon.c          |    4 ++--
 arch/arm/mach-omap2/board-devkit8000.c       |    2 +-
 arch/arm/mach-omap2/board-h4.c               |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ++-
 arch/arm/mach-omap2/board-zoom-debugboard.c  |    3 ++-
 arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++--
 arch/arm/mach-omap2/common-board-devices.c   |    2 +-
 arch/arm/plat-omap/include/plat/gpio.h       |    4 ----
 drivers/input/serio/ams_delta_serio.c        |    2 +-
 23 files changed, 48 insertions(+), 51 deletions(-)

