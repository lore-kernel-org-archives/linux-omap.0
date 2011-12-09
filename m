From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH] ARM: remove header files included more than once
Date: Fri,  9 Dec 2011 10:25:43 -0600
Message-ID: <1323447943-23595-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:46779 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750758Ab1LIQZ5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Dec 2011 11:25:57 -0500
Received: by mail-gy0-f179.google.com with SMTP id g15so2527984ghb.10
        for <linux-omap@vger.kernel.org>; Fri, 09 Dec 2011 08:25:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Jiandong Zheng <jdzheng@broadcom.com>, Scott Branden <sbranden@broadcom.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Eric Miao <eric.y.miao@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>, Paul Walmsley <paul@pwsan.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Simtec Linux Team <linux@simtec.co.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, Daniel Silverstone <dsilvers@simtec.co.uk>, Stephen Boyd <sboyd@codeaurora.org>, Krzysztof Halasa <khc@pm.waw.pl>, Lei Wen <leiwen@marvell.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

checkincludes.pl complains about these:
	linux/debugfs.h
	linux/dma-mapping.h
	linux/gpio.h
	linux/sched.h
	linux/slab.h
	plat/common.h
	plat/i2c.h

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-bcmring/dma.c                 |    1 -
 arch/arm/mach-ks8695/leds.c                 |    1 -
 arch/arm/mach-mmp/aspenite.c                |    1 -
 arch/arm/mach-mmp/tavorevb.c                |    1 -
 arch/arm/mach-msm/board-msm7x30.c           |    1 -
 arch/arm/mach-msm/board-qsd8x50.c           |    1 -
 arch/arm/mach-omap2/board-ldp.c             |    1 -
 arch/arm/mach-omap2/io.c                    |    1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c  |    1 -
 arch/arm/mach-pxa/pxa25x.c                  |    1 -
 arch/arm/mach-pxa/pxa27x.c                  |    1 -
 arch/arm/mach-pxa/saarb.c                   |    1 -
 arch/arm/mach-shmobile/board-ag5evm.c       |    1 -
 arch/arm/mach-ux500/board-mop500-u8500uib.c |    1 -
 arch/arm/plat-omap/clock.c                  |    1 -
 arch/arm/plat-samsung/dev-backlight.c       |    1 -
 16 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index f4d4d6d..b52b8de 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -36,7 +36,6 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/atomic.h>
-#include <linux/sched.h>
 #include <mach/dma.h>
 
 /* I don't quite understand why dc4 fails when this is set to 1 and DMA is enabled */
diff --git a/arch/arm/mach-ks8695/leds.c b/arch/arm/mach-ks8695/leds.c
index d6f6502..4bd7075 100644
--- a/arch/arm/mach-ks8695/leds.c
+++ b/arch/arm/mach-ks8695/leds.c
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/gpio.h>
 
 #include <asm/leds.h>
 #include <mach/devices.h>
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 7a60bbb..2b3b0c6 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -17,7 +17,6 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-mmp/tavorevb.c b/arch/arm/mach-mmp/tavorevb.c
index eb5be87..143e52e 100644
--- a/arch/arm/mach-mmp/tavorevb.c
+++ b/arch/arm/mach-mmp/tavorevb.c
@@ -12,7 +12,6 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
-#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
index db81ed5..8a941bb 100644
--- a/arch/arm/mach-msm/board-msm7x30.c
+++ b/arch/arm/mach-msm/board-msm7x30.c
@@ -14,7 +14,6 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 7e8909c..d82a73e 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -14,7 +14,6 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e179da0..eed5c78 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -10,7 +10,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 25d20ce..cf25a60 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -43,7 +43,6 @@
 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
-#include <plat/common.h>
 
 /*
  * The machine specific code may provide the extra mapping besides the
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index daaf165..5f78e90 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,7 +22,6 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
-#include <plat/i2c.h>
 #include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index f05f948..f6ef67f 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -24,7 +24,6 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/irq.h>
-#include <linux/gpio.h>
 
 #include <asm/mach/map.h>
 #include <asm/suspend.h>
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index bc5a98e..2dd93e9 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -21,7 +21,6 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/i2c/pxa-i2c.h>
-#include <linux/gpio.h>
 
 #include <asm/mach/map.h>
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-pxa/saarb.c b/arch/arm/mach-pxa/saarb.c
index 3e999e3..7991552 100644
--- a/arch/arm/mach-pxa/saarb.c
+++ b/arch/arm/mach-pxa/saarb.c
@@ -15,7 +15,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/mfd/88pm860x.h>
-#include <linux/gpio.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index b862e9f..544cde2 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -37,7 +37,6 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/sh_clk.h>
-#include <linux/dma-mapping.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mipi_dsi.h>
 #include <sound/sh_fsi.h>
diff --git a/arch/arm/mach-ux500/board-mop500-u8500uib.c b/arch/arm/mach-ux500/board-mop500-u8500uib.c
index feb5744..4df0a3d 100644
--- a/arch/arm/mach-ux500/board-mop500-u8500uib.c
+++ b/arch/arm/mach-ux500/board-mop500-u8500uib.c
@@ -4,7 +4,6 @@
  * Board data for the U8500 UIB, also known as the New UIB
  * License terms: GNU General Public License (GPL), version 2
  */
-#include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 567e4b5..6022154 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -477,7 +477,6 @@ int __init clk_init(struct clk_functions * custom_clocks)
  *	debugfs support to trace clock tree hierarchy and attributes
  */
 
-#include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
 static struct dentry *clk_debugfs_root;
diff --git a/arch/arm/plat-samsung/dev-backlight.c b/arch/arm/plat-samsung/dev-backlight.c
index e657305..a976c02 100644
--- a/arch/arm/plat-samsung/dev-backlight.c
+++ b/arch/arm/plat-samsung/dev-backlight.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/pwm_backlight.h>
-#include <linux/slab.h>
 
 #include <plat/devs.h>
 #include <plat/gpio-cfg.h>
-- 
1.7.4.1

