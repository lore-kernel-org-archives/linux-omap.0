From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH] i2c: omap: Remove the OMAP_I2C_FLAG_RESET_REGS_POSTIDLE flag
Date: Mon, 26 Nov 2012 15:24:41 +0530
Message-ID: <1353923681-9576-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45372 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab2KZJzK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 04:55:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The OMAP_I2C_FLAG_RESET_REGS_POSTIDLE is not used anymore
in the i2c driver. Remove the flag.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
Has dependency on the below patch
http://git.pengutronix.de/?p=wsa/linux.git;a=commitdiff;h=554c96744afd169886bd6fc2736fb0d9aaf634e8

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    3 +--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
 drivers/i2c/busses/i2c-omap.c              |    3 +--
 include/linux/i2c-omap.h                   |    1 -
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 59d5c1c..c9a186b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1103,8 +1103,7 @@ static struct omap_hwmod_class i2c_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags = OMAP_I2C_FLAG_BUS_SHIFT_NONE |
-		  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
+	.flags = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
 };
 
 /* i2c1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 943222c4..36270bb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -791,8 +791,7 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 /* I2C1 */
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
-			  OMAP_I2C_FLAG_BUS_SHIFT_2,
+	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod omap3xxx_i2c1_hwmod = {
@@ -817,8 +816,7 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 /* I2C2 */
 static struct omap_i2c_dev_attr i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
-		 OMAP_I2C_FLAG_BUS_SHIFT_2,
+	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod omap3xxx_i2c2_hwmod = {
@@ -843,8 +841,7 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 /* I2C3 */
 static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
-	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
-		 OMAP_I2C_FLAG_BUS_SHIFT_2,
+	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..eb40dbc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1526,8 +1526,7 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
-	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE |
-			OMAP_I2C_FLAG_RESET_REGS_POSTIDLE,
+	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
 };
 
 /* i2c1 */
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fabcbe1..815a401 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1038,8 +1038,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 #ifdef CONFIG_OF
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
-		 OMAP_I2C_FLAG_BUS_SHIFT_2,
+	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_i2c_bus_platform_data omap4_pdata = {
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 1b25c04..babe0cf 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -20,7 +20,6 @@
 #define OMAP_I2C_FLAG_NO_FIFO			BIT(0)
 #define OMAP_I2C_FLAG_SIMPLE_CLOCK		BIT(1)
 #define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
-#define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE	BIT(3)
 #define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
 #define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
 /* how the CPU address bus must be translated for I2C unit access */
-- 
1.7.5.4

