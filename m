From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCHv8 01/13] I2C: OMAP: I2C register restore only if context is lost
Date: Mon, 18 Jun 2012 20:00:16 +0530
Message-ID: <1340029828-20751-2-git-send-email-shubhrajyoti@ti.com>
References: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52341 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab2FRObY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jun 2012 10:31:24 -0400
In-Reply-To: <1340029828-20751-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, w.sang@pengutronix.de, Shubhrajyoti D <shubhrajyoti@ti.com>, Kevin Hilman <khilman@ti.com>

 Currently i2c register restore is done always.
 Adding conditional restore.
 The i2c register restore is done only if the context is lost
 or in case of error to be on the safe side.

Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 arch/arm/plat-omap/i2c.c      |    3 +++
 drivers/i2c/busses/i2c-omap.c |   35 ++++++++++++++++++++++++++---------
 include/linux/i2c-omap.h      |    1 +
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index db071bc..4ccab07 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -179,6 +179,9 @@ static inline int omap2_i2c_add_bus(int bus_id)
 	 */
 	if (cpu_is_omap34xx())
 		pdata->set_mpu_wkup_lat = omap_pm_set_max_mpu_wakeup_lat_compat;
+
+	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
+
 	pdev = omap_device_build(name, bus_id, oh, pdata,
 			sizeof(struct omap_i2c_bus_platform_data),
 			NULL, 0, 0);
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 9895fa7..9a54e88 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -43,6 +43,7 @@
 #include <linux/slab.h>
 #include <linux/i2c-omap.h>
 #include <linux/pm_runtime.h>
+#include <plat/omap_device.h>
 
 /* I2C controller revisions */
 #define OMAP_I2C_OMAP1_REV_2		0x20
@@ -185,6 +186,7 @@ struct omap_i2c_dev {
 	u32			latency;	/* maximum mpu wkup latency */
 	void			(*set_mpu_wkup_lat)(struct device *dev,
 						    long latency);
+	int			(*get_context_loss_count)(struct device *dev);
 	u32			speed;		/* Speed of bus in kHz */
 	u32			dtrev;		/* extra revision from DT */
 	u32			flags;
@@ -207,6 +209,7 @@ struct omap_i2c_dev {
 	u16			syscstate;
 	u16			westate;
 	u16			errata;
+	int			dev_lost_count;
 };
 
 static const u8 reg_map_ip_v1[] = {
@@ -987,6 +990,7 @@ omap_i2c_probe(struct platform_device *pdev)
 		dev->speed = pdata->clkrate;
 		dev->flags = pdata->flags;
 		dev->set_mpu_wkup_lat = pdata->set_mpu_wkup_lat;
+		dev->get_context_loss_count = pdata->get_context_loss_count;
 		dev->dtrev = pdata->rev;
 	}
 
@@ -1128,12 +1132,26 @@ omap_i2c_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_RUNTIME
+static void omap_i2c_restore(struct omap_i2c_dev *dev)
+{
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, 0);
+	omap_i2c_write_reg(dev, OMAP_I2C_PSC_REG, dev->pscstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLL_REG, dev->scllstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_SCLH_REG, dev->sclhstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_BUF_REG, dev->bufstate);
+	omap_i2c_write_reg(dev, OMAP_I2C_WE_REG, dev->westate);
+	omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+
+}
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
 	u16 iv;
 
+	if (_dev->get_context_loss_count)
+		_dev->dev_lost_count = _dev->get_context_loss_count(dev);
+
 	_dev->iestate = omap_i2c_read_reg(_dev, OMAP_I2C_IE_REG);
 
 	omap_i2c_write_reg(_dev, OMAP_I2C_IE_REG, 0);
@@ -1154,16 +1172,15 @@ static int omap_i2c_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_i2c_dev *_dev = platform_get_drvdata(pdev);
+	int loss_cnt;
+
+	if (!(_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE))
+		return 0;
 
-	if (_dev->flags & OMAP_I2C_FLAG_RESET_REGS_POSTIDLE) {
-		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, 0);
-		omap_i2c_write_reg(_dev, OMAP_I2C_PSC_REG, _dev->pscstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SCLL_REG, _dev->scllstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SCLH_REG, _dev->sclhstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_BUF_REG, _dev->bufstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_SYSC_REG, _dev->syscstate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_WE_REG, _dev->westate);
-		omap_i2c_write_reg(_dev, OMAP_I2C_CON_REG, OMAP_I2C_CON_EN);
+	if (_dev->get_context_loss_count) {
+		loss_cnt = _dev->get_context_loss_count(dev);
+		if (_dev->dev_lost_count != loss_cnt)
+			omap_i2c_restore(_dev);
 	}
 
 	/*
diff --git a/include/linux/i2c-omap.h b/include/linux/i2c-omap.h
index 92a0dc7..c76cbc0 100644
--- a/include/linux/i2c-omap.h
+++ b/include/linux/i2c-omap.h
@@ -35,6 +35,7 @@ struct omap_i2c_bus_platform_data {
 	u32		rev;
 	u32		flags;
 	void		(*set_mpu_wkup_lat)(struct device *dev, long set);
+	int		(*get_context_loss_count)(struct device *dev);
 };
 
 #endif
-- 
1.7.5.4

