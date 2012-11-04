From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 4/7] ARM: i2c: omap: Remove the i207 errata flag
Date: Sun, 4 Nov 2012 16:14:30 +0530
Message-ID: <1352025873-27492-5-git-send-email-shubhrajyoti@ti.com>
References: <1352025873-27492-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1352025873-27492-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The commit [i2c: omap: use revision check for OMAP_I2C_FLAG_APPLY_ERRATA_I207]
uses the revision id instead of the flag. So the flag can be safely removed.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
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
index b62cd9d..8a54efc 100644
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
