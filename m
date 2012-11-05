From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv3 4/8] ARM: i2c: omap: Remove the i207 errata flag
Date: Mon, 5 Nov 2012 17:53:39 +0530
Message-ID: <1352118223-3796-5-git-send-email-shubhrajyoti@ti.com>
References: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38811 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038Ab2KEMYc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 07:24:32 -0500
In-Reply-To: <1352118223-3796-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, b-cousson@ti.com, balbi@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The commit [i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207]
uses the revision id instead of the flag. So the flag can be safely removed.

Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +--
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++------
 drivers/i2c/busses/i2c-omap.c              |    3 +--
 include/linux/i2c-omap.h                   |    1 -
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c455e41..b79ccf6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -76,8 +76,7 @@ static struct omap_hwmod_class i2c_class = {
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
+	.flags		= OMAP_I2C_FLAG_BUS_SHIFT_2 |
 			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index f67b7ee..943222c4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -791,8 +791,7 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 /* I2C1 */
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-			  OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags		= OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 			  OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
@@ -818,8 +817,7 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 /* I2C2 */
 static struct omap_i2c_dev_attr i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
-	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
@@ -845,8 +843,7 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 /* I2C3 */
 static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
-	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 5f0c06c..88358d8 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1029,8 +1029,7 @@ static const struct i2c_algorithm omap_i2c_algo = {
 #ifdef CONFIG_OF
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
-	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
-		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+	.flags = OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
 		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index df804ba..5c88187 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -21,7 +21,6 @@
 #define OMAP_I2C_FLAG_SIMPLE_CLOCK		BIT(1)
 #define OMAP_I2C_FLAG_16BIT_DATA_REG		BIT(2)
 #define OMAP_I2C_FLAG_RESET_REGS_POSTIDLE	BIT(3)
-#define OMAP_I2C_FLAG_APPLY_ERRATA_I207	BIT(4)
 #define OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK	BIT(5)
 #define OMAP_I2C_FLAG_FORCE_19200_INT_CLK	BIT(6)
 /* how the CPU address bus must be translated for I2C unit access */
-- 
1.7.5.4

