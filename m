From: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv7 2/3] OMAP: I2C: Remove the reset in the init path
Date: Fri, 2 Dec 2011 14:51:13 +0530
Message-ID: <1322817674-25384-3-git-send-email-shubhrajyoti@ti.com>
References: <1322817674-25384-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1322817674-25384-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, khilman-l0cyMroinI0@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

-  The reset in the driver at init is not needed anymore as the
   hwmod framework takes care of reseting it.
-  Reset is removed from omap_i2c_init, which was called
   not only during probe, but also after time out and error handling.
   device_reset were added in those places to effect the reset.
-  Earlier the hwmod SYSC settings were over-written in the driver.
   Removing the same and letting the hwmod take care of the settings.
-  Clean up the SYSS_RESETDONE_MASK macro as it is no longer needed.
-  Clean up the SYSCONFIG SYSC bit defination macros.
-  Fix the typos in wakeup.

Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
---
 drivers/i2c/busses/i2c-omap.c |   82 +++++++++++------------------------------
 1 files changed, 22 insertions(+), 60 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index fa23faa..beff9f3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -155,19 +155,6 @@ enum {
 #define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
 #endif
 
-/* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
-
-/* OCP_SYSCONFIG bit definitions */
-#define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
-#define SYSC_SIDLEMODE_MASK		(0x3 << 3)
-#define SYSC_ENAWAKEUP_MASK		(1 << 2)
-#define SYSC_SOFTRESET_MASK		(1 << 1)
-#define SYSC_AUTOIDLE_MASK		(1 << 0)
-
-#define SYSC_IDLEMODE_SMART		0x2
-#define SYSC_CLOCKACTIVITY_FCLK		0x2
-
 /* Errata definitions */
 #define I2C_OMAP_ERRATA_I207		(1 << 0)
 #define I2C_OMAP3_1P153			(1 << 1)
@@ -182,6 +169,7 @@ struct omap_i2c_dev {
 	u32			latency;	/* maximum mpu wkup latency */
 	void			(*set_mpu_wkup_lat)(struct device *dev,
 						    long latency);
+	int			(*device_reset)(struct device *dev);
 	u32			speed;		/* Speed of bus in Khz */
 	u16			cmd_err;
 	u8			*buf;
@@ -317,60 +305,23 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 	u16 psc = 0, scll = 0, sclh = 0, buf = 0;
 	u16 fsscll = 0, fssclh = 0, hsscll = 0, hssclh = 0;
 	unsigned long fclk_rate = 12000000;
-	unsigned long timeout;
 	unsigned long internal_clk = 0;
 	struct clk *fclk;
 	struct omap_i2c_bus_platform_data *pdata;
 
 	pdata = dev->dev->platform_data;
 
-	if (dev->rev >= OMAP_I2C_OMAP1_REV_2) {
-		/* Disable I2C controller before soft reset */
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG,
-			omap_i2c_read_reg(dev, OMAP_I2C_CON_REG) &
-				~(OMAP_I2C_CON_EN));
-
-		omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG, SYSC_SOFTRESET_MASK);
-		/* For some reason we need to set the EN bit before the
-		 * reset done bit gets set. */
-		timeout = jiffies + OMAP_I2C_TIMEOUT;
-		omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
-		while (!(omap_i2c_read_reg(dev, OMAP_I2C_SYSS_REG) &
-			 SYSS_RESETDONE_MASK)) {
-			if (time_after(jiffies, timeout)) {
-				dev_warn(dev->dev, "timeout waiting "
-						"for controller reset\n");
-				return -ETIMEDOUT;
-			}
-			msleep(1);
-		}
-
-		/* SYSC register is cleared by the reset; rewrite it */
-		if (dev->rev == OMAP_I2C_REV_ON_2430) {
-
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
-					   SYSC_AUTOIDLE_MASK);
-
-		} else if (dev->rev >= OMAP_I2C_REV_ON_3430) {
-			dev->syscstate = SYSC_AUTOIDLE_MASK;
-			dev->syscstate |= SYSC_ENAWAKEUP_MASK;
-			dev->syscstate |= (SYSC_IDLEMODE_SMART <<
-			      __ffs(SYSC_SIDLEMODE_MASK));
-			dev->syscstate |= (SYSC_CLOCKACTIVITY_FCLK <<
-			      __ffs(SYSC_CLOCKACTIVITY_MASK));
-
-			omap_i2c_write_reg(dev, OMAP_I2C_SYSC_REG,
-							dev->syscstate);
-			/*
-			 * Enabling all wakup sources to stop I2C freezing on
-			 * WFI instruction.
-			 * REVISIT: Some wkup sources might not be needed.
-			 */
-			dev->westate = OMAP_I2C_WE_ALL;
-			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-							dev->westate);
-		}
+	if (dev->rev >= OMAP_I2C_REV_ON_3430) {
+		/*
+		 * Enabling all wakeup sources to stop I2C freezing on
+		 * WFI instruction.
+		 * REVISIT: Some wakeup sources might not be needed.
+		 */
+		dev->westate = OMAP_I2C_WE_ALL;
+		omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+						dev->westate);
 	}
+
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
 	if (pdata->flags & OMAP_I2C_FLAG_ALWAYS_ARMXOR_CLK) {
@@ -594,6 +545,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		return r;
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
+		if (dev->device_reset) {
+			r = dev->device_reset(dev->dev);
+			if (r < 0)
+				dev_err(dev->dev, "reset failed\n");
+		}
 		omap_i2c_init(dev);
 		return -ETIMEDOUT;
 	}
@@ -604,6 +560,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	/* We have an error */
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
+		if (dev->device_reset) {
+			r = dev->device_reset(dev->dev);
+			if (r < 0)
+				dev_err(dev->dev, "reset failed\n");
+		}
 		omap_i2c_init(dev);
 		return -EIO;
 	}
@@ -1004,6 +965,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (pdata != NULL) {
 		speed = pdata->clkrate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
+		dev->device_reset = pdata->device_reset;
 	} else {
 		speed = 100;	/* Default speed */
 		dev->set_mpu_wkup_lat = NULL;
-- 
1.7.1
