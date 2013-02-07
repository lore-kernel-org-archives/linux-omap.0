From: Philip Avinash <avinashphilip@ti.com>
Subject: [PATCH v2 0/4] suspend/resume support for OMAP nand driver
Date: Thu, 7 Feb 2013 18:06:54 +0530
Message-ID: <1360240618-11094-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@ti.com, tony@atomide.com, linux@arm.linux.org.uk, dwmw2@infradead.org, artem.bityutskiy@linux.intel.com
Cc: afzal@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, hvaibhav@ti.com, Philip Avinash <avinashphilip@ti.com>
List-Id: linux-omap@vger.kernel.org

This patch series adds low power transition support for OMAP NAND driver.
With recent driver conversion of GPMC to platform_driver, pm_runtime calls
can be used to handle module enable & disable of GPMC. This is taken care
patch #1.

patch #2 is for GPMC suspend/resume support.

This includes low power transition support of
- GPMC module
- ELM module
- OMAP2 NAND driver

User initiated suspend/resume sequence tested on am335x-evm with NAND
flash support. Also tested in omap3-evm for user initiated
suspend/resume sequence with NAND flash.
This patch series based on [1] and is present in [2].

1. ARM: OMAP2+: AM33XX: Add suspend-resume support
   http://comments.gmane.org/gmane.linux.ports.arm.omap/91405
2. https://github.com/avinashphilip/am335x_linux/commits/NAND_supend_resume_support


Philip Avinash (4):
  arm: gpmc: Converts GPMC driver to pm_runtime capable
  arm: gpmc: Low power transition support
  mtd: devices: elm: Low power transition support
  mtd: nand: omap2: Low power transition support

 arch/arm/mach-omap2/gpmc.c |   30 +++++++++++++++++++++++++++---
 drivers/mtd/devices/elm.c  |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/mtd/nand/omap2.c   |   19 +++++++++++++++++++
 3 files changed, 86 insertions(+), 3 deletions(-)

-- 
1.7.9.5
