From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCH RFC] I2C : OMAP : make omap_i2c_unidle/idle functions depend on CONFIG_PM_RUNTIME
Date: Wed, 11 Jan 2012 14:00:57 +0530
Message-ID: <1326270657-15309-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The functions omap_i2c_unidle/idle are called from omap_i2c_runtime_resume
and omap_i2c_runtime_suspend which is compiled for CONFIG_PM_RUNTIME.
Make the omap_i2c_unidle/idle also depend on CONFIG_PM_RUNTIME flag.

This fixes the below warn when CONFIG_PM_RUNTIME is not defined

 CC      arch/arm/mach-omap2/board-ti8168evm.o
drivers/i2c/busses/i2c-omap.c:272: warning: 'omap_i2c_unidle' defined but not used
drivers/i2c/busses/i2c-omap.c:293: warning: 'omap_i2c_idle' defined but not used
  CC      net/ipv4/ip_forward.o

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
applies to Kevin's for_3.3/i2c/misc branch

 drivers/i2c/busses/i2c-omap.c |   82 ++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f713eac..ad564ac 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -269,47 +269,6 @@ static inline u16 omap_i2c_read_reg(struct omap_i2c_dev *i2c_dev, int reg)
 				(i2c_dev->regs[reg] << i2c_dev->reg_shift));
 }
 
-static void omap_i2c_unidle(struct omap_i2c_dev *dev)
-{
-	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
-		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
-		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
-	}
-
-	/*
-	 * Don't write to this register if the IE state is 0 as it can
-	 * cause deadlock.
-	 */
-	if (dev->iestate)
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
-}
-
-static void omap_i2c_idle(struct omap_i2c_dev *dev)
-{
-	u16 iv;
-
-	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	if (dev->dtrev == OMAP_I2C_IP_VERSION_2)
-		omap_i2c_write_reg(dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
-	else
-		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
-
-	if (dev->rev < OMAP_I2C_OMAP1_REV_2) {
-		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
-	} else {
-		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
-
-		/* Flush posted write */
-		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
-	}
-}
-
 static int omap_i2c_init(struct omap_i2c_dev *dev)
 {
 	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
@@ -1159,6 +1118,47 @@ omap_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_RUNTIME
+static void omap_i2c_unidle(struct omap_i2c_dev *dev)
+{
+	if (dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+		omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, dev->syscstate);
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+	}
+
+	/*
+	 * Don't write to this register if the IE state is 0 as it can
+	 * cause deadlock.
+	 */
+	if (dev->iestate)
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, dev->iestate);
+}
+
+static void omap_i2c_idle(struct omap_i2c_dev *dev)
+{
+	u16 iv;
+
+	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
+	if (dev->dtrev == OMAP_I2C_IP_VERSION_2)
+		omap_i2c_write_reg(dev, OMAP_I2C_IP_V2_IRQENABLE_CLR, 1);
+	else
+		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);
+
+	if (dev->rev < OMAP_I2C_OMAP1_REV_2) {
+		iv = omap_i2c_read_reg(dev, OMAP_I2C_IV_REG); /* Read clears */
+	} else {
+		omap_i2c_write_reg(dev, OMAP_I2C_STAT_REG, dev->iestate);
+
+		/* Flush posted write */
+		omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
+	}
+}
+
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-- 
1.7.1
