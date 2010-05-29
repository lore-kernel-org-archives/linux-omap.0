From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2] omap: Stalker board: switch over to gpio_set_debounce
Date: Sat, 29 May 2010 11:34:07 +0530
Message-ID: <1275113047-14486-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55879 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635Ab0E2GES (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 May 2010 02:04:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>

With latest linus's tip, omap3_defconfig is broken.
 
 LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/arm/mach-omap2/built-in.o: In function `ads7846_dev_init':
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:542: undefined reference to `omap_set_gpio_debounce'
linux-2.6/arch/arm/mach-omap2/board-omap3stalker.c:543: undefined reference to `omap_set_gpio_debounce_time'
make: *** [.tmp_vmlinux1] Error 1

>From the commit 48feb337475a ( arm: omap: switch over to gpio_set_debounce),
board-omap3stalker.c seems to be missed out or got merged later.
The patch was to remove omap-specific implementations for gpio debouncing 
in favor of gpiolib function.

Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
Updated the subject and changelog as suggested by Kevin Hilman

 arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index f848ba8..a04cffd 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -538,9 +538,7 @@ static void ads7846_dev_init(void)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
 
 	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
-
-	omap_set_gpio_debounce(OMAP3_STALKER_TS_GPIO, 1);
-	omap_set_gpio_debounce_time(OMAP3_STALKER_TS_GPIO, 0xa);
+	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
 }
 
 static int ads7846_get_pendown_state(void)
-- 
1.6.0.4

