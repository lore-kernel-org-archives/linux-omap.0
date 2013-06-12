From: Pekon Gupta <pekon@ti.com>
Subject: [v4 0/3] suspend/resume support for OMAP nand driver
Date: Wed, 12 Jun 2013 15:55:05 +0530
Message-ID: <1371032708-9242-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45451 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab3FLKZk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Jun 2013 06:25:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
Cc: Pekon Gupta <pekon@ti.com>

This patch series adds low power transition support for OMAP NAND driver.
[Patch 1/3]: Adds pm_runtime calls to handle GPMC module probe and remove
[Patch 2/3]: Adds GPMC suspend/resume support.
[Patch 3/3]: Adds ELM suspend/resume support.

Tested on am335x-evm with NAND flash support, using following:
	echo devices 	> /sys/power/pm_test
	echo mem	> /sys/power/state

	echo core	> /sys/power/pm_test
	echo mem	> /sys/power/state

Changes Since v3:
- CONFIG_PM -> CONFIG_PM_SLEEP
- using struct dev_pm_ops via driver->pm, instead of struct platform_driver
- rebased to 3.10-rc5

Changes Since v2:
- Remove calll back of nand_suspend from omap2 nand driver, as the same call
  already done from suspend activity mtd class driver.

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/91405


avinash philip (3):
  arm: gpmc: Converts GPMC driver to pm_runtime capable
  arm: gpmc: Low power transition support
  mtd: devices: elm: Low power transition support

 arch/arm/mach-omap2/gpmc.c | 27 +++++++++++++++++++++++++--
 drivers/mtd/devices/elm.c  | 19 +++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

-- 
1.8.1

