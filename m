From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 00/12] mfd: twl: Fix for irqdomain/next + SPARSE_IRQ + MMC card detect
Date: Fri, 2 Mar 2012 17:50:12 +0100
Message-ID: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60572 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2CBQue (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 11:50:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Samuel and Tony,

Here is a fix + cleanup + SPARSE_IRQ series for TWL4030 and TWL6030.

The first goal was to fix the current regression due to irqdomain
support inside twl-core for OMAP3 + twl4030.

The issue is that there is no quick and dirty fix for that, hence this
exhaustive series started by Felipe to add SPARSE_IRQ support for TWL
modules.

On top of that a bunch of code cleanup are done, and in order to make
the MMC card detect still operational, some fixes are needed in the
board file too.

Due to the modification in the SIH setup API, the twl4030-gpio driver
has to be updated as well.

It was then trivial to add some basic device tree support for the
twl4030-gpio driver.

Please note that this series does depend on the irqdomain/next series
from Grant.

These patches will be probably sent in separate pull request. The only
strong dependency is with the irqdomain series.

This series is available here for reference:
  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/twl_irq_gpio_cleanup

This is not for pull-request, becasue it is based on irqdomain + OMAP
IRQ DT series + OMAP twl DT series yet to be pushed.

Regards,
Benoit


Benoit Cousson (9):
  mfd: twl-core: Remove references already defined in header file
  mfd: twl-core: Move IRQ allocation into twl[4030|6030]-irq files
  mfd: twl4030-irq: Make SIH SPARSE_IRQ capable
  mfd: twl-*: Change from pr_XXX to dev_XXX macros and various cleanups
  gpio/twl: Allocate irq_desc dynamically for SPARSE_IRQ support
  gpio/twl: Add DT support to gpio-twl4030 driver
  arm/dts: twl4030: Add twl4030-gpio node
  mfd: twl4030-irq: Return twl6030_mmc_card_detect IRQ for board setup
  ARM: OMAP2+: board-omap4-*: Do not use anymore TWL6030_IRQ_BASE in board files

Felipe Balbi (3):
  mfd: twl-core: don't depend on pdata->irq_base/end
  mfd: twl-core: remove unneeded header
  mfd: twl4030-irq: micro-optimization on IRQ handler

 .../devicetree/bindings/gpio/gpio-twl4030.txt      |   23 ++++
 arch/arm/boot/dts/twl4030.dtsi                     |    8 ++
 arch/arm/mach-omap2/board-4430sdp.c                |   13 ++-
 arch/arm/mach-omap2/board-omap4panda.c             |   15 ++--
 drivers/gpio/gpio-twl4030.c                        |  111 ++++++++++++--------
 drivers/mfd/twl-core.c                             |   99 +++++++-----------
 drivers/mfd/twl-core.h                             |    4 +-
 drivers/mfd/twl4030-irq.c                          |   87 +++++++++-------
 drivers/mfd/twl6030-irq.c                          |   71 ++++++++-----
 include/linux/i2c/twl.h                            |    2 +-
 10 files changed, 247 insertions(+), 186 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-twl4030.txt

