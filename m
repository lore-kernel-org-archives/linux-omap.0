From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v5 0/3] suspend/resume support for OMAP nand driver
Date: Tue, 18 Jun 2013 00:16:36 +0530
Message-ID: <1371494799-11876-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51831 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab3FQSrT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jun 2013 14:47:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@linaro.org, Pekon Gupta <pekon@ti.com>

This patch series adds runtime PM support (specifically suspend/resume) 
for GPMC and ELM drivers.
[Patch 1/3]: Adds pm_runtime calls to handle GPMC module probe and remove
[Patch 2/3]: Adds GPMC suspend/resume support.
[Patch 3/3]: Adds ELM suspend/resume support.

Tested on am335x-evm with NAND flash support, using following:
	echo devices 	> /sys/power/pm_test
	echo mem	> /sys/power/state

	echo core	> /sys/power/pm_test
	echo mem	> /sys/power/state

Changes since v4:
- added save/restore to ELM suspend/resume
- removed #ifdef CONFIG_ARCH_OMAP3
- updated changelog to be more descriptive

Changes Since v3:
- CONFIG_PM -> CONFIG_PM_SLEEP
- using struct dev_pm_ops via driver->pm, instead of struct platform_driver
- rebased to 3.10-rc5

Changes Since v2:
- Remove calll back of nand_suspend from omap2 nand driver, as the same call
  already done from suspend activity mtd class driver.

[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/91405


avinash philip (3):
  ARM: OMAP2+: gpmc: Converts GPMC driver to pm_runtime capable
  arm: gpmc: Low power transition support
  mtd: devices: elm: Low power transition support

 arch/arm/mach-omap2/gpmc.c |  29 +++++++++--
 drivers/mtd/devices/elm.c  | 117 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+), 4 deletions(-)

-- 
1.8.1

