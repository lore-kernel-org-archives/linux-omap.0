From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/2] ARM: OMAP: HSMMC: General code cleanup and cosmetic fixes
Date: Fri, 18 Apr 2008 16:29:00 -0400
Message-ID: <4809048C.3060705@indt.org.br>
References: <48061C1E.1030007@indt.org.br> <20080418183945.GF12099@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23429 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbYDRUdZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Apr 2008 16:33:25 -0400
In-Reply-To: <20080418183945.GF12099@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch makes the following general code cleanup and cosmetic fixes:

- Use #include <linux/io.h> instead of <asm/io.h>, according to warning
reported by scripts/checkpatch.pl on arch/arm/mach-omap2/board-sdp-hsmmc.c

- Use if (power_on) instead of if (power_on == 1).

- Use if (ret) instead of if (ret != 0).

- Add an extra-line to separate labels.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
Acked-by: Anderson Lizardo <anderson.lizardo@indt.org.br>
Acked-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
---
 arch/arm/mach-omap2/board-sdp-hsmmc.c |   41 ++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-sdp-hsmmc.c b/arch/arm/mach-omap2/board-sdp-hsmmc.c
index 3ae5b20..355c1c0 100644
--- a/arch/arm/mach-omap2/board-sdp-hsmmc.c
+++ b/arch/arm/mach-omap2/board-sdp-hsmmc.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
@@ -17,7 +18,6 @@
 #include <asm/hardware.h>
 #include <asm/arch/mmc.h>
 #include <asm/arch/board.h>
-#include <asm/io.h>
 
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
@@ -31,7 +31,7 @@
 #define TWL_GPIO_ISR1A		0x19
 #define LDO_CLR			0x00
 #define VSEL_S2_CLR		0x40
-#define GPIO_0_BIT_POS		1 << 0
+#define GPIO_0_BIT_POS		(1 << 0)
 #define MMC1_CD_IRQ		0
 #define MMC2_CD_IRQ		1
 
@@ -51,27 +51,27 @@ static int sdp_mmc_late_init(struct device *dev)
 	 * Configure TWL4030 GPIO parameters for MMC hotplug irq
 	 */
 	ret = twl4030_request_gpio(MMC1_CD_IRQ);
-	if (ret != 0)
+	if (ret)
 		goto err;
 
 	ret = twl4030_set_gpio_edge_ctrl(MMC1_CD_IRQ,
 			TWL4030_GPIO_EDGE_RISING | TWL4030_GPIO_EDGE_FALLING);
-	if (ret != 0)
+	if (ret)
 		goto err;
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0x02,
 						TWL_GPIO_PUPDCTR1);
-	if (ret != 0)
+	if (ret)
 		goto err;
 
 	ret = twl4030_set_gpio_debounce(MMC1_CD_IRQ, TWL4030_GPIO_IS_ENABLE);
-	if (ret != 0)
+	if (ret)
 		goto err;
 
 	return ret;
+
 err:
 	dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
-
 	return ret;
 }
 
@@ -80,7 +80,7 @@ static void sdp_mmc_cleanup(struct device *dev)
 	int ret = 0;
 
 	ret = twl4030_free_gpio(MMC1_CD_IRQ);
-	if (ret != 0)
+	if (ret)
 		dev_err(dev, "Failed to configure TWL4030 GPIO IRQ\n");
 }
 
@@ -96,24 +96,25 @@ static int mask_cd_interrupt(int mask)
 	u8 reg = 0, ret = 0;
 
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_IMR1A);
-	if (ret != 0)
+	if (ret)
 		goto err;
 
 	reg = (mask == 1) ? (reg | GPIO_0_BIT_POS) : (reg & ~GPIO_0_BIT_POS);
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_IMR1A);
-	if (ret != 0)
+	if (ret)
 		goto err;
 
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_GPIO, &reg, TWL_GPIO_ISR1A);
-	if (ret != 0)
+	if (ret)
 		goto err;
 
 	reg = (mask == 1) ? (reg | GPIO_0_BIT_POS) : (reg & ~GPIO_0_BIT_POS);
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, reg, TWL_GPIO_ISR1A);
-	if (ret != 0)
+	if (ret)
 		goto err;
+
 err:
 	return ret;
 }
@@ -155,7 +156,7 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
 	#define OMAP2_CONTROL_PBIAS 0x48002520
 #endif
 
-	if (power_on == 1) {
+	if (power_on) {
 		if (cpu_is_omap24xx())
 			devconf = omap_readl(0x490022E8);
 		else
@@ -186,12 +187,12 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
 
 		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 						P1_DEV_GRP, VMMC1_DEV_GRP);
-		if (ret != 0)
+		if (ret)
 			goto err;
 
 		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 						vdd_sel, VMMC1_DEDICATED);
-		if (ret != 0)
+		if (ret)
 			goto err;
 
 		msleep(100);
@@ -202,7 +203,7 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
 
 		return ret;
 
-	} else if (power_on == 0) {
+	} else {
 		/* Power OFF */
 
 		/* For MMC1, Toggle PBIAS before every power up sequence */
@@ -210,24 +211,22 @@ static int sdp_mmc_set_power(struct device *dev, int slot, int power_on,
 					OMAP2_CONTROL_PBIAS);
 		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 						LDO_CLR, VMMC1_DEV_GRP);
-		if (ret != 0)
+		if (ret)
 			goto err;
 
 		ret = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
 						VSEL_S2_CLR, VMMC1_DEDICATED);
-		if (ret != 0)
+		if (ret)
 			goto err;
 
 		/* 100ms delay required for PBIAS configuration */
 		msleep(100);
 		omap_writel(omap_readl(OMAP2_CONTROL_PBIAS) | 0x7,
 			OMAP2_CONTROL_PBIAS);
-	} else {
-		ret = -1;
-		goto err;
 	}
 
 	return 0;
+
 err:
 	return 1;
 }
-- 1.5.3.GIT

