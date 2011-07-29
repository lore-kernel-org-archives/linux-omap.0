From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv5 2/3] OMAP: I2C: Remove the reset in the init path
Date: Fri, 29 Jul 2011 16:06:52 +0530
Message-ID: <1311935813-8481-3-git-send-email-shubhrajyoti@ti.com>
References: <1311935813-8481-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47293 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756178Ab1G2KhI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jul 2011 06:37:08 -0400
In-Reply-To: <1311935813-8481-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, balajitk@ti.com, santosh.shilimkar@ti.com, Shubhrajyoti D <shubhrajyoti@ti.com>

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

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |   83 +++++++++++------------------------------
 1 files changed, 22 insertions(+), 61 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 4e3256f..d8f4470 100644
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
@@ -317,60 +305,22 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
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
-			if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
-				omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
-								dev->westate);
-		}
+	if (dev->rev >= OMAP_I2C_REV_ON_3430) {
+		/*
+		 * Enabling all wakeup sources to stop I2C freezing on
+		 * WFI instruction.
+		 * REVISIT: Some wakeup sources might not be needed.
+		 */
+		dev->westate = OMAP_I2C_WE_ALL;
+		if (dev->rev < OMAP_I2C_REV_ON_3530_4430)
+			omap_i2c_write_reg(dev, OMAP_I2C_WE_REG,
+							dev->westate);
 	}
 	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
 
@@ -595,6 +545,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 		return r;
 	if (r == 0) {
 		dev_err(dev->dev, "controller timed out\n");
+		if (dev->device_reset != NULL) {
+			r = dev->device_reset(dev->dev);
+			if (r < 0)
+				dev_err(dev->dev, "reset failed\n");
+		}
 		omap_i2c_init(dev);
 		return -ETIMEDOUT;
 	}
@@ -605,6 +560,11 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
 	/* We have an error */
 	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
 			    OMAP_I2C_STAT_XUDF)) {
+		if (dev->device_reset != NULL) {
+			r = dev->device_reset(dev->dev);
+			if (r < 0)
+				dev_err(dev->dev, "reset failed\n");
+		}
 		omap_i2c_init(dev);
 		return -EIO;
 	}
@@ -1005,6 +965,7 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (pdata != NULL) {
 		speed = pdata->clkrate;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
+		dev->device_reset = pdata->device_reset;
 	} else {
 		speed = 100;	/* Default speed */
 		dev->set_mpu_wkup_lat = NULL;
-- 
1.7.1

