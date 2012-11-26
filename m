From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] i2c: omap: Remove the OMAP_I2C_IP_VERSION_*
Date: Mon, 26 Nov 2012 17:09:42 +0530
Message-ID: <1353929982-13984-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56410 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab2KZLkM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 06:40:12 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, balbi@ti.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>

The OMAP_I2C_IP_VERSION_1 and OMAP_I2C_IP_VERSION_2 was needed
as on VER2 we were not reading all the 32-bits. Since now that
we read the hi register we do not need the OMAP_I2C_IP_VERSION_*.
Delete the same.

The custom reset is also changed to detect VER2 based on the
scheme.

Also move some of the common defines to i2c-omap.h to avoid duplication.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/mach-omap2/i2c.c                  |   16 +++++++---------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
 arch/arm/plat-omap/i2c.c                   |    3 ---
 drivers/i2c/busses/i2c-omap.c              |    5 -----
 include/linux/i2c-omap.h                   |   16 ++++------------
 9 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index fc57e67..6532bc1 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -63,18 +63,16 @@ void __init omap2_i2c_mux_pins(int bus_id)
 int omap_i2c_reset(struct omap_hwmod *oh)
 {
 	u32 v;
-	u16 i2c_con;
+	u16 i2c_con, scheme;
 	int c = 0;
 
-	if (oh->class->rev == OMAP_I2C_IP_VERSION_2) {
-		i2c_con = OMAP4_I2C_CON_OFFSET;
-	} else if (oh->class->rev == OMAP_I2C_IP_VERSION_1) {
+	i2c_con = OMAP4_I2C_CON_OFFSET;
+	v = omap_hwmod_read(oh, 0x4);
+
+	scheme = OMAP_I2C_SCHEME(v);
+
+	if (scheme == OMAP_I2C_SCHEME_0)
 		i2c_con = OMAP2_I2C_CON_OFFSET;
-	} else {
-		WARN(1, "Cannot reset I2C block %s: unsupported revision\n",
-		     oh->name);
-		return -EINVAL;
-	}
 
 	/* Disable I2C */
 	v = omap_hwmod_read(oh, i2c_con);
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index b5db600..51251a9 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -91,7 +91,6 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
-	.rev		= OMAP_I2C_IP_VERSION_1,
 	.reset		= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index b79ccf6..260b3d1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -70,7 +70,6 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
-	.rev		= OMAP_I2C_IP_VERSION_1,
 	.reset		= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index c9a186b..ce1f68e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -1098,7 +1098,6 @@ static struct omap_hwmod_class_sysconfig am33xx_i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &am33xx_i2c_sysc,
-	.rev		= OMAP_I2C_IP_VERSION_2,
 	.reset		= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 36270bb..5c1c8e2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -612,7 +612,6 @@ static struct omap_hwmod am35xx_uart4_hwmod = {
 static struct omap_hwmod_class i2c_class = {
 	.name	= "i2c",
 	.sysc	= &i2c_sysc,
-	.rev	= OMAP_I2C_IP_VERSION_1,
 	.reset	= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index eb40dbc..d6ef477 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1521,7 +1521,6 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
-	.rev	= OMAP_I2C_IP_VERSION_2,
 	.reset	= &omap_i2c_reset,
 };
 
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 6013831..d02d4b6 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -108,9 +108,6 @@ static inline int omap1_i2c_add_bus(int bus_id)
 	res[1].start = OMAP1_INT_I2C;
 	pdata = &i2c_pdata[bus_id - 1];
 
-	/* all OMAP1 have IP version 1 register set */
-	pdata->rev = OMAP_I2C_IP_VERSION_1;
-
 	/* all OMAP1 I2C are implemented like this */
 	pdata->flags = OMAP_I2C_FLAG_NO_FIFO |
 		       OMAP_I2C_FLAG_SIMPLE_CLOCK |
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 815a401..df2aa1b 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1037,12 +1037,10 @@ static const struct i2c_algorithm omap_i2c_algo = {
 
 #ifdef CONFIG_OF
 static struct omap_i2c_bus_platform_data omap3_pdata = {
-	.rev = OMAP_I2C_IP_VERSION_1,
 	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_i2c_bus_platform_data omap4_pdata = {
-	.rev = OMAP_I2C_IP_VERSION_2,
 };
 
 static const struct of_device_id omap_i2c_of_match[] = {
@@ -1059,15 +1057,12 @@ static const struct of_device_id omap_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
 #endif
 
-#define OMAP_I2C_SCHEME(rev)		((rev & 0xc000) >> 14)
 
 #define OMAP_I2C_REV_SCHEME_0_MAJOR(rev) (rev >> 4)
 #define OMAP_I2C_REV_SCHEME_0_MINOR(rev) (rev & 0xf)
 
 #define OMAP_I2C_REV_SCHEME_1_MAJOR(rev) ((rev & 0x0700) >> 7)
 #define OMAP_I2C_REV_SCHEME_1_MINOR(rev) (rev & 0x1f)
-#define OMAP_I2C_SCHEME_0		0
-#define OMAP_I2C_SCHEME_1		1
 
 static int __devinit
 omap_i2c_probe(struct platform_device *pdev)
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index babe0cf..d66af65 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -3,18 +3,6 @@
 
 #include <linux/platform_device.h>
 
-/*
- * Version 2 of the I2C peripheral unit has a different register
- * layout and extra registers.  The ID register in the V2 peripheral
- * unit on the OMAP4430 reports the same ID as the V1 peripheral
- * unit on the OMAP3530, so we must inform the driver which IP
- * version we know it is running on from platform / cpu-specific
- * code using these constants in the hwmod class definition.
- */
-
-#define OMAP_I2C_IP_VERSION_1 1
-#define OMAP_I2C_IP_VERSION_2 2
-
 /* struct omap_i2c_bus_platform_data .flags meanings */
 
 #define OMAP_I2C_FLAG_NO_FIFO			BIT(0)
@@ -28,6 +16,10 @@
 #define OMAP_I2C_FLAG_BUS_SHIFT_2		BIT(8)
 #define OMAP_I2C_FLAG_BUS_SHIFT__SHIFT 7
 
+#define OMAP_I2C_SCHEME(rev)		((rev & 0xc000) >> 14)
+#define OMAP_I2C_SCHEME_0		0
+#define OMAP_I2C_SCHEME_1		1
+
 struct omap_i2c_bus_platform_data {
 	u32		clkrate;
 	u32		rev;
-- 
1.7.5.4

