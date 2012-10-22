From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/8] i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
Date: Mon, 22 Oct 2012 12:46:55 +0300
Message-ID: <1350899218-13624-6-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54200 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752597Ab2JVJxE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 05:53:04 -0400
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

on OMAP4+ we want to read IRQSTATUS_RAW register,
instead of IRQSTATUS. The reason being that IRQSTATUS
will only contain the bits which were enabled on
IRQENABLE_SET and that will break when we need to
poll for a certain bit which wasn't enabled as an
IRQ source.

One such case is after we finish converting to
deferred stop bit, we will have to poll for ARDY
bit before returning control for the client driver
in order to prevent us from trying to start a
transfer on a bus which is already busy.

Note, however, that omap-i2c.c needs a big rework
on register definition and register access. Such
work will be done in a separate series of patches.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/i2c.c                  |  3 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  2 +-
 drivers/i2c/busses/i2c-omap.c              | 26 ++++++++++++++++++++++----
 include/linux/i2c-omap.h                   |  1 +
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index fc57e67..e871928 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -66,7 +66,8 @@ int omap_i2c_reset(struct omap_hwmod *oh)
 	u16 i2c_con;
 	int c = 0;
 
-	if (oh->class->rev == OMAP_I2C_IP_VERSION_2) {
+	if ((oh->class->rev == OMAP_I2C_IP_VERSION_2) ||
+			(oh->class->rev == OMAP_I2C_IP_VERSION_3)) {
 		i2c_con = OMAP4_I2C_CON_OFFSET;
 	} else if (oh->class->rev == OMAP_I2C_IP_VERSION_1) {
 		i2c_con = OMAP2_I2C_CON_OFFSET;
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 652d028..ae9c023 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1521,7 +1521,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
-	.rev	= OMAP_I2C_IP_VERSION_2,
+	.rev	= OMAP_I2C_IP_VERSION_3,
 	.reset	= &omap_i2c_reset,
 };
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6219522..c65d526 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -271,8 +271,18 @@ static inline void omap_i2c_write_reg(struct omap_i2c_dev *i2c_dev,
 
 static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 {
-	return __raw_readw(i2c_dev->base +
+	/* if we are OMAP_I2C_IP_VERSION_3, we need to read from
+	 * IRQSTATUS_RAW, but write to IRQSTATUS
+	 */
+	if ((i2c_dev->dtrev == OMAP_I2C_IP_VERSION_3) &&
+			(reg == OMAP_I2C_STAT_REG)) {
+		return __raw_readw(i2c_dev->base +
+				((i2c_dev->regs[reg] - 0x04)
+				 << i2c_dev->reg_shift));
+	} else {
+		return __raw_readw(i2c_dev->base +
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
+	}
 }
 
 static int omap_i2c_init(struct omap_i2c_dev *dev)
@@ -1124,10 +1134,18 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	dev->reg_shift = (dev->flags >> OMAP_I2C_FLAG_BUS_SHIFT__SHIFT) & 3;
 
-	if (dev->dtrev == OMAP_I2C_IP_VERSION_2)
-		dev->regs = (u8 *)reg_map_ip_v2;
-	else
+	switch (dev->dtrev) {
+	case OMAP_I2C_IP_VERSION_1:
 		dev->regs = (u8 *)reg_map_ip_v1;
+		break;
+	case OMAP_I2C_IP_VERSION_2:
+		/* FALLTHROUGH */
+	case OMAP_I2C_IP_VERSION_3:
+		/* FALLTHROUGH */
+	default:
+		dev->regs = (u8 *)reg_map_ip_v2;
+		break;
+	}
 
 	pm_runtime_enable(dev->dev);
 	pm_runtime_set_autosuspend_delay(dev->dev, OMAP_I2C_PM_TIMEOUT);
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index df804ba..84f7355 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -14,6 +14,7 @@
 
 #define OMAP_I2C_IP_VERSION_1 1
 #define OMAP_I2C_IP_VERSION_2 2
+#define OMAP_I2C_IP_VERSION_3 3
 
 /* struct omap_i2c_bus_platform_data .flags meanings */
 
-- 
1.8.0.rc0

